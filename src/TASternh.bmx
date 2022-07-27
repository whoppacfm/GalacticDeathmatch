Global xofs[] = [ 0,  1,  1,  1,  0, -1, -1, -1]
Global yofs[] = [ -1, -1,  0,  1,  1,  1,  0, -1]

Global COSTDIAGONAL = 1'554 'sqrt(2)*100000/255
Global COSTSTRAIGHT = 1'392 '100000/255



'0x7fffff = 8388607
Global costModify[] = [0, COSTSTRAIGHT * 128, COSTSTRAIGHT * 256, 8388607, 8388607, 8388607, 8388607, 8388607]

Global travCost[] = [COSTSTRAIGHT, COSTDIAGONAL, COSTSTRAIGHT, COSTDIAGONAL, COSTSTRAIGHT, COSTDIAGONAL, COSTSTRAIGHT, COSTDIAGONAL]


Type TPosition
	Field x,y

'       Position( Int x, Int y ) : _x( x ), _y( y ) {};
'		Position() : _x( 0 ), _y( 0 ) {};

	Method checkGleich(p:TPosition)
		If p.x = x And p.y = y Then
			Return 1
		Else
			Return 0
		End If
	End Method

	Method Neighbour:TPosition(d:Int)
		Local pos:TPosition = New TPosition
		pos.x = x+xofs[d]
		pos.y = y+yofs[d]
		Return pos
		'Return TPosition(x+xofs[d], y+yofs[d])
	End Method


	Function create:TPosition(sx,sy)
		Local pos:TPosition = New TPosition
		pos.x = sx
		pos.y = sy
		Return pos
	End Function


'        Const bool operator == ( Const Position &p ) Const 
'		{ 
'			Return ( p._x == _x && p._y == _y ); 
'		}
        

'		Const bool operator != ( Const Position &p ) Const 
'		{ 
'		
'			Return !( p._x == _x && p._y == _y ); 
'		}

        
'		Position & operator = ( Const Position &p ) 
'		{ 
'			_x = p._x; _y = p._y; 
'			Return *this; 
'		}

        
'		Const Position neighbour( Const Int d ) Const 
'		{ 
'			Return Position( _x + xofs[ d ], _y + yofs[ d ] ); 
'		}

End Type



Type TNode
'    friend class AStar;
'	friend class NodeCompare;
'	friend class MasterNodeList;

	Field g 'kosten vom start bis zu dieser node
    Field h 'geschätzte restkosten
    Field f 'f = g + h

	Field Pred:TNode 'zeiger auf vorgängerknoten
    Field nPred
    Field p:TPosition 'eigene position
	Field inOpen:Int 'boolean 0=false, 1=true
	Field inClosed:Int 'boolean 
	
'        Node() : pred( Null ), g( 0 ), h( 0 ), f( 0 ), nPred( 0 ) 
'		{ p.x(0); p.y(0); };

	Function createN:TNode()
		Local nod:TNode = New TNode	
		nod.g = 0
		nod.h = 0
		nod.Pred = Null
		nod.nPred = 0
		nod.p = Null
		nod.inopen = 0
		nod.inclosed = 0
		Return nod
	End Function
	

	Function create:TNode(_g,_h, _pred:TNode,_nPred,_p:TPosition)
		Local nod:TNode = New TNode	
		nod.g = _g
		nod.h = _h
		nod.Pred = _pred
		nod.nPred = _nPred
		nod.p = _p
		nod.inopen = 0
		nod.inclosed = 0
		Return nod
	End Function
		
	Method set(_g,_h,_Pred:TNode,_nPred,_p:TPosition)
		g = _g
		h = _h
		Pred = _Pred
		nPred = _nPred
		p = _p	
	End Method
		

	Method compare (other:Object)
		'	   bool operator()( Node *a, Node *b ) Const 
		'	   {
		'		  Return( a->f > b->f );
		'	   }

		If Not TNode(other) Then
	        Return 0
		Else
			Local o:TNode = TNode (other)
		    If o.f > self.f Then
        		Return -1
	  		ElseIf o.f < self.f Then
		        Return 1
			Else
				Return 0
		    EndIf
		End If
	End Method
	
End Type





'Die NodeBank allokiert einfach im Vorraus Speicher für Nodes. 
'Speicherallokieren ist sonst zu zeitaufwendig

Type TNodeBank
	Field MAXBANKSIZE = 256*256 'define
	
	
	Field n:Int
	Field nodeBank:TNode[]


	Method initme()
		Local i:Int
		
		'For i = 0 To MAXBANKSIZE-1
		'	nodebank[i] = TNode.createn() 
		'Next
		
		n = 0
	End Method


	Function create:TNodebank()
		Local MB:TNodebank = New TNodebank
		Local i:Int
		
		MB.nodebank = New TNode[MB.MAXBANKSIZE]
		
		For i = 0 To MB.MAXBANKSIZE-1
			mb.nodebank[i] = TNode.createn() 
		Next
		
		MB.n = 0
		Return MB
	End Function

'		NodeBank(): n(0)
'		{
'			nodebank = New Node[ MAXBANKSIZE ];
'		}
		
'		~NodeBank()
'		{
'			Delete nodebank;
'		}

	Method GetNewNode:TNode()
		If n < maxbanksize Then
			n:+1
			Return nodebank[n]
		Else
			Return Null
			'Exit'zuwenig speicher
		End If
	End Method

		
'		Node *getNewNode()
'		{
'			If ( n < MAXBANKSIZE )
'			{
'				Return &nodebank[ n++ ];
'			} Else
'			{
'				MessageBox( Null, "Zuwenig Speicher im NodeBank Pool !", "Memory low !", MB_OK );
'				Exit( 1 );
'			}
'		}
End Type



' Die MasterNodeList speichert alle Nodes und sucht sie mittels Hashing
Type THASHNODE
	Field node:TNode
	Field NextN:THASHNODE

'	Function create
End Type



Type TMasterNodeList
	Field MAXHASHSIZE:Int = 65536
	
	Field pool:THASHNODE[]
	Field poolCount:Int
	Field hash:THASHNODE[]
	Field nodebank:TNodebank

	Method hashfunc(p:TPosition)
		Return ((p.x & 255) Shl 8) | (p.y & 255) 	'oder shr ?  <<
	End Method

	Method reset()
		Local i:Int
					
		poolcount = 0
		For i = 0 To MAXHASHSIZE -1
			'hash[i] = New THASHNODE
			hash[i].node = Null	
			hash[i].NextN = Null
		Next 

		'nodeBank = TNodeBank.create()
		nodebank.initme()
	End Method


	Function create:TMasterNodeList()
		Local i:Int
		Local mnl:TMasterNodeList = New TMasterNodeList 
		mnl.hash = New THASHNODE[mnl.MAXHASHSIZE]
		mnl.pool = New THASHNODE[mnl.MAXHASHSIZE]
				
		mnl.poolcount = 0

		For i = 0 To mnl.MAXHASHSIZE -1
			mnl.hash[i] = New THASHNODE
			mnl.hash[i].node = Null
			mnl.hash[i].NextN = Null
		Next 

		mnl.nodeBank = TNodeBank.create()
	
		Return mnl
	End Function


	Method GetNodeStored:TNode(p:TPosition)
		Local hashcode = hashfunc(p)
		Local node:THashnode = hash[hashcode] 'HASHNODE *node = &hash[ hashcode ];
		
		While (node <> Null) And (node.node <> Null) And ((node.node.p.x <> p.x) Or (node.node.p.y <> p.y))
			node = node.nextN		
		Wend
			
		If (node <> Null)
			Return node.node		
		Else
			Return Null
		End If
	End Method


	Method GetNode:TNode(p:TPosition)
		'mal schauen, ob die Node schon in der Liste ist
		Local node:TNode = self.getNodeStored(p)

		If node Then
			Return node
		Else
			'noch nicht drin => neue Node erzeugen			
			Local newNode:TNode = nodeBank.getNewNode()
			newNode.p = p
			newNode.inOpen = 0 'false
			newNode.inClosed = 0 'false
			self.storeNode(newNode)
			Return newNode
		End If
	End Method
	
	
	Method StoreNode(node:TNode)
 		Local hashcode:Int = hashfunc(node.p)	
		Local hashnode:THASHNODE = hash[hashcode] 'HASHNODE *hashnode = &hash[ hashcode ];

		If hash[hashcode].node = Null Then
		'If Not hash[hashcode].node Then
			hash[hashcode].node = node
			hash[hashcode].NextN = Null
		Else
			While((hashnode <> Null) And (hashnode.nextN <> Null))
				hashnode = hashnode.nextN			
			Wend
			
			If poolCount < MAXHASHSIZE Then
				hashnode.nextN = pool[poolCount = poolCount + 1] 'hashnode->Next = &pool[ poolCount ++ ]; 			
				hashnode.nextN.nextN = Null
				hashnode.nextN.node = node
			Else
				'zuwenig Speicher
				'Exit			
			End If
		End If			
	End Method
End Type



'Type NodeCompare
	
		
	
'	   bool operator()( Node *a, Node *b ) Const 
'	   {
'		  Return( a->f > b->f );
'	   }

'End Type



'Eine PriorityQueue in einem Heap
Type TPriorityQueue
	
	Field heapList:TList	
	Function create:TPriorityQueue()
		Local PQ:TPriorityQueue = New TPriorityQueue
		PQ.heapList = CreateList()
		Return PQ
	End Function
		
		
	Method clearit()
		heaplist.clear()
	End Method
		
		
	Method push(node:TNode)
		' O(Log n)
		
		' Node am Ende speichern => Heap ist unsortiert !
		'this->heap.push_back( node );
		
		ListAddLast heapList,node
									
		' Element einsortieren !
		'std::push_heap( this->heap.begin(), this->heap.end(), NodeCompare() );
		'heaplist.sort()
	End Method
					
				
	Method pop:TNode()

			Local i
			Local af=-1
			Local index=0
			
			For i = 0 To heaplist.count()-1
				If af = -1 Then
					af = TNode(heaplist.valueatindex(i)).f
					index = i
				Else
					If TNode(heaplist.valueatindex(i)).f < af Then
						af = TNode(heaplist.valueatindex(i)).f
						index = i
					End If
				End If
			Next

			Local no:TNode = TNode(heaplist.valueatindex(index))
			ListRemove(heaplist,no)
			Return no
								
																																													
'			Local node:TNode = TNode(self.heaplist.first())
'			self.heaplist.removefirst()
'			Return node 	
	End Method


	Method updateNode(node:TNode)
			' O(n+Log n)
			
			'heaplist.sort()
			
'			Local no:TNode

'			For no:TNode = EachIn heapList
'				If (no.p.x = node.p.x) And (no.p.y = node.p.y) Then
					'Node gefunden, von dieser Position aus neu sortieren !
					'std::push_heap( this->heap.begin(), i+1, NodeCompare() );
					
'					heaplist.sort() 'so nicht !!!
					'-> TEMP-LISTE MIT NODES AB DIESER POSITION ?
'					
'				End If			
'			Next
	End Method


	Method isEmpty()
		If self.heaplist.count() < 1 Then
			Return 1
		Else
			Return 0
		End If
	End Method

End Type









