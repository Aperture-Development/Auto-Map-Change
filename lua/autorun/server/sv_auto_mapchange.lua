--[[
	###############################################################
	Auto Mapchange System   by: Aperture Hosting
	Licence: Attribution-NonCommercial-ShareAlike 4.0 International
	###############################################################
]]

AutoMapchange = AutoMapchange or {}
AutoMapchange.Enabled = true

AutoMapchange.SmallMap		= CreateConVar( "automap_smallmap", "rp_bangclaw", FCVAR_NONE, "The map when the player count is under the limit." )
AutoMapchange.BigMap		= CreateConVar( "automap_bigmap", "rp_florida", FCVAR_NONE, "The map when the player count is above the limit." )
AutoMapchange.PlayerLimit 	= CreateConVar( "automap_playerlimit", 20, FCVAR_NONE, "The player limit on which the map should change" )

AutoMapchange.SmallMap_String		= AutoMapchange.SmallMap:GetString()
AutoMapchange.BigMap_String			= AutoMapchange.BigMap:GetString()
AutoMapchange.PlayerLimit_Number	= AutoMapchange.PlayerLimit:GetInt()

AutoMapchange.Anouncements = {}
AutoMapchange.Anouncements[600] = true
AutoMapchange.Anouncements[300] = true
AutoMapchange.Anouncements[240] = true
AutoMapchange.Anouncements[180] = true
AutoMapchange.Anouncements[120] = true
AutoMapchange.Anouncements[60] = true
AutoMapchange.Anouncements[30] = true
AutoMapchange.Anouncements[15] = true
AutoMapchange.Anouncements[10] = true
AutoMapchange.Anouncements[9] = true
AutoMapchange.Anouncements[8] = true
AutoMapchange.Anouncements[7] = true
AutoMapchange.Anouncements[6] = true
AutoMapchange.Anouncements[5] = true
AutoMapchange.Anouncements[4] = true
AutoMapchange.Anouncements[3] = true
AutoMapchange.Anouncements[2] = true
AutoMapchange.Anouncements[1] = true


-- Permission checker for the command
function AutoMapchange.CheckPermission(ply,perm)

	if ULib then
		return ULib.ucl.query(ply,perm)
	elseif evolve then
		return ply:EV_HasPrivilege( perm )
	else
		return ply:IsAdmin()
	end
	
end

-- Time Translator
function AutoMapchange.TTime(time)
	
	if time > 60 and (time/60)>=1 then
		return (time/60).." Minutes"
	else
		return time.." Seconds"
	end
	
end

--Chat Print
function AutoMapchange.ChatPrint(message,bool)

	if bool == nil then
		bool = false
	end

	net.Start("AutoMap_ChatPrint")
		net.WriteString(message)
		net.WriteBool(bool)
	net.Broadcast()
	
end

--Check the online players
function AutoMapchange.CheckPlayers()

	local plyCount = player.GetCount()
	
	if plyCount<AutoMapchange.PlayerLimit_Number then
	
		AutoMapchange.MapChange(AutoMapchange.SmallMap_String)
		
	elseif plyCount>=AutoMapchange.PlayerLimit_Number then
	
		AutoMapchange.MapChange(AutoMapchange.BigMap_String)
		
	end
	
end


--Changemap Timer
function AutoMapchange.MapChange(map)
	
	local curMap = game.GetMap()
	
	if not timer.Exists("changemap") and map != curMap and AutoMapchange.Enabled then
		
	
		timer.Create( "changemap", 1, 601, function()
			
			local reps = timer.RepsLeft( "changemap" )
			
			if AutoMapchange.Anouncements[reps] then
			
				AutoMapchange.ChatPrint("Mapchange in "..AutoMapchange.TTime(reps),true)
				
			end
			
			if reps == 0 then
				RunConsoleCommand("changelevel",map)
			end
			
		end)
		
	elseif timer.Exists("changemap") and map == curMap and AutoMapchange.Enabled then
	
		timer.Remove("changemap")
		
	end
	
end


--Init Function
function AutoMapchange.Init()

	util.AddNetworkString("AutoMap_ChatPrint")
	
	print("[AutoMap] Script disabled Reason: Mapchange or Init")
	print("[AutoMap] Automapchange disabled for 5 Minutes!")
	timer.Simple(300, function()
		
		hook.Add( "PlayerInitialSpawn", "CheckPlayer_AutoMap", function( ply )
			
			AutoMapchange.CheckPlayers()
			
		end)
		
	end)
	
	
	if ULib then
		ULib.ucl.registerAccess("auto_mapchange_abort","admin","Grants access to the Auto Mapchange abort command","Command")
	elseif evolve then
		table.Add( evolve.privileges, "auto_mapchange_abort" ) 
		table.sort( evolve.privileges )
	end

end

hook.Add( "PlayerSay", "AutoMap_ChatListener", function( ply, text, team )
	if ( string.sub( text, 1, 6 ) == "!abort" ) then
		if AutoMapchange.CheckPermission(ply,"auto_mapchange_abort") and timer.Exists("changemap") then
		
			AutoMapchange.Enabled = false
			timer.Remove("changemap")
			AutoMapchange.ChatPrint("Mapchange Aborted by: "..ply:Nick())
			AutoMapchange.ChatPrint("There will be no Automatic Mapchange until one of the following things:")
			AutoMapchange.ChatPrint("- A Manual Mapchange")
			AutoMapchange.ChatPrint("- An Server restart")
			
		end
	elseif ( string.sub( text, 1, 4 ) == "!dev" ) then
	
		ply:SendLua("chat.AddText( [[The Auto Mapchange script was made by Aperture Hosting: https://www.Aperture-Hosting.de/ ]] )")
	elseif ( string.sub( text, 1, 4 ) == "!deb" ) then
		AutoMapchange.ChatPrint("Test1")
		AutoMapchange.ChatPrint("test2",true)
	end
end )

AutoMapchange.Init()