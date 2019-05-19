"
A slot decorator can decorate a slot with three things:
	1) meta data by storint it as its state
	2) it can act on #installingIn:
	3) it can provice before and after code for read and write
"
Class {
	#name : #SlotDecorator,
	#superclass : #ComposableSlot,
	#category : #'Slot-Composition'
}

{ #category : #'meta-object-protocol' }
SlotDecorator >> afterRead: anObject [
]

{ #category : #'meta-object-protocol' }
SlotDecorator >> afterWrite: aValue to: anObject [
	
]

{ #category : #'meta-object-protocol' }
SlotDecorator >> beforeRead: anObject [
]

{ #category : #'meta-object-protocol' }
SlotDecorator >> beforeWrite: aValue to: anObject [
	
]

{ #category : #testing }
SlotDecorator >> isDecorator [
	^true
]
