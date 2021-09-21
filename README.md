1.change the config to your language and set permission. you can also use webhook to log the bans if you want. 
2. run the sql file.
3.really important! to use offline bans, you need to replace  QBcore/server/events in the PlayerJoined event in dependency.lua to the code written down below so everytime a player join it will save him. 
4.
requirements: 
1. mysql-async
2. async 
3. QBCore
all requirements need to be started before the script itself! 
