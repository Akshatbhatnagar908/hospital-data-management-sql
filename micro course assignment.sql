drop table if exists hospital;
create table hospital(
	Hospital_name varchar(100),
	Location varchar(100),
	Department varchar(100),
	Doctors_count int,
	Patients_count int,
	Admission_date date,
	Discharge_date date,
	medical_expenses numeric(10,2)
);


select * from hospital;

--1)total no. of patients
select sum(patients_count) as total_patient
from hospital;

--2)average number of doctor per hospital
select distinct h.hospital_name,avg(h.doctors_count) over(partition by h.hospital_name) as sum_doctor
from hospital h
group by h.hospital_name,h.doctors_count;

--3)top 3 department with the highest number of patients
select distinct department,sum(patients_count) over(partition by department) as patients
from hospital
limit 3;

--4)hospital with the max medical expenses
select distinct hospital_name,sum(medical_expenses) over(partition by hospital_name) as total
from hospital
limit 1;

--5)daily average medical expenses
select distinct hospital_name,avg(medical_expenses/(discharge_date-admission_date)) 
over(partition by hospital_name) as average
from hospital;

--6. Longest Hospital Stay 
select hospital_name,(discharge_date-admission_date) as stay
from hospital
order by stay desc
limit 1;

--7. Total Patients Treated Per City
select distinct location,sum(patients_count) over(partition by location) as total
from hospital;

--8. Average Length of Stay Per Department 
SELECT distinct department,avg(discharge_date-admission_date) over(partition by department) as average
from hospital;

--9. Identify the Department with the Lowest Number of Patients
select department, sum(patients_count) over(partition by department) as total
from hospital
order by total asc
limit 1;

--10. Monthly Medical Expenses Report

select distinct date_part('month',admission_date) as intial_month,sum(medical_expenses) over(partition by date_part('month',admission_date)) as total_first
from hospital
order by intial_month asc;




