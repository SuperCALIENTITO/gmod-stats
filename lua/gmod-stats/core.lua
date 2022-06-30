local lang = CreateConVar("stats_lang", "en", FCVAR_NONE, "", 0, 1)

function GmS_GetLanguage(phrase)
    local lang = lang:GetString()
    if lang == "ar" then
        return gmod-stats.language["arabic"][phrase]
    elseif lang == "bn" then
        return gmod-stats.language["bengali"][phrase]
    elseif lang == "ch" then
        return gmod-stats.language["chinese"][phrase]
    elseif lang == "en" then
        return gmod-stats.language["english"][phrase]
    elseif lang == "fr" then
        return gmod-stats.language["french"][phrase]
    elseif lang == "de" then
        return gmod-stats.language["german"][phrase]
    elseif lang == "hb" then
        return gmod-stats.language["hebrew"][phrase]
    elseif lang == "hn" then
        return gmod-stats.language["hindi"][phrase]
    elseif lang == "jp" then
        return gmod-stats.language["japanese"][phrase]
    elseif lang == "ko" then
        return gmod-stats.language["korean"][phrase]
    elseif lang == "ru" then
        return gmod-stats.language["russian"][phrase]
    elseif lang == "es" then
        return gmod-stats.language["spanish"][phrase]
    elseif lang == "tk" then
        return gmod-stats.language["turkish"][phrase]
    else
        return gmod-stats.language["english"][phrase]
    end
end