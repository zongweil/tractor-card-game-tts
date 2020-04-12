-- Scripts for the "Reset" button. When clicked, all cards on the table should
-- be cleared, and a new deck should be placed on the table.

-- The GUID of the "template" deck (for cloning purposes). If the GUID of 
-- the deck in TTS changes, this will need to be updated accordingly.
templateDeckGUID = 'b1d845'

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
        tooltip = "Clear cards and reset deck"
    })
    -- Button label
    self.createButton({
        click_function = "click", 
        function_owner = self,
        position = {0, 0.2, 0}, 
        height = 1, 
        width = 1, 
        color = {1, 1, 1, 1}, 
        label = "Reset", 
        font_size = 200
    })
end

function click(gameObj, playerColor)
    self.AssetBundle.playTriggerEffect(0)
    printToAll("Clearing cards from table, pressed by " .. playerColor .. ".")
    local allObjects = getAllObjects()
    for _, object in ipairs(allObjects) do
        if object.tag == "Card" or (object.tag == 'Deck' and object.guid != templateDeckGUID) then
            object.destruct()
        end
    end
    local cloneParameters = {position = {0, 0, 0}}
    local newDeck = getObjectFromGUID(templateDeckGUID).clone(cloneParameters)
    newDeck.setLock(false)
end
