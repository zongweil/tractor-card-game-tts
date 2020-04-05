function onload()
  -- clickable area
  self.createButton({
      click_function="click", function_owner=self,
      position={0, 0.2, 0}, height=700, width=700, color={1,1,1,0}, label=""
  })
  -- button label
  self.createButton({
      click_function="click", function_owner=self,
      position={0, 0.2, 0}, height=1, width=1, color={1,1,1,1}, label="Deal", font_size=200
  })
end

function click(gameObj, playerColor)
  self.AssetBundle.playTriggerEffect(0)
  print("Dealing cards, pressed by " .. playerColor .. ".")
  local allObjects = getAllObjects()
  --Loop through allObjects
  for _, object in ipairs(allObjects) do

      if object.tag == 'Deck' and object.guid != '1ef81b' then
          object.shuffle()
          dealDeck(object, playerColor)
      end
  end
end

function dealDeck(deck, playerColorWhoPressed)
  local numSeatedPlayers = #getSeatedPlayers()
  local numCardsToDeal = 156 / numSeatedPlayers
  for index, currentPlayerColor in ipairs(getSeatedPlayers()) do
    Wait.time(function() deck.deal(1, currentPlayerColor) end, 2, numCardsToDeal)
  end
  Wait.time(function() deck.deal(6, playerColorWhoPressed) end, (2 * numCardsToDeal) + 2)
end