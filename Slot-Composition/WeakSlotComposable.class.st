"
Composable version of WeakSlot. When the implementation is complete enough, we will replace WeakSlot with this implementation
"
Class {
	#name : #WeakSlotComposable,
	#superclass : #SlotWrapper,
	#category : #'Slot-Composition'
}

{ #category : #'meta-object-protocol' }
WeakSlotComposable >> initialize: anObject [

	implementor write: (WeakArray new: 1) to: anObject
]

{ #category : #'meta-object-protocol' }
WeakSlotComposable >> read: anObject [

	^ (implementor read: anObject) at: 1
]

{ #category : #'meta-object-protocol' }
WeakSlotComposable >> wantsInitalization [

	^ true
]

{ #category : #'meta-object-protocol' }
WeakSlotComposable >> write: aValue to: anObject [

	^(implementor read: anObject) at: 1 put: aValue
]
