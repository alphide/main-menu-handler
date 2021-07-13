local plr = game.Players.LocalPlayer

local char = plr.Character or plr.CharacterAdded:Wait()	
char:WaitForChild("HumanoidRootPart").Anchored = true


local mouse = plr:GetMouse()

wait(0.01)


local camera = game.workspace.CurrentCamera
local original_CF = camera.CFrame

camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = workspace.MenuComponents.CameraStartPosition.CFrame


local tweenService = game:GetService("TweenService")


local mainMenuGui = script.Parent


local mainMenuBG = mainMenuGui:WaitForChild("MainMenuBackground")
local whiteScreen = mainMenuBG:WaitForChild("WhiteScreen")

local playBtn = mainMenuBG:WaitForChild("PlayButton")
local creditsBtn = mainMenuBG:WaitForChild("CreditsButton")
local settingsBtn = mainMenuBG:WaitForChild("SettingsButton")

local creditsBG = mainMenuBG:WaitForChild("CreditsBackground")


local loadingScreenBG = mainMenuGui:WaitForChild("LoadingScreenBackground")

local logo = loadingScreenBG:WaitForChild("Logo")

local loadingBarBG = loadingScreenBG:WaitForChild("LoadingBarBG")
local clippingFrame = loadingBarBG:WaitForChild("ClippingFrame")
local loadingBar = clippingFrame:WaitForChild("LoadingBar")
local sound = Instance.new("Sound", game.Workspace)
local BlackRover = Instance.new("Sound", game.Workspace) -- ;)


BlackRover.SoundId = "rbxassetid://3427900635"
BlackRover.Looped = true

sound.SoundId = "rbxassetid://4255432837"
sound.Volume = 1


local originalCFrame = camera.CFrame
local scaleFactor = 1000

game:GetService("RunService").RenderStepped:Connect(function()


	local centreOfScreen = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

	local mouseDistanceFromCentre = Vector3.new((-mouse.X - centreOfScreen.X) / scaleFactor, (mouse.Y - centreOfScreen.Y) / scaleFactor, 0)


	camera.CFrame = originalCFrame * CFrame.new(originalCFrame.LookVector + mouseDistanceFromCentre)
end)



clippingFrame.Size = UDim2.new(0, 0, 1, 0)

clippingFrame:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 5) -- style and effect of loading bar

	
clippingFrame:GetPropertyChangedSignal("Size"):Connect(function() -- function for scale of loading bar	


	loadingBar.Size = UDim2.new(1/clippingFrame.Size.X.Scale, 0, 1, 0)
end)


repeat wait() until clippingFrame.Size == UDim2.new(1, 0, 1, 0)
sound:Play()


logo:TweenPosition(UDim2.new(0.25, 0, -0.25, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
loadingBarBG:TweenPosition(UDim2.new(0.85, 0, 1.85, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)


local loadingScreenFade = tweenService:Create(loadingScreenBG, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {BackgroundTransparency = 1})
loadingScreenFade:Play()


BlackRover.Volume = 0
wait(0.2)
BlackRover:Play()
for x = 0,1,0.1 do
	BlackRover.Volume = x
	wait(0.1)
end	



local playButtonClicked = false

playBtn.MouseButton1Click:Connect(function()
	
	if playButtonClicked then return end
	playButtonClicked = true
	
	
	
	creditsBG:TweenPosition(UDim2.new(-0.5, 0, 0.5, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 1, true)
	

	local whiteScreenFade = tweenService:Create(whiteScreen, TweenInfo.new(1), {ImageTransparency = 0})
	local whiteScreenFadeIn = tweenService:Create(whiteScreen, TweenInfo.new(1), {ImageTransparency = 1})
	
	
	whiteScreenFade:Play()

	
	wait(2)
	
	
	
	char.HumanoidRootPart.Anchored = false
	char.HumanoidRootPart.CFrame = workspace.MenuComponents.SpawnPart.CFrame
	
	camera.CameraType = Enum.CameraType.Custom
	
	
	wait(0.01)
	
	whiteScreenFadeIn:Play()
	
	sound:Destroy()
	
	for i = 1,0,-0.1  do
		BlackRover.Volume = i
		wait(0.1)
	end
	wait(0.2)
	BlackRover:Destroy()
	mainMenuGui:Destroy()
	

end)

local settingsBtnClicked = false
-- wip
settingsBtn.MouseButton1Click:Connect(function()
	if settingsBtnClicked then return end
	settingsBtnClicked = true
	
	
	
end)


local creditsOpen = false

creditsBtn.MouseButton1Click:Connect(function()
	
	if playButtonClicked then return end	
	
	if creditsOpen then
		creditsBG:TweenPosition(UDim2.new(-0.5, 0, 0.5, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 1, true)
		
	else
		creditsBG:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 1, true)
	end
	
	creditsOpen = not creditsOpen
end)


local function hoverOnButton(btn)
	
	if playButtonClicked then return end
	
	local colorDarken = tweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(221, 221, 221)})
	colorDarken:Play()
	playBtn:TweenSize(UDim2.new(0.192, 0, 0.128, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.25, true)
end

local function hoverOffButton(btn)
	
	if playButtonClicked then return end
	
	local colorNormal = tweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
	colorNormal:Play()
	playBtn:TweenSize(UDim2.new(0.202, 0, 0.138, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.25, true)
	
end

local function hoverOffButtonSet(btn)

	if settingsBtnClicked then return end

	local colorNormal = tweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
	colorNormal:Play()
	settingsBtn:TweenSize(UDim2.new(0, 277, 0, 98), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.25, true)
end

local function hoverOnButtonSet(btn)

	if settingsBtnClicked then return end

	
	local colorDarken = tweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(221, 221, 221)})
	colorDarken:Play()
	settingsBtn:TweenSize(UDim2.new(0, 270, 0, 91), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.25, true)

end




playBtn.MouseEnter:Connect(function()
	
	hoverOnButton(playBtn)
	
end)
creditsBtn.MouseEnter:Connect(function()
	
	hoverOnButton(creditsBtn)
end)
settingsBtn.MouseEnter:Connect(function()
	hoverOnButtonSet(settingsBtn)
end)


playBtn.MouseLeave:Connect(function()
	
	hoverOffButton(playBtn)
end)
creditsBtn.MouseLeave:Connect(function()
	
	hoverOffButton(creditsBtn)
end)
settingsBtn.MouseLeave:Connect(function()
	hoverOffButtonSet(settingsBtn)
end)

