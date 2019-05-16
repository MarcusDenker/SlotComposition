"
A slot wrapper is used for wrapping slots in objects. Examples are WeakSlot, HistorySlot...
"
Class {
	#name : #SlotWrapper,
	#superclass : #ComposableSlot,
	#instVars : [
		'implementor'
	],
	#category : #'Slot-Composition'
}

{ #category : #accessing }
SlotWrapper >> composition: aComposedSlot [
	super composition: aComposedSlot.
	aComposedSlot addWrapper: self.
]

{ #category : #accessing }
SlotWrapper >> implementor: aSlot [
	implementor := aSlot
]

{ #category : #'meta-object-protocol' }
SlotWrapper >> initialize: anObject [
	"do nothing by default"
]

{ #category : #printing }
SlotWrapper >> printOn: aStream [
	aStream nextPutAll: self class name
]

{ #category : #'meta-object-protocol' }
SlotWrapper >> read: anObject [
	^implementor read: anObject
]

{ #category : #'meta-object-protocol' }
SlotWrapper >> wantsInitalization [
	^ false
]

{ #category : #'meta-object-protocol' }
SlotWrapper >> write: aValue to: anObject [
	^implementor write: aValue to: anObject
]
