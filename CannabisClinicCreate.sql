drop database if exists Cannabis_Clinic;
create database if NOT exists Cannabis_Clinic;
use Cannabis_Clinic;

create table city
(
	city_id int auto_increment primary key,
    city varchar(64) not null unique
);

Create table province
(
	prov_id int auto_increment primary key,
    province varchar(64) not null unique
);

Create table gender_type
( gender_id int auto_increment primary key,
 gender varchar(64) Not null unique
 );

Create table contact_preferences
(   contact_pref_id int auto_increment primary key,
	subscription enum('Yes', 'No'),
    voicemail enum('Yes', 'No'),
    Text_appointment enum('Yes', 'No')
);

Create table patient_info
(
	patient_id int auto_increment primary key,
    first_middle_name varchar(96) not null,
    last_name varchar(64) not null,
    healthcard_number varchar(16) not null unique,
    DOB datetime,
    gender int,
    Telephone_Cellphone varchar(64) not null,
    email varchar(128) unique,
    Caretaker_Contact character(128),
    address varchar(128) not null unique,
    city_id int,
    prov_id int,
    postal_code varchar(8) not null,
	contact_pref int,
    constraint fk_gender foreign key (gender) references gender_type(gender_id),
    constraint fk_P_city FOREIGN KEY (city_id) references city (city_id),
    constraint fk_P_province FOREIGN KEY (prov_id) references province (prov_id),
    constraint fk_P_contac_pref FOREIGN KEY (contact_pref) references contact_preferences (contact_pref_id)
);
 
create table physician_info
(
	doctor_id int auto_increment primary key,
    first_middle_name varchar(96) not null,
    last_name varchar(64) not null,
    billing_number varchar(32) not null unique,
    telephone_fax varchar(64) not null,
    address_PO varchar(128) not null unique,
    city_id int,
    prov_id int,
    constraint fk_city FOREIGN KEY (city_id) references city (city_id),
    constraint fk_province FOREIGN KEY (prov_id) references province (prov_id)
);

create table veteran
( 	patient_id int primary key,
	veteran_id int not null unique,
    constraint fk_patient FOREIGN KEY (patient_id) references patient_info (patient_id)
);

Create table Treatment_Medication
(T_M_id int auto_increment primary key,
 T_M varchar(256) Not null);
 
 Create table Diagnosis_Symptoms
 (D_S_id int auto_increment primary key, 
  D_S varchar(256) Not null);
 
 Create table Primary_Complaint
( complaint_id int auto_increment primary key,
complaint varchar(256) Not null);
 
create table Form
(	form_id int auto_increment primary key,
	processed_date datetime,
    province_ref int,
    physician_signature enum('Yes', 'No'),
    constraint fk_F_province FOREIGN KEY (province_ref) references province (prov_id)
);

/* two coloumn primary key tables*/

create table City_referred
( 	form_id int,
	city_reffered int,
	constraint City_ref_PK primary key (form_id, city_reffered),
    constraint fk_Form_id foreign key (form_id) references form (form_id),
    constraint fk_F_city foreign key (city_reffered) references city (city_id)
    );

create table Complaint_form
(	form_id int not null,
	complaint_id int not null,
    constraint Compalint_PK PRIMARY KEY (form_id, complaint_id),
    constraint fk_C_form_id foreign key (form_id) references form (form_id),
    constraint fk_Compalint_id foreign key (complaint_id) references Primary_Complaint(complaint_id)
);

create table Treatment_form
(	form_id int not null,
	treatment_id int not null,
    constraint Treatment_PK PRIMARY KEY (form_id, treatment_id),
    constraint fk_T_form_id foreign key (form_id) references form (form_id),
    constraint fk_Treatment_id foreign key (treatment_id) references Treatment_Medication(T_M_id)
);

create table Diagnosis_form
(	form_id int not null,
	diagnosis_id int not null,
    constraint Compalint_PK PRIMARY KEY (form_id, diagnosis_id),
    constraint fk_D_form_id foreign key (form_id) references form (form_id),
    constraint fk_Diagnosis_id foreign key (diagnosis_id) references Diagnosis_Symptoms(D_S_id)
);

create table form_patient
(	form_id int not null,
	patient_id int not null,
    Constraint form_patient_PK primary key (form_id, patient_id),
    Constraint fk_FP_form_id foreign key (form_id) references form (form_id),
    Constraint fk_FP_patient_id foreign key (patient_id) references patient_info (patient_id)
);

create table form_doc
(	form_id int not null,
	doctor_id int not null,
    Constraint form_doc_PK primary key (form_id, doctor_id),
    Constraint fk_FD_form_id foreign key (form_id) references form (form_id),
    Constraint fk_FD_doctor_id foreign key (doctor_id) references physician_info (doctor_id)
);

/* inserting Data*/

insert into contact_preferences (contact_pref_id, subscription, voicemail, Text_appointment) Values
(default,'Yes','Yes','Yes'),
(default,'Yes','Yes','No'),
(default,'Yes','No','No'),
(default,'No','Yes','Yes'),
(default,'No','No','Yes'), 
(default,'No','No','No'),
(default,'No','Yes','No'),
(default,'Yes','No','Yes');

insert into gender_type (gender_id,gender) Values
(default,'Male'),
(default,'Female'),
(default,'N/A');

insert into city (city_id, city) Values
(Default,'Stoner'),
(Default,'Calgary'),
(Default,'Cambridge'),
(Default,'Whitby'),
(Default,'Ottawa'),
(Default,'Kitchener'),
(Default,'Hamilton'),
(Default,'Burlington'),
(Default,'Waterloo'),
(Default,'Etobicoke'),
(Default,'Toronto'),
(Default,'Mississagua'),
(Default,'Burnaby'),
(Default,'Sudbury'),
(Default,'Compton'),
(Default,'Guelph');

insert into province(prov_id,province) values
(Default, 'Ontario'),
(Default, 'Alberta'),
(Default, 'British Columbia'),
(Default, 'Quebec');

insert into patient_info (patient_id, first_middle_name, last_name, healthcard_number, DOB, gender, Telephone_Cellphone, email, Caretaker_Contact, address, city_id, prov_id, postal_code, contact_pref) values
(Default, 'Sean Qunicy','Laringo','1234-567-890-SD','1995-05-23',1,'672-420-0420, 672-420-4204','SQL.1995@gmail.com','Reggie Function','420 Subquery Lane',1,3,'V2N 5Z7',2),
(Default, 'Jeff','Windows','7748-487-247-LC','1929-04-18',1,'519-784-8732','JefferWindows@email.com',NULL,'78 Stonehedge Dr.',3,1,'4U2 0H0',5),
(Default, 'Elsa','Repunzil','2365-849-751-DP','1993-09-29',2,'519-242-0428, 519-745-9621','repunzile@gmail.com','Minnie Mouse','1234 Condor Ave',6,1,'N3B 4C1',2),
(Default, 'Derek','Shepherd','432-123-567 WP','1992-03-13',1,'519-212-3333','smark@gmail.com',NULL,'13 Queen St.',6,1,'N2M 1L5',6),
(Default, 'Connie','Bus','7666-665-890-xx','2001-01-01',2,'222-898-7657, 226-989-8776','getlit@yahoo.ca','Po T Bars','33 Leslie Way',7,1,'L8G 6E7',1),
(Default, 'Mary','Jane','2066-972-123-WF','1980-04-20','2','226-989-7683, 226-888-3445','mj123@gmail.com',NULL,'45 Jane Street',9,1,'NZE 4R8',8),
(Default, 'Organic','Kushla','2067-972-143-WF','1970-04-20',1,'226-989-7644, 226-888-3443','OGKush@gmail.com',NULL,'49 Jane Street',12,1,'NZE 4R8',8),
(Default, 'Bob','Marlee','1000-972-143-WF','1962-04-29',1,'232-989-7644, 226-888-3443','bob_@cheeba.com',NULL,'490 High Street',13,3,'BBC 4R8',8),
(Default, 'Snoop','Dogg','0420-420-420-SD','1971-10-20',1,'519-213-1971','D.O.DoubleG@gmail.com','Martha Stewart','420 Dizzle Street',15,1,'N2A 0J2',7),
(Default, 'Sierra','Brown','2976-831-654-YM','1976-03-24',2,'555-822-1685, 519-168-4792','siebr76@gmail.com','Bianca Brown, 555-493-0313','73 Rickson Road',16,1,'N1G 9K3',1);

insert into physician_info (doctor_id, first_middle_name, last_name, billing_number,telephone_fax, address_PO, city_id, prov_id) values
(Default, 'Ima','Ovacheeva','9899100','672-989-9898, 672-999-9999','98 Percent Ave',1,3),
(Default, 'Landon','Carter','421','519-875-4135, 519-875-4211','247 Newport Dr.',5,1),
(Default, 'Donald','Duck','087145','519-846-7952, 519-846-7950','32830 Walt Disney World Rd., 1M3 2D5',6,1),
(Default, 'Jenifer','Wang','129231','519-345-6789, 519-234-5678','15 Belmont Ave', 6,1),
(Default, 'John','Gotz','0098773','263-898-7667, 263-226-8873','33 NightnDay Drive',7,1),
(Default, 'Taylor D.','Ketix','887R888','905-989-3333, 905-767-4637','411 Mississauga Road', 12,1),
(Default, 'Andrew','Bud','8887R333','905-898-3333, 905-767-4637','411 Mississagua Road',11,1),
(Default, 'Manny','Morcheeba','887R913','405-844-3333, 405-764-4637','411 Budbury Drive', 13,3),
(Default, 'Drake','Dre','4983762','519-226-3938','213 Gin & Juice Dr', 15,1),
(Default, 'Tom', 'Jerry','678900', '555-437-6915, 555-749-8102','1385 Water Street', 16,1);

insert into veteran( patient_id, veteran_id) values
(2,1918),
(5,9888999),
(8,98883);

insert into primary_complaint (complaint_id, complaint) values
(Default, 'Pain'),
(default, 'in wrist'),
(Default, 'in foot'),
(default, 'in back'),
(Default, 'Cold Hands and Feet'),
(Default, 'Rapid Hair Growth'),
(Default, 'Headache'),
(Default, 'dizzy'),
(Default, 'Shortness of breath'),
(Default, 'post shingles'),
(Default, 'Sore'),
(default, 'in knees'),
(Default, 'in feet'),
(default, 'Nervous'),
(default, 'Severe nightmares'),
(default, 'Sleep deprivation'),
(default, 'Constant restlessness'),
(default, 'avoiding social events'),
(default, 'cannot sleep at night'),
(default, 'around other people');

insert into Treatment_Medication (T_M_id, T_M) values
(Default, 'Physical Therapy'),
(Default, 'Opiods'),
(Default, 'diabetic medication'),
(Default, 'pain killers low dose'),
(Default, 'Circulation treatment for hands and feet'),
(Default, 'Medicated Shampoo for hair removal'),
(Default, 'Hormone treatment to slow hair growth'),
(Default, 'losartan 50mg orally once a day'),
(Default, 'Cistalopram'),
(Default, 'Setraline'),
(Default, 'Savella'),
(default, 'Xanax'),
(default, 'Coffee'),
(default, 'Allergy Medication'),
(default, 'codeine'),
(default, 'Hydrocodone'),
(default, 'Yoga'),
(default, 'Toradol'),
(default, 'Prednisone'),
(default, 'Clonazepam'),
(default, 'diazepam');

insert into diagnosis_symptoms (D_S_id, D_S) values
(Default,'Carpal Tunnel due to constant query writing'),
(Default,'Diabetes is affecting his way of life'),
(Default,'Foot pain'),
(Default,'minor lower back pain'),
(Default,'Raynaud''s disease'),
(Default,'hypertension'),
(Default,'fatigue'),
(Default,'Chronic Pain'),
(Default,'Fibromyalgia'),
(Default,'Inflammatory Polyarthropoathy'),
(default,'Anxiety'),
(Default,'PTSD'),
(Default,'delusions'),
(Default,'sleep walking'),
(Default,'Feeling nervous'),
(Default,'restlessness'),
(Default,'trouble sleeping');

insert into Form (form_id, processed_date, province_ref, physician_signature) values
(default, '2018-11-13',2,'No'),
(default, '2018-11-22 16:50',1,'No'),
(default, '2019-02-19',1,'Yes'),
(default, '2019-03-15',1,'No'),
(default, '2019-03-26 07:10',1,'No'),
(default, '2019-04-09',1,'No'),
(default, '2019-06-27 09:06',1,'No'),
(default, '2019-11-27 12:12',1,'No'),
(default, '2019-11-28',1,'No'),
(default, '2019-12-01 14:30',1,'Yes');

insert into City_referred (form_id, city_reffered) values
(1,2),
(2,4),
(3,6),
(4,6),
(5,8),
(6,10),
(7,10),
(8,14),
(9,16),
(10,7),
(10,12);

insert into form_patient(form_id,patient_id) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

insert into form_doc(form_id,doctor_id) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

insert into Complaint_form (form_id, complaint_id) values
(1,1),
(1,2),
(2,1),
(2,3),
(3,5),
(3,6),
(4,7),
(4,8),
(4,9),
(5,1),
(5,10),
(6,11),
(6,12),
(6,4),
(6,13),
(7,14),
(7,20),
(8,15),
(8,16),
(9,4),
(9,1),
(10,14),
(10,17),
(10,18),
(10,19);
insert into Treatment_form (form_id,treatment_id) values
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(3,6),
(3,7),
(4,8),
(5,9),
(5,10),
(6,11),
(7,12),
(7,13),
(7,14),
(8,15),
(8,16),
(8,17),
(9,18),
(9,19),
(10,20),
(10,21);

insert into Diagnosis_form (form_id,diagnosis_id)values
(1,1),
(2,2),
(2,3),
(2,4),
(3,5),
(4,6),
(4,7),
(5,8),
(6,9),
(6,10),
(7,11),
(8,12),
(8,13),
(8,14),
(9,11),
(9,9),
(10,11),
(10,15),
(10,16),
(10,17);