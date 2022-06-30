-- https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
local lang = CreateConVar("stats_lang", "en", FCVAR_NONE, "The language to display in the stats menu", nil, nil)
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
    ["ru"] = "russian",
    ["so"] = "somali",
    ["es"] = "spanish",
    ["tr"] = "turkish"
}

function GmS_GetLanguage(phrase)
    return stats.language[lang_table[lang:GetString()]][phrase]
end