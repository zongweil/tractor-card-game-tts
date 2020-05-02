-- Global scripts. Used to calculate the number of points in the points pile.
-- This assumes there is only one scripting zone. If more are added in the future,
-- we will need to check the zone GUIDs.

pointsZoneGUID = '6fba05'
pointsCounterGUID = '9f24b0'

-- Called when the game is initially loaded.
function onload()
    calculatePointsPile()
end

-- Calculates the points in the pile and updates the counter.
function calculatePointsPile()
    local pointsZone = getObjectFromGUID(pointsZoneGUID)
    local pointsCounter = getObjectFromGUID(pointsCounterGUID)

    local points = 0
    for _, gameObj in ipairs(pointsZone.getObjects()) do
        if gameObj.tag == 'Card' then
            points = points + getPointsForCard(gameObj.getName())
        end
        if gameObj.tag == 'Deck' then
            for _, card in ipairs(gameObj.getObjects()) do
                points = points + getPointsForCard(card.name)
            end
        end
    end
    pointsCounter.setValue(points)
    scheduleNextRun()
end


-- Returns the number of points the card is worth.
function getPointsForCard(cardName)
    local cardValue = string.upper(cardName);
    if cardValue == '5' then
        return 5
    end
    if cardValue == '10' or cardValue == 'K' then
        return 10
    end
    return 0
end

-- Schedules the next run of calculatePointsPile().
function scheduleNextRun()
    Timer.destroy("PointsPileTimer")
    Timer.create({identifier="PointsPileTimer", function_name='calculatePointsPile', delay=1})
end
