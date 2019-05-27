"
Two sublasses: Wrapping and Decorating.
"
Class {
	#name : #ComposableSlot,
	#superclass : #Object,
	#instVars : [
		'composition'
	],
	#category : #'Slot-Composition'
}

{ #category : #'instance creation' }
ComposableSlot class >> named: aName [
	^(InstanceVariableSlot named: aName) + self
]

{ #category : #'as yet unclassified' }
ComposableSlot >> checkComposition [
	"everythung goes"
]

{ #category : #accessing }
ComposableSlot >> composition: aComposedSlot [
	aComposedSlot addDecorator: self.
	composition := aComposedSlot
]

{ #category : #'meta-object-protocol' }
ComposableSlot >> initialize: anObject [
	"do nothing by default"
]

{ #category : #'meta-object-protocol' }
ComposableSlot >> installingIn: aClass [
	"do Nothing by default"
]

{ #category : #testing }
ComposableSlot >> isDecorator [
	^false
]

{ #category : #testing }
ComposableSlot >> isWrapper [
	^false
]

{ #category : #accessing }
ComposableSlot >> name [
	^composition name
]

{ #category : #printing }
ComposableSlot >> printOn: aStream [
	aStream nextPutAll: self class name
]

{ #category : #'meta-object-protocol' }
ComposableSlot >> wantsInitalization [
	^ false
]
