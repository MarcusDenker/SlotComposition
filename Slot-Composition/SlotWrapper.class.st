"
A slot wrapper is used for wrapping slots in objects. Examples are WeakSlot, HistorySlot...
"
Class {
	#name : #SlotWrapper,
	#superclass : #ComposableSlot,
	#category : #'Slot-Composition'
}

{ #category : #accessing }
SlotWrapper >> composition: aComposedSlot [
	super composition: aComposedSlot.
	aComposedSlot addDecorator: self
]

{ #category : #accessing }
SlotWrapper >> implementor [
	^composition wrappers before: self
]

{ #category : #'meta-object-protocol' }
SlotWrapper >> initialize: anObject [
	"do nothing by default"
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
