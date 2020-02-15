/*Question 1'*/
select count(t1.form_id) as 'Total Referals',
round(count(t2.form_id)/count(t1.form_id)*100,1) as 'Anxiety proportionin %',
round(count(t3.form_id)/count(t1.form_id)*100,1) as 'Depression proportionin %'
from (select form_id from form) t1
left join
(select form_id, GROUP_CONCAT(DISTINCT D_S order by D_S desc separator ', ') as Diagnosis_Symptoms from diagnosis_form
join diagnosis_symptoms
on diagnosis_id=D_S_id
group by form_id
having REGEXP_LIKE (Diagnosis_Symptoms,'Anxiety') > 0) t2
on t1.form_id=t2.form_id
left join
(select form_id, GROUP_CONCAT(DISTINCT D_S order by D_S desc separator ', ') as Diagnosis_Symptoms from diagnosis_form
join diagnosis_symptoms
on diagnosis_id=D_S_id
group by form_id
having REGEXP_LIKE (Diagnosis_Symptoms,'Depression') > 0) t3
on t1.form_id=t3.form_id;

/*Question 2*/

select monthname(processed_date) as Summary, count(form_id) as 'Referals Processed', Year(processed_date) AS 'last Year'
from form
where processed_date between date_sub(curdate(), interval 2 year) and date_sub(curdate(), interval 1 year)
or processed_date between date_sub(curdate(), interval 1 year) and curdate()
group by Summary, year(processed_date);


/*Question 3*/
select monthname(curdate()) as 'Month of Report',
Year(curdate()) as 'Year of Interst',
ifnull(count(f2.processed_date), 0) as 'Referrals Received' from form f1
right join form f2
on f1.processed_date= f2.processed_date
where month(curdate()) =  month(f2.processed_date)
and f2.processed_date > date_sub(curdate(), interval 30 day)
and f2.processed_date < date_add(curdate(), interval 30 day)
group by 'Referrals Received';

/*Question 4*/
select fp.form_id, p.patient_id, floor(datediff(curdate(), p.DOB)/365)as age, c.city as 'City', T2.avg_age, T2.max_age,T2.min_age
from form_patient fp
	join patient_info p
		on fp.patient_id=p.patient_id
	join city c
		on p.city_id=c.city_id
	join (select c.city_id as id, c.city as city_ref , round(avg(datediff(curdate(), p.DOB)/365),2) as avg_age,
			round(max(datediff(curdate(), p.DOB)/365),2) as max_age, round(min(datediff(curdate(), p.DOB)/365),2) as min_age
			from city c
			join patient_info p
			on c.city_id=p.city_id
			group by c.city
			order by c.city) T2
		on p.city_id= T2.id
 order by fp.form_id, p.patient_id, age, 'City';
 
 
 /*Quesiton 5*/
 
	select 'Primary Complaints' as 'Sections of interest',round(sum(t1.complaints)/count(t1.complaints),1) as 'Average Number Across all Referrals' from
	(select cf.form_id, count(cf.complaint_id) complaints from complaint_form cf
	group by cf.form_id) t1
	order by 'Sections of interest';