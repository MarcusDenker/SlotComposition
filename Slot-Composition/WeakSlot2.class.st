"
Composable version of WeakSlot. When the implementation is complete enough, we will replace WeakSlot with this implementation
"
Class {
	#name : #WeakSlot2,
	#superclass : #SlotWrapper,
	#category : #'Slot-Composition'
}

{ #category : #'meta-object-protocol' }
WeakSlot2 >> initialize: anObject [

	self implementor write: (WeakArray new: 1) to: anObject
]

{ #category : #'meta-object-protocol' }
WeakSlot2 >> read: anObject [

	^ (self implementor read: anObject) at: 1
]

{ #category : #'meta-object-protocol' }
WeakSlot2 >> wantsInitalization [

	^ true
]

{ #category : #'meta-object-protocol' }
WeakSlot2 >> write: aValue to: anObject [

	^(self implementor read: anObject) at: 1 put: aValue
]
