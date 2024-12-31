-- Create database
DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;

-- Connect to database
\c universe

-- Create tables
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    age_in_millions_of_years INT NOT NULL,
    distance_from_earth NUMERIC(10,2),
    has_life BOOLEAN DEFAULT false,
    is_spherical BOOLEAN DEFAULT true,
    description TEXT
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    temperature_kelvin INT NOT NULL,
    mass_solar_masses NUMERIC(8,2),
    is_binary BOOLEAN DEFAULT false,
    is_visible_from_earth BOOLEAN DEFAULT true,
    color VARCHAR(30)
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id),
    orbital_period_days INT,
    diameter_km INT NOT NULL,
    has_atmosphere BOOLEAN DEFAULT true,
    has_water BOOLEAN DEFAULT false,
    planet_type VARCHAR(30)
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    orbital_period_days INT,
    diameter_km INT NOT NULL,
    is_spherical BOOLEAN DEFAULT true,
    has_atmosphere BOOLEAN DEFAULT false,
    surface_type VARCHAR(30)
);

-- Additional table to meet five-table requirement
CREATE TABLE asteroid (
    asteroid_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    diameter_km INT NOT NULL,
    is_potentially_hazardous BOOLEAN DEFAULT false,
    discovery_year INT,
    composition VARCHAR(50)
);

-- Insert sample data
INSERT INTO galaxy (name, age_in_millions_of_years, distance_from_earth, has_life, description)
VALUES 
    ('Milky Way', 13600, 0.0, true, 'Our home galaxy'),
    ('Andromeda', 10000, 2.537, false, 'Nearest major galaxy'),
    ('Triangulum', 10000, 2.73, false, 'Third-largest galaxy in the Local Group'),
    ('Large Magellanic Cloud', 1101, 0.163, false, 'Satellite galaxy of the Milky Way'),
    ('Small Magellanic Cloud', 6500, 0.197, false, 'Dwarf galaxy near Milky Way'),
    ('Centaurus A', 13270, 13.05, false, 'Peculiar galaxy with dark dust lane');

INSERT INTO star (name, galaxy_id, temperature_kelvin, mass_solar_masses, is_binary)
VALUES 
    ('Sun', 1, 5778, 1.00, false),
    ('Proxima Centauri', 1, 3042, 0.12, false),
    ('Alpha Centauri A', 1, 5790, 1.10, true),
    ('Betelgeuse', 1, 3600, 17.7, false),
    ('Sirius', 1, 9940, 2.02, true),
    ('Vega', 1, 9602, 2.13, false);

INSERT INTO planet (name, star_id, orbital_period_days, diameter_km, has_atmosphere, has_water)
VALUES 
    ('Mercury', 1, 88, 4879, false, false),
    ('Venus', 1, 225, 12104, true, false),
    ('Earth', 1, 365, 12742, true, true),
    ('Mars', 1, 687, 6779, true, true),
    ('Jupiter', 1, 4333, 139820, true, false),
    ('Saturn', 1, 10759, 116460, true, false),
    ('Uranus', 1, 30687, 50724, true, false),
    ('Neptune', 1, 60190, 49244, true, false),
    ('Kepler-186f', 2, 130, 11000, true, true),
    ('Proxima b', 2, 11, 12000, true, false),
    ('TRAPPIST-1e', 3, 6, 9200, true, true),
    ('HD 40307g', 3, 198, 16400, true, false);

INSERT INTO moon (name, planet_id, orbital_period_days, diameter_km, is_spherical)
VALUES 
    ('Moon', 3, 27, 3475, true),
    ('Phobos', 4, 0.3, 22, false),
    ('Deimos', 4, 1.2, 12, false),
    ('Io', 5, 1.8, 3642, true),
    ('Europa', 5, 3.5, 3122, true),
    ('Ganymede', 5, 7.2, 5268, true),
    ('Callisto', 5, 16.7, 4821, true),
    ('Titan', 6, 15.9, 5150, true),
    ('Enceladus', 6, 1.4, 504, true),
    ('Mimas', 6, 0.9, 396, true),
    ('Triton', 8, 5.9, 2707, true),
    ('Nereid', 8, 360, 340, false),
    ('Naiad', 8, 0.3, 60, false),
    ('Thalassa', 8, 0.3, 80, false),
    ('Despina', 8, 0.3, 150, false),
    ('Galatea', 8, 0.4, 170, false),
    ('Larissa', 8, 0.5, 190, false),
    ('Proteus', 8, 1.1, 420, true),
    ('Halimede', 8, 1879, 60, false),
    ('Psamathe', 8, 9115, 38, false);

INSERT INTO asteroid (name, diameter_km, is_potentially_hazardous, discovery_year)
VALUES 
    ('Ceres', 940, false, 1801),
    ('Vesta', 525, false, 1807),
    ('Pallas', 512, false, 1802); 