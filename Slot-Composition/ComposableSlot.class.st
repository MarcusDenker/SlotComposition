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

{ #category : #accessing }
ComposableSlot >> composition: aComposedSlot [
	composition := aComposedSlot
]
