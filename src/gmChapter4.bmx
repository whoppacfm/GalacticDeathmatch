'Chapter4
Global gmChapter4:TSpielmodus = TSpielmodus.Create("Delta Quadrant","") 'Erziele schneller als Deine Gegnern eine bestimmte Anzahl an Abschuessen")


	'LEVEL 6 : Ausscheidungskampf

	Function updateC4L6(lev:TLevel)
		'..									
	End Function
	gmChapter4.AddLevel(TLevel.Create("Sektor 6: Ausscheidungskampf","Besiege den Abgesandten der ...","arena2.map",updateC4L6))
    'Gegner adden
    	TLevel(gmChapter4.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))

