#!/bin/bash

# PostgreSQL database setup
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generate random number between 1 and 1000
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
GUESSES=0

# Get username
echo "Enter your username:"
read USERNAME

# Username should be max 22 chars
if [[ ${#USERNAME} -gt 22 ]]
then
  exit
fi

# Check if user exists
USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]
then
  # If user doesn't exist, insert new user
  INSERT_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, 0)")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  # Parse existing user info
  IFS='|' read GAMES_PLAYED BEST_GAME <<< $USER_INFO
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"

while true; do
  read GUESS
  
  # Check if input is an integer
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi

  # Increment guess counter
  ((GUESSES++))

  # Check guess against secret number
  if [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    
    # Update user statistics
    if [[ -z $USER_INFO ]]
    then
      # First game for new user
      UPDATE_STATS=$($PSQL "UPDATE users SET games_played = 1, best_game = $GUESSES WHERE username = '$USERNAME'")
    else
      # Update existing user's stats
      if [[ $GUESSES -lt $BEST_GAME || $BEST_GAME -eq 0 ]]
      then
        UPDATE_STATS=$($PSQL "UPDATE users SET games_played = games_played + 1, best_game = $GUESSES WHERE username = '$USERNAME'")
      else
        UPDATE_STATS=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username = '$USERNAME'")
      fi
    fi
    break
  elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
  else
    echo "It's lower than that, guess again:"
  fi
done 