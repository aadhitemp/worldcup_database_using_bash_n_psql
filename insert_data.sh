#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINGOAL OPPGOAL
do
 if [[ $YEAR != "year" ]]
 then
 OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
 WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
 if [[ -z $OPP_ID ]]
 then
  INS_OPP_RES=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
  if [[ $INS_OPP_RES == "INSERT 0 1" ]]
  then
   echo Inserted into teams, $OPPONENT
  fi
  OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
fi
if [[ -z $WIN_ID ]]
 then
  INS_OPP_RES=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
  if [[ $INS_OPP_RES == "INSERT 0 1" ]]
  then
    echo Inserted into teams, $WINNER
  fi
  WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
fi
INS_GAM=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR,'$ROUND', $WIN_ID, $OPP_ID, $WINGOAL, $OPPGOAL)")
  if [[ $INS_GAM == "INSERT 0 1" ]]
  then
    echo Inserted into games, $YEAR $ROUND, $WINNER vs $OPPONENT
  fi 
 fi
done
