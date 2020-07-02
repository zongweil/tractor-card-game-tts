-- Scripts for the "Deal" button with 2 decks (108 cards). When clicked, cards
-- from the deck will automatically be dealt to all seated players.

-- The GUID of the "template" deck (for cloning purposes). If the GUID of
-- the deck in TTS changes, this will need to be updated accordingly.
templateDeckGUID = '1ef81b'

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
        tooltip = "Automatically deal cards to each player"
    })
    -- Button label
    self.createButton({
        click_function = "click", 
        function_owner = self,
        position = {0, 0.2, 0}, 
        height = 1, 
        width = 1, 
        color = {1, 1, 1, 1}, 
        label = "Deal", 
        font_size = 200
    })
end

function click(gameObj, playerColor)
    self.AssetBundle.playTriggerEffect(0)
    printToAll("Dealing cards, pressed by " .. playerColor .. ".")
    local allObjects = getAllObjects()
    for _, object in ipairs(allObjects) do
        if object.tag == 'Deck' and object.guid != templateDeckGUID then
            object.shuffle()
            dealDeck(object, playerColor)
        end
    end
end

function dealDeck(deck, playerColorWhoPressed)
    local numSeatedPlayers = #getSeatedPlayers()
    local numCardsToDeal = 100 / numSeatedPlayers
    -- Deal 100 of the 108 cards, 1 to each player at a time.
    for index, currentPlayerColor in ipairs(getSeatedPlayers()) do
        Wait.time(function() deck.deal(1, currentPlayerColor) end, 2, numCardsToDeal)
    end
end