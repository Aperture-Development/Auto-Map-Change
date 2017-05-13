--[[
	###############################################################
	Auto Mapchange System   by: Aperture Hosting
	Licence: Attribution-NonCommercial-ShareAlike 4.0 International
	###############################################################
]]

local AutoMapchange = AutoMapchange or {}

surface.CreateFont( "MapchangeTimer", {
	font = "Trebuchet24", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 55,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

net.Receive( "AutoMap_ChatPrint", function( len, ply )
	
	local text = net.ReadString()
	
	chat.AddText(Color(255,255,255),"[",Color(220,0,255),"Auto Map",Color(255,255,255),"] "..text)
	
	local pMiddleScreen = net.ReadBool()
	
	if pMiddleScreen==true then
		
		AutoMapchange.AlphaLevel = 255
		
		hook.Add( "HUDPaint", "AutoMap_MiddlePrint", function()
			draw.DrawText( text, "MapchangeTimer", ScrW()/2, ScrH()/5, Color( 255, 0, 0, AutoMapchange.AlphaLevel ), TEXT_ALIGN_CENTER )
		end )
		
		timer.Create( "AutoMap_AlphaEffect", 0.01, 140, function()
			local reps = timer.RepsLeft( "AutoMap_AlphaEffect" )
			
			if reps<52 then
				AutoMapchange.AlphaLevel = AutoMapchange.AlphaLevel-5
				
				if reps==0 then
					hook.Remove("AutoMap_MiddlePrint")
				end
			end
		end)
		
	end
end )