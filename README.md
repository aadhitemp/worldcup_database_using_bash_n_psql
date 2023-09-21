﻿# worldcup_database_using_bash_n_psql
```mermaid
---
title: WorldCup Database
---
erDiagram
games }|--|{ teams : contains
games{
  SERIAL game_id PK
  VARCHAR(100) round 
  INT YEAR
  INT winner_id FK
  INT opponent_id FK
  INT winner_goals 
  INT opponent_goals
}
teams{
SERIAL team_id PK
VARCHAR(100) name
}
```


