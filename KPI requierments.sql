use [Bank Loan DB];

select top 10 * from bank_loan_data;

select avg(int_rate) from bank_loan_data;

-- Total loan applications
select count(distinct id) as total_loan_applications from bank_loan_data;

-- Month To Date (MTD) & Previous Month To Date (PMTD) Applications
select count(distinct id) as MTD_total_loan_applications from bank_loan_data
where month(issue_date) = (select max(month(issue_date)) from bank_loan_data) and 
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

select count(distinct id) as PMTD_total_loan_applications from bank_loan_data
where month(issue_date) = (select max(month(issue_date))-1 from bank_loan_data) and 
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

-- Total, MTD & PMTD funded loan amount
select id, sum(loan_amount) total_funded_amount from bank_loan_data
group by id;

select sum(loan_amount) MTD_total_funded_amount from bank_loan_data
where month(issue_date) = (select max(month(issue_date)) from bank_loan_data) and 
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

select sum(loan_amount) PMTD_total_funded_amount from bank_loan_data
where month(issue_date) = (select max(month(issue_date))-1 from bank_loan_data) and 
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

-- Total, MTD & PMTD amount revceived
select id, sum(total_payment) total_amount_revceived from bank_loan_data
group by id;

select sum(total_payment) MTD_total_amount_revceived from bank_loan_data
where month(issue_date) = (select max(month(issue_date)) from bank_loan_data) and 
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

select sum(total_payment) PMTD_total_amount_revceived from bank_loan_data
where month(issue_date) = (select max(month(issue_date))-1 from bank_loan_data) and 
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

--Average, MTD interest rate
select round(avg(int_rate)*100,2) average_int_rate from bank_loan_data;

select round(avg(int_rate)*100,2) MTD_average_int_rate from bank_loan_data
where month(issue_date) = (select max(month(issue_date)) from bank_loan_data) and 
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

-- Average, MTD & PMTD Debt to Income Ratio (DTI)
select round(avg(dti)*100,2) average_dti from bank_loan_data;

select round(avg(dti)*100,2) MTD_average_dti from bank_loan_data
where month(issue_date) = (select max(month(issue_date)) from bank_loan_data) and
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);

select round(avg(dti)*100,2) PMTD_average_dti from bank_loan_data
where month(issue_date) = (select max(month(issue_date))-1 from bank_loan_data) and
year(issue_date) = (select max(year(issue_date)) from bank_loan_data);


select distinct loan_status from bank_loan_data;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank_loan_data'
AND COLUMN_NAME = 'int_rate';

