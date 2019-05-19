Extension { #name : #Slot }

{ #category : #'*Slot-Composition' }
Slot >> + anotherSlot [
		
	^ComposedSlot new 
		addDecorator: self; "base slot is the first in the composition"
		addComposableSlot: anotherSlot new;
		name: name.
]

{ #category : #'*Slot-Composition' }
Slot >> isWrapper [
	^true
]
