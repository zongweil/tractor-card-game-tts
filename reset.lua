function onload()
  -- clickable area
  self.createButton({
      click_function="click", function_owner=self,
      position={0, 0.2, 0}, height=700, width=700, color={1,1,1,0}, label=""
  })
  -- button label
  self.createButton({
      click_function="click", function_owner=self,
      position={0, 0.2, 0}, height=1, width=1, color={1,1,1,1}, label="Reset", font_size=200
  })
end

function click(gameObj, playerColor)
  self.AssetBundle.playTriggerEffect(0)
  print("Clearing cards from table, pressed by " .. playerColor .. ".")
  local allObjects = getAllObjects()
  --Loop through allObjects
  for _, object in ipairs(allObjects) do

      if object.tag == "Card" or (object.tag == 'Deck' and object.guid != '1ef81b') then
          object.destruct()
      end
  end
  local deckTemplate = getObjectFromGUID('1ef81b')
  local clone_parameters = {position = {0, 0, 0}}
  local newDeck = deckTemplate.clone(clone_parameters)
  newDeck.setLock(false)
end