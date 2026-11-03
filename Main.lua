
local ADDON_NAME = "Old Eyes"
local SCALE_VALUE = 1.25

local Frame = CreateFrame("Frame")

local pendingFrames = {}
local optionsCategory

-- Initialize default settings.
local function InitializeSavedVariables()

    if ScaleMerchantFrame == nil then
        ScaleMerchantFrame = true
    end

    if ScalePlayerFrames == nil then
        ScalePlayerFrames = true
    end

    if ScaleObjectiveTracker == nil then
        ScaleObjectiveTracker = true
    end

end

-- Apply scaling to a frame.
local function ScaleFrame(frame)

    if not frame then
        return
    end

    -- Avoid changing protected frames during combat.
    if InCombatLockdown and InCombatLockdown() then
        pendingFrames[frame] = true
        return
    end

    frame:SetScale(SCALE_VALUE)

    -- Reapply scaling whenever the frame is displayed.
    if not frame.OldEyesHooked then

        frame:HookScript("OnShow", function(self)

            if InCombatLockdown and InCombatLockdown() then
                pendingFrames[self] = true
            else
                self:SetScale(SCALE_VALUE)
            end

        end)

        frame.OldEyesHooked = true

    end

end

-- Scale frames that are currently available.
local function ApplyScaling()

    -- Quest, gossip, books and group finder.
    ScaleFrame(_G.QuestFrame)
    ScaleFrame(_G.GossipFrame)
    ScaleFrame(_G.ItemTextFrame)
    ScaleFrame(_G.PVEFrame)

    -- Merchant frame.
    if ScaleMerchantFrame then
        ScaleFrame(_G.MerchantFrame)
    end

    -- Player, target and focus frames.
    if ScalePlayerFrames then

        ScaleFrame(_G.PlayerFrame)
        ScaleFrame(_G.TargetFrame)
        ScaleFrame(_G.FocusFrame)

    end

    -- Objective tracker.
    if ScaleObjectiveTracker then
        ScaleFrame(_G.ObjectiveTrackerBlocksFrame)
    end

end

-- Apply deferred scaling after combat ends.
local function ApplyPendingScaling()

    for frame in pairs(pendingFrames) do

        if frame and frame.SetScale then
            frame:SetScale(SCALE_VALUE)
        end

        pendingFrames[frame] = nil

    end

end

-- Create the modern WoW settings panel.
local function CreateOptionsPanel()

    if optionsCategory then
        return
    end

    if not Settings or not Settings.RegisterCanvasLayoutCategory then
        return
    end

    local panel = CreateFrame("Frame")
    panel.name = ADDON_NAME

    -- Instructions.
    local message = panel:CreateFontString(
        nil,
        "ARTWORK",
        "GameFontNormal"
    )

    message:SetPoint("TOPLEFT", 32, -24)
    message:SetText("Requires UI Reload")

    -- Create a checkbox.
    local function CreateOptionCheckbox(text, tooltip, variable, yOffset)

        local checkbox = CreateFrame(
            "CheckButton",
            nil,
            panel
        )

        checkbox:SetSize(24, 24)
        checkbox:SetPoint("TOPLEFT", 32, yOffset)

        local label = panel:CreateFontString(
            nil,
            "ARTWORK",
            "GameFontNormal"
        )

        label:SetPoint("LEFT", checkbox, "RIGHT", 4, 0)
        label:SetText(text)

        checkbox:SetChecked(_G[variable])

        checkbox:SetScript("OnClick", function(self)

            _G[variable] = self:GetChecked()

        end)

        checkbox:SetScript("OnEnter", function(self)

            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tooltip)
            GameTooltip:Show()

        end)

        checkbox:SetScript("OnLeave", function()

            GameTooltip:Hide()

        end)

    end

    -- Merchant frame.
    CreateOptionCheckbox(
        "Scale Merchant Frame",
        "Sets whether to scale the merchant frame.",
        "ScaleMerchantFrame",
        -56
    )

    -- Player frames.
    CreateOptionCheckbox(
        "Scale Player Frames",
        "Sets whether to scale the player frames.",
        "ScalePlayerFrames",
        -88
    )

    -- Objective tracker.
    CreateOptionCheckbox(
        "Scale Objective Tracker",
        "Sets whether to scale the objective tracker.",
        "ScaleObjectiveTracker",
        -120
    )

    -- Register the settings panel.
    optionsCategory = Settings.RegisterCanvasLayoutCategory(
        panel,
        ADDON_NAME
    )

    optionsCategory.ID = ADDON_NAME

    Settings.RegisterAddOnCategory(optionsCategory)

end

-- Register events.
Frame:RegisterEvent("ADDON_LOADED")
Frame:RegisterEvent("PLAYER_LOGIN")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Frame:RegisterEvent("PLAYER_LOGOUT")
Frame:RegisterEvent("PLAYER_REGEN_ENABLED")

Frame:SetScript("OnEvent", function(self, event, arg1)

    if event == "ADDON_LOADED" then

        if arg1 == ADDON_NAME then

            InitializeSavedVariables()
            CreateOptionsPanel()

        end

        -- Some Blizzard UI frames are loaded on demand.
        ApplyScaling()

    elseif event == "PLAYER_LOGIN" then

        InitializeSavedVariables()
        CreateOptionsPanel()

        ApplyScaling()

        print("Old Eyes (2026.11.3) Loaded. Developed by PHANTOM-40417")

    elseif event == "PLAYER_ENTERING_WORLD" then

        ApplyScaling()

    elseif event == "PLAYER_REGEN_ENABLED" then

        ApplyPendingScaling()

    end

end)
