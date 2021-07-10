
DROP DATABASE IF EXISTS electric_power_db;
CREATE DATABASE electric_power_db;
USE electric_power_db;

DROP TABLE IF EXISTS substations;
CREATE TABLE substations (
id SERIAL PRIMARY KEY, 
name VARCHAR(255) NOT NULL,
address VARCHAR(255)
);

DROP TABLE IF EXISTS current_transformers_1ph;
CREATE TABLE current_transformers_1ph (
id SERIAL PRIMARY KEY, 
count_parallel_ct TINYINT UNSIGNED,
count_serial_ct TINYINT UNSIGNED
);

DROP TABLE IF EXISTS current_transformers_3ph;
CREATE TABLE current_transformers_3ph (
id SERIAL PRIMARY KEY, 
substation_id BIGINT UNSIGNED NOT NULL,
name VARCHAR(100) NOT NULL,
phase_A_id BIGINT UNSIGNED NOT NULL,
phase_B_id BIGINT UNSIGNED,
phase_C_id BIGINT UNSIGNED,
type VARCHAR(100) NOT NULL,
voltage_class SMALLINT UNSIGNED NOT NULL,
I1_nom SMALLINT UNSIGNED NOT NULL,
I2_nom TINYINT UNSIGNED NOT NULL,
scheme VARCHAR(50) NOT NULL,

FOREIGN KEY (substation_id) REFERENCES substations(id),
FOREIGN KEY (phase_A_id) REFERENCES current_transformers_1ph (id),
FOREIGN KEY (phase_B_id) REFERENCES current_transformers_1ph (id),
FOREIGN KEY (phase_C_id) REFERENCES current_transformers_1ph (id)
);

DROP TABLE IF EXISTS cabels;
CREATE TABLE cabels (
id SERIAL PRIMARY KEY, 
type VARCHAR(255),
material VARCHAR(20),
cross_section_area FLOAT(3,1) UNSIGNED NOT NULL
);

DROP TABLE IF EXISTS VIchar;
CREATE TABLE VIchar (
id SERIAL PRIMARY KEY, 
currents TEXT NOT NULL,
voltages TEXT NOT NULL,
voltage_middle_lin FLOAT(5,1) UNSIGNED,
current_middle_lin FLOAT(5,1) UNSIGNED,
voltage_magnetization FLOAT(5,1) UNSIGNED,
current_magnetization FLOAT(5,1) UNSIGNED
);

DROP TABLE IF EXISTS BHchar;
CREATE TABLE BHchar (
id SERIAL PRIMARY KEY, 
mf_strength TEXT NOT NULL,
mf_induction TEXT NOT NULL
);

DROP TABLE IF EXISTS secondary_windings;
CREATE TABLE secondary_windings (
id SERIAL PRIMARY KEY, 
CT_id BIGINT UNSIGNED NOT NULL,
active_resistance FLOAT UNSIGNED NOT NULL,
inductive_resistance FLOAT UNSIGNED NOT NULL,
rated_load FLOAT UNSIGNED NOT NULL,
rated_power TINYINT UNSIGNED NOT NULL,
cos_phi_nom FLOAT(1,1) UNSIGNED NOT NULL,
accuracy_class VARCHAR(5),
k_nom TINYINT UNSIGNED NOT NULL,
k_trans_nom TINYINT UNSIGNED NOT NULL,
cable_id BIGINT UNSIGNED NOT NULL,
cable_length MEDIUMINT UNSIGNED NOT NULL,
cable_count_core TINYINT UNSIGNED NOT NULL,
load_resistance_1ph_sc FLOAT UNSIGNED NOT NULL,
load_resistance_3ph_sc FLOAT UNSIGNED NOT NULL,
residual_magnetization FLOAT(2,2) UNSIGNED NOT NULL,
VIchar_id BIGINT UNSIGNED,
turn_number MEDIUMINT UNSIGNED,
core_cross_section_area FLOAT UNSIGNED, 
magnetic_line_length FLOAT UNSIGNED, 
BHchar_id BIGINT UNSIGNED,
t_sat_1ph_sc_without_rf FLOAT(3,1) UNSIGNED,
t_sat_1ph_sc_with_rf FLOAT(3,1) UNSIGNED,
t_sat_3ph_sc_without_rf FLOAT(3,1) UNSIGNED,
t_sat_3ph_sc_with_rf FLOAT(3,1) UNSIGNED,

FOREIGN KEY (CT_id) REFERENCES current_transformers_1ph(id),
FOREIGN KEY (cable_id) REFERENCES cabels(id),
FOREIGN KEY (VIchar_id) REFERENCES VIchar(id),
FOREIGN KEY (BHchar_id) REFERENCES BHchar(id)
);

DROP TABLE IF EXISTS short_circuit_currents;
CREATE TABLE short_circuit_currents (
id SERIAL PRIMARY KEY, 
transformer_id BIGINT UNSIGNED NOT NULL,
sc_point VARCHAR(5),
sc_kind VARCHAR(10),
sum_current_sc_1ph SMALLINT UNSIGNED,
eq_tau_sc_1ph FLOAT(3,1) UNSIGNED,
sum_current_sc_3ph SMALLINT UNSIGNED,
eq_tau_sc_3ph FLOAT(3,1) UNSIGNED,

FOREIGN KEY (transformer_id) REFERENCES current_transformers_3ph(id)
);

DROP TABLE IF EXISTS branch_short_circuit_currents;
CREATE TABLE branch_short_circuit_currents (
id SERIAL PRIMARY KEY, 
sc_sum_id BIGINT UNSIGNED NOT NULL,
branch_current SMALLINT UNSIGNED,
branch_tau FLOAT(3,1) UNSIGNED,
shift_angle SMALLINT UNSIGNED,
type_sc TINYINT UNSIGNED,

FOREIGN KEY (sc_sum_id) REFERENCES short_circuit_currents (id)
);

DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
id SERIAL PRIMARY KEY, 
name VARCHAR(255),
address VARCHAR(255),
phone BIGINT UNSIGNED UNIQUE,
head_position VARCHAR (100),
head_firstname VARCHAR (50),
head_lastname VARCHAR (50),
head_patronymic VARCHAR (50)
);

DROP TABLE IF EXISTS relay_protection_eqs;
CREATE TABLE relay_protection_eqs (
id SERIAL PRIMARY KEY, 
type VARCHAR(255),
manufacturer_id BIGINT UNSIGNED NOT NULL,
need_t_sat FLOAT(3,1) UNSIGNED,

FOREIGN KEY (manufacturer_id) REFERENCES companies (id)
);
DROP TABLE IF EXISTS connections_to_windings;
CREATE TABLE connections_to_windings (
winding_id BIGINT UNSIGNED NOT NULL, 
equipment_id BIGINT UNSIGNED NOT NULL,

FOREIGN KEY (winding_id) REFERENCES secondary_windings (id),
FOREIGN KEY (equipment_id) REFERENCES relay_protection_eqs (id)
);
DROP TABLE IF EXISTS connections_to_zero_cable;
CREATE TABLE connections_to_zero_cable (
winding_id BIGINT UNSIGNED NOT NULL, 
equipment_id BIGINT UNSIGNED NOT NULL,

FOREIGN KEY (winding_id) REFERENCES secondary_windings (id),
FOREIGN KEY (equipment_id) REFERENCES relay_protection_eqs (id)
);
DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY, 
substation_id BIGINT UNSIGNED NOT NULL,
firstname VARCHAR(50),
lastname VARCHAR(50), 
companie_id BIGINT UNSIGNED NOT NULL,
photo_path TEXT,
mail VARCHAR(120) UNIQUE,
phone BIGINT UNSIGNED UNIQUE,
gender CHAR(1),
hometown VARCHAR(100),
password_hash VARCHAR(100),
created_at DATETIME DEFAULT NOW(),

INDEX users_name_idx(firstname, lastname),
FOREIGN KEY (substation_id) REFERENCES substations (id),
FOREIGN KEY (companie_id) REFERENCES companies (id)
);
