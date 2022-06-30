include("gmod-stats/core.lua")

if SERVER then
    if not sql.TableExists("stats_mp") then
        sql.Query([[CREATE TABLE IF NOT EXISTS stats_mp ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            player INTEGER NOT NULL,
            kill INTEGER NOT NULL,
            death INTEGER NOT NULL,
            connection INTEGER NOT NULL,
            chat INTEGER NOT NULL,
            noclip INTEGER NOT NULL,
            physgun INTEGER NOT NULL )]])
    end
end

local function Addfile(file, dir)
    local prefix = string.lower(string.Left(file,3))

    if SERVER and prefix == "sv_" then
        include(dir .. file)
        print( "[STATS] SERVER file loaded: " .. file )
    elseif prefix == "sh_" then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print( "[STATS] SHARED file loaded: " .. file )
        end
        include(dir .. file)
        print( "[STATS] SHARED file loaded: " .. file )
    elseif prefix == "cl_" then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print( "[STATS] CLIENT file loaded: " .. file )
        elseif CLIENT then
            include(dir .. file)
            print( "[STATS] CLIENT file loaded: " .. file )
        end
    end
end

local function AddDir(dir)
    local dir = dir .. "/"
    local files, dirs = file.Find(dir .. "*", "LUA")
    for k, v in ipairs(files) do
        if string.EndsWith(v,".lua") then
            Addfile(v,dir)
        end
    end
    for k, v in ipairs(dirs) do
        AddDir(dir .. v)
    end
end
addDir("gmod-stats")