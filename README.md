# Auto Map Changer #  
  
This system allows your server to automaticly change the map when your serevr reaches an specified amount of Players.  
This allows you to have an Small map when less players are online and an big map when much players are online.  
  
  
  
# How to Setup #  
  
There is no In-Game UI. Everything is setup by ConVars  
  
ConVar: automap_smallmap  
Default: rp_bangclaw  
Description: Set this CVar to the map when the playercount is below the playerlimit  
  
ConVar: automap_bigmap  
Default: rp_florida  
Description: Set this CVar to the map when the playercount is above the playerlimit  
  
ConVar: automap_playerlimit  
Default: 20  
Description: Set this CVar to the playerlimit which will cause a mapchange.  
  
For your admins, to be able to abort the Mapchange, you need to add an Permission to their rank.  
If you have no Permission system then everyone with admin gets access to the command.  
  
Commands:  
  
CMD: !abort  
Desc: Aborts the mapchange  
  
CMD: !dev  
Desc: Shows the information of Aperture Hosting  
  
# Support #  
  
Support is Provided over the Aperture Hosting website: https://www.Aperture-Hosting.de/ticketsystem  
