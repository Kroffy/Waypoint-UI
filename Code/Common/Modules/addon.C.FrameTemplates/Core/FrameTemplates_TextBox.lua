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
	-- Creates a text field.
	---@param parent any
	---@param data table
	---@param name string
	function NS:CreateTextBox(parent, frameStrata, frameLevel, data, name)
		local inset = data.inset or 5

		--------------------------------

		local Frame = CreateFrame("Frame", name, parent)
		Frame:SetFrameStrata(frameStrata)
		Frame:SetFrameLevel(frameLevel)

		--------------------------------

		do -- ELEMENTS
			do -- SCROLL FRAME
				Frame.ScrollFrame, Frame.ScrollChildFrame = addon.C.FrameTemplates:CreateScrollFrame(parent, { direction = "vertical", smoothScrollingRatio = 5 }, "$parent.Name" .. "ScrollFrame", "$parent.Name" .. "ScrollChildFrame")
				Frame.ScrollFrame:SetPoint("CENTER", Frame)
				Frame.ScrollFrame:SetFrameStrata(frameStrata)
				Frame.ScrollFrame:SetFrameLevel(frameLevel + 1)
				addon.C.API.FrameUtil:SetDynamicSize(Frame.ScrollFrame, Frame, inset * 2, inset * 2)
				addon.C.API.FrameUtil:SetDynamicSize(Frame.ScrollChildFrame, Frame.ScrollFrame, 0, nil)

				local ScrollFrame = Frame.ScrollFrame
				local ScrollChildFrame = Frame.ScrollChildFrame

				----------------------------------

				do -- SCORLL BAR
					ScrollFrame.ScrollBar:Hide()

					ScrollFrame.CustomScrollBar = PrefabRegistry:Create("Global.Default.ScrollBar", ScrollFrame, frameStrata, frameLevel + 2, { scrollFrame = ScrollFrame, scrollFrameType = "scrollFrame", direction = "vertical" }, "$parent.CustomScrollBar")
					ScrollFrame.CustomScrollBar:SetWidth(5)
					ScrollFrame.CustomScrollBar:SetPoint("RIGHT", Frame, -5, 0)
					ScrollFrame.CustomScrollBar:SetFrameStrata(frameStrata)
					ScrollFrame.CustomScrollBar:SetFrameLevel(frameLevel + 2)
					addon.C.API.FrameUtil:SetDynamicSize(ScrollFrame.CustomScrollBar, Frame, nil, 10, true)
				end

				do -- CONTENT
					ScrollChildFrame.Content = CreateFrame("Frame", "$parent.Content", ScrollChildFrame)
					ScrollChildFrame.Content:SetPoint("TOP", ScrollChildFrame)
					ScrollChildFrame.Content:SetFrameStrata(frameStrata)
					ScrollChildFrame.Content:SetFrameLevel(frameLevel + 2)
					addon.C.API.FrameUtil:SetDynamicSize(ScrollChildFrame.Content, ScrollFrame, 0, 0)
					addon.C.API.FrameUtil:SetDynamicSize(ScrollChildFrame, ScrollChildFrame.Content, nil, 0)

					local Content = ScrollChildFrame.Content

					----------------------------------

					do -- CONTENT
						Content.Content = CreateFrame("Frame", "$parent.Content", Content)
						Content.Content:SetPoint("CENTER", Content)
						Content.Content:SetFrameStrata(frameStrata)
						Content.Content:SetFrameLevel(frameLevel + 3)
						addon.C.API.FrameUtil:SetDynamicSize(Content.Content, Content, 0, 0)

						local Subcontent = Content.Content

						----------------------------------

						do -- LAYOUT GROUP
							Subcontent.LayoutGroup = addon.C.FrameTemplates:CreateLayoutGroup(Subcontent, { point = "LEFT", direction = "horizontal", resize = false, padding = 0, distribute = false, distributeResizeElements = false, excludeHidden = true, autoSort = true, customOffset = nil, customLayoutSort = nil }, "$parent.LayoutGroup")
							Subcontent.LayoutGroup:SetPoint("CENTER", Subcontent)
							addon.C.API.FrameUtil:SetDynamicSize(Subcontent.LayoutGroup, Subcontent, 0, 0)

							local LayoutGroup = Subcontent.LayoutGroup

							--------------------------------

							local IMAGE_FRAME_WIDTH = 20
							local IMAGE_FRAME_HEIGHT = 20

							do -- IMAGE FRAME
								LayoutGroup.ImageFrame = CreateFrame("Frame", "$parent.ImageFrame", LayoutGroup)
								LayoutGroup.ImageFrame:SetSize(IMAGE_FRAME_WIDTH, IMAGE_FRAME_HEIGHT)
								LayoutGroup:AddElement(LayoutGroup.ImageFrame)

								local ImageFrame = LayoutGroup.ImageFrame

								--------------------------------

								do -- BACKGROUND
									ImageFrame.Background, ImageFrame.BackgroundTexture = addon.C.FrameTemplates:CreateTexture(ImageFrame, frameStrata, nil, "$parent.Background")
									ImageFrame.Background:SetPoint("CENTER", ImageFrame)
									addon.C.API.FrameUtil:SetDynamicSize(ImageFrame.Background, ImageFrame, 7.5, 7.5)
								end
							end

							do -- TEXT BOX
								LayoutGroup.TextBox = CreateFrame("EditBox", name, LayoutGroup)
								LayoutGroup.TextBox:SetFrameStrata(frameStrata)
								LayoutGroup.TextBox:SetFrameLevel(frameLevel + 4)
								addon.C.API.FrameUtil:SetDynamicSize(ScrollChildFrame, LayoutGroup.TextBox, nil, 0)
								LayoutGroup:AddElement(LayoutGroup.TextBox)

								LayoutGroup.TextBox:SetMultiLine(false)
								LayoutGroup.TextBox:SetAutoFocus(false)

								local TextBox = LayoutGroup.TextBox

								--------------------------------

								do -- TEXT
									TextBox.Text = select(1, TextBox:GetRegions())
									TextBox.Text.justifyV = "TOP"
								end

								do -- PLACEHOLDER
									TextBox.Placeholder = CreateFrame("Frame", "$parent.Placeholder", TextBox)
									TextBox.Placeholder:SetPoint("CENTER", TextBox)
									addon.C.API.FrameUtil:SetDynamicSize(TextBox.Placeholder, TextBox, 0, 0)
									TextBox.Placeholder:SetAlpha(.25)

									local Placeholder = TextBox.Placeholder

									--------------------------------

									do -- TEXT
										Placeholder.Text = addon.C.FrameTemplates:CreateText(Placeholder, addon.CREF:GetSharedColor().RGB_WHITE, 12.5, "LEFT", "TOP", addon.C.Fonts.CONTENT_MEDIUM, "$parent.Text")
										Placeholder.Text:SetPoint("CENTER", Placeholder)
										addon.C.API.FrameUtil:SetDynamicSize(Placeholder.Text, Placeholder, 0, 0)
										Placeholder.Text.justifyV = "TOP"
									end
								end

								do -- EVENTS
									local function UpdateLayout()
										local indentWidth = LayoutGroup.ImageFrame:IsShown() and IMAGE_FRAME_WIDTH or 0
										TextBox:SetWidth(LayoutGroup:GetWidth() - indentWidth)
										Subcontent.LayoutGroup:Sort()
									end

									local function UpdateSize(self, userInput)
										if userInput then
											if TextBox:IsMultiLine() then
												local stringHeight = TextBox.Text:GetHeight()

												--------------------------------

												TextBox:SetHeight(stringHeight)
												TextBox.Text:SetJustifyV(TextBox.Text.justifyV)
												TextBox.Placeholder.Text:SetJustifyV(TextBox.Placeholder.Text.justifyV)
											else
												TextBox:SetHeight(Subcontent:GetHeight())
												TextBox.Text:SetJustifyV("MIDDLE")
												TextBox.Placeholder.Text:SetJustifyV("MIDDLE")
											end
										end
									end

									TextBox:SetScript("OnShow", UpdateLayout)
									TextBox:SetScript("OnUpdate", UpdateSize)
								end
							end
						end
					end
				end
			end
		end

		do -- LOGIC
			Frame.isMouseOver = false
			Frame.isMouseDown = false
			Frame.autoSelect = false

			Frame.enterCallbacks = {}
			Frame.leaveCallbacks = {}
			Frame.mouseDownCallbacks = {}
			Frame.mouseUpCallbacks = {}
			Frame.escapePressedCallbacks = {}
			Frame.textChangedCallbacks = {}

			--------------------------------

			do -- FUNCTIONS
				do -- GET
					do -- REFERENCES
						function Frame:GetImage()
							return Frame.ScrollChildFrame.Content.Content.LayoutGroup.ImageFrame
						end

						function Frame:GetTextBox()
							return Frame.ScrollChildFrame.Content.Content.LayoutGroup.TextBox
						end

						function Frame:GetTextBoxPlaceholder()
							return Frame:GetTextBox().Placeholder
						end

						function Frame:GetTextBoxPlaceholderTextObject()
							return Frame:GetTextBoxPlaceholder().Text
						end

						function Frame:GetTextBoxTextObject()
							return Frame:GetTextBox().Text
						end
					end
				end

				do -- SET
					function Frame:SetImage(image)
						if image then
							Frame:GetImage():Show()
							Frame:GetImage().BackgroundTexture:SetTexture(image)
						else
							Frame:GetImage():Hide()
						end
					end

					function Frame:SetPlaceholder(text)
						Frame:GetTextBoxPlaceholderTextObject():SetText(text)

						----------------------------------

						Frame:UpdatePlaceholder()
					end
				end

				do -- LOGIC
					function Frame:UpdatePlaceholder()
						if Frame:GetTextBox():HasText() then
							Frame:GetTextBoxPlaceholder():Hide()
						else
							Frame:GetTextBoxPlaceholder():Show()
						end
					end
				end
			end

			do -- EVENTS
				function Frame:Event_OnEnter()
					Frame.isMouseOver = true

					--------------------------------

					do -- ON ENTER
						local enterCallbacks = Frame.enterCallbacks

						if #enterCallbacks >= 1 then
							for callback = 1, #enterCallbacks do
								enterCallbacks[callback](Frame)
							end
						end
					end
				end

				function Frame:Event_OnLeave()
					if not Frame:GetTextBox():HasFocus() then
						Frame.isMouseOver = false

						--------------------------------

						do -- ON LEAVE
							local leaveCallbacks = Frame.leaveCallbacks

							if #leaveCallbacks >= 1 then
								for callback = 1, #leaveCallbacks do
									leaveCallbacks[callback](Frame)
								end
							end
						end
					end
				end

				function Frame:Event_OnMouseDown()
					Frame.isMouseDown = true

					--------------------------------

					do -- ON MOUSE DOWN
						local mouseDownCallbacks = Frame.mouseDownCallbacks

						if #mouseDownCallbacks >= 1 then
							for callback = 1, #mouseDownCallbacks do
								mouseDownCallbacks[callback](Frame)
							end
						end
					end
				end

				function Frame:Event_OnMouseUp()
					Frame.isMouseDown = false

					--------------------------------

					do -- ON MOUSE UP
						local mouseUpCallbacks = Frame.mouseUpCallbacks

						if #mouseUpCallbacks >= 1 then
							for callback = 1, #mouseUpCallbacks do
								mouseUpCallbacks[callback](Frame)
							end
						end
					end
				end

				function Frame:Event_OnEscapePressed()
					Frame:GetTextBox():ClearFocus()

					--------------------------------

					do -- ON ESCAPE PRESSED
						local escapePressedCallbacks = Frame.escapePressedCallbacks

						if #escapePressedCallbacks >= 1 then
							for callback = 1, #escapePressedCallbacks do
								escapePressedCallbacks[callback](Frame, Frame:GetTextBox())
							end
						end
					end
				end

				function Frame:Event_OnTextChanged()
					Frame:UpdatePlaceholder()

					--------------------------------

					do -- ON VALUE CHANGED
						local textChangedCallbacks = Frame.textChangedCallbacks

						if #textChangedCallbacks >= 1 then
							for callback = 1, #textChangedCallbacks do
								textChangedCallbacks[callback](Frame, Frame:GetTextBox(), Frame:GetTextBoxTextObject():GetText())
							end
						end
					end
				end

				addon.C.FrameTemplates:CreateMouseResponder(Frame, { enterCallback = Frame.Event_OnEnter, leaveCallback = Frame.Event_OnLeave, mouseDownCallback = Frame.Event_OnMouseDown, mouseUpCallback = Frame.Event_OnMouseUp })
				Frame:GetTextBox():SetScript("OnEditFocusGained", Frame.Event_OnEnter)
				Frame:GetTextBox():SetScript("OnEditFocusLost", Frame.Event_OnLeave)
				Frame:GetTextBox():SetScript("OnEscapePressed", Frame.Event_OnEscapePressed)
				Frame:GetTextBox():HookScript("OnTextChanged", Frame.Event_OnTextChanged)
				Frame:SetScript("OnShow", function()
					Frame:UpdatePlaceholder()

					--------------------------------

					addon.C.Libraries.AceTimer:ScheduleTimer(function()
						if Frame.autoSelect then
							Frame:GetTextBox():HighlightText(0, #Frame:GetTextBox():GetText())
							Frame:GetTextBox():SetFocus()
						else
							Frame:GetTextBox():ClearFocus()
						end
					end, 0)
				end)
			end
		end

		do -- SETUP
			Frame:SetImage(nil)
			Frame:Event_OnLeave()
			Frame:UpdatePlaceholder()
		end

		--------------------------------

		return Frame
	end
end
