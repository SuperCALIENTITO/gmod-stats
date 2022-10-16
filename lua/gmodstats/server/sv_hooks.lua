----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "StatsDeath", function(victim, inflictor, attacker)
	stats.setStat(victim, "death")

	if inflictor:IsPlayer() and (victim ~= attacker) then
		stats.setStat(attacker, "kill")
	end
end)

----------------------------------
-------------- Chat --------------
----------------------------------
hook.Add("PlayerSay", "StatsChat", function(ply)
	stats.setStat(ply, "chat")
end)

----------------------------------
------------- Noclip -------------
----------------------------------
hook.Add("PlayerNoClip", "StatsNoclip", function(ply)
	stats.setStat(ply, "noclip")
end)

----------------------------------
------------- Physgun ------------
----------------------------------
hook.Add("OnPhysgunPickup", "StatsPhysgun", function(ply)
	stats.setStat(ply, "physgun")
end)

----------------------------------
----------- Connection -----------
----------------------------------
hook.Add("PlayerInitialSpawn", "StatsConnection", function(ply)
	stats.setStat(ply, "connection")
end)

-- vehicle
--[[
hook.Add("PlayerEnteredVehicle", "StatsUseVehicle", function(ply, veh, role)
	checkPlayerDatabase(ply)

	local use_vehicle = sql.Query("SELECT use_vehicle FROM stats_mp WHERE player = " .. sql.SQLStr(ply:SteamID64()) .. ";")
	sql.Query("UPDATE stats_mp SET use_vehicle = " .. sql.SQLStr(tonumber(use_vehicle[1]["use_vehicle"]) + 1) .. " WHERE player = " .. ply:SteamID64() .. ";")
end)
--]]
