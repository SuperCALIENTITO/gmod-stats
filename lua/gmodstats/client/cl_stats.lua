net.Receive("gstatsShow", function ()
    local stats = net.ReadTable()

    -- ventana
    local sFrame = vgui.Create("DFrame", nil, "MP_StatsFrame")
    sFrame:SetTitle(GMS_GetLanguage("title"))
    sFrame:SetIcon("materials/icon16/database.png")
    sFrame:SetSize(320, 200)
    sFrame:Center()
    sFrame:MakePopup()

    -- conexiones
    local s1Image = vgui.Create("DImage", sFrame, "Stats1Image")
    s1Image:SetPos(5, 30)
    s1Image:SetSize(16, 16)
    s1Image:SetImage("icon16/user_go.png")

    local s1Label = vgui.Create("DLabel", sFrame, "Stats1Label")
    s1Label:SetPos(24, 30)
    s1Label:SetSize(100, 16)
    s1Label:SetText(GMS_GetLanguage("connections") .. ": " .. stats.connections)

    -- asesinatos
    local s2Image = vgui.Create("DImage", sFrame, "Stats2Image")
    s2Image:SetPos(5, 50)
    s2Image:SetSize(16, 16)
    s2Image:SetImage("icon16/user_orange.png")

    local s2Label = vgui.Create("DLabel", sFrame, "Stats2Label")
    s2Label:SetPos(24, 50)
    s2Label:SetSize(100, 16)
    s2Label:SetText(GMS_GetLanguage("kills") .. ": " .. stats.kills)

    -- muertes
    local s3Image = vgui.Create("DImage", sFrame, "Stats3Image")
    s3Image:SetPos(5, 70)
    s3Image:SetSize(16, 16)
    s3Image:SetImage("icon16/user_red.png")

    local s3Label = vgui.Create("DLabel", sFrame, "Stats3Label")
    s3Label:SetPos(24, 70)
    s3Label:SetSize(100, 16)
    s3Label:SetText(GMS_GetLanguage("deaths") .. ": " .. stats.deaths)

    -- chat
    local s4Image = vgui.Create("DImage", sFrame, "Stats4Image")
    s4Image:SetPos(5, 90)
    s4Image:SetSize(16, 16)
    s4Image:SetImage("icon16/comment.png")

    local s4Label = vgui.Create("DLabel", sFrame, "Stats4Label")
    s4Label:SetPos(24, 90)
    s4Label:SetSize(100, 16)
    s4Label:SetText(GMS_GetLanguage("chat") .. ": " .. stats.chat)

    -- noclip
    local s5Image = vgui.Create("DImage", sFrame, "Stats5Image")
    s5Image:SetPos(5, 110)
    s5Image:SetSize(16, 16)
    s5Image:SetImage("icon16/shading.png")

    local s5Label = vgui.Create("DLabel", sFrame, "Stats5Label")
    s5Label:SetPos(24, 110)
    s5Label:SetSize(100, 16)
    s5Label:SetText(GMS_GetLanguage("noclip") .. ": " .. stats.noclip)

    -- physgun
    local s6Image = vgui.Create("DImage", sFrame, "Stats6Image")
    s6Image:SetPos(5, 130)
    s6Image:SetSize(16, 16)
    s6Image:SetImage("icon16/brick.png")

    local s6Label = vgui.Create("DLabel", sFrame, "Stats6Label")
    s6Label:SetPos(24, 130)
    s6Label:SetSize(100, 16)
    s6Label:SetText(GMS_GetLanguage("physgun") .. ": " .. stats.physgun)
end)