#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# If no argument provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Check if argument is a number
if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_INFO=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type 
    FROM elements 
    INNER JOIN properties ON elements.atomic_number = properties.atomic_number 
    INNER JOIN types ON properties.type_id = types.type_id 
    WHERE elements.atomic_number = $1")
else
  # Check if argument is a symbol or name
  ELEMENT_INFO=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type 
    FROM elements 
    INNER JOIN properties ON elements.atomic_number = properties.atomic_number 
    INNER JOIN types ON properties.type_id = types.type_id 
    WHERE symbol = '$1' OR name = '$1'")
fi

# If element not found
if [[ -z $ELEMENT_INFO ]]
then
  echo "I could not find that element in the database."
  exit
fi

# Read element info into variables
echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME MASS MELTING BOILING TYPE
do
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
done 