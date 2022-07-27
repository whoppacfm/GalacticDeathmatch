'Strict
'Global AppVersion:String = "0.1"
'AppTitle$ = "A*"

'Graphics 1024,768

Include	"TASternh.bmx"

'Global MAPSIZE = 20 'für 2000*2000 Level und 100*100 Felder
'Global map:Byte[MAPSIZE,MAPSIZE] 'unsigned char   map[ MAPSIZE ][ MAPSIZE ];
'Global marked:Byte[MAPSIZE,MAPSIZE]

Global mapsize:Int
Global map:Byte[,]
Global marked:Byte[,]

Const MARKED_NONE = 0
Const MARKED_OPEN = 1
Const MARKED_CLOSE = 2


Type TAStar
	Field start:TPosition
	Field goal:TPosition
	Field nodesExpanded:Int

	Field masterNodeList:TMasterNodeList
	Field pQueue:TPriorityQueue
	Field goalNode:TNode
	
	Field openNodes:Int
	Field closedNodes:Int

	
		
				
	Method pathCostEstimate:Int(s:TPosition, g:TPosition)

		Local cx
		Local cy

	


		'Manhattan
		If s.x > g.x Then
			cx = s.x - g.x
		Else
			cx = g.x - s.x
		End If
		
		If s.y > g.y Then
			cy = s.y - g.y	
		Else
			cy = g.y - s.y	
		End If
	
		'Return cx+cy*500


	

		Local c:Int = (map[s.x,s.y] + map[g.x,g.y]) Shr 1
		'Return c

		' nur entfernung als maß, keine unterschiedlichen bewegungskosten !
        'Return sqrt( ( s.x() - g.x() ) * ( s.x() - g.x() ) + ( s.y() - g.y() ) * ( s.y() - g.y() ) ) * COSTSTRAIGHT * 128;
		
		'Euklid
		Return Sqr(((s.x - g.x)*(s.x-g.x)) + ((s.y-g.y)*(s.y-g.y))) * 392 * 128
		
		
		
        ' variante 1
        'Int straight = Max( Abs( s.x() - g.x() ), Abs( s.y() - g.y() ) );
        'Int diagonal = Min( Abs( s.x() - g.x() ), Abs( s.y() - g.y() ) );
      
		'Return ( diagonal * COSTDIAGONAL + ( straight - diagonal ) * COSTSTRAIGHT ) * c;
        
		' variante 2
        'Return Max( Abs( s.x - g.x ), Abs( s.y - g.y ) ) * COSTSTRAIGHT * c;
        
		' variante 3
        'Return Sqr( Abs( s.x - g.x ) * Abs( s.x - g.x ) + Abs( s.y - g.y ) * Abs( s.y - g.y ) ) * c;

        ' triviale variante
        'Return 0;
	End Method
	
	
	
	
	
	
	Method traversalCost:Int(a:TPosition,b:TPosition, d:Int)
'		Local c:Int = (map[a.x][a.y] + map[b.x][b.y]) Shr 1
		Local c:Int = (map[a.x,a.y] + map[b.x,b.y]) Shr 1
		'Return 1
		Return c * travCost[d]
	End Method 
	
	
	Method getDirIndex:Int(dx:Int,dy:Int)
		Local i:Int
		Local back:Int = 0
		For i = 0 To 7
			If (xofs[i] = dx) And (yofs[i] = dy) Then
				back = i
				Exit
			End If
		Next
		
		Return back
	End Method	
	
	
	Method isValid:Int(p:TPosition)
'		If (p.x < 0 Or p.x >= MAPSIZE Or p.y < 0 Or p.y >= MAPSIZE Or map[p.x][p.y]=255) Then
		If (p.x < 0 Or p.x >= MAPSIZE Or p.y < 0 Or p.y >= MAPSIZE Or map[p.x,p.y]=255) Then

			Return 0
		Else
			Return 1
		End If	
	End Method	
	
	
	Function create1:TAStar(_start:TPosition,_goal:TPosition)
		Local star:TAStar = New TAStar
		star.start = _start
		star.goal = _goal
		star.nodesexpanded = 0
		star.masterNodeList = TMasterNodeList.create()
		star.pqueue = TPriorityQueue.create()
		Return star
	End Function
		
	
	Function create2:TAStar()
		Local star:TAStar = New TAStar
		star.start = New TPosition
		star.start.x = 0
		star.start.y = 0
		star.goal = New TPosition
		star.goal .x = 0
		star.goal .y = 0
		star.nodesexpanded = 0
		star.masterNodeList = TMasterNodeList.create()
		star.pqueue = TPriorityQueue.create()
		Return star
	End Function
	
	
	Method init(s:TPosition Var , g:TPosition Var)
		'masterNodeList = TMasterNodeList.create()
		'pqueue = TPriorityQueue.create()		
		
		openNodes = 0
		closedNodes = 0

		masternodelist.reset()
		pqueue.clearit()

		Local startNode:TNode = masterNodeList.getNode(s)
		startNode.inOpen = 1
		startNode.inClosed = 0
		startNode.pred = Null
		startNode.nPred = 0
		startNode.g = 0
		startNode.f = pathCostEstimate(s,g)
		startNode.h = startNode.f
		pqueue.push(startNode)
		goal=g
	End Method

	
	Method expandNode(node:TNode)
		Local d:Int
		For	d = 0 To 7 ' -> 0 bis 7 = 8 Nachbarknoten
			Local p:TPosition = node.p.neighbour(d)

			If (isValid(p) = 1) Then
				Local travCostModify:Int = 0
				
				'-> wenn prefer_straight dann dieser codeblock der auskommentiert ist
				
				'If node.pred Then
				'	Local dirx = p.x - node.p.x
				'	Local diry = p.y - node.p.y
				'	Local lastDirX = node.p.x - node.pred.p.x
				'	Local lastDirY = node.p.y - node.pred.p.y 'original: -node.pred.p.x <- x nicht y
				'	Local dir = getDirIndex(dirX,dirY)
				'	Local lastDir = getDirIndex(lastDirX,lastDirY)				
				'	Local rot = lastDir - dir
				'	If rot > 4 Then rot = 8 - rot End If
				'	If rot < -4 Then rot = 8 + rot End If
				'	rot = Abs(rot)
				'	travCostModify = costModify[rot]
				'End If
				
				'<- end wenn prefer straight
				
				
				'nicht die node durchsuchen, von der wir kommen
				If (node.pred = Null) Or (node.pred.p.x <> p.x Or node.pred.p.y <> p.y) Then
								'					_g,_h, _pred:TNode,_nPred,_p:TPosition
										
															
					Local newNode:TNode = TNode.create(node.g+traversalCost(node.p,p,d)+travCostModify,0,node,node.nPred+1,p)
					newNode.f = newnode.g + pathcostestimate(p,goal)
					
										
					'eine preallokierte Node für die MasterNodeList holen
					Local pNode:TNode = masterNodeList.getNode(newNode.p)
													
														
					'prüfen, ob sich die neue Node lohnt
					If ((Not (pNode.inOpen=1 And newNode.f > pNode.f)) And (Not(pNode.inClosed=1 And newNode.f > pNode.f))) Then
							
						'ja, ab in die Open Liste oder zumindest updaten !
						'(theoretisch aus der Open und Close Liste nehmen und neu in die
						'OpenList einfügen !)
						
						pNode.inClosed = 0
						pNode.pred = newNode.pred
						pNode.nPred = newNode.nPred
						pNode.g = newNode.g
						pNode.f = newNode.f
						
						If pNode.inOpen=1 Then
							' Update Fall => nur Position in der PriorityQueue updaten !
							pqueue.updatenode(pnode)													
						Else
							' Neue Node => ab in die OpenList
							pqueue.push(pNode)
							pNode.inOpen = 1
							openNodes:+1
						End If
						'marked[pNode.p.x][pNode.p.y] = MARKED_OPEN	
						marked[pNode.p.x,pNode.p.y] = MARKED_OPEN	

					End If
				End If	
			End If
		Next
	End Method

	
	Method searchPath:Int()
		Local back:Int=-1
	
	
		While pqueue.isEmpty() = 0 'solange was in der queue ist


			'beste node holen
			Local node:TNode = pqueue.pop()

			'vor Rucklern im Spiel bewahren
			'If closedNodes > 10 Then 
			'	goalnode = node
			'	back = node.nPred+1
			'	Return back
			'End If
			'If closedNodes > 50 Then Return back
		
						
			If (node.p.x = goal.x) And (node.p.y = goal.y) Then
				'Ziel gefunden?
				goalNode = node
				back = node.nPred+1
				'DebugStop
				Return back
				'Exit
			End If
			expandNode(node)
			
			'Feld für Visualisierung markieren
			'marked[node.p.x][node.p.y] = MARKED_CLOSE
			marked[node.p.x,node.p.y] = MARKED_CLOSE

			nodesExpanded:+1
			
			'node in close-liste
			node.inClosed=1
			closedNodes:+1
		Wend
		
		Return back
	End Method

	
	Method GetPath(p:TPosition Ptr)
		Local length:Int = 0
		Local node:TNode = goalNode
		While(node.pred <> Null)
			node = node.pred
			length:+1
		Wend
		
		Local dst:TPosition Ptr = Varptr p[length-1+1]
		
		node = goalNode
		
		
		While(True)
			dst[0] = node.p '(TPosition Ptr)(Varptr node.p)
			dst:-1
			If node.pred <> Null Then
				node = node.pred
			Else
				Exit
			End If		
		Wend
		
		Return length
	End Method

	
'	Method reducePath(p:TPosition, o:TPosition, size:Int)
'		Local newSize:Int = 2
'		Local i:Int
'		Local dst:TPosition Ptr = Varptr p
'		Local src:TPosition Ptr = Varptr o
'		Local last:TPosition = src
		
'		(dst:+1)[0] = (src:+1)[0] '*(dst++) = *(src++);  ' HIER ÄNDERN Adresse eins hochzählen
'		
'		Local lastDir = getDirIndex(src.x - last.x, src.y - last.y)
'		
'		For i = 1 To size-1
'			Local dir = getDirIndex(src.x - last.x, src.y - last.y)
'			
'			If lastdir <> dir Then
'				dst:+1 = last
'				lastDir = dir
'				newSize:+1
'			End If		
'			last = src
'			src:+1	
'		Next

		 
'		dst:+1 = src:+1    '*(dst++) = *(src++);   ' HIER AUCH

'
'		Return newsize		
'	End Method
End Type
















'Freie Funktionen zum malen
'------------------------------------------------------------------------------
'------------------------------------------------------------------------------




Rem



'Karte malen

Function drawmap()
    Local i:Int
	Local j:Int
	glLineWidth(1.0)
	For j = 0 To MAPSIZE - 1
		For i = 0 To MAPSIZE - 1
			'Local c = 255 - map[i][j]
			Local c = 255 - map[i,j]

			If map[i,j] = 255 Then
	            SetColor 0,0,0
				'glColor3ub( 255, 0, 0 )
			Else
				SetColor 255,255,255
	            'glColor3ub( 0, 0, 255 )
			End If
			
			DrawRect(i*feldsize,j*feldsize,feldsize,feldsize)
 
		Next
	Next
End Function





Function drawpath(path:TPosition[],length:Int)
	Local i:Int
	If path <> Null Then
		For i = 1 To length - 1
			Local last:TPosition = path[i-1]
			Local curr:TPosition = path[i]
			
			SetColor 255,0,0
			DrawOval(curr.x*feldsize,curr.y*feldsize,10,10)
			If i = 1 Then
				'SetColor 255,0,0
				DrawOval(curr.x*feldsize,curr.y*feldsize,20,20)
			End If
			If i = length-1 Then
				DrawOval(curr.x*feldsize,curr.y*feldsize,20,20)
			End If
		Next
	End If
	
	
	For j = 0 To MAPSIZE - 1
		For i = 0 To MAPSIZE - 1
			If marked[i,j] <> MARKED_NONE Then
				If marked[i,j] = MARKED_OPEN Then
					SetColor(0,255,0)
				End If
				If marked[i,j] = MARKED_CLOSE Then
					SetColor(0,0,255)
				End If
	        
				DrawOval(i*feldsize,j*feldsize,5,5)
	
			End If
		Next
	Next
	
End Function


Function interpolatedPosition()


'DAS ORIGINAL NOCH MAL REINZIEHEN -> WEGEN POINTERN...


'void interpolatedPosition( Float *x, Float *y, Position *a, Position *b, Position *c, Position *d, Float u )
'{
'	u = 0.66666666f;
'	Float u3 = u * u * u;
'	Float u2 = u * u;
'	Float f1 = -0.5f * u3 +        u2 - 0.5f * u;
'	Float f2 =  1.5f * u3 - 2.5f * u2 + 1.0f;
'	Float f3 = -1.5f * u3 + 2.0f * u2 + 0.5f * u;
'	Float f4 =  0.5f * u3 - 0.5f * u2;

'	*x = (Float)a->x() * f1 + (Float)b->x() * f2 + (Float)c->x() * f3 + (Float)d->x() * f4;
'	*y = (Float)a->y() * f1 + (Float)b->y() * f2 + (Float)c->y() * f3 + (Float)d->y() * f4;
'}
End Function


Function drawPathCatmullRom(path:TPosition, length:Int)
	If path <> Null Then
	    glColor3ub( 255, 0, 0 )
    	glLineWidth( 2.0 )
		
	    glBegin( GL_LINE_STRIP )
		Local i:Int
		Local u:Float
    	For i = 0 To length - 1
	    	For u = 0.0 To 1.0 - 0.01 Step 0.01 
				Local x:Float
				Local y:Float
				'interpolatedPosition( Varptr x, Varptr y, Varptr path[ Max( 0, i-1 ) ], Varptr path[ i ], Varptr path[ Min( i+1, length-1 ) ],Varptr path[ Min( i+2, length-1 ) ], u )
				glVertex2f( x + 0.5, y + 0.5 )
			Next
		Next
    	glEnd()
	End If
End Function










	Global pathFinder:TAStar
	Global path:TPosition[]
	Global length:Int
	Global length2:Int
	Global showPath:Int=0
	Global feldsize:Int=20
	
	Global start1:TPosition
	Global ende1:TPosition

	Local i:Int
	Local j:Int
	Local k:Int
	


		

		If pathfinder <> Null Then
			pathfinder.pqueue = Null
			pathfinder.masternodelist = Null
		End If
		pathFinder=Null
		path=Null
		length=0
		length2=0
		showPath=0
			
		mapsize = 40
		map = New Byte[mapsize,mapsize]
		marked = New Byte[mapsize,mapsize]
	
	For j = 0 To MAPSIZE - 1
		For i = 0 To MAPSIZE - 1
			marked[i,j] = 0
		Next
	Next	
	
	
	'  - rotation miteinrechnen
	'  - 255 und 0 werden in AStern umgekehrt? stimmt das so?
	
		pathfinder = TAStar.create2()
		'mapsize = Int(arena.lwidth/Feldsize)
		


		'Frei machen -> auf 23 setzen
		For i = 0 To MAPSIZE-1
			For j = 0 To MAPSIZE-1
				map[i,j] = 23
				'map[i,j] = 255
			Next
		Next

'		map[20,20] = 255



'		For i = 0 To MAPSIZE-8
'			map[5,i] = 255
'			map[20,i] = 255
'		Next

		For i = MAPSIZE-1 To 4 Step -1
			map[i,10] = 255
'			map[i,30] = 255
		Next




		'map[,] = 255

		start1 = TPosition.create(mapsize-1,1)
		ende1 = TPosition.create(mapsize-1,mapsize-12)
		pathFinder.init(start1,ende1)
		length = pathfinder.searchpath()
			
		If length <> -1 Then
			'pfad gefunden
			path = New TPosition[length+2]      'path = New Position[ length + 2 ];
			length = pathfinder.getpath(path)

			'path2 = 
			'length = pathfinder.reducepath(path2,path,length)
		End If


Graphics 800,600
SetViewport 0,0,800,600
'SetClsColor(255,255,255)

While Not KeyHit(KEY_ESCAPE)
	Cls
	DrawMap()
	DrawPath(path,length)
	Flip
Wend

End Rem

