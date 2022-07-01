-- https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

CreateConVar("stats_lang", "en", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The language to use for the stats.")
local lang = GetConVar("stats_lang")
local lang_table = {
    ["af"] = "afrikaans",
    ["ar"] = "arabic",
    ["bn"] = "bengali",
    ["zh"] = "chinese",
    ["en"] = "english",
    ["fr"] = "french",
    ["de"] = "german",
    ["he"] = "hebrew",
    ["hi"] = "hindi",
    ["jp"] = "japanese",
    ["ko"] = "korean",
    ["pt"] = "portuguese",
    ["ru"] = "russian",
    ["es"] = "spanish",
    ["tr"] = "turkish"
}

function GMS_GetLanguage(phrase)
    local language = lang_table[lang:GetString()] or "english"
    return stats.language[language][phrase] or phrase
end

function GMS_Size(size)
    local language = lang_table[lang:GetString()] or "english"
    return stats.menu_size[language][size] or size
end