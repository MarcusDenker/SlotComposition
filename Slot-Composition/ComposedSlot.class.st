"
The idea is to keep this at first quite simple:

-> There is an explicit composition Slot
-> it has ivars for the base slot, decorators and wrappers

Later this might be structured more efficiently, e.g. 
	-> have just one list and filter it 
	-> base is head
	-> do not use collection but Wrappers/Decorators could form linked list
	


"
Class {
	#name : #ComposedSlot,
	#superclass : #Slot,
	#instVars : [
		'base',
		'wrappers',
		'decorators'
	],
	#category : #'Slot-Composition'
}

{ #category : #arithmetic }
ComposedSlot >> + aComposableSlot [
	"here we add a slot"

]

{ #category : #adding }
ComposedSlot >> addComposableSlot: aSlot [
	"need to add to wrappers or decorators"
	aSlot composition: self.
]

{ #category : #adding }
ComposedSlot >> addDecorator: aSlot [
	decorators add: aSlot
]

{ #category : #adding }
ComposedSlot >> addWrapper: aSlot [
	wrappers add: aSlot
]

{ #category : #arithmetic }
ComposedSlot >> base: aSlot [
	base := aSlot
]

{ #category : #accessing }
ComposedSlot >> index [
	^base index
]

{ #category : #accessing }
ComposedSlot >> index: anIndex [
	base index: anIndex
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> initialize [
	wrappers := OrderedCollection new.
	decorators := OrderedCollection new.
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> initialize: anObject [
	wrappers do: [ :slotWrapper | slotWrapper initialize: anObject ]
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> installingIn: aClass [
	super installingIn: aClass.
	decorators do: [ :each | each installingIn: aClass ]
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> isVirtual [
	^base isVirtual
]

{ #category : #printing }
ComposedSlot >> printOn: aStream [
	base needsFullDefinition
		ifFalse: [ 
			aStream
				store: self name;
				nextPutAll: ' => ' ]
		ifTrue: [
			base printOn: aStream.
			aStream nextPutAll: ' + ' ].
	wrappers allButFirst 
		do: [ :each | each printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ' + ' ].
		
	decorators 
		do: [ :each | each printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ' + ' ]
		
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> read: anObject [
	| value | 
	decorators do: [ :decorator | decorator beforeRead: anObject ].

	value := wrappers last read: anObject.

	decorators do: [ :decorator  | decorator afterRead: anObject ].
	
	^value.
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> wantsInitalization [

	^wrappers anySatisfy: [ :each | each wantsInitalization ]
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> write: aValue to: anObject [
	| value | 
	decorators do: [ :decorator | decorator beforeWrite: aValue to: anObject ].
	value := wrappers last write: aValue to: anObject.
	decorators do: [ :decorator  | decorator afterWrite: aValue to: anObject ].
	^value.
]
