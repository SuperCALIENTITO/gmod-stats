hook.Add("PlayerSay", "Hook-Stats", function(ply, text)
	if string.lower(text) == "!stats" then
		local id64 = ply:SteamID64()
		local name = ply:Name()
		local deaths = sql.Query("SELECT death FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
		local kills = sql.Query("SELECT kill FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
		local connections = sql.Query("SELECT connection FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
		local chat = sql.Query("SELECT chat FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
		local noclip = sql.Query("SELECT noclip FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")
		local physgun = sql.Query("SELECT physgun FROM stats_mp WHERE player = " .. sql.SQLStr(id64) .. ";")

		ply:ChatPrint("[STATS] " .. name .. " Stats:")
		ply:ChatPrint("[STATS] " .. GmS_GetLanguage("kills") .. ": " .. kills[1]["kill"])
		ply:ChatPrint("[STATS] " .. GmS_GetLanguage("death") .. ": " .. deaths[1]["death"])
		ply:ChatPrint("[STATS] " .. GmS_GetLanguage("connections") .. ": " .. connections[1]["connection"])
		ply:ChatPrint("[STATS] Chat: " .. chat[1]["chat"])
		ply:ChatPrint("[STATS] NoClip: " .. noclip[1]["noclip"])
		ply:ChatPrint("[STATS] Physgun: " .. physgun[1]["physgun"])
		MsgC(color, "[STATS] " .. name .. " " .. GmS_GetLanguage("asked") .. ".\n")
		return ""
	end
end)