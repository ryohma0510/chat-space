# Explanations for DB construcure

## tables and columns

messages table

|column|type|constraint|index|
|:--|:--|:--|:--:|
|content|string|not null|add|
|image|string|||
|group_id|references|not null , foreign key||
|user_id|references|not null , foreign key||


groups table

|column|type|constraint|index|
|:--|:--|:--|:--:|
|name|string|not null||

users table

|column|type|constraint|index|
|:--|:--|:--|:--:|
|name|string|not null||
|email|string|not null, unique ||
|password|string|not null||


users_groups table

|column|type|constraint|index|
|:--|:--|:--|:--:|
|user_id|references|not null, foreign key||
|group_id|references|not null, foreign key ||


## Association

User <- Users_group ->Group
User -> Message
