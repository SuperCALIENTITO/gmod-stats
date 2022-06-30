stats = {}
stats.language = {}
if SERVER and not sql.TableExists("stats_mp") then
    sql.Query([[CREATE TABLE IF NOT EXISTS stats_mp ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        player INTEGER NOT NULL,
        kill INTEGER NOT NULL,
        death INTEGER NOT NULL,
        connection INTEGER NOT NULL,
        chat INTEGER NOT NULL,
        noclip INTEGER NOT NULL,
        physgun INTEGER NOT NULL )]])
end

local function AddFile(file, dir)
    local prefix = string.lower(string.Left(file, 3))
    if SERVER and (prefix == "sv_") then
        include(dir .. file)
        print("[STATS] SERVER INCLUDE: " .. file)
    elseif (prefix == "sh_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print( "[STATS] SHARED: " .. file)
        end
        include(dir .. file)
        print("[STATS] SHARED INCLUDE: " .. file)
    elseif (prefix == "cl_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print( "[STATS] CLIENT ADDCS: " .. file)
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

    for _, v in ipairs(directories) do
        AddDir(dir .. v)
    end
end
AddDir("gmodstats")