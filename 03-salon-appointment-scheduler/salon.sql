-- Drop database if exists and recreate it
DROP DATABASE IF EXISTS salon;
CREATE DATABASE salon;

-- Connect to salon database
\c salon;

-- Create tables
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    phone VARCHAR UNIQUE NOT NULL,
    name VARCHAR NOT NULL
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    service_id INTEGER REFERENCES services(service_id),
    time VARCHAR NOT NULL
);

-- Insert initial services
INSERT INTO services (name) VALUES 
    ('cut'),
    ('color'),
    ('perm'),
    ('style'),
    ('trim'); 