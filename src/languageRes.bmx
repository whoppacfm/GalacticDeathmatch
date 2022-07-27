




Function GetLang:String(value:String)
	
	If language = 0 Then 'deutsch
		Return value
	Else If language = 1 Then 'englisch
		value = Lower(value)
												
		Select value 
		
			'Spacetest.bmx
		
			Case Lower("Spieler") 							Return "Player"
			Case Lower("Laden...") 							Return "LOADING..."
			Case Lower("weiterspielen") 					Return "continue"
			Case Lower("Sound-OPTIONEN") 					Return "sound options"
			Case Lower("Graphik-OPTIONEN") 					Return "graphics options"
			Case Lower("Spiel abbrechen") 					Return "cancel game"
			Case Lower("zu Windows") 						Return "quit to windows"
			Case Lower("ZURÜCK") 							Return "back"
			Case Lower("ÄNDERN")			 				Return "change"
			Case Lower("ÄNDERUNGEN SPEICHERN") 				Return "save changes"
			Case Lower("LEVEL STARTEN")						Return "start level"
			Case Lower("AUFLÖSUNG: ") 						Return "resolution: "
			Case Lower("FARBTIEFE: ") 						Return "depth: "
			Case Lower("TREIBER: ") 						Return "driver: "
			Case Lower("Vollversion holen") 				Return "get full version"
			Case Lower("Vielleicht später") 				Return "maybe later"
			Case Lower("BEENDEN") 							Return "quit"
			Case Lower("SPIELEN") 							Return "play"
			Case Lower("WEITER") 							Return "continue"
			Case Lower("EINFACH") 							Return "easy"
			Case Lower("NORMAL") 							Return "normal"
			Case Lower("PROFI") 							Return "champion"
			Case Lower("Wähle einen Schwierigkeitsgrad") 	Return "Choose degree of difficulty"
			Case Lower("Wähle einen Level") 				Return "Choose level"
			Case Lower("Wähle einen Quadrant") 				Return "Choose quadrant"
			Case Lower("NUR IN DER VOLLVERSION VERFÜGBAR")	 Return "ONLY AVAILABLE IN FULL VERSION"
			Case Lower("Wähle ein Raumschiff") 				Return "choose your spaceship"
			Case Lower("Geschwindigkeit:") 					Return "speed:"
			Case Lower("Schildenergie:") 					Return "shield energy:"
			Case Lower("Wendigkeit:") 						Return "agility:"
			Case Lower("SOUNDEFFEKTE") 						Return "sound effects"
			Case Lower("MUSIK") 							Return "music"
			
			'--------------------
			
			
			
			
			'gmChapter1.bmx						
			Case Lower("Alpha Quadrant")
				Return "Alpha Quadrant"
			Case Lower("Guten Tag, Abgesandter!") 					
				Return "Good afternoon, envoy"
			Case Lower("Drücke jetzt die F1-Taste, um den Hilfebildschirm aufzurufen.") 					
				Return "Now press the F1 key to call the help screen."
			Case Lower("Drücke wiederholt F1 oder Escape, um zum Spiel zurückzukehren.") 					
				Return "Press F1 again or Escape to return to the game."
			Case Lower("Der Hilfebildschirm kann während des Spiels jederzeit aufgerufen werden.") 					
				Return "The help screen can be called at any time during the game."
			Case Lower("Nutze ihn, um Dich über Tastaturbelegung und Spielelemente zu informieren.") 					
				Return "Use it to inform yourself about game controls and game elements."
			Case Lower("Der blaue rotierende Schild, links unten, zeigt Deine Schildenergie.") 					
				Return "The blue rotary sign, at the bottom left, shows your shield energy."
			Case Lower("Fällt Deine Schildenergie unter 0, explodiert Dein Raumschiff.") 					
				Return "If your shield energy falls under 0, your spaceship will explode."
			Case Lower("Unten in der Mitte befindet sich die Munitionsanzeige für Deine") 					
				Return "The ammunition display, below In the middle, is for your "
			Case Lower("aktuelle Waffe. Am Anfang besitzt Du nur den Standard-Laser mit") 					
				Return "topical weapon. At the beginning, you only have the single laser"
			Case Lower("unendlich viel Munition, was Du am Gedankenstrich erkennen kannst.") 					
				Return "with endless ammo."
			Case Lower("Drücke die Enter-Taste, um fortzufahren.") 					
				Return "Press ENTER to continue"
			Case Lower("Probiere als nächstes Deine Standardwaffe aus:") 					
				Return "Press the shooting key (space bar) to test your standard weapon."
			Case Lower("Drücke dazu die Schuss-Taste (Leertaste)") 					
				Return ""
			Case Lower("Um andere Waffen und Items zu erhalten, musst Du mit Deinem") 					
				Return "To receive other weapons and items, you have to fly over the"
			Case Lower("Raumschiff über die Items fliegen.") 					
				Return "items with your spaceship."
			Case Lower("Drücke jetzt solange auf die Vorwärtsfliegen-Taste bis") 					
				Return "Now press the forward key, until your spaceship"
			Case Lower("sich Dein Raumschiff über dem nächsten Item befindet.") 					
				Return "has reached the next item."
			Case Lower("Wenn Du über ein Waffen-Item fliegst, wird die neue Waffe") 					
				Return "If you fly over a weapon item, the new weapon will be"
			Case Lower("automatisch als Deine aktuelle Waffe gesetzt.") 					
				Return "automatically set as your topical weapon."
			Case Lower("Mit der Taste c oder den Tasten 1-9, kannst Du zwischen") 					
				Return "With the c key or the keys 1-9, you can"
			Case Lower("deinen Waffen wechseln.") 					
				Return "change your weapon."
			Case Lower("Drücke die Enter-Taste, um fortzufahren.") 					
				Return "Press ENTER to continue"
			Case Lower("Um einen Überblick über die im Level vorhandenen Gegner zu") 					
				Return "To get an overview about your opponents,"
			Case Lower("bekommen, kannst Du Dir das Radar-Item holen:") 					
				Return "you can pick up the Radar-Item."
			Case Lower("Drücke solange die Vorwärtsfliegen-Taste bis Du das Radar-Item") 					
				Return "Press the forward key, until you have picked up the radar item."
			Case Lower("aufgenommen hast.") 					
				Return ""
			Case Lower("Jetzt siehst Du links oben eine Miniaturausführung der Arena.") 					
				Return "Now you see a miniature design of the arena at the top left."
			Case Lower("Der weisse Punkt bist Du und feindliche Raumschiffe werden mit") 					
				Return "You are the white point and hostile spaceships are marked"
			Case Lower("roten Punkten gekennzeichnet.") 					
				Return "with red points."
			Case Lower("Turbo-Booster") 					
				Return "Turbo booster"
			Case Lower("Drücke die Vorwärtsfliegen-Taste, bis sich Dein Raumschiff") 					
				Return "Press the forward key, until your spaceship has reached"
			Case Lower("über dem Booster-Item befindet.") 					
				Return "the booster item."
			Case Lower("Mit Hilfe des Boosters kann Dein Raumschiff deutlich schneller") 					
				Return "With the help of the turbo booster, your spaceship can fly"
			Case Lower("fliegen. Drücke dazu die Vorwärtsfliegen-Taste und gleichzeitig") 					
				Return "much faster. Press the forward key and the booster key (LEFT ALT"
			Case Lower("die Booster-Taste (linke ALT-Taste neben der Leertaste).") 					
				Return "key beside the space bar) at the same time."
			Case Lower("Drücke die Enter-Taste, um fortzufahren.") 					
				Return "Press ENTER to continue"
			Case Lower("Hole Dir das Minen-Item vor Deinem Raumschiff. Drücke die Schusstaste") 					
				Return "Get the mine item in front of your spaceship. Press the shooting key"
			Case Lower("um Minen abzulegen. Blaue Minen sind für Dein Raumschiff ungefährlich") 					
				Return "to place mines. Blue mines are safe for your spaceship and only injure"
			Case Lower("und verletzen nur feindliche Raumschiffe, rote Minen können Dein Raumschiff") 					
				Return "hostile spaceships, red mines can damage your spaceship."
			Case Lower("dagegen beschädigen.") 					
				Return ""
			Case Lower("Drücke die Enter-Taste, um Deine neuen Fähigkeiten praktisch") 					
				Return "Press ENTER to use your new abilities practically."
			Case Lower("einzusetzen: Steuere die roten Punkte auf dem Radar an und zerstöre") 					
				Return "Head for the red points on the radar and destroy the hostile spaceships."
			Case Lower("die feindlichen Raumschiffe.") 					
				Return ""

			Case Lower("Tipps für Deinen ersten Kampfdrohnen-Einsatz:") 					
				Return "Tips for your first fighting drones mission:"
			Case Lower("- Drücke die Taste F1, um die Tastaturbelegung zu erfahren") 					
				Return "- Press the F1 key to find out the keyboard controls"
			Case Lower("- Finde die Schwächen der Drohnen und nutze sie") 					
				Return "- Find the weaknesses of the drones and use them"
			Case Lower("- Sammle das Radar ein und verschaffe Dir einen Überblick") 					
				Return "- Collect the radar item to get an overview"
			Case Lower("Drücke die Enter-Taste, um die Tipps auszublenden") 						
				Return "Press the ENTER key to fade out the tips"

			Case Lower("Tipps für Dein erstes Labyrinth:") 					
				Return "Tips for your first labyrinth:"
			Case Lower("- Sammle alle roten Signalitems ein, bevor der Countdown abläuft") 					
				Return "- Collect all red signal items, before the countdown runs off"
			Case Lower("- Informiere Dich am oberen Bildschirmrand über Deinen Status") 					
				Return "- Your level status is displayed in the upper screen edge"
			Case Lower("- Hole und benutze den Turbo-Booster (ALT-Taste)") 					
				Return "- Get and use the turbo booster (LEFT ALT key) "
			Case Lower("Drücke die Enter-Taste, um die Tipps auszublenden") 					
				Return "Press the Enter key to fade out the tips"

			Case Lower("Tipps für Deinen ersten Sicherungs-Level:") 					
				Return "Tips for your first space station protection:"
			Case Lower("- Nutze die Taste c, um zwischen deinen Waffen zu wechseln") 					
				Return "- Use the c-key to change your weapons"
			Case Lower("- Sammle Minen-Items und lege Minenfelder an") 					
				Return "- Collect mine items and create a field of mines"
			Case Lower("- Am oberen Bildschirmrand wird die Schildenergie der Raumstation angezeigt") 					
				Return "- Collect gun turret items and place them with the v-key"
			Case Lower("- Sammle Geschützturm-Items und platziere sie mit der Taste v") 					
				Return ""
			Case Lower("Drücke die Enter-Taste, um die Tipps auszublenden") 					
				Return "Press the Enter key to fade out the tips"
				
			Case Lower("Tipps für Deinen ersten Zweikampf:") 					
				Return "Tips for your first duel:"
			Case Lower("- Lege Minen an taktisch geschickten Stellen") 					
				Return "- Place mines at tactical places"
			Case Lower("- Repariere Dein Raumschiff mit Schildenergie-Boni") 					
				Return "- Repair your spaceship with shield energy bonuses"
			Case Lower("- Wenn Du rückwärts fliegst, vergrößert sich Deine Schuss-Reichweite") 					
				Return "- Fly backwards to enhance your shooting range"
			Case Lower("- Der Turbo-Booster kann im Nahkampf sehr nützlich sein") 					
				Return "- The turbo booster can be helpful in the short distance fight"
			Case Lower("Drücke die Enter-Taste, um die Tipps auszublenden") 					
				Return "Press the Enter key to fade out the tips"



			Case Lower("Level 1: Pilotentraining") 					
				Return "Level 1: Training"
			Case Lower("Werde ein Pilot") 					
				Return "Become a pilot"
			Case Lower("Kampfdrohnen") 					
				Return "Fighting drones"
			Case Lower("Vernichte alle Kampfdrohnen") 					
				Return "Destroy all fighting drones"
			Case Lower("Labyrinth") 					
				Return "Labyrinth"
			Case Lower("Finde alle roten Signalgeber")					
				Return "Find all red signal items"
			Case Lower("Sicherung") 					
				Return "Protection"
			Case Lower("Verteidige die Raumstation gegen alle Angreifer") 					
				Return "Defend the space station against all attackers"
			Case Lower("Zweikampf") 					
				Return "Duel"
			Case Lower("Erziele als erstes 5 Abschüsse") 					
				Return "Achieve 5 frags to win"
			Case Lower("Power Drohnen") 					
				Return "Power drones"
			Case Lower("Eine echte Herausforderung") 					
				Return "A real challenge"
			Case Lower("Teamwork") 					
				Return "Teamwork"
			Case Lower("Minenfelder") 					
				Return "Mine fields"
			Case Lower("An der Wand") 					
				Return "At the wall"
			Case Lower("Triple Drohnen") 					
				Return "Triple drones"
			Case Lower("Duell der Scharfschützen") 					
				Return "Duel of the marksmen"
			Case Lower("Der Gejagte") 					
				Return "The hunted"
			Case Lower("Dreierpack")					
				Return "Triple pack"
			Case Lower("Jetzt wird abgerechnet!") 					
				Return "Partytime"
			Case Lower("Flamer Drohnen") 					
				Return "Flamer drones"
			Case Lower("Bewache den Durchgang") 					
				Return "Guard the passageway"
			Case Lower("Schlacht im Trümmerfeld") 					
				Return "Battle in the field of rubble"
			Case Lower("Gute Mischung") 					
				Return "Good mixture"
			Case Lower("Bewachtes Gebiet") 					
				Return "Guarded area"
			Case Lower("Fernkampf-Duell") 					
				Return "Distant fight"
			Case Lower("Sturmtruppen")					
				Return "Storm troopers"
			Case Lower("Target Drohnen") 					
				Return "Target drones"
			Case Lower("Speedy Scout") 					
				Return "Speedy Scout"
			Case Lower("Mausefalle") 					
				Return "Mousetrap"
			Case Lower("Zusammenkunft") 					
				Return "The meeting"
			Case Lower("Aus allen Richtungen") 					
				Return "From all directions"
			Case Lower("Nahkampf-Duell") 					
				Return "Melee"
			Case Lower("Schlachtfeld") 					
				Return "Battlefield"
			Case Lower("Finalkampf") 					
				Return "Final fight"
			Case Lower("Besiege den Ultra Fighter") 					
				Return "Defeat the Ultra Fighter"
			Case Lower("Gegner") 					
				Return "Opponent"
			Case Lower("Graphikmodus wird nicht unterstuetzt.") 					
				Return "Graphics mode is not supported"
						
											

																					
			Case Lower("(Ausgeteilter Schaden minus erlittener Schaden)") 					
				Return "(damage of all enemy ships minus damage of your ship)"
			Case Lower("(Übrige Schildenergie der Raumstation)") 					
				Return "(remaining shield energy of the space station)"
			Case Lower("(Übrige Zeit in Sekunden)") 					
				Return "(remaining time)"
			Case Lower("(Deine Abschuesse minus Abschuesse des Gegners)") 					
				Return "(your frags minus enemy frags)"
							
							
																																																																																																																																																																																							
																											
						
			Case Lower("- DRÜCKE ENTER -") 					
				Return "- Press enter to respawn -"
			Case Lower("AUFTRAG ERFUELLT") 					
				Return "Mission SUCCESSFULLY accomplished"
			Case Lower("DEMOVERSION ERFOLGREICH DURCHGESPIELT") 					
				Return "DEMO VERSION SUCCESSFULLY ACCOMPLISHED"
			Case Lower("Herzlichen Glückwunsch!") 					
				Return "Congratulations!"
			Case Lower("Du hast alle Herausforderungen bewältigt und bist der neue Champion.") 					
				Return "You have mastered all challenges and can call yourself the new champion."
			Case Lower("Auf www.workisover.de wartet noch mehr Action auf Dich.") 					
				Return "Even more action awaits you on www.workisover.com"
			Case Lower("Es wird immer fleissig an Updates mit kostenlosen Zusatzlevels,") 					
				Return "We are busily working on updates with new free additional levels,"
			Case Lower("Raumschiffen, Waffen und Bonus-Items gearbeitet. Wenn Du Ideen für") 					
				Return "spaceships, weapons and Bonus-Items."
			Case Lower("neue Levels, Waffen usw hast, wären wir erfreut, wenn Du uns diese") 					
				Return "if you have some cool ideas, we were pleased if you would inform us."
			Case Lower("mitteilst. Nur so können wir das Spiel verbessern.") 					
				Return ""
			Case Lower("Klicke mit der Maus, um zum Spiel zurückzukehren") 					
				Return "Click the mouse to return to the game"
			Case Lower("AUFTRAG FEHLGESCHLAGEN") 					
				Return "Mission failed"
			Case Lower("Spieler") 					
				Return "Player"
		
					
			
			Default Return ""
		End Select
	
	Else 
		Return ""
	End If
End Function