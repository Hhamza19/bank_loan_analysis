use [Bank Loan DB];
select top 10 * from bank_loan_data;

select distinct loan_status from dbo.bank_loan_data;
-- Good loans and bad loans applications
with loan_classification as (
	select id,loan_status,
		case 
			when loan_status in ('Fully Paid', 'Current') then 'Good Loan' 
			when loan_status in ('Charged Off') then 'Bad Loan' 
			else 'Other' 
		end as loan_type
	from dbo.bank_loan_data
)
--select loan_type, count(*) as Nbr_of_applications from loan_classification
--group by loan_type;
select distinct loan_type,count(*) over(partition by loan_type) as Nbr_of_applications,count(*) over() as total_applications,
cast((count(*) over(partition by loan_type))*1.0*100/count(*) over() AS DECIMAL(10,2)) as Percentage_of_Applications
from loan_classification;

-- Good loans and bad loans percentage
select
count(case when loan_status in ('Fully Paid', 'Current') then id end) as Good_Loan_nbr,
count(case when loan_status in ('Charged Off') then id end) as Bad_Loan_nbr,
cast(count(case when loan_status in ('Fully Paid', 'Current') then id end)*1.0*100/count(*) as DECIMAL(10,2)) as Good_Loan_Percentage,
cast(count(case when loan_status in ('Charged Off') then id end)*1.0*100/count(*) as DECIMAL(10,2)) as Bad_Loan_Percentage
from bank_loan_data

-- Good & bad loan total funded amount
select sum(case when loan_status in ('Fully Paid', 'Current') then loan_amount else 0 end) as Good_Loan_Total_Funded_Amount,
sum(case when loan_status in ('Charged Off') then loan_amount else 0 end) as Bad_Loan_Total_Funded_Amount
from bank_loan_data;

select sum(loan_amount) as good_loan_total_funded_amount from bank_loan_data
where loan_status in ('Fully Paid', 'Current');

-- Good & bad loan total received amount
select sum(case when loan_status in ('Fully Paid', 'Current') then total_payment end) as good_loan_total_received_amount,
sum(case when loan_status = 'Charged Off' then total_payment end) as bad_loan_total_received_amount
from bank_loan_data;

-- Loan status grid view
select loan_status,count(*) as total_applications,sum(loan_amount) as total_funded_amount,sum(total_payment) as total_received_amount,
cast(avg(int_rate)*100 as decimal(10,2)) as avg_interest_rate,cast(avg(dti)*100 as decimal(10,2)) as avg_dti 
from bank_loan_data
group by loan_status
order by total_applications desc;

-- MTD funded & received amount
select loan_status,sum(loan_amount) as total_funded_amount_mtd,sum(total_payment) as total_received_amount_mtd
from bank_loan_data
where month(issue_date) = (select max(month(issue_date)) from bank_loan_data)
and year(issue_date) = (select max(year(issue_date)) from bank_loan_data)
group by loan_status
order by loan_status desc;








