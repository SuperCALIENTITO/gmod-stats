local lang = CreateConVar("stats_lang", "en", FCVAR_NONE, "", 0, 1)

function GmS_GetLanguage(phrase)
    -- https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
    local lang = lang:GetString()
    if lang == "af" then
        return gmod_stats.language["afrikaans"][phrase]
    elseif lang == "ar" then
        return gmod_stats.language["arabic"][phrase]
    elseif lang == "bn" then
        return gmod_stats.language["bengali"][phrase]
    elseif lang == "zh" then
        return gmod_stats.language["chinese"][phrase]
    elseif lang == "en" then
        return gmod_stats.language["english"][phrase]
    elseif lang == "fr" then
        return gmod_stats.language["french"][phrase]
    elseif lang == "de" then
        return gmod_stats.language["german"][phrase]
    elseif lang == "he" then
        return gmod_stats.language["hebrew"][phrase]
    elseif lang == "hi" then
        return gmod_stats.language["hindi"][phrase]
    elseif lang == "jp" then
        return gmod_stats.language["japanese"][phrase]
    elseif lang == "ko" then
        return gmod_stats.language["korean"][phrase]
    elseif lang == "ru" then
        return gmod_stats.language["russian"][phrase]
    elseif lang == "so" then
        return gmod_stats.language["somali"][phrase]
    elseif lang == "es" then
        return gmod_stats.language["spanish"][phrase]
    elseif lang == "tr" then
        return gmod_stats.language["turkish"][phrase]
    else
        return gmod_stats.language["english"][phrase]
    end
end