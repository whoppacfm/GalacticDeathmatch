
'Chapter3
Global gmChapter3:TSpielmodus = TSpielmodus.Create("Gamma Quadrant","") 'Erziele schneller als Deine Gegnern eine bestimmte Anzahl an Abschuessen")

	'LEVEL 6 : Ausscheidungskampf

	Function updateC3L6(lev:TLevel)
		'..									
	End Function
	gmChapter3.AddLevel(TLevel.Create("Sektor 6: Ausscheidungskampf","Besiege den Abgesandten der ...","arena2.map",updateC3L6))
    'Gegner adden
    	TLevel(gmChapter3.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))


