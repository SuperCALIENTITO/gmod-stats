---------------------------------------
---------------- Hooks ----------------
---------------------------------------


----------------------
-- Kills and Deaths --
----------------------
function statsOnDeath(victim, inflictor, attacker)
	-- Death
	local v_id64 = victim:SteamID64()
	local v_deaths = sql.Query("SELECT death FROM stats_mp WHERE player = " .. sql.SQLStr(v_id64) .. ";")
	local v_deaths_fix = v_deaths[1]["death"]
	sql.Query("UPDATE stats_mp SET death = " .. sql.SQLStr(tonumber(v_deaths_fix)+1) .. " WHERE player = " .. v_id64 .. ";")

	-- Kill
	local a_id64 = attacker:SteamID64()
	local a_kills = sql.Query("SELECT kill FROM stats_mp WHERE player = " .. sql.SQLStr(a_id64) .. ";")
	local a_kills_fix = a_kills[1]["kill"]

	if victim:GetName() ~= attacker:GetName() then
		sql.Query("UPDATE stats_mp SET kill = " .. sql.SQLStr(tonumber(a_kills_fix)+1) .. " WHERE player = " .. a_id64 .. ";")
	end

	if stats_debug == 1 then
		MsgC(color, "[STATS] ", scolor, victim:Name() .. " has now: " .. tonumber(v_deaths_fix)+1 .. " deaths.\n")
		if victim:GetName() ~= attacker:GetName() then
			MsgC(color, "[STATS] ", scolor, attacker:Name() .. " has now: " .. tonumber(a_kills_fix)+1 .. " kills.\n")
		end
	end

	return
end
hook.Add("PlayerDeath", "Hook-StatsOnDeath", statsOnDeath)


----------------------
-------- Chat --------
----------------------
function statsChat(ply, string)
	local id64 = ply:SteamID64()
	local chat = sql.Query("SELECT chat FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
	local chat_fix = chat[1]["chat"]
	sql.Query("UPDATE stats_mp SET chat = " .. sql.SQLStr(tonumber(chat_fix)+1) .. " WHERE player = " .. id64 .. ";")

	if stats_debug == 1 then
		MsgC(color, "[STATS] ", scolor, ply:Name() .. " has now: " .. tonumber(chat_fix)+1 .. " chat uses.\n")
	end

	MsgC(color, "[MSG] ", scolor, ply:Name() .. " : ", string, "\n")
	return
end
hook.Add("PlayerSay", "Hook-StatsChat", statsChat)


----------------------
------- Noclip -------
----------------------
function statsNoclip(ply)
	local id64 = ply:SteamID64()
	local noclip = sql.Query("SELECT noclip FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
	local noclip_fix = noclip[1]["noclip"]
	sql.Query("UPDATE stats_mp SET noclip = " .. sql.SQLStr(tonumber(noclip_fix)+1) .. " WHERE player = " .. id64 .. ";")

	if stats_debug == 1 then
		MsgC(color, "[STATS] ", scolor, ply:Name() .. " has now: " .. tonumber(noclip_fix)+1 .. " noclip uses.\n")
	end

	return
end
hook.Add("PlayerNoClip", "Hook-StatsNoclip", statsNoclip)


----------------------
------- Physgun ------
----------------------
function statsPhysgun(ply)
	local id64 = ply:SteamID64()
	local physgun = sql.Query("SELECT physgun FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
	local physgun_fix = physgun[1]["physgun"]
	sql.Query("UPDATE stats_mp SET physgun = " .. sql.SQLStr(tonumber(physgun_fix)+1) .. " WHERE player = " .. id64 .. ";")

	if stats_debug == 1 then
		MsgC(color, "[STATS] ", scolor, ply:Name() .. " has now: " .. tonumber(physgun_fix)+1 .. " physgun uses.\n")
	end

	return
end
hook.Add("OnPhysgunPickup", "Hook-StatsPhysgun", statsPhysgun)

----------------------
----- Custom Hook ----
----------------------
--[[
function statsCustomHook(ply)
	local id64 = ply:SteamID64()
	local custom = sql.Query("SELECT custom FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
	local custom_fix = custom[1]["custom"]
	sql.Query("UPDATE stats_mp SET use = " .. sql.SQLStr(custom+1) .. " WHERE player = " .. id64 .. ";")

	return -- ALWAYS PUT "return" AT THE END OF THE FUNCTION!!!!
end
hook.Add("PutYourHookHere", "Hook-StatsCustomHook", statsCustomHook)
--]]