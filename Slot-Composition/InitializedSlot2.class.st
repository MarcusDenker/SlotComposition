"
I am showing how a slot can initialize itself on object creation.

#name => InitializedSlot default: 5.

#name => InitializedSlot defaultBlock: [ 'a bloc' ].

#name => InitializedSlot defaultBlock: [ :object | 'a bloc, parameter is the instance' ].
"
Class {
	#name : #InitializedSlot2,
	#superclass : #SlotDecorator,
	#instVars : [
		'default'
	],
	#category : #'Slot-Composition'
}

{ #category : #accessing }
InitializedSlot2 class >> default: anInteger [
	| instance |
	instance := self new.
	"size: return the compisition, this this method is a bit odd"
	instance default: anInteger.
	^instance
]

{ #category : #accessing }
InitializedSlot2 >> default: anObject [
	"we wrap the default in a block, this way we can support calculated default values"
	<exposeToComposition>
	default := [anObject].
	^composition
]

{ #category : #accessing }
InitializedSlot2 >> defaultBlock: aBlock [
	default := aBlock
]

{ #category : #'meta-object-protocol' }
InitializedSlot2 >> initialize: anObject [
	self implementor write: (default copy cull: anObject) to: anObject
]

{ #category : #accessing }
InitializedSlot2 >> printOn: aStream [
	aStream 
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name;
		nextPutAll: ' default: ';
		store: default
]

{ #category : #'meta-object-protocol' }
InitializedSlot2 >> wantsInitalization [
	^ true
]
