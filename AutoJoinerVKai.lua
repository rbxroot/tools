local virtualNigga = game:service('VirtualUser')
game:service('Players').LocalPlayer.Idled:Connect(function()
    virtualNigga:CaptureController()
    virtualNigga:ClickButton2(Vector2.new())
end)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoJoinerGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Thickness = 4
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = frame
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundTransparency = 1
label.Text = "Auto Joiner\nby sudo_kai"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.SourceSans
label.TextStrokeTransparency = 0.8
label.Parent = frame
local function animateRGBBorder()
    while true do
        for i = 0, 255, 5 do
            local color = Color3.fromRGB(i, 0, 255 - i)
            uiStroke.Color = color
            wait(0.05)
        end
        for i = 255, 0, -5 do
            local color = Color3.fromRGB(i, 255 - i, 0)
            uiStroke.Color = color
            wait(0.05)
        end
    end
end
spawn(animateRGBBorder)
local dragging = false
local dragInput, startPos, framePos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            startPos = input.Position
        else
            startPos = input.Position
        end
        framePos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
        local delta
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            delta = input.Position - startPos
        elseif input.UserInputType == Enum.UserInputType.Touch then
            delta = input.Position - startPos
        end
        frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)
frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

--autojoiner
local Token = Token or ""
local ChannelId = Channel or ""

repeat wait() until game:IsLoaded()
local HttpService = game:GetService("HttpService")
local requestFunction = (syn and syn.request) or (http and http.request) or (http_request) or (request)

local saveFilePath = "cache.txt"
local function saveLastMessageId(messageId)
    local success, err = pcall(function()
        writefile(saveFilePath, messageId)
    end)
    if not success then
        warn("Give Roblox access to storage!", err)
    end
end

local function loadLastMessageId()
    if isfile(saveFilePath) then
        local success, messageId = pcall(function()
            return readfile(saveFilePath)
        end)
        if success then
            return messageId
        end
    end
    return nil
end

local lastProcessedMessageId = loadLastMessageId()

while true do
    local success, response = pcall(function()
        return requestFunction({
            Url = "https://discord.com/api/v9/channels/" .. ChannelId .. "/messages?limit=1",
            Method = "GET",
            Headers = {
                ["Authorization"] = Token,
                ["Content-Type"] = "application/json",
            },
        })
    end)
    if success and response.StatusCode == 200 then
        local messages = HttpService:JSONDecode(response.Body)
        if #messages > 0 then
            local message = messages[1]
            if message.id == lastProcessedMessageId then
            else
                local messageContent = message.content
                local placeId, jobId = string.match(messageContent, "TeleportToPlaceInstance%((%d+),%s*\"([^\"]+)\"")
                if placeId and jobId then
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(tonumber(placeId), jobId, game.Players.LocalPlayer)
                    end)
                    saveLastMessageId(message.id)
                end
            end
        end
    end
    wait(0.5)
end


