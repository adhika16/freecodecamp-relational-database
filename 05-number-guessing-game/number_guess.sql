--
-- PostgreSQL database dump
--

-- Create database
DROP DATABASE IF EXISTS number_guess;
CREATE DATABASE number_guess;

\c number_guess;

-- Create users table
CREATE TABLE users (
  username VARCHAR(22) PRIMARY KEY,
  games_played INTEGER DEFAULT 0,
  best_game INTEGER DEFAULT 0
); 