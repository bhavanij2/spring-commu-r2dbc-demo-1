-- CREATE TABLES
SET SEARCH_PATH = 'public';

CREATE TABLE IF NOT EXISTS DIM_USER_TYPE (
    user_type varchar(100) PRIMARY KEY,
    user_type_desc varchar
);

INSERT INTO DIM_USER_TYPE (user_type, user_type_desc) VALUES ('ADMIN', 'ADMIN');
INSERT INTO DIM_USER_TYPE (user_type, user_type_desc) VALUES ('ZONE_LEADER', 'ZONE_LEADER');
INSERT INTO DIM_USER_TYPE (user_type, user_type_desc) VALUES ('DSM', 'DSM');
INSERT INTO DIM_USER_TYPE (user_type, user_type_desc) VALUES ('KAM', 'KAM');

select * from dim_user_type;

CREATE TABLE IF NOT EXISTS DIM_USER (
    user_name varchar(100) PRIMARY KEY,
    parent_user varchar(100) NOT NULL REFERENCES DIM_USER,
    user_type varchar(100) NOT NULL,
    district varchar NOT NULL,
    CONSTRAINT fk_user_type FOREIGN KEY(user_type) REFERENCES DIM_USER_TYPE(user_type)
);

INSERT INTO DIM_USER (user_name, parent_user, user_type, district) VALUES ('Gavin Buckland', 'Gavin Buckland', 'DSM', 'Chesapeake');
INSERT INTO DIM_USER (user_name, parent_user, user_type, district) VALUES ('Caryn Smith', 'Gavin Buckland', 'KAM', 'Chesapeake');
INSERT INTO DIM_USER (user_name, parent_user, user_type, district) VALUES ('Bradley Adkins', 'Gavin Buckland', 'KAM', 'Chesapeake');
INSERT INTO DIM_USER (user_name, parent_user, user_type, district) VALUES ('Nirmal Amarender', 'Nirmal Amarender', 'DSM', 'Metro NYC');
INSERT INTO DIM_USER (user_name, parent_user, user_type, district) VALUES ('Kaleigh Costello', 'Nirmal Amarender', 'KAM', 'Metro NYC');
INSERT INTO DIM_USER (user_name, parent_user, user_type, district) VALUES ('Benjamin Carlos', 'Nirmal Amarender', 'KAM', 'Metro NYC');

select * from dim_user;

CREATE TABLE IF NOT EXISTS DIM_FORM_TYPE (
    form_type varchar(100) PRIMARY KEY,
    form_type_desc varchar(100)
);

INSERT INTO DIM_FORM_TYPE (form_type, form_type_desc) VALUES ('SCORECARD', 'SCORECARD');
INSERT INTO DIM_FORM_TYPE (form_type, form_type_desc) VALUES ('PRIORITY_TRACKER', 'PRIORITY_TRACKER');
INSERT INTO DIM_FORM_TYPE (form_type, form_type_desc) VALUES ('SEGMENTATION', 'SEGMENTATION');

select * from DIM_FORM_TYPE;

CREATE TABLE IF NOT EXISTS FACT_FORM_TYPE_ACCESS (
    id SERIAL PRIMARY KEY,
    user_type varchar(100) NOT NULL,
    form_type varchar(100) NOT NULL,
    is_viewable char(1) NOT NULL,
    is_editable char(1) NOT NULL,
    is_deletable char(1) NOT NULL,
    CONSTRAINT fk_user_type FOREIGN KEY(user_type) REFERENCES DIM_USER_TYPE(user_type),
    CONSTRAINT fk_form_type FOREIGN KEY(form_type) REFERENCES DIM_FORM_TYPE(form_type),
    CONSTRAINT unique_user_type_form_type UNIQUE(user_type, form_type)
);

INSERT INTO FACT_FORM_TYPE_ACCESS (user_type, form_type, is_viewable, is_editable, is_deletable) VALUES ('ADMIN', 'SCORECARD', 1, 1, 0);
INSERT INTO FACT_FORM_TYPE_ACCESS (user_type, form_type, is_viewable, is_editable, is_deletable) VALUES ('ZONE_LEADER', 'SCORECARD', 1, 1, 0);
INSERT INTO FACT_FORM_TYPE_ACCESS (user_type, form_type, is_viewable, is_editable, is_deletable) VALUES ('DSM', 'SCORECARD', 1, 1, 0);
INSERT INTO FACT_FORM_TYPE_ACCESS (user_type, form_type, is_viewable, is_editable, is_deletable) VALUES ('KAM', 'SCORECARD', 1, 1, 0);

select * from FACT_FORM_TYPE_ACCESS;

CREATE TABLE IF NOT EXISTS DIM_ACCOUNT (
    id SERIAL PRIMARY KEY,
    account_name varchar(100) NOT NULL,
    district varchar NOT NULL,
    zone_name varchar NOT NULL,
    account_type varchar,
    definitive_id int NOT NULL,
    account_segment varchar,
    kam varchar,
    idn varchar,
    city varchar,
    street varchar,
    CONSTRAINT unique_account UNIQUE(account_name, district, zone_name, account_type),
    CONSTRAINT unique_definitive_id UNIQUE(definitive_id)
);

INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('VA Medical Center Washington DC', 'Chesapeake', 'East', 6, 'Caryn Smith', 'VA Capitol Health Care Network (VISN 5)');
INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('George Washington University Hospital', 'Chesapeake', 'East', 748, 'Caryn Smith', 'Universal Health Services');

INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('VA Medical Center Martinsburg', 'Chesapeake', 'East', 338, 'Bradley Adkins', 'VA Capitol Health Care Network (VISN 5)');
INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('Western Maryland Regional Medical Center', 'Chesapeake', 'East', 1876, 'Bradley Adkins', 'University of Pittsburgh Medical Center (UPMC)');

INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('VA Medical Center West Haven', 'Metro NYC', 'East', 4, 'Kaleigh Costello', 'VA New England Healthcare System (VISN 1)');
INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('Stamford Hospital', 'Metro NYC', 'East', 710, 'Kaleigh Costello', 'Stamford Health');

INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('Lincoln Medical Center', 'Metro NYC', 'East', 2753, 'Benjamin Carlos', 'NYC Health and Hospitals');
INSERT INTO DIM_ACCOUNT (account_name, district, zone_name, definitive_id, kam, idn)
VALUES ('Jacobi Medical Center', 'Metro NYC', 'East', 2755, 'Benjamin Carlos', 'NYC Health and Hospitals');

select * from DIM_ACCOUNT;

CREATE TABLE IF NOT EXISTS DIM_QUESTION_SECTION (
    id SERIAL PRIMARY KEY,
    question_section_name varchar(100) NOT NULL
--    order int NOT_NULL
);

INSERT INTO DIM_QUESTION_SECTION (question_section_name) VALUES ('Customer Overview');
INSERT INTO DIM_QUESTION_SECTION (question_section_name) VALUES ('Migration Status');

select * from DIM_QUESTION_SECTION;

CREATE TABLE IF NOT EXISTS DIM_QUESTION_SUB_SECTION (
    id SERIAL PRIMARY KEY,
    question_sub_section_name varchar(100) NOT NULL
--    order int NOT_NULL
);

INSERT INTO DIM_QUESTION_SUB_SECTION (question_sub_section_name) VALUES ('Account Summary');
INSERT INTO DIM_QUESTION_SUB_SECTION (question_sub_section_name) VALUES ('Wards & Beds');
INSERT INTO DIM_QUESTION_SUB_SECTION (question_sub_section_name) VALUES ('Planning & Budgeting');

select * from DIM_QUESTION_SUB_SECTION;

CREATE TABLE IF NOT EXISTS DIM_QUESTION (
    id SERIAL PRIMARY KEY,
    question_name varchar(100) NOT NULL,
--    order int NOT_NULL,
    question_desc varchar,
    answer_guide varchar,
    drop_down_options varchar
);

INSERT INTO DIM_QUESTION (question_name, question_desc, answer_guide, drop_down_options)
VALUES ('Account Type', 'drop-down', 'IDN, Academic, Children''s, Government, Other', 'IDN | Academic | Children''s | Government | Other');
INSERT INTO DIM_QUESTION (question_name)
VALUES ('How many sites/facilities with >= 150 beds');

INSERT INTO DIM_QUESTION (question_name, question_desc, answer_guide, drop_down_options)
VALUES ('Total number of sites with ICU beds', 'Whole number only', '' , '');
INSERT INTO DIM_QUESTION (question_name, question_desc, answer_guide, drop_down_options)
VALUES ('% ICU Beds standardized to Philips Monitoring', '% drop-down', '' , '<10% | 10%-25% | 25%-50% | 50%-75% | >75% | 100%');

INSERT INTO DIM_QUESTION (question_name, question_desc, answer_guide, drop_down_options)
VALUES ('Opportunities in SFDC?', 'drop-down', '', 'yes | no');
INSERT INTO DIM_QUESTION (question_name, question_desc, answer_guide, drop_down_options)
VALUES ('Is there a Technology Management Plan (TMP) at the IDN Level?', 'drop-down', '', 'yes | no');

select * from DIM_QUESTION;

CREATE TABLE IF NOT EXISTS FACT_FORM_SECTION_SUB_SECTION_QUESTIONS (
    id SERIAL PRIMARY KEY,
    form_type varchar(100) NOT NULL,
    question_section_id int,
    question_sub_section_id int,
    question_id int NOT NULL,
    form_question_order int,
    CONSTRAINT fk_form_type FOREIGN KEY(form_type) REFERENCES DIM_FORM_TYPE(form_type),
    CONSTRAINT fk_question_section_id FOREIGN KEY(question_section_id) REFERENCES DIM_QUESTION_SECTION(id),
    CONSTRAINT fk_question_sub_section_id FOREIGN KEY(question_sub_section_id) REFERENCES DIM_QUESTION_SUB_SECTION(id),
    CONSTRAINT fk_question_id FOREIGN KEY(question_id) REFERENCES DIM_QUESTION(id),
    CONSTRAINT unique_form_type_question UNIQUE(form_type, question_section_id, question_sub_section_id, question_id)
);

INSERT INTO FACT_FORM_SECTION_SUB_SECTION_QUESTIONS (form_type, question_section_id, question_sub_section_id, question_id, form_question_order)
VALUES ('SCORECARD', 1, 1, 1, 1);
INSERT INTO FACT_FORM_SECTION_SUB_SECTION_QUESTIONS (form_type, question_section_id, question_sub_section_id, question_id, form_question_order)
VALUES ('SCORECARD', 1, 1, 2, 2);

INSERT INTO FACT_FORM_SECTION_SUB_SECTION_QUESTIONS (form_type, question_section_id, question_sub_section_id, question_id, form_question_order)
VALUES ('SCORECARD', 1, 2, 3, 3);
INSERT INTO FACT_FORM_SECTION_SUB_SECTION_QUESTIONS (form_type, question_section_id, question_sub_section_id, question_id, form_question_order)
VALUES ('SCORECARD', 1, 2, 4, 4);

INSERT INTO FACT_FORM_SECTION_SUB_SECTION_QUESTIONS (form_type, question_section_id, question_sub_section_id, question_id, form_question_order)
VALUES ('SCORECARD', 2, 3, 5, 5);
INSERT INTO FACT_FORM_SECTION_SUB_SECTION_QUESTIONS (form_type, question_section_id, question_sub_section_id, question_id, form_question_order)
VALUES ('SCORECARD', 2, 3, 6, 6);

select * from FACT_FORM_SECTION_SUB_SECTION_QUESTIONS;

CREATE TABLE IF NOT EXISTS FACT_SCORECARD_KEY (
    id SERIAL PRIMARY KEY,
    zone_name varchar(100) NOT NULL,
    district varchar NOT NULL,
    idn varchar,
    national_idn char(1) NOT NULL,
    account_name varchar NOT NULL,
    kam varchar NOT NULL,
    form_version int NOT NULL,
    form_status varchar NOT NULL,
    progress_percentage int NOT NULL,
    created_by varchar NOT NULL DEFAULT 'test',
    updated_by varchar NOT NULL DEFAULT 'test',
    created_date date NOT NULL DEFAULT now(),
    updated_date date NOT NULL DEFAULT now(),
    CONSTRAINT fk_kam_user FOREIGN KEY(kam) REFERENCES DIM_USER(user_name),
    CONSTRAINT unique_scorecard_form UNIQUE(zone_name, district, idn, national_idn, account_name, kam, form_version)
);

CREATE TABLE IF NOT EXISTS FACT_SCORECARD_DETAILS (
    id SERIAL PRIMARY KEY,
    fact_scorecard_key_id int NOT NULL,
--    form_version int NOT NULL,
    question_id int NOT NULL,
    answers varchar,
    created_by varchar NOT NULL DEFAULT 'test',
    updated_by varchar NOT NULL DEFAULT 'test',
    created_date date NOT NULL DEFAULT now(),
    updated_date date NOT NULL DEFAULT now(),
    CONSTRAINT fk_fact_scorecard_key_id FOREIGN KEY(fact_scorecard_key_id) REFERENCES FACT_SCORECARD_KEY(id),
--    CONSTRAINT fk_fact_scorecard_form_version FOREIGN KEY(form_version) REFERENCES FACT_SCORECARD_KEY(form_version),
--    CONSTRAINT fk_fact_scorecard_key_and_version FOREIGN KEY(fact_scorecard_key_id, form_version) REFERENCES FACT_SCORECARD_KEY(id, form_version),
    CONSTRAINT fk_question_id FOREIGN KEY(question_id) REFERENCES DIM_QUESTION(id),
    CONSTRAINT unique_scorecard_details UNIQUE(fact_scorecard_key_id, question_id)
);


