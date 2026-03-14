local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")

local Window = Rayfield:CreateWindow({
    Name = "Zorvixa / Flex your weather",
    LoadingTitle = "Loading... made by zorvixa",
    LoadingSubtitle = "made by Zorvixa",
    ConfigurationSaving = {
        Enabled = false
    }
})

local MainTab = Window:CreateTab("Main")

local customTime = "20:36"
local isSpoofing = false
local useFlicker = false
local spoofConnection = nil

local timeRemote = game:GetService("ReplicatedStorage"):FindFirstChild("updateLocalTime")

MainTab:CreateButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/auqz35TtVm")
        Rayfield:Notify({
            Title = "Success",
            Content = "Discord link copied to clipboard!",
            Duration = 5
        })
    end,
})

MainTab:CreateInput({
    Name = "Set Custom Time",
    PlaceholderText = "e.g. 20:36",
    Callback = function(Text) 
        customTime = Text 
    end,
})

MainTab:CreateToggle({
    Name = "Orignal time",
    CurrentValue = false,
    Flag = "FlickerToggle",
    Callback = function(Value) 
        useFlicker = Value 
    end,
})

MainTab:CreateToggle({
    Name = "Spoof Fake ass time",
    CurrentValue = false,
    Flag = "SpoofToggle",
    Callback = function(Value)
        isSpoofing = Value
        
        if isSpoofing then
            spoofConnection = RunService.Heartbeat:Connect(function()
                if not isSpoofing then 
                    if spoofConnection then spoofConnection:Disconnect() end
                    return 
                end

                if timeRemote then
                    if useFlicker then
                        timeRemote:FireServer(os.date("%H:%M"))
                        timeRemote:FireServer(customTime)
                    else
                        timeRemote:FireServer(customTime)
                    end
                end
            end)
        else
            if spoofConnection then
                spoofConnection:Disconnect()
                spoofConnection = nil
            end
        end
    end,
})

Rayfield:LoadConfiguration()
