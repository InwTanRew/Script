BlowB = false
Shard_Challenge = false
Farmdrops = false
EautoShiny = false  


local lib = loadstring(game:HttpGet("https://pastebin.com/raw/xpT46ucU"))();

local debug_f = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ClientScript.Modules.InputService).UpdateClickDelay)[1]
repeat
    wait(.1)
    debug_f = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ClientScript.Modules.InputService).UpdateClickDelay)[1]
until debug_f ~= nil

local Module = game:GetService("ReplicatedStorage").Assets.Modules.ImageService
local guiserv = require(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ClientScript.Modules.GuiService)

local pets = debug.getupvalues(require(Module))[1]

local FinityWindow = lib.new(true);
FinityWindow.ChangeToggleKey(Enum.KeyCode.Insert);

local farm = FinityWindow:Category("Main");

local s1 = farm:Sector("Main");
local target = nil;

local petlist = require(game:GetService("ReplicatedStorage").Assets.Modules.ItemDataService.PetModule)
local hatlist = require(game:GetService("ReplicatedStorage").Assets.Modules.ItemDataService.HatModule)
local raritys = {}
local moneyz = require(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ClientScript.Modules.GuiService)

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

local plr = game.Players.LocalPlayer
local char = plr.Character

function toTarget(pos, targetPos, targetCFrame)
    local tween, err = pcall(function()local tween = game:service"TweenService":Create(plr.Character["HumanoidRootPart"], TweenInfo.new((targetPos - pos).Magnitude/50, Enum.EasingStyle.Quad), {CFrame = targetCFrame})tween:Play()end)
    if not tween then return err end
end


local Auto_Bubble = s1:Cheat("Checkbox", "Auto-Blow Bubble", function(state)
    BlowB = state
    while BlowB do
        if debug_f then
            debug_f['FireServer'](debug_f,'BlowBubble')
        else
            debug_f = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ClientScript.Modules.InputService).UpdateClickDelay)[1]
        end
        wait()
    end
end)

local Auto_Shard_Challenge = s1:Cheat("Checkbox", "Auto Shard Challenge", function(state)
    Shard_Challenge = state
    while Shard_Challenge do
        if debug_f then
            debug_f['FireServer'](debug_f, 'GetShardQuest', 'Hard')
            wait(1)
            debug_f['FireServer'](debug_f, 'ClaimShardQuestReward')
            wait(1)
        end
        wait()
    end
end)

local Farmdrops_E = s1:Cheat("Checkbox", "Farmdrops" , function(state)
    Farmdrops = state
    while Farmdrops do
        if Farmdrops == true then
            local closest = nil
            local dis = math.huge
            for i, v in ipairs(game.Workspace.Pickups:GetChildren()) do
                range = 100
                if tonumber(range) ~= nil then
                    if v:FindFirstChild("TouchInterest") and (char.HumanoidRootPart.Position - v.Position).magnitude <= tonumber(range) and (char.HumanoidRootPart.Position - v.Position).magnitude < dis then
                        closest = v
                        dis = (char.HumanoidRootPart.Position - v.Position).magnitude
                    end
                end
            end
            if closest ~= nil and (target == nil or target.Parent == nil) then
                local dis = closest.CFrame.Y - char.HumanoidRootPart.CFrame.Y
                if dis < (closest.Size.Y * -1) or dis > closest.Size.Y then
                    char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.CFrame.X, closest.CFrame.Y + 2, char.HumanoidRootPart.CFrame.Z)
                end
                toTarget(
                    char.HumanoidRootPart.Position,
                    closest.Position + Vector3.new(0, 2, 0),
                    closest.CFrame + Vector3.new(0, 2, 0)
                )
            end
        else
            Farmdrops = false;
        end
        wait()
    end
end)

local AutoShiny = s1:Cheat("Checkbox", "Auto Shiny", function (state)
    EautoShiny = state
    while EautoShiny do
        if EautoShiny == true then
            local cp = {}
            local e = f:InvokeServer("GetPlayerData")
            local pn = require(game:GetService("ReplicatedStorage").Assets.Modules.Library.index)["PETS"]
            pcall(function()
                --repeat
                    for i,d in pairs(e[pn]) do
                        local id = d[1]
                        local name = d[2]
                        if d[8] == false then
                            cp[name] = (cp[name] or 0) + 1
                            if cp[name] >= 10 then
                                debug_f['FireServer'](debug_f, "MakePetShiny", id)
                            end
                        end
                    end
                --until EautoShiny == false
            end)
        else
            EautoShiny == false
        end
        wait()
    end
end)