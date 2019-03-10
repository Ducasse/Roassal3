"
I have the basic examples for shapes
"
Class {
	#name : #TSShapeExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #'box and ellipses' }
TSShapeExamples >> example01Basic [
	<script: 'self new example01Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		extent: 100@100;
		yourself).
	c addShape: (TSBox new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example02Basic [
	<script: 'self new example02Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSEllipse new
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example03Basic [
	<script: 'self new example03Basic'>

	| c g |
	c := TSCanvas new.
	g := TSGroup new.
	g add: (TSBox new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	g add: (TSBox new
		position: 100@100;
		color: (Color red alpha: 0.4);
		extent: 100@100;
		yourself).
		
	c addShape: g.	
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		position: 100@100;
		color: (Color red alpha: 0.4);
		extent: 100@100;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example04Basic [
	<script: 'self new example04Basic'>

	| c g |
	c := TSCanvas new.
	g := TSGroup new.
	g add: (TSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	g add: (TSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
	g position: 100@100.
	
	c addShape: g.	
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example05Basic [
	<script: 'self new example05Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	c addShape: (TSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
		
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]

{ #category : #labels }
TSShapeExamples >> example06Basic [
	<script: 'self new example06Basic'>

	| c label |
	c := TSCanvas new.
	1 to: 12 do: [ :m | 
		| angle theta p|
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		label := TSLabel new
			color: (Color purple alpha: 0.5);
			fontSize: 20;
			text: (Month nameOfMonth: m);
			yourself.
		angle := angle radiansToDegrees.
		angle := angle + ((angle between: 90 and: 270) 
			ifTrue: [ 180 ]
			ifFalse: [ 0 ] ).
		
		label rotateByDegrees: angle..
		label position: p + ((label textWidth/2) * theta).
		m even
			ifTrue: [ label bold ]
			ifFalse: [ label italic ].
		c addShape: label.
		].
	c addShape: (TSEllipse new
		color: nil;
		border: TSBorder new;
		radius: 90).
	c open
	



]

{ #category : #events }
TSShapeExamples >> example07Basic [
	<script: 'self new example07Basic'>

	| c ellipse a b drag update |
	c := TSCanvas new.
	ellipse := TSEllipse new
		radius: 40;
		border: TSBorder new.
	c addShape: ellipse.
	a := Color colorFrom: '12A288'.
	b := Color colorFrom: 'AB2567'.
	drag := false.
	update := [ :evt |
		ellipse 
			color: (drag ifTrue: [ a ] ifFalse: [b ]);
			position: evt position.
		c signalUpdate ].
	c
		when: TSMouseMove do: [ :evt | update value: evt.  ];
		when: TSMouseDragStart do: [ :evt| drag := true. ];
		when: TSMouseDragEnd do: [ :evt | drag := false. ].
	c clearBackground: false.
	
	c open.
	
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example08Basic [
	<script: 'self new example08Basic'>

	| c y r |
	c := TSCanvas new.
	r := SharedRandom globalGenerator.
	c color: (Color colorFrom: '325A64').
	1 to: 500 do: [ :x|
		y := 255 + (x sin * 255).
		c addShape: (TSEllipse new
			color: Color transparent;
			border: (TSBorder new
				width: x/ 50;
				color: (Color 
					r: r next * 255 
					g: r next * 200
					b: 255
					range: y) );
			position: (x*2@y)-250;
			extent: (y/10)@( x * 75/ 499 ) ).
		 ].
	"m := c morph.
	PolymorphSystemSettings setDesktopLogoWith: m.
	m position: 0@World menubar height.
	m extent: World extent- (0@World menubar height)."
	c open
]

{ #category : #events }
TSShapeExamples >> example09Basic [
	<script: 'self new example09Basic'>

	|  c e prev dif |
	c := TSCanvas new.
	c color: Color black.
	e := TSEllipse new
		border: (TSBorder new color: Color white);
		radius: 0.
	c addShape: e.
	prev := 0.
	c when: TSMouseMove do: [ :evt | 
		dif := (evt position x - prev) abs.
		prev := evt position x.
		e 
			color: (Color r: 0 g: dif b: 0 range: 255);
			position: evt position;
			size: dif.
		c signalUpdate.
		 ].
	c clearBackground: false.
	c open.
]

{ #category : #events }
TSShapeExamples >> example10Basic [
	<script: 'self new example10Basic'>

	| c border circleResolution angle a b radius |
	c := TSCanvas new.
	c color: Color white.
	border := TSBorder new color: (Color colorFrom: '002800').
	b := 1.
	radius := 200.
	c when: TSMouseMove do: [ :evt | 
		circleResolution := b.
		circleResolution isZero ifTrue: [ circleResolution := 1 ].
		angle := Float twoPi / circleResolution.
		a := 175 * evt position x / c extent x.
		b := 200 * evt position y / c extent y.
		c shapes copy do: #remove.
		0 to: circleResolution do: [ :i |
			c addShape: (TSEllipse new 
				color: Color transparent;
				rotateByDegrees: 45;
				border: border;
				extent: ((angle * i) cos @ (angle * i) sin) * radius + a
			)].
		
		c signalUpdate.
		 ].
	c open.
]

{ #category : #events }
TSShapeExamples >> example11Basic [
	<script: 'self new example11Basic'>

	| c easing canvasExtent boxSize zindex maxDist scale border |
	c := TSCanvas new.
	c color: Color white.
	easing := 0@0.
	boxSize := 50.
	canvasExtent := 500 asPoint.
	maxDist := 0@0 dist: canvasExtent.
	scale := TSScale linear 
		domain: { 0. maxDist}; 
		rangeRound: #(80 0).
	border := TSBorder new.
	c when: TSResizeCanvasEvent do: [ 
		c shapes copy do: #remove.
		canvasExtent := c extent.
		maxDist := 0@0 dist: canvasExtent.
		scale := TSScale linear 
			domain: { 0. maxDist}; 
			rangeRound: #(80 0).
		0 to: canvasExtent y/boxSize do: [ :y|
			0 to: canvasExtent x/boxSize do: [ :x| 
				c addShape: (TSBox new 
					color: Color white;
					position: ((x@y)*boxSize) - (canvasExtent/2);
					extent: 10@10;
					border: border )
				] ]
		].
	c when: TSMouseMove do: [ :evt | 
		easing := easing + ((evt position - easing)* 0.1).
		c shapes copy do: [ :s |
			zindex := scale scale: (easing dist: s position).
			s extent: boxSize * (zindex /100) asPoint ].
		c signalUpdate.
	].
	c clearBackground: false.
	c open.
]

{ #category : #lines }
TSShapeExamples >> example12Basic [
	<script: 'self new example12Basic'>

	| c |
	c := TSCanvas new.
	c addShape: TSLine new.
	c open.
]

{ #category : #lines }
TSShapeExamples >> example13Basic [
	<script: 'self new example13Basic'>

	| c box paint form border animation |
	c := TSCanvas new.
	form := self iconNamed: #eyedropper.
	paint := (AthensCairoPatternSurfacePaint 
		createForSurface: (AthensCairoSurface 
			fromForm: form)).
	paint origin: (form extent / 2) negated.
	border := TSBorder new
		color: Color purple;
		dashArray: #(4).
	box := TSBox new
		paint: paint;
		extent: form extent;
		border: border;
		scaleBy: 3.
	
	c addShape: box.
	
	animation := c animation
		repeat;
		from: 0;
		to: 8;
		on: border set: #dashOffset:.
	box when: TSMouseClick do: [ :a |
		animation isPaused 
			ifTrue: [ animation continue ]
			ifFalse: [ animation pause ] ].
	c open.
	




]

{ #category : #bitmap }
TSShapeExamples >> example14Basic [
	<script: 'self new example14Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBitmap new
		form: (self iconNamed: #eyedropper);
		extent: 200@350).
		
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example15Basic [
	<script: 'self new example15Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		cornerRadius: 5;
		extent: 100@50).
		
	c addShape: (TSBox new
		cornerRadius: (TSCornerRadius new top: 20);
		position: 100@100;
		extent: 100@50;
		border: TSBorder new).
		
	c open
]

{ #category : #lines }
TSShapeExamples >> example16Basic [
	<script: 'self new example16Basic'>
	| c b1 b2 translate l arrowWidth arrowHeight middle |
	c := TSCanvas new.
	b1 := TSBox new size: 100@100.
	b2 := TSBox new size: 100@100; color: Color blue; position: 100@100.
	c addShape: b1.
	c addShape: b2.
	
	l := TSSVGPathLine new
		svgPath: [ :a :b |
			[ :canvas | | vector u unit left right left1 right1 |
			arrowWidth := 50.
			arrowHeight := 30.
			vector := a-b.
			u := vector normal.
			unit := vector / (vector r max: 1).
			middle := b + (unit* arrowHeight).
			left := middle - (u * arrowWidth / 4).
			right := middle + (u * arrowWidth / 4).
			left1 := middle - (u * arrowWidth / 2).
			right1 := middle + (u * arrowWidth / 2).
			
			canvas
				absolute;
				moveTo: a;
				lineTo: left;
				lineTo: left1;
				lineTo: b;
				lineTo: right1;
				lineTo: right;
				close.
			 ]
			 ];
		width: 5;
		paint: Color yellow;
		dashArray: { 10. 2 };
		joinMiter;
		startPoint: 0@0;
		endPoint: 100@100.
	c addShape: l.
	
	translate := [ :evt |
		l 
			startPoint: b1 position;
			endPoint: b2 position.
		evt shape translateBy: evt step.
		evt signalUpdate ].
	b1 when: TSMouseDragging do: translate.
	b2 when: TSMouseDragging do: translate.
	c open
]

{ #category : #border }
TSShapeExamples >> example17Borders [
	<script: 'self new example17Borders'>
	| c border border2 a b ce d |
	c := TSCanvas new.
	border := [ :position :inner :outer :text |
		c addShape: (TSBox new
			color: Color lightGray;
			position: position;
			border: (TSBorder new
				capSquare;
				joinMiter;
				color: inner);"brighter"
			size: 100).
		c addShape: (TSBox new
			color: nil;
			position: position;
			border: (TSBorder new
				capSquare;
				dashArray: #(98 196);
				color: outer);"darker"
			size: 98).
		c addShape: (TSBox new
			color: nil;
			position: position;
			border: (TSBorder new
				capSquare;
				dashArray: #(0 102 102 0 102 0);
				color: outer);"darker"
			size: 102).
		c addShape: (TSLabel new
			text: text;
			position: position;
			color: Color black).
		 ].
	border2 := [ :position :text |
		
		c addShape: (TSBox new
			color: Color lightGray;
			position: position;
			size: 100).
		c addShape: (TSLine new
			startPoint: position - 50;
			endPoint: position + (50 @ -50);
			color: a).
		c addShape: (TSLine new
			startPoint: position - 50;
			endPoint: position + (-50 @ 50);
			color: a).
		c addShape: (TSLine new
			startPoint: position - 49;
			endPoint: position + (49 @ -49);
			color: b).
		c addShape: (TSLine new
			startPoint: position - 49;
			endPoint: position + (-49 @ 49);
			color: b).
			
		c addShape: (TSLine new
			startPoint: position + (-49@49);
			endPoint: position + 49;
			color: ce ).
		c addShape: (TSLine new
			startPoint: position + (49@ -49) ;
			endPoint: position + (49 @ 49);
			color: ce).
			
		c addShape: (TSLine new
			startPoint: position + (-50@50);
			endPoint: position + 50;
			color: d).
		c addShape: (TSLine new
			startPoint: position + (50@ -50);
			endPoint: position + (50 @ 50);
			color: d).
		c addShape: (TSLabel new
			text: text;
			position: position;
			color: Color black).
		 ].
	
	"line border"
	c addShape: (TSBox new
		color: Color lightGray;
		border: TSBorder new;
		size: 100).
	c addShape: (TSLabel new
		text: 'Line border';
		color: Color black).
	"raised etched"
	border 
		value: 120@0
		value: (Color lightGray adjustBrightness: 0.08)
		value: (Color lightGray adjustBrightness: -0.08)
		value: 'Raised etched'.
	
	"lowered etched"
	border 
		value: -120@0
		value: (Color lightGray adjustBrightness: -0.08)
		value: (Color lightGray adjustBrightness: 0.08)
		value: 'Lowered etch'.
	"Raised bevel"
	b := Color lightGray adjustBrightness: 0.08.
	a := b adjustBrightness: 0.08.
	ce := Color lightGray adjustBrightness: -0.08.
	d := ce adjustBrightness: -0.08.
	border2
		value: 0@ -120
		value: 'Raised bevel'.
	"Lowered bevel"
	b := Color lightGray adjustBrightness: -0.08.
	a := b adjustBrightness: -0.08.
	ce := Color lightGray adjustBrightness: 0.08.
	d := ce adjustBrightness: 0.08.
	border2 
		value: 0@ 120
		value: 'Lowered bevel'.
	RSDraggableView new onElement: c.
	RSZoomableView new onElement: c.
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example18 [
	<script: 'self new example18'>
	| c |
	c := TSCanvas new.
	"empty"
	c addShape: TSPieSlice new.
	"circle"
	c addShape: (TSPieSlice new
		innerRadius: 0;
		externalRadius: 100;
		alphaAngle: 0;
		betaAngle: 360).
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example19 [
	<script: 'self new example19'>
	| c |
	c := TSCanvas new.
	"slice"
	c addShape: (TSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 30;
		betaAngle: 90;
		segmentSpacing: 5).
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example20 [
	<script: 'self new example20'>
	| c |
	c := TSCanvas new.
	"donut"
	c addShape: (TSPieSlice new
		border: TSBorder new;
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 360).
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example21 [
	<script: 'self new example21'>
	| c |
	c := TSCanvas new.
	"corner radii"
	c addShape: (TSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 45;
		cornerRadii: 20).
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example22 [
	<script: 'self new example22'>
	| c |
	c := TSCanvas new.
	"slice"
	c addShape: (TSPieSlice new
		externalRadius: 100;
		alphaAngle: 30;
		betaAngle: 90).
	c open.
]