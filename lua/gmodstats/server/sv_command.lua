util.AddNetworkString("gstatsShow")
util.AddNetworkString("gstatsAdmin")
hook.Add("PlayerSay", "ShowStats", function(ply, text)
	if (string.lower(text) == "!stats admin") then
		if ply:IsAdmin() or ply:IsSuperAdmin() then
			local stats = sql.Query("SELECT * FROM stats_mp;")
			net.Start("gstatsAdmin")
				net.WriteTable(stats)
			net.Send(ply)
			return ""
		end
		return text
	elseif (string.lower(text) == "!stats") then
		local stats = sql.Query("SELECT * FROM stats_mp WHERE player = " .. sql.SQLStr(ply:SteamID64()) .. ";")
		net.Start("gstatsShow")
			net.WriteTable({
				id = ply:SteamID64(),
				name = ply:Name(),
				deaths = stats[1]["death"],
				kills = stats[1]["kill"],
				connections = stats[1]["connection"],
				chat = stats[1]["chat"],
				noclip = stats[1]["noclip"],
				physgun = stats[1]["physgun"],
				use_vehicle = stats[1]["use_vehicle"]
			})
		net.Send(ply)
		print("[GModStats] " .. ply:Name() .. " " .. GMS_GetLanguage("asked"))
		return ""
	end
end)