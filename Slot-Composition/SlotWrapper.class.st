"
A slot wrapper is used for wrapping slots in objects. Examples are WeakSlot and ProcessLocalSlot.

Wrappers are hard to compose, therefore:
	- if possible, use another strategy!
	- by default we allow one wrapper per composition
"
Class {
	#name : #SlotWrapper,
	#superclass : #ComposableSlot,
	#category : #'Slot-Composition'
}

{ #category : #composition }
SlotWrapper >> checkComposition [
	"By default we allow just one Wrapper"
	(composition wrappers size > 2) ifTrue: [self error: 'just one Wrapper allowed']
]

{ #category : #accessing }
SlotWrapper >> implementor [
	^composition wrappers before: self
]

{ #category : #testing }
SlotWrapper >> isWrapper [
	^true
]

{ #category : #'meta-object-protocol' }
SlotWrapper >> read: anObject [
	^self implementor read: anObject
]

{ #category : #'meta-object-protocol' }
SlotWrapper >> write: aValue to: anObject [
	^self implementor write: aValue to: anObject
]
