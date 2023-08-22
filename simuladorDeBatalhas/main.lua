local utils = require("utils")
local player = require("player.player")
local playerActions = require("player.actions")
local colossus = require("colossus.colossus")
local colossusActions = require("colossus.actions")
local game = require("game")

utils.enableUtf8()
utils.header()

local boss = colossus
local bossActions = colossusActions
utils.printCard(boss)

local hero = player
local heroActions = playerActions

heroActions.build()
bossActions.build()


while true do
    --hero Turn
    print(
        string.format("qual sera a proxima acao de %s?",hero.name)
    )
    
    local validheroActions = game.displayActions(hero,heroActions,boss)

    local chosenId = utils.ask()
    local chosenAction = validheroActions[chosenId]
    local isActionValid = chosenAction ~= nil
    os.execute("cls")
    utils.cardLimite()

    if isActionValid then
        chosenAction.execute(hero,boss)
    else
        print(
            string.format("Sua acao eh invalida, %s perdeu a vez!",hero.name)
        )
    end

    if boss.health <= 0 then
        break
    end

    --Boss Turn
    utils.cardLimite()
    local validBossActions = bossActions.getValidActions(hero,boss)
    local bossAction = validBossActions[math.random(#validBossActions)]
    bossAction.execute(hero,boss)
    utils.cardLimite()
    if hero.health <= 0 then
        break
    end
end

utils.footer(hero,boss)

