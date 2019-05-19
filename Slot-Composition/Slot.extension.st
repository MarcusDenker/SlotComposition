Extension { #name : #Slot }

{ #category : #'*Slot-Composition' }
Slot >> + anotherSlot [
		
	^ComposedSlot new 
		addWrapper: self; "base slot is the first wrapper, too"
		addComposableSlot: anotherSlot new;
		name: name.
]
