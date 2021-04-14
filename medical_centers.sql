-- from the terminal run:
-- psql < medical_centers.sql

DROP DATABASE IF EXISTS medical_centers;

CREATE DATABASE medical_centers;

\c medical_centers

CREATE TABLE medical_centers (
  id SERIAL PRIMARY KEY,
  med_institution TEXT NOT NULL,
  med_address TEXT NOT NULL,
  med_phone VARCHAR(10) NOT NULL,
  med_email VARCHAR(50)
);

CREATE TABLE insurers (
  id SERIAL PRIMARY KEY,
  insur_company TEXT NOT NULL,
  insur_address TEXT NOT NULL,
  insur_phone VARCHAR(10) NOT NULL,
  insur_email VARCHAR(50) NOT NULL
);

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  has_insurance BOOLEAN NOT NULL,
  patient_first_name TEXT NOT NULL,
  patient_last_name TEXT NOT NULL,
  birth_date DATE NOT NULL,
  patient_address TEXT NOT NULL,
  phone VARCHAR(10) NOT NULL,
  email VARCHAR(50)
);

CREATE TABLE insurance_policies (
  id SERIAL PRIMARY KEY,
  patient_id integer REFERENCES patients(id) ON DELETE CASCADE,
  insurer_id integer REFERENCES insurers(id) ON DELETE CASCADE
);

CREATE TABLE doctors (
  id SERIAL PRIMARY KEY,
  doctor_first_name TEXT NOT NULL,
  doctor_last_name TEXT NOT NULL,
  specialty TEXT NOT NULL,
  doctor_office_address TEXT NOT NULL,
  doctor_office_phone VARCHAR(10) NOT NULL,
  doctor_office_email VARCHAR(50) NOT NULL,
  doctor_pager VARCHAR(10) NOT NULL,
  doctor_home_address TEXT NOT NULL,
  doctor_home_phone VARCHAR(10) NOT NULL,
  doctor_home_email VARCHAR(50) NOT NULL,
  medical_center_id integer REFERENCES medical_centers(id) ON DELETE CASCADE
);

CREATE TABLE diagnoses (
  id SERIAL PRIMARY KEY,
  patient_id integer REFERENCES patients(id) ON DELETE CASCADE,
  doctor_id integer REFERENCES doctors(id) ON DELETE CASCADE,
  condition TEXT NOT NULL,
  description TEXT NOT NULL,
  treatment TEXT NOT NULL,
  curable BOOLEAN NOT NULL,       
  patient_notes TEXT
);

CREATE TABLE appointments (

  id SERIAL PRIMARY KEY,
  appt_date DATE NOT NULL,
  appt_time TIME NOT NULL,
  med_center integer REFERENCES medical_centers(id),
  patient_id integer REFERENCES patients(id) ON DELETE CASCADE,
  doctor_id integer REFERENCES doctors(id) ON DELETE CASCADE,
  diagnosis_id integer REFERENCES diagnoses(id)
);

INSERT INTO medical_centers
(med_institution, med_address, med_phone, med_email)
  VALUES
('Harborview Medical Center', '325 Ninth Avenue Seattle, WA', '2067443000', 'harborview@example.org'),
('Northwest Hospital', '1550 N 115th Street, Seattle, WA', '2065554432', 'nwh@example.org'),    
('Seattle Childrens', '4800 Sand Point Way NE Seattle, WA 98105', '2069872000', 'seattlechildrenshospital@example.org');
  
INSERT INTO insurers
(insur_company, insur_address, insur_phone, insur_email)
  VALUES
('Kaiser', '1234 Main St NE Seattle, WA', '2065559875', 'kaiser@example.org'),
('Acme Insurance', '12276 Linden St N Seattle, WA', '2065558957', 'acme@example.org');
  
INSERT INTO patients
(patient_first_name, patient_last_name, birth_date, patient_address, phone, email, has_insurance)
  VALUES
('Jennifer', 'Finch', '1984-07-11', '6500 Greenwood Ave N. Seattle, WA 98103', '2065552121', 'jennifer@example.com', true),
('Michael', 'Green', '1975-01-22', '20000 Aurora Ave N. Seattle, WA 98133', '2065559912', 'michael@example.com', true);

INSERT INTO insurance_policies
(patient_id, insurer_id)
  VALUES
(1, 1),
(2, 2);
  
INSERT INTO doctors
(doctor_first_name, doctor_last_name, specialty, doctor_office_address, doctor_office_phone, doctor_office_email, doctor_pager, doctor_home_address, doctor_home_phone, doctor_home_email, medical_center_id)
  VALUES
('Jeremy', 'Mitchell', 'General Practice', '11830 15th Ave N. Seattle, WA 98103', '2065552631', 'jeremy@example.com', '2065550000', '12345 Wallingford Ave N. Seattle, WA 98102', '2065553333', 'drmitchell@example.com', 1),
('Antoine', 'Stone', 'Cardiology', '17901 Linden Ave N. Seattle, WA 98133', '2065551111', 'michael@example.com', '2065551224', '12469 15th Ave NE Seattle, WA 98111', '2065559412', 'antoine98@example.com', 2);

INSERT INTO diagnoses
(patient_id, doctor_id, condition, description, treatment, curable, patient_notes)
  VALUES
(1, 1, 'Addisons Disease', 'Addisons disease, also called adrenal insufficiency, or hypocortisolism, occurs when the adrenal glands do not produce enough of the hormone cortisol and, in some cases, the hormone aldosterone.', 'hormone treatment', false, 'Patient allergic to Aspirin'),
(2, 2, 'Athletes Foot', 'Dermal foot fungus that usually affects the feet but can be spread by skin contact to other areas of the body', 'antifungal medication', true, 'Patient practices Karate; likely caught in dojo');

INSERT INTO appointments
(appt_date, appt_time, med_center, patient_id, doctor_id, diagnosis_id)
  VALUES
('2021-05-05', '10:30', 1, 1, 1, 1),
('2021-05-06', '11:30', 2, 2, 2, 2);
