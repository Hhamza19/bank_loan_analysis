use [Bank Loan DB];
select top 10 * from bank_loan_data;

-- Monthly trends
select year, month_name,total_applications from
(select year(issue_date) year,datename(month,issue_date) as month_name, month(issue_date) month_num,
count(*) total_applications 
from bank_loan_data
group by year(issue_date),datename(month,issue_date),month(issue_date)) as src
order by year desc, month_num asc;

-- Reional analysis by state
select address_state, count(*) total_applications, sum(loan_amount) total_loan_amount,sum(total_payment) total_payments
from bank_loan_data
group by address_state;

-- Long term analysis
select term, count(*) total_applications, sum(loan_amount) total_loan_amount,sum(total_payment) total_payments
from bank_loan_data
group by term;

-- Employment length analysis
select emp_length, count(*) total_applications, sum(loan_amount) total_loan_amount,sum(total_payment) total_payments
from bank_loan_data
group by emp_length;

-- Loan purpose breakdown
select purpose, count(*) total_applications, sum(loan_amount) total_loan_amount,sum(total_payment) total_payments
from bank_loan_data
group by purpose;

-- Home ownership analysis
select home_ownership, count(*) total_applications, sum(loan_amount) total_loan_amount,sum(total_payment) total_payments
from bank_loan_data
group by home_ownership;