"
I can create shapes in order that the client can modify it
"
Class {
	#name : #RSShapeFactory,
	#superclass : #RSObject,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #shapes }
RSShapeFactory class >> arc [
	^ RSPieSlice new
]

{ #category : #shapes }
RSShapeFactory class >> arrow [
	"inverted vee"
	^ self polygonWithPoints: (Array
		with: 1 @ 1
		with: 0 @ 0.333
		with: -1 @ 1
		with: 0 @ -1)
]

{ #category : #lines }
RSShapeFactory class >> arrowedLine [
	| marker shape |
	marker := RSPolygon new
		privatePoints: { -5@5. 0@0. 5@5. 0@0 };
		paint: nil;
		withBorder.
	shape := RSLine new.
	shape markerEnd: marker.
	^ shape
]

{ #category : #shapes }
RSShapeFactory class >> bitmap [
	^ RSBitmap new
]

{ #category : #shapes }
RSShapeFactory class >> box [
	^ self rectangle
]

{ #category : #shapes }
RSShapeFactory class >> circle [
	^ self ellipse
]

{ #category : #shapes }
RSShapeFactory class >> composite [ 
	^ RSComposite new
]

{ #category : #shapes }
RSShapeFactory class >> cross [
	| t t1 |
	t := 2 / 6 asFloat.
	t1 := t negated.
	^ self polygonWithPoints:
		{(-1 @ t1).
		(t1 @ t1).
		(t1 @ -1).
		(t @ -1).
		(t @ t1).
		(1 @ t1).
		(1 @ t).
		(t @ t).
		(t @ 1).
		(t1@ 1).
		(t1@ t).
		(-1@ t)}
]

{ #category : #shapes }
RSShapeFactory class >> diamond [
	^ self polygonWithPoints: (Array
		with: 0 @ 1
		with: 1 @ 0
		with: 0 @ -1
		with: -1 @ 0)
]

{ #category : #shapes }
RSShapeFactory class >> ellipse [
	^ RSEllipse new
]

{ #category : #shapes }
RSShapeFactory class >> heptagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 7)
]

{ #category : #shapes }
RSShapeFactory class >> hexagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 6)
]

{ #category : #shapes }
RSShapeFactory class >> label [
	^ RSLabel new
]

{ #category : #shapes }
RSShapeFactory class >> octagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 8)
]

{ #category : #shapes }
RSShapeFactory class >> pentagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 5)
]

{ #category : #shapes }
RSShapeFactory class >> polygon [
	^ RSPolygon new
]

{ #category : #utils }
RSShapeFactory class >> polygonWithPoints: points [
	^ self polygon
		privatePoints: points;
		yourself
]

{ #category : #shapes }
RSShapeFactory class >> rectangle [
	^ RSBox new
]

{ #category : #shapes }
RSShapeFactory class >> rhomboid [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0.333 @ -1
		with: 1 @ 1
		with: -0.333 @ 1)
]

{ #category : #shapes }
RSShapeFactory class >> square [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 4)
]

{ #category : #shapes }
RSShapeFactory class >> star [
	| star5Points outerPoints innerPoints innerRadius ar |
	star5Points := Array new: 10.
	outerPoints := RSPolygon generateUnitNgonPoints: 5 rotation: 0.
	innerPoints := RSPolygon generateUnitNgonPoints: 5 rotation: Float pi / -5.
	"Outer radius is 1; inner radius of star is smaller"
	innerRadius := 0.5.
	innerPoints
		doWithIndex: [ :p :i | innerPoints at: i put: (p x * innerRadius) @ (p y * innerRadius) ].
	star5Points
		doWithIndex: [ :p :i | 
			ar := i even
				ifTrue: [ outerPoints ]
				ifFalse: [ innerPoints ].
			star5Points at: i put: (ar at: i // 2 + (i % 2)) ].
	star5Points := RSPolygon fitPolygonToSquare: star5Points.
	^ self polygonWithPoints: star5Points
]

{ #category : #shapes }
RSShapeFactory class >> triangle [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 3)
]

{ #category : #shapes }
RSShapeFactory class >> vee [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0 @ -0.333
		with: 1 @ -1
		with: 0 @ 1)
]
