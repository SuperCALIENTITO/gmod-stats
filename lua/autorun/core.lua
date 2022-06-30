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

local function AddFile(File, Directory)
    local prefix = string.lower(string.Left(File, 3))
    if SERVER and (prefix == "sv_") then
        include(Directory .. File)
        print("[STATS] SERVER INCLUDE: " .. File)
    elseif (prefix == "sh_") then
        if SERVER then
            AddCSLuaFile(Directory .. File)
            print( "[STATS] SHARED: " .. File)
        end
        include(Directory .. File)
        print("[STATS] SHARED INCLUDE: " .. File)
    elseif (prefix == "cl_") then
        if SERVER then
            AddCSLuaFile(Directory .. File)
            print( "[STATS] CLIENT ADDCS: " .. File)
        elseif CLIENT then
            include(Directory .. File)
            print("[STATS] CLIENT INCLUDE: " .. File)
        end
    end
end

local function IncludeDir(Directory)
    Directory = Directory .. "/"

    local files, directories = file.Find(Directory .. "*", "LUA")
    for _, v in ipairs(files) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, Directory)
        end
    end

    for _, v in ipairs(directories) do
        IncludeDir(Directory .. v)
    end
end
IncludeDir("gmod-stats")