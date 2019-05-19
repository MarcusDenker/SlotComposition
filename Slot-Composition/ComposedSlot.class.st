"
A composed slot composes a base slot with one or multiple Slot Decorators or Slot Wrappers
"
Class {
	#name : #ComposedSlot,
	#superclass : #Slot,
	#instVars : [
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

{ #category : #accessing }
ComposedSlot >> base [
	^decorators first
]

{ #category : #accessing }
ComposedSlot >> decorators [
	"first is the base slot"
	^decorators allButFirst select: #isDecorator
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
	decorators := OrderedCollection new.
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> initialize: anObject [
	decorators do: [ :slotWrapper | slotWrapper initialize: anObject ]
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> installingIn: aClass [
	super installingIn: aClass.
	decorators do: [ :each | each installingIn: aClass ]
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
	
	decorators allButFirst 
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

	^decorators allButFirst anySatisfy: [ :each | each wantsInitalization ]
]

{ #category : #accessing }
ComposedSlot >> wrappers [
	^decorators select: #isWrapper.
	
]

{ #category : #'meta-object-protocol' }
ComposedSlot >> write: aValue to: anObject [
	| value | 
	self decorators do: [ :decorator | decorator beforeWrite: aValue to: anObject ].
	value := self wrappers last write: aValue to: anObject.
	self decorators do: [ :decorator  | decorator afterWrite: aValue to: anObject ].
	^value.
]
