local Frame = CreateFrame("Frame")
local SCALE_VALUE = 1.25;

-- Event Registration
Frame:RegisterEvent("PLAYER_LOGIN")
Frame:RegisterEvent("ADDON_LOADED")
Frame:RegisterEvent("PLAYER_LOGOUT")

OldEyes = {};
OldEyes.panel = CreateFrame("Frame", "Old Eyes", UIParent);
OldEyes.panel.name = "Old Eyes";
InterfaceOptions_AddCategory(OldEyes.panel);

-- Label for user settings.
local MsgFrame = CreateFrame("Frame", "Message Frame", OldEyes.panel);
MsgFrame:SetPoint("TOPLEFT");
MsgFrame:SetSize(100, 50);
MsgFrame.Text = MsgFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
MsgFrame.Text:SetPoint("BOTTOM", MsgFrame, "TOP", 32, -30);
MsgFrame.Text:SetText("Requires UI Reload");

-- Scale Merchant Frame
ScaleMerchFrameCheckButton = CreateFrame("CheckButton", "ScaleMerchFrameCheckButton_GlobalName", OldEyes.panel, "InterfaceOptionsCheckButtonTemplate");
ScaleMerchFrameCheckButton:SetPoint("TOPLEFT", 32, -32);
ScaleMerchFrameCheckButton_GlobalNameText:SetText("Scale Merchant Frame");
ScaleMerchFrameCheckButton.tooltip = "Sets whether to scale the merchant frame.";

ScaleMerchFrameCheckButton:SetScript("OnClick", 
function()

	ScaleMerchantFrame = ScaleMerchFrameCheckButton:GetChecked();

end
);

-- Scale Player Frames
ScalePlayerFramesCheckButton = CreateFrame("CheckButton", "ScalePlayerFramesCheckButton_GlobalName", OldEyes.panel, "InterfaceOptionsCheckButtonTemplate");
ScalePlayerFramesCheckButton:SetPoint("TOPLEFT", 32, -64);
ScalePlayerFramesCheckButton_GlobalNameText:SetText("Scale Player Frames");
ScalePlayerFramesCheckButton.tooltip = "Sets whether to scale the player frames.";

ScalePlayerFramesCheckButton:SetScript("OnClick",
function()

	ScalePlayerFrames = ScalePlayerFramesCheckButton:GetChecked();

end
);

-- Scale Objective Tracker
ScaleObjectiveTrackerCheckButton = CreateFrame("CheckButton", "ScaleObjectiveTrackerCheckButton_GlobalName", OldEyes.panel, "InterfaceOptionsCheckButtonTemplate");
ScaleObjectiveTrackerCheckButton:SetPoint("TOPLEFT", 32, -96);
ScaleObjectiveTrackerCheckButton_GlobalNameText:SetText("Scale Objective Tracker");
ScaleObjectiveTrackerCheckButton.tooltip = "Sets whether to scale the objective tracker.";

ScaleObjectiveTrackerCheckButton:SetScript("OnClick",
function()

	ScaleObjectiveTracker = ScaleObjectiveTrackerCheckButton:GetChecked();

end
);

-- arg1 is the addon name.
Frame:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "Old Eyes" then

		-- If no saved data for the addon variable (ScaleMerchantFrame)...
		if ScaleMerchantFrame == nil then

			ScaleMerchantFrame = true; -- Set default value.

		end
	
		-- If there is saved data for the addon variable, use it to update the check button.
		ScaleMerchFrameCheckButton:SetChecked(ScaleMerchantFrame);

		-- If no saved data for the addon variable (ScalePlayerFrames)...
		if ScalePlayerFrames == nil then

			ScalePlayerFrames = true; -- Set default value.

		end

		-- If there is saved data for the addon variable, use it to update the check button.
		ScalePlayerFramesCheckButton:SetChecked(ScalePlayerFrames);

		-- If no saved data for the addon variable (ScaleObjectiveTracker)...
		if ScaleObjectiveTracker == nil then

			ScaleObjectiveTracker = true; -- Set default value.

		end

		-- if there is saved data for the addon variable, use it to update the check button.
		ScaleObjectiveTrackerCheckButton:SetChecked(ScaleObjectiveTracker);

		elseif event == "PLAYER_LOGOUT" then

			-- Save changes so they can be restored during the next gaming session.
			ScaleMerchantFrame = ScaleMerchFrameCheckButton:GetChecked();
			ScalePlayerFrames = ScalePlayerFramesCheckButton:GetChecked();
			ScaleObjectiveTracker = ScaleObjectiveTrackerCheckButton:GetChecked();

		elseif event == "PLAYER_LOGIN" then

			QuestFrame:SetScale(SCALE_VALUE);			-- Quest Text
			GossipFrame:SetScale(SCALE_VALUE);			-- Gossip/Speaking ??
			ItemTextFrame:SetScale(SCALE_VALUE);		-- Books
			PVEFrame:SetScale(SCALE_VALUE);				-- LFG

			-- Scale merchant frame if player requests it.
			if (ScaleMerchantFrame == true) then

				MerchantFrame:SetScale(SCALE_VALUE);	-- Buy/Sell

			end

			-- Scale the player frames if the player requests it.
			if (ScalePlayerFrames == true) then

				PlayerFrame:SetScale(SCALE_VALUE);		-- Player Frame (Name/Avatar)
				TargetFrame:SetScale(SCALE_VALUE);		-- Player's Target Frame
				FocusFrame:SetScale(SCALE_VALUE);		-- Player's Focus Frame (Works well for Hunters)

			end

			-- Scale the objective tracker if the player requests it.
			if(ScaleObjectiveTracker == true) then

				ObjectiveTrackerBlocksFrame:SetScale(SCALE_VALUE);

				--[[ 
					Scaling the objective tracker causes clipping if both action bars are shown on the right side of the screen,
					to counter this, the position of the objective tracker is slightly adjusted to the left.
				--]]
				ObjectiveTrackerBlocksFrame:SetPoint("RIGHT", -275, 300);

			end

			-- Display the copyright and version line in chat.
			print("Old Eyes (2026.11.3) Loaded. Developed by PHANTOM-40417");
		end
	end
)