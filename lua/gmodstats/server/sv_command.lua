local function toN(t,n) return tonumber(string.sub(t,n)) end

hook.Add("PlayerSay", "ShowStats", function(ply, text)
	if string.StartWith(text, "!stats admin") then
		if ply:IsAdmin() or ply:IsSuperAdmin() then
			local stats = {}
			for _, v in ipairs(player.GetAll()) do
				local query = sql.Query("SELECT * FROM stats_mp WHERE player = " .. v:SteamID64())
				if query then
					table.insert(stats, query[1])
				end
			end
			local v = 0
			
			if toN(text, -1) then
				v = toN(text, -1)
			elseif toN(text, -2) then
				v = toN(text, -2)
			elseif toN(text, -3) then
				v = toN(text, -3)
			else
				v = 0
			end

			local stats = util.Compress(util.TableToJSON(sql.Query("SELECT * FROM stats_mp WHERE plyname IS NOT NULL LIMIT 100 OFFSET " .. v*100 .. ";")))
			local bytes = #stats

			print("Bytes: " .. bytes)

			net.Start("gstatsAdmin")
				net.WriteUInt(bytes, 16)
				net.WriteData(stats, bytes)
			net.Send(ply)
		end
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
				physgun = stats[1]["physgun"]
			})
		net.Send(ply)
		print("[GModStats] " .. ply:Name() .. " " .. GMS_GetLanguage("asked"))
		return ""
	end
end)