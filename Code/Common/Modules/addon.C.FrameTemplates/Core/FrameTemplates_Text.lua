---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.C.FrameTemplates; addon.C.FrameTemplates = NS

--------------------------------
-- VARIABLES
--------------------------------

do -- MAIN

end

do -- CONSTANTS

end

--------------------------------
-- TEMPLATES
--------------------------------

do
	-- Creates a text. Optional HTML rendering support.
	---@param parent any
	---@param textColor table
	---@param textSize number
	---@param alignH string
	---@param alignV string
	---@param fontFile string
	---@param name? string
	---@param createHtml? boolean
	function NS:CreateText(parent, textColor, textSize, alignH, alignV, fontFile, name, createHtml, template)
		if not parent then
			return
		end

		if fontFile and fontFile.size then
			textSize = math.ceil(textSize * fontFile.size)
			fontFile = fontFile.font
		end

		--------------------------------

		local Frame = CreateFrame("Frame", name or nil, parent)
		Frame:SetAllPoints(parent)

		--------------------------------

		do -- TEXT
			Frame.Text = Frame:CreateFontString(name or nil, "OVERLAY", template or nil)
			Frame.Text:SetFont(fontFile, textSize or 11, "")
			Frame.Text:SetJustifyH(alignH or "CENTER")
			Frame.Text:SetJustifyV(alignV or "MIDDLE")
			Frame.Text:SetTextColor(textColor.r or 1, textColor.g or 1, textColor.b or 1)
		end

		do -- HTML
			if createHtml then
				local _, fontHeight, _ = Frame.Text:GetFont()
				if fontHeight <= 0 then
					fontHeight = addon.C.AddonInfo.Database.DB_GLOBAL.profile.INT_CONTENT_SIZE
				end

				--------------------------------

				Frame.Html = CreateFrame("SimpleHTML", (name and name .. "HTML") or nil, Frame)
				Frame.Html:SetFont("P", QuestFont:GetFont(), fontHeight, "")
				Frame.Html:SetFont("H1", addon.C.Fonts.Title_Medium, 48, "")
				Frame.Html:SetFont("H2", Game20Font:GetFont(), fontHeight, "")
				Frame.Html:SetFont("H3", addon.C.Fonts.Title_Medium, 28, "")
				Frame.Html:SetTextColor("P", textColor.r, textColor.g, textColor.b)
				Frame.Html:SetTextColor("H1", textColor.r, textColor.g, textColor.b)
				Frame.Html:SetTextColor("H2", textColor.r, textColor.g, textColor.b)
				Frame.Html:SetTextColor("H3", textColor.r, textColor.g, textColor.b)

				--------------------------------

				local function UpdateFormatting()
					local _, fontHeight, _ = Frame.Text:GetFont()
					if fontHeight <= 0 then
						fontHeight = addon.C.AddonInfo.Database.DB_GLOBAL.profile.INT_CONTENT_SIZE
					end

					--------------------------------

					Frame.Html:SetFont("P", QuestFont:GetFont(), fontHeight, "")
					Frame.Html:SetFont("H2", Game20Font:GetFont(), fontHeight, "")

					--------------------------------

					if addon.C.API.Util:FindString(Frame.Text:GetText(), "<HTML>") then
						Frame.Html:SetSize(Frame.Text:GetWidth() * 1.5, Frame.Text:GetStringHeight())
						Frame.Html:SetScale(.625)
						Frame.Html:SetPoint("TOP", Frame.Text)

						local text = Frame.Text:GetText()
						local formattedText = text:gsub('<IMG src="Interface\\Common\\spacer.->', '')

						Frame.Html:SetText(formattedText)

						Frame.Html:SetAlpha(1)
						Frame.Text:SetAlpha(0)
					else
						Frame.Html:SetAlpha(0)
						Frame.Text:SetAlpha(1)
					end
				end

				hooksecurefunc(Frame.Text, "SetText", UpdateFormatting)
				hooksecurefunc(Frame.Text, "SetFont", UpdateFormatting)
			end
		end

		--------------------------------

		return Frame.Text
	end
end
