"
Basic examples about highlighting
"
Class {
	#name : #RSHighlightableExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #examples }
RSHighlightableExamples >> example01Basic [
	<script: 'self new example01Basic open'>
	| canvas shapes color |
	canvas := RSCanvas new.
	
	color := RSColorPalette sequential bupu3.
	shapes := (1 to: 20) collect: [ :m |
		RSBox new
			size: 10;
			model: m;
			draggable;
			withBorder;
			color: (color scale: m);
			yourself.
		 ].
	RSEdgeBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas edges do: #withBorder.
	canvas addAll: shapes.
	canvas shapes @ RSHighlightable defaultRed.
	RSClusterLayout on: shapes.
	canvas zoomToFit.
	^ canvas
]

{ #category : #examples }
RSHighlightableExamples >> example02ElementEdges [
	<script: 'self new example02ElementEdges open'>
	| canvas shapes interaction color |
	canvas := RSCanvas new.
	interaction := RSHighlightable defaultRed
		withEdges;
		yourself.
	color := RSColorPalette diverging rdylbu3.
	shapes := (1 to: 20) collect: [ :i |
		RSBox new
			size: 10;
			model: i;
			draggable;
			withBorder;
			color: (color scale: i) ;
			yourself ].
	RSEdgeBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas addAll: shapes.
	canvas edges do: #withBorder.
	canvas edges @ RSHighlightable defaultRed.
	canvas nodes @ interaction.
	RSClusterLayout on: shapes.
	canvas zoomToFit.
	^ canvas
]

{ #category : #'examples - animated' }
RSHighlightableExamples >> example03Interactive [
	<script: 'self new example03Interactive open'>
	| canvas shapes interaction update color |
	canvas := RSCanvas new.
	
	color := RSColorPalette diverging rdylbu3.
	shapes := (1 to: 20) collect: [ :i |
		RSBox new
			size: 10;
			model: i;
			draggable;
			withBorder;
			color: (color scale: i) ;
			yourself ].
	RSEdgeBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas edges do: #withBorder.
	canvas addAll: shapes.
	RSClusterLayout on: shapes.
	
	interaction := RSHighlightable defaultRed.
	interaction withEdges.
	update := [ interaction doHighlight: shapes atRandom ].
	update value.
	canvas newAnimation repeat when: RSAnimationLoopEvent do: update.
	
	canvas zoomToFit.
	^ canvas
]

{ #category : #'examples - animated' }
RSHighlightableExamples >> example04Interactive [
	<script: 'self new example04Interactive open'>
	| canvas shapes interaction bool update color |
	canvas := RSCanvas new.
	
	color := RSColorPalette qualitative accent8.
	shapes := (1 to: 20) collect: [ :i |
		RSBox new
			size: 10;
			model: i;
			popup;
			draggable;
			withBorder;
			color: (color scale: i) ;
			yourself ].
	RSEdgeBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas addAll: shapes.
	RSClusterLayout on: shapes.
	
	interaction := RSHighlightable defaultRed.
	bool := true.
	update := [
		interaction doHighlightShapes: (shapes select: [ :e | bool = e model even ]).
		bool := bool not ].
	update value.
	canvas newAnimation repeat when: RSAnimationLoopEvent do: update.
	canvas zoomToFit.
	^ canvas
]

{ #category : #examples }
RSHighlightableExamples >> example05Border [
	<script: 'self new example05Border open'>
	| canvas shapes interaction color |
	canvas := RSCanvas new.
	
	color := RSColorPalette sequential blues9.
	shapes := (1 to: 20) collect: [ :i |
		RSBox new
			size: 10;
			model: i;
			popup;
			draggable;
			withBorder;
			color: (color scale: i) ;
			yourself ].
	RSEdgeBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	interaction := RSHighlightable new.
	interaction highlightBorder: (RSBorder new width: 2).
	canvas addAll: shapes.
	canvas nodes @ interaction.
	RSClusterLayout on: shapes.
	canvas zoomToFit.
	^ canvas
]

{ #category : #examples }
RSHighlightableExamples >> example06IterateNext [
	<script: 'self new example06IterateNext open'>
	| canvas numbers edges layout legendBuilder highlightableForBoxes highlightableForLabels selectedNumber highlightBlock unhighlightAllBlock |
	canvas := RSCanvas new.
	legendBuilder := RSLegend new container: canvas. 

	"Create the view with numbers as elements."
	numbers := (1 to: 10) collect: [ :i |
		RSBox new
			model: i;
			size: 30;
			labeled;
			yourself ] as: RSGroup.
	edges := RSEdgeBuilder line
		shapes: numbers;
		connectFrom: [ :i | i // 2 ].
	canvas
		addAll: edges;
		addAll: numbers.
	layout := RSForceBasedLayout new
		length: 80;
		charge: -300;
		nodes: numbers;
		edges: edges;
		start;
		yourself.
	canvas newAnimation repeat onStepDo: [ :t | layout step ].
	numbers @ (RSDraggableForce new layout: layout).

	"Set up highlighting interactions"
	highlightableForBoxes := RSHighlightable defaultRed.
	highlightableForLabels := RSHighlightable new
		propertyKey: #exampleKey;
		when: RSHighlightEvent do: [ :evt | evt shape bold ];
		when: RSUnHighlightEvent do: [ :evt | evt shape normal ].
	highlightBlock := [ :model |
		highlightableForBoxes doHighlight: (canvas shapeFromModel: model).
		highlightableForLabels doHighlight: (legendBuilder shapes shapeFromModel: model).
		selectedNumber := model ].
	unhighlightAllBlock := [
		highlightableForBoxes unhighlightRecordedShapes: canvas.
		highlightableForLabels unhighlightRecordedShapes: canvas ].

	"Build a legend with all the numbers"
	legendBuilder leyendDo: [ :l |l withBorder; padding: 5 ].
	legendBuilder location 
		outer; right; offset: 70@ -200.
	numbers do: [ :e | 
		(legendBuilder text: e model) model: e model  ].
	numbers, legendBuilder shapes when: RSMouseClick do: [ :evt | highlightBlock value: evt shape model ].
	legendBuilder build.

	"Unhighlight all when clicking on background."
	canvas when: RSMouseClick do: unhighlightAllBlock.

	"Highlight next number when N key is pressed. Initial is nothing"
	selectedNumber := 0.
	canvas when: RSKeyUp do: [ :evt |
		evt keyName = #N ifTrue: [
			selectedNumber := (selectedNumber \\ numbers size) + 1.
			highlightBlock value: selectedNumber ] ].

	^ canvas
]

{ #category : #examples }
RSHighlightableExamples >> example07HighlightButtons [
	<script: 'self new example07HighlightButtons open'>
	| canvas mouseOver selectedButton |
	canvas := RSCanvas new.
	selectedButton := RSHighlightable defaultRed.

	mouseOver:= RSHighlightable new.
	mouseOver highlightColor: [ :shape | 
		shape model > 5
			ifTrue: [ Color purple ]
			ifFalse: [ Color blue ] ].
	"usefull to combine 2 instances of RSHighlightable"
	selectedButton propertyKey: #buttons.
	mouseOver highlightShapesButKeep: selectedButton.
		
	canvas addAll: ((1 to: 10) collect: [ :i |
		RSBox new
			model: i;
			@ mouseOver; 
			extent: 120@30;
			cornerRadius: 3;
			when: RSMouseClick do: [ :evt |
				mouseOver doUnhighlight: evt shape.
				selectedButton doHighlight: evt shape.
				evt signalUpdate ];
			yourself ] ).

	selectedButton doHighlight: canvas nodes first.
	RSVerticalLineLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
	

]

{ #category : #examples }
RSHighlightableExamples >> example08DependendMethods [
	<script: 'self new example08DependendMethods open'>
	| packagesRegExp packages canvas popup label padding high arrow allClasses allMethods |
	packagesRegExp := { 'Roassal3-Shapes'}.
	    
	packages := packagesRegExp flatCollect: [ :regExp | 
		RPackageOrganizer default packages 
			select: [ :p | regExp match: p packageName ] ].

	canvas := RSCanvas new.
	popup := RSPopup new.
	label := RSLabeled new highlightable.
	padding := 10 asMargin.
	high := RSHighlightable new.
	arrow := RSShapeFactory arrowedLine
		color: Color blue.
	packages := packages collect: [ :p | 
		| classes pkg |
		classes := p definedClasses collect: [ :cls | | methods |
			methods := cls methods collect: [ :met |
				RSBox new
					extent: 5 @ met linesOfCode;
					@ popup;
					@ high;
					model: met;
					yourself
					 ].
			RSGridLayout on: methods.
			RSComposite new
				model: cls;
				@ label;
				@ popup;
				paint: Color white;
				children: methods;
				padding: padding;
				yourself ] as: RSGroup.
		pkg := RSComposite new
			children: classes;
			paint: Color blue translucent;
			model: p;
			@ popup;
			draggable;
			yourself.
		RSEdgeBuilder orthoVertical 
			withVerticalAttachPoint;
			canvas: pkg;
			shapes: pkg nodes;
			connectFrom: #superclass.
		RSTreeLayout on: pkg nodes edges: pkg edges.
		pkg adjustToChildren;
			padding: padding.
		pkg ].
	canvas addAll: packages.
	RSGridLayout on: canvas shapes.
	allClasses := canvas shapes flatCollect: #nodes.
	allMethods := allClasses flatCollect: #nodes.

	high 
		when: RSHighlightEvent do: [ :evt | | methods |
			methods := allClasses flatCollect: [ :class | 
				(class model 
					thoroughWhichMethodsReferTo: 
						evt shape model selector) 
							collect: [ :method | method ] ].
			methods := methods collect: [ :met | 
				arrow copy
					from: evt shape;
					to:(allMethods shapeFromModel: met)
					 ].
			canvas addAll: methods.
			canvas propertyAt: #methods put: methods.
			 ];
		when: RSUnHighlightEvent do: [ :evt | 
			(canvas propertyAt: #methods ifAbsent: [ #() ]) do:#remove ].

	canvas @ RSCanvasController.
	^  canvas 
]
