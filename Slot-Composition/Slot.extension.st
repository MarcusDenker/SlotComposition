Extension { #name : #Slot }

{ #category : #'*Slot-Composition' }
Slot >> + anotherSlot [
	| composableSlot |
	"not correct, needs to be set where we do the auto-composition"
	composableSlot := anotherSlot new
		implementor: self.
		
	^ComposedSlot new 
		base: self;
		addComposableSlot: composableSlot;
		name: name.
]
