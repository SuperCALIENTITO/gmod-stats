stats = {}
stats.language = {}
stats.validType = {
    ["kill"] = true,
    ["death"] = true,
    ["connection"] = true,
    ["chat"] = true,
    ["noclip"] = true,
    ["physgun"] = true,
    ["use_vehicle"] = true,
}
if SERVER and not sql.TableExists("stats_mp") then
    sql.Query([[CREATE TABLE IF NOT EXISTS stats_mp (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        player INTEGER NOT NULL,
        plyname VARCHAR(255) NOT NULL,
        kill INTEGER NOT NULL DEFAULT 0,
        death INTEGER NOT NULL DEFAULT 0,
        connection INTEGER NOT NULL DEFAULT 0,
        chat INTEGER NOT NULL DEFAULT 0,
        noclip INTEGER NOT NULL DEFAULT 0,
        physgun INTEGER NOT NULL DEFAULT 0,
        use_vehicle INTEGER NOT NULL DEFAULT 0
    )]])
end

if SERVER then
util.AddNetworkString("gstatsShow")
util.AddNetworkString("gstatsAdmin")

function stats.setStat(ply, hType)
    if ply:IsPlayer() and stats.validType[hType] then

        local exists = sql.Query("SELECT * FROM stats_mp WHERE player = " .. ply:SteamID64() .. ";")

        if not exists then
            sql.Query("INSERT INTO stats_mp (player, plyname, kill, death, connection, chat, noclip, physgun, use_vehicle) VALUES (" .. ply:SteamID64() .. ", " .. ply:Name() .. ", 0, 0, 0, 0, 0, 0, 0);")
            sql.Query("UPDATE stats_mp SET " .. hType .. " = " .. hType .. " + 1 WHERE player = " .. ply:SteamID64())
        else
            sql.Query("UPDATE stats_mp SET " .. hType .. " = " .. hType .. " + 1 WHERE player = " .. ply:SteamID64())
        end

    end
end

end

local function AddFile(file, dir)
    local prefix = string.lower(string.Left(file, 3))
    if SERVER and (prefix == "sv_") then
        include(dir .. file)
        print("[STATS] SERVER INCLUDE: " .. file)
    elseif (prefix == "sh_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[STATS] SHARED ADDCS: " .. file)
        end
        include(dir .. file)
        print("[STATS] SHARED INCLUDE: " .. file)
    elseif (prefix == "cl_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[STATS] CLIENT ADDCS: " .. file)
        elseif CLIENT then
            include(dir .. file)
            print("[STATS] CLIENT INCLUDE: " .. file)
        end
    end
end

local function AddDir(dir)
    dir = dir .. "/"

    local files, directories = file.Find(dir .. "*", "LUA")
    for _, v in ipairs(files) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, dir)
        end
    end

    for _, v in ipairs(directories) do AddDir(dir .. v) end
end
AddDir("gmodstats")
