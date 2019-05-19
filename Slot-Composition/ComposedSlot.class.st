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
		'wrappers',
		'decorators'
	],
	#category : #'Slot-Composition'
}

{ #category : #arithmetic }
ComposedSlot >> + aComposableSlot [
		
	^self
		addComposableSlot: aComposableSlot new;
		name: name.

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

{ #category : #accessing }
ComposedSlot >> base [
	^self wrappers first
]

{ #category : #accessing }
ComposedSlot >> decorators [
	^decorators
]

{ #category : #accessing }
ComposedSlot >> index [
	^self base index
]

{ #category : #accessing }
ComposedSlot >> index: anIndex [
	self base index: anIndex
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> initialize [
	wrappers := OrderedCollection new.
	decorators := OrderedCollection new.
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> initialize: anObject [
	self wrappers do: [ :slotWrapper | slotWrapper initialize: anObject ]
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> installingIn: aClass [
	super installingIn: aClass.
	self decorators do: [ :each | each installingIn: aClass ]
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> isVirtual [
	^self base isVirtual
]

{ #category : #printing }
ComposedSlot >> printOn: aStream [
	self base needsFullDefinition
		ifFalse: [ 
			aStream
				store: self name;
				nextPutAll: ' => ' ]
		ifTrue: [
			self base printOn: aStream.
			aStream nextPutAll: ' + ' ].
	
	self wrappersAndDecorators allButFirst 
		do: [ :each | each printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ' + ' ].
		
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> read: anObject [
	| value | 
	self decorators do: [ :decorator | decorator beforeRead: anObject ].

	value := self wrappers last read: anObject.

	self decorators do: [ :decorator  | decorator afterRead: anObject ].
	
	^value.
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> wantsInitalization [

	^self wrappersAndDecorators anySatisfy: [ :each | each wantsInitalization ]
]

{ #category : #accessing }
ComposedSlot >> wrappers [
	^wrappers
]

{ #category : #accessing }
ComposedSlot >> wrappersAndDecorators [
	^ wrappers, decorators
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> write: aValue to: anObject [
	| value | 
	self decorators do: [ :decorator | decorator beforeWrite: aValue to: anObject ].
	value := self wrappers last write: aValue to: anObject.
	self decorators do: [ :decorator  | decorator afterWrite: aValue to: anObject ].
	^value.
]
