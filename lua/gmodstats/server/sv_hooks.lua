-- kills & deaths
hook.Add("PlayerDeath", "StatsDeath", function (victim, inflictor, attacker)
	local v_deaths = sql.Query("SELECT death FROM stats_mp WHERE player = " .. sql.SQLStr(victim:SteamID64()) .. ";")
	sql.Query("UPDATE stats_mp SET death = " .. sql.SQLStr(tonumber(v_deaths[1]["death"]) + 1) .. " WHERE player = " .. victim:SteamID64() .. ";")

	if inflictor:IsPlayer() and (victim ~= attacker) then
		local a_kills = sql.Query("SELECT kill FROM stats_mp WHERE player = " .. sql.SQLStr(attacker:SteamID64()) .. ";")
		sql.Query("UPDATE stats_mp SET kill = " .. sql.SQLStr(tonumber(a_kills[1]["kill"]) + 1) .. " WHERE player = " .. attacker:SteamID64() .. ";")
	end
	return
end)

-- chat
hook.Add("PlayerSay", "StatsChat", function (ply, string)
	local chat = sql.Query("SELECT chat FROM stats_mp WHERE player = " .. sql.SQLStr(ply:SteamID64()) .. ";")
	sql.Query("UPDATE stats_mp SET chat = " .. sql.SQLStr(tonumber(chat[1]["chat"]) + 1) .. " WHERE player = " .. ply:SteamID64() .. ";")
	return
end)

-- noclip
hook.Add("PlayerNoClip", "StatsNoclip", function (ply)
	local noclip = sql.Query("SELECT noclip FROM stats_mp WHERE player = " .. sql.SQLStr(ply:SteamID64()) .. ";")
	sql.Query("UPDATE stats_mp SET noclip = " .. sql.SQLStr(tonumber(noclip[1]["noclip"]) + 1) .. " WHERE player = " .. ply:SteamID64() .. ";")
	return
end)

-- physgun
hook.Add("OnPhysgunPickup", "StatsPhysgun", function (ply)
	local physgun = sql.Query("SELECT physgun FROM stats_mp WHERE player = " .. sql.SQLStr(ply:SteamID64()) .. ";")
	sql.Query("UPDATE stats_mp SET physgun = " .. sql.SQLStr(tonumber(physgun[1]["physgun"]) + 1) .. " WHERE player = " .. ply:SteamID64() .. ";")
	return
end)

-- connection
hook.Add("PlayerInitialSpawn", "StatsConnection", function (ply)
	local connection = sql.Query("SELECT connection FROM stats_mp WHERE player = " .. ply:SteamID64() .. ";")
	if not connection then
		sql.Query("INSERT into stats_mp (player, kill, death, connection, chat, noclip, physgun) VALUES (" .. ply:SteamID64() .. ", 0, 0, 0, 0, 0, 0);")
		return
	end

	sql.Query("UPDATE stats_mp SET connection = " .. sql.SQLStr(tonumber(connection[1]["connection"]) + 1) .. " WHERE player = " .. ply:SteamID64() .. ";")
	return
end)