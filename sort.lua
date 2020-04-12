-- Scripts for the "Sort" button. When clicked, all cards in the hand of
-- the player that clicked the button will be sorted.
-- This assumes the cards have the value in the name and suit in the description.

-- Order to sort the card value by.
valueOrder = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A", "J1", "J2"}
-- Order to sort the card suits by.
suitOrder = {"S", "D", "C", "H", "JOKER"}

function onload()
    -- Clickable area
    self.createButton({
        click_function = "click", 
        function_owner = self,
        position = {0, 0.2, 0}, 
        height = 700, 
        width = 700, 
        color = {1, 1, 1, 0}, 
        label = "",
        tooltip = "Sort cards in your hand"
    })
    -- Button label
    self.createButton({
        click_function = "click", 
        function_owner = self,
        position = {0, 0.2, 0}, 
        height = 1, 
        width = 1, 
        color = {1, 1, 1, 1}, 
        label = "Sort", 
        font_size = 200
    })
end

function click(_, playerColor)
    printToAll("Sorting cards for " .. playerColor .. ".")
    local hand = {}
    local handOut = {}
    local positions = {}
    local rotation = Player[playerColor].getHandTransform().rotation
    rotation.y = rotation.y + 180
    for i, card in ipairs(Player[playerColor].getHandObjects()) do
        table.insert(hand, {string.upper(card.getName()), string.upper(card.getDescription()), card.guid})
        table.insert(positions, card.getPosition())
    end
    for i, c in ipairs(suitOrder) do
        for x, n in ipairs(valueOrder) do
            for z, card in ipairs(hand) do
                if card[1] == n and card[2] == c then
                    table.insert(handOut, card[3])
                end
            end
        end
    end
    for i, id in ipairs(handOut) do
        getObjectFromGUID(id).setPosition(positions[i])
        getObjectFromGUID(id).setRotation(rotation)
    end
end
