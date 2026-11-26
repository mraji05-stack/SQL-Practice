
create Table patient_info(
patient_id INT Primary key,
patient_name Varchar(50),
patient_city Varchar(50),
patient_age INT,
patient_gender Varchar(11)
)
;

create table doctor_info(
doctor_id INT primary key,
doctor_name varchar(50),
specialised varchar(60)
)
;

create table appointment_info
(
appointment_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
fees decimal (10,2),
FOREIGN KEY (patient_id) references patient_info(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctor_info(doctor_id)
)
;
select * from appointment_info
select * from patient_info
select*from doctor_info

insert into patient_info (patient_id,patient_name,patient_city,patient_age,patient_gender)
values(1,"Shivakumar","Chennai",35,"Male"),
	(2,"Raghuram P","Bangalore",50,"Male"),
	(3,"Ramya Krishnan","chennai",55,"Female"),
	(4,"Priyamani M","Hyderabad",43,"Female"),
	(5,"Vijay sethupati","Chennai",56,"Male");


insert into doctor_info (doctor_id,doctor_name,specialised)
	values(001,"Dr.Subramaniam","Ortho"),
		(002,"Dr.Raghupati","Cardio"),
		(003,"Dr.Rajeshwari M","Cardio")
    ;

alter table appointment_info add column appointment_date DATE;

insert into appointment_info (appointment_id,patient_id,doctor_id,fees,appointment_date)
values (01,1,002,3000,'2026-01-15'),
(02,2,003,5500,'2026-01-28'),
(03,3,002,3000,'2026-02-25'),
(04,1,001,3500,'2026-03-01'),
(05,1,003,5000,'2026-03-28')
;

insert into appointment_info (appointment_id,patient_id,doctor_id,fees,appointment_date)
values(06,3,003,5000,'2026-03-28')

-----INNER JOIN----
SELECT * from appointment_info as a
join doctor_info as d
on d.doctor_id=a.doctor_id
join patient_info as p
on p.patient_id=a.patient_id

-----RIGHT JOIN-----
SELECT * from appointment_info as a
Right join doctor_info as d
on a.doctor_id=d.doctor_id
right join patient_info as p
on a.patient_id=p.patient_id

-----LEFT JOIN----
SELECT * from appointment_info as a
left join doctor_info as d
on d.doctor_id=a.doctor_id
left join patient_info as p
on p.patient_id=a.patient_id

---Full Join---

SELECT * from appointment_info as a
left join doctor_info as d
on d.doctor_id=a.doctor_id
left join patient_info as p
on p.patient_id=a.patient_id
Union
SELECT * from appointment_info as a
Right join doctor_info as d
on a.doctor_id=d.doctor_id
right join patient_info as p
on a.patient_id=p.patient_id;

---Find the total number of appointments for each doctor where appointment fees are above ₹3,000----

select d.doctor_name, count(*) as Total_Appoinment from appointment_info a
join doctor_info as d
on d.doctor_id=a.doctor_id
join patient_info as p
on p.patient_id=a.patient_id where a.fees>3000 group by d.doctor_name 

---Display doctors whose total fees exceed ₹5,000, sorted from highest to lowest collection---

Select
    d.doctor_name,
    SUM(a.fees) AS total_fees
from appointment_info a
JOIN doctor_info d
    on a.doctor_id = d.doctor_id
Group by d.doctor_name
Having SUM(a.fees) > 5000
Order by total_fees DESC;

----Display the number of male and female patients from Chennai--------
Select
    patient_gender,count(*) from patient_info
    where patient_city="Chennai" group by patient_gender;
    
-----Display patients who have more than one appointment, sorted by appointment count---
Select
    p.patient_name,
   count(a.appointment_id) as Appointments
from appointment_info a
join doctor_info as d
on d.doctor_id=a.doctor_id
join patient_info as p
on p.patient_id=a.patient_id
group by (p.patient_name)
Having COUNT(a.appointment_id)>1
ORDER BY Appointments DESC;
;

----Display doctors whose average fees exceed ₹4,000, sorted by average fees in descending order.
Select
    d.doctor_name,
   AVG(a.fees) as Avg_fees
from appointment_info a
join doctor_info as d
on d.doctor_id=a.doctor_id
join patient_info as p
on p.patient_id=a.patient_id
group by (d.doctor_name)
Having AVG(a.fees)>4000
ORDER BY Avg_fees DESC;

----Find the number of appointments for each doctor in February and March 2026, sorted by appointment count----
Select
    d.doctor_name, count(a.appointment_id) as appointment_febmarch
from appointment_info a
join doctor_info as d
on d.doctor_id=a.doctor_id
join patient_info as p
on p.patient_id=a.patient_id
where a.appointment_date between '2026-02-01' AND '2026-03-31'
group by d.doctor_id,d.doctor_name
ORDER BY appointment_febmarch DESC;
