'Chapter5
Global gmChapter5:TSpielmodus = TSpielmodus.Create("Finale","") 'Erziele schneller als Deine Gegnern eine bestimmte Anzahl an Abschuessen")

	'LEVEL 6 : Ausscheidungskampf

	Function updateC5L6(lev:TLevel)
		'..									
	End Function
	gmChapter5.AddLevel(TLevel.Create("Sektor 6: Ausscheidungskampf","Besiege den Abgesandten der ...","arena2.map",updateC5L6))
    'Gegner adden
    	TLevel(gmChapter5.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))


