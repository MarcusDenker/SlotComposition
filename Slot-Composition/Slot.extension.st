Extension { #name : #Slot }

{ #category : #'*Slot-Composition' }
Slot >> + anotherSlot [
	| composableSlot |
	 composableSlot :=  anotherSlot isBehavior 
		ifTrue: [ anotherSlot new ]
		ifFalse: [  anotherSlot ].
		
	^ComposedSlot new 
		addDecorator: self; "base slot is the first in the composition"
		addComposableSlot: composableSlot;
		name: name.
]

{ #category : #'*Slot-Composition' }
Slot >> isWrapper [
	^true
]
