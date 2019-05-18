Extension { #name : #Slot }

{ #category : #'*Slot-Composition' }
Slot >> + anotherSlot [
	| composableSlot |
	"not correct, needs to be set where we do the auto-composition"
	composableSlot := anotherSlot new
		implementor: self.  "will go away, we can get the firt wrapper"
		
		
	^ComposedSlot new 
		addWrapper: self; "base slot is the first wrapper, too"
		addComposableSlot: composableSlot;
		name: name.
]
