---@class addon
local addon = select(2, ...)
local CallbackRegistry = addon.C.CallbackRegistry.Script
local PrefabRegistry = addon.C.PrefabRegistry.Script
local L = addon.C.AddonInfo.Locales
local NS = addon.Waypoint; addon.Waypoint = NS

--------------------------------

NS.Elements = {}

--------------------------------

function NS.Elements:Load()
	--------------------------------
	-- CREATE ELEMENTS
	--------------------------------

	do
		do -- ELEMENTS
			WaypointFrame.Waypoint = CreateFrame("Frame", "$parent.Waypoint", WaypointFrame)
			WaypointFrame.Waypoint:SetFrameStrata(NS.Variables.FRAME_STRATA)
			WaypointFrame.Waypoint:SetFrameLevel(NS.Variables.FRAME_LEVEL)

			local Frame = WaypointFrame.Waypoint
			local Frame_BlizzardWaypoint = SuperTrackedFrame

			--------------------------------

			do -- ELEMENTS
				local PADDING = NS.Variables.PADDING

				--------------------------------

				do -- WAYPOINT
					Frame.Waypoint = CreateFrame("Frame", "$parent.Waypoint", Frame)
					Frame.Waypoint:SetSize(37.5, 37.5)
					Frame.Waypoint:SetFrameStrata(NS.Variables.FRAME_STRATA)
					Frame.Waypoint:SetFrameLevel(NS.Variables.FRAME_LEVEL + 1)

					local Waypoint = Frame.Waypoint

					--------------------------------

					do -- CONTEXT FRAME
						Waypoint.ContextFrame = PrefabRegistry:Create("Waypoint.General.ContextFrame", Waypoint, NS.Variables.FRAME_STRATA, NS.Variables.FRAME_LEVEL + 2, "$parent.ContextFrame")
						Waypoint.ContextFrame:SetPoint("CENTER", Waypoint)
						Waypoint.ContextFrame:SetFrameStrata(NS.Variables.FRAME_STRATA)
						Waypoint.ContextFrame:SetFrameLevel(NS.Variables.FRAME_LEVEL + 2)
						addon.C.API.FrameUtil:SetDynamicSize(Waypoint.ContextFrame, Waypoint, 0, 0)

						local ContextFrame = Waypoint.ContextFrame

						--------------------------------

						do -- VFX
							ContextFrame.VFX = CreateFrame("Frame", "$parent.VFX", ContextFrame)
							ContextFrame.VFX:SetSize(125, 125)
							ContextFrame.VFX:SetPoint("CENTER", ContextFrame)
							ContextFrame.VFX:SetFrameStrata(NS.Variables.FRAME_STRATA)
							ContextFrame.VFX:SetFrameLevel(NS.Variables.FRAME_LEVEL + 3)

							local VFX = ContextFrame.VFX

							--------------------------------

							do -- QUEST COMPLETION
								VFX.QuestCompletion = addon.C.FrameTemplates:CreateModelFrame_VisualEffect(VFX, { dynamicEffectInfo = { effectID = 179, offsetX = 3, offsetY = 0 } }, "$parent.QuestCompletion")
								VFX.QuestCompletion:SetSize(125, 125)
								VFX.QuestCompletion:SetPoint("CENTER", VFX)
								VFX.QuestCompletion:SetFrameStrata(NS.Variables.FRAME_STRATA)
								VFX.QuestCompletion:SetFrameLevel(NS.Variables.FRAME_LEVEL + 3)
							end
						end
					end

					do -- FOOTER
						Waypoint.Footer = CreateFrame("Frame", "$parent.Footer", Waypoint)
						Waypoint.Footer:SetSize(200, 37.5)
						Waypoint.Footer:SetPoint("TOP", Waypoint, "BOTTOM", 0, 0)
						Waypoint.Footer:SetFrameStrata(NS.Variables.FRAME_STRATA)
						Waypoint.Footer:SetFrameLevel(NS.Variables.FRAME_LEVEL + 2)
						Waypoint.Footer:SetAlpha(.25)
						Waypoint.Footer:SetScale(.75)
						Waypoint.Footer:SetIgnoreParentScale(true)

						local Footer = Waypoint.Footer

						--------------------------------

						do -- TEXT FRAME
							Footer.TextFrame = CreateFrame("Frame", "$parent.TextFrame", Footer)
							Footer.TextFrame:SetPoint("CENTER", Footer)
							Footer.TextFrame:SetFrameStrata(NS.Variables.FRAME_STRATA)
							Footer.TextFrame:SetFrameLevel(NS.Variables.FRAME_LEVEL + 3)
							addon.C.API.FrameUtil:SetDynamicSize(Footer.TextFrame, Footer, 0, 0)

							local TextFrame = Footer.TextFrame

							--------------------------------

							do -- TEXT
								TextFrame.Text = addon.C.FrameTemplates:CreateText(TextFrame, addon.CREF:GetSharedColor().RGB_WHITE, 12.5, "CENTER", "MIDDLE", addon.C.Fonts.CONTENT_DEFAULT, "$parent.Text")
								TextFrame.Text:SetPoint("CENTER", TextFrame)
								addon.C.API.FrameUtil:SetDynamicSize(TextFrame.Text, TextFrame, 0, 0)
								TextFrame.Text:SetText("Placeholder")
							end
						end
					end

					do -- MARKER
						Waypoint.Marker = CreateFrame("Frame", "$parent.Marker", Waypoint)
						Waypoint.Marker:SetWidth(25)
						Waypoint.Marker:SetFrameStrata(NS.Variables.FRAME_STRATA)
						Waypoint.Marker:SetFrameLevel(NS.Variables.FRAME_LEVEL + 2)

						local Marker = Waypoint.Marker

						--------------------------------

						do -- BACKGROUND
							Marker.Background, Marker.BackgroundTexture = addon.C.FrameTemplates:CreateTexture(Marker, NS.Variables.FRAME_STRATA, NS.Variables.PATH .. "waypoint-line.png", "$parent.Background")
							Marker.Background:SetPoint("CENTER", Marker)
							Marker.Background:SetFrameStrata(NS.Variables.FRAME_STRATA)
							Marker.Background:SetFrameLevel(NS.Variables.FRAME_LEVEL + 3)
							addon.C.API.FrameUtil:SetDynamicSize(Marker.Background, Marker, 0, 0)
						end
					end
				end

				do -- PINPOINT
					Frame.Pinpoint = CreateFrame("Frame", "$parent.Pinpoint", Frame)
					Frame.Pinpoint:SetFrameStrata(NS.Variables.FRAME_STRATA)
					Frame.Pinpoint:SetFrameLevel(NS.Variables.FRAME_LEVEL + 1)
					Frame.Pinpoint:SetScale(.75)

					local Pinpoint = Frame.Pinpoint

					--------------------------------

					do -- ELEMENTS
						local PADDING_FRAME = NS.Variables:RATIO(2.5)
						local TEXT_WIDTH_MAX = 300

						--------------------------------

						do -- BACKGROUND
							Pinpoint.Background = CreateFrame("Frame", "$parent.Background", Pinpoint)
							Pinpoint.Background:SetPoint("CENTER", Pinpoint)
							Pinpoint.Background:SetFrameStrata(NS.Variables.FRAME_STRATA)
							Pinpoint.Background:SetFrameLevel(NS.Variables.FRAME_LEVEL)
							addon.C.API.FrameUtil:SetDynamicSize(Pinpoint.Background, Pinpoint, 0, 0)

							local Background = Pinpoint.Background

							--------------------------------

							do -- CONTEXT FRAME
								Background.ContextFrame = PrefabRegistry:Create("Waypoint.General.ContextFrame", Background, NS.Variables.FRAME_STRATA, NS.Variables.FRAME_LEVEL, "$parent.ContextFrame")
								Background.ContextFrame:SetSize(75, 75)
								Background.ContextFrame:SetPoint("CENTER", Background)
								Background.ContextFrame:SetFrameStrata(NS.Variables.FRAME_STRATA)
								Background.ContextFrame:SetFrameLevel(NS.Variables.FRAME_LEVEL + 1)
								Background.ContextFrame:SetAlpha(.25)
							end

							do -- ARROW FRAME
								Background.ArrowFrame = PrefabRegistry:Create("Waypoint.Pinpoint.ArrowFrame", Background, NS.Variables.FRAME_STRATA, NS.Variables.FRAME_LEVEL + 1, {
									["size"] = 25,
									["offset"] = -7.5,
								}, "$parent.ArrowFrame")
								Background.ArrowFrame:SetSize(75, 75)
								Background.ArrowFrame:SetPoint("TOP", Background, "BOTTOM", 0, -12.5)
								Background.ArrowFrame:SetFrameStrata(NS.Variables.FRAME_STRATA)
								Background.ArrowFrame:SetFrameLevel(NS.Variables.FRAME_LEVEL + 1)
							end
						end

						do -- FOREGROUND
							Pinpoint.Foreground = CreateFrame("Frame", "$parent.Foreground", Pinpoint)
							Pinpoint.Foreground:SetPoint("CENTER", Pinpoint)
							Pinpoint.Foreground:SetFrameStrata(NS.Variables.FRAME_STRATA)
							Pinpoint.Foreground:SetFrameLevel(NS.Variables.FRAME_LEVEL_MAX)
							addon.C.API.FrameUtil:SetDynamicSize(Pinpoint.Foreground, Pinpoint, 0, 0)

							local Foreground = Pinpoint.Foreground

							--------------------------------

							do -- BACKGROUND
								Foreground.Background = CreateFrame("Frame", "$parent.Background", Foreground)
								Foreground.Background:SetPoint("CENTER", Foreground)
								Foreground.Background:SetFrameStrata(NS.Variables.FRAME_STRATA)
								Foreground.Background:SetFrameLevel(NS.Variables.FRAME_LEVEL_MAX + 1)
								addon.C.API.FrameUtil:SetDynamicSize(Foreground.Background, Foreground, -25, -25)

								local Background = Foreground.Background

								--------------------------------

								do -- CENTER
									Background.Center, Background.CenterTexture = addon.C.FrameTemplates:CreateNineSlice(Background, NS.Variables.FRAME_STRATA, NS.Variables.PATH .. "pinpoint-background-center.png", 37, .125, "$parent.Center", Enum.UITextureSliceMode.Stretched)
									Background.Center:SetPoint("CENTER", Background)
									Background.Center:SetFrameStrata(NS.Variables.FRAME_STRATA)
									Background.Center:SetFrameLevel(NS.Variables.FRAME_LEVEL_MAX + 2)
									addon.C.API.FrameUtil:SetDynamicSize(Background.Center, Background, 0, 0)

									Background.CenterTexture:SetVertexColor(0, 0, 0, .375)
								end

								do -- BORDER
									Background.Border, Background.BorderTexture = addon.C.FrameTemplates:CreateNineSlice(Background, NS.Variables.FRAME_STRATA, NS.Variables.PATH .. "pinpoint-background-border.png", 37, .125, "$parent.Border", Enum.UITextureSliceMode.Stretched)
									Background.Border:SetPoint("CENTER", Background)
									Background.Border:SetFrameStrata(NS.Variables.FRAME_STRATA)
									Background.Border:SetFrameLevel(NS.Variables.FRAME_LEVEL_MAX + 3)
									addon.C.API.FrameUtil:SetDynamicSize(Background.Border, Background, 0, 0)
								end
							end

							do -- CONTENT
								Foreground.Content = CreateFrame("Frame", "$parent.Content", Foreground)
								Foreground.Content:SetPoint("CENTER", Foreground)
								Foreground.Content:SetFrameStrata(NS.Variables.FRAME_STRATA)
								Foreground.Content:SetFrameLevel(NS.Variables.FRAME_LEVEL_MAX + 5)
								addon.C.API.FrameUtil:SetDynamicSize(Foreground.Content, Foreground, 0, 0)

								local Content = Foreground.Content

								--------------------------------

								do -- TEXT FRAME
									Content.TextFrame = CreateFrame("Frame", "$parent.TextFrame", Content)
									Content.TextFrame:SetPoint("CENTER", Content)
									Content.TextFrame:SetFrameStrata(NS.Variables.FRAME_STRATA)
									Content.TextFrame:SetFrameLevel(NS.Variables.FRAME_LEVEL_MAX + 6)
									addon.C.API.FrameUtil:SetDynamicSize(Content.TextFrame, Content, 0, 0)

									local TextFrame = Content.TextFrame

									--------------------------------

									do -- TEXT
										TextFrame.Text = addon.C.FrameTemplates:CreateText(TextFrame, addon.CREF:GetSharedColor().RGB_WHITE, 12.5, "CENTER", "MIDDLE", addon.C.Fonts.CONTENT_DEFAULT, "$parent.Text")
										TextFrame.Text:SetPoint("CENTER", TextFrame)
										addon.C.API.FrameUtil:SetDynamicTextSize(TextFrame.Text, TextFrame, TEXT_WIDTH_MAX, 10000)
										addon.C.API.FrameUtil:SetDynamicSize(Pinpoint, TextFrame.Text, 0, 0)
									end
								end
							end
						end
					end
				end
			end
		end

		do -- REFERENCES
			local Frame = WaypointFrame.Waypoint

			--------------------------------

			-- CORE
			Frame.REF_WAYPOINT = Frame.Waypoint
			Frame.REF_PINPOINT = Frame.Pinpoint

			-- WAYPOINT
			Frame.REF_WAYPOINT_CONTEXT = Frame.REF_WAYPOINT.ContextFrame
			Frame.REF_WAYPOINT_CONTEXT_VFX = Frame.REF_WAYPOINT_CONTEXT.VFX
			Frame.REF_WAYPOINT_CONTEXT_VFX_QUEST_COMPLETION = Frame.REF_WAYPOINT_CONTEXT_VFX.QuestCompletion

			Frame.REF_WAYPOINT_FOOTER = Frame.REF_WAYPOINT.Footer
			Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME = Frame.REF_WAYPOINT_FOOTER.TextFrame
			Frame.REF_WAYPOINT_FOOTER_TEXT = Frame.REF_WAYPOINT_FOOTER_TEXT_FRAME.Text
			Frame.REF_WAYPOINT_MARKER = Frame.REF_WAYPOINT.Marker
			Frame.REF_WAYPOINT_MARKER_BACKGROUND = Frame.REF_WAYPOINT_MARKER.Background
			Frame.REF_WAYPOINT_MARKER_BACKGROUND_TEXTURE = Frame.REF_WAYPOINT_MARKER.BackgroundTexture

			-- PINPOINT
			Frame.REF_PINPOINT_BACKGROUND = Frame.REF_PINPOINT.Background
			Frame.REF_PINPOINT_BACKGROUND_CONTEXT = Frame.REF_PINPOINT_BACKGROUND.ContextFrame
			Frame.REF_PINPOINT_BACKGROUND_ARROW = Frame.REF_PINPOINT_BACKGROUND.ArrowFrame
			Frame.REF_PINPOINT_FOREGROUND = Frame.REF_PINPOINT.Foreground
			Frame.REF_PINPOINT_FOREGROUND_BACKGROUND = Frame.REF_PINPOINT_FOREGROUND.Background
			Frame.REF_PINPOINT_FOREGROUND_BACKGROUND_CENTER = Frame.REF_PINPOINT_FOREGROUND_BACKGROUND.Center
			Frame.REF_PINPOINT_FOREGROUND_BACKGROUND_CENTER_TEXTURE = Frame.REF_PINPOINT_FOREGROUND_BACKGROUND.CenterTexture
			Frame.REF_PINPOINT_FOREGROUND_BACKGROUND_BORDER = Frame.REF_PINPOINT_FOREGROUND_BACKGROUND.Border
			Frame.REF_PINPOINT_FOREGROUND_BACKGROUND_BORDER_TEXTURE = Frame.REF_PINPOINT_FOREGROUND_BACKGROUND.BorderTexture
			Frame.REF_PINPOINT_FOREGROUND_TEXT = Frame.REF_PINPOINT_FOREGROUND.Content.TextFrame.Text
		end
	end

	--------------------------------
	-- REFERENCES
	--------------------------------

	local Frame = WaypointFrame.Waypoint
	local Frame_Waypoint = Frame.REF_WAYPOINT
	local Frame_Pinpoint = Frame.REF_PINPOINT
	local Frame_BlizzardWaypoint = SuperTrackedFrame
	local Callback = NS.Script; NS.Script = Callback

	--------------------------------
	-- SETUP
	--------------------------------

	do
		Frame_Waypoint.hidden = true
		Frame_Waypoint:Hide()

		Frame_Pinpoint.hidden = true
		Frame_Pinpoint:Hide()
	end
end
