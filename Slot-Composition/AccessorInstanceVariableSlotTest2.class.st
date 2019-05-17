Class {
	#name : #AccessorInstanceVariableSlotTest2,
	#superclass : #SlotSilentTest,
	#category : #'Slot-Composition'
}

{ #category : #tests }
AccessorInstanceVariableSlotTest2 >> testAccessorInstanceVariableSlot [
	| slot object |
	aClass := self
		make:
			[ :builder | builder slots: {(#slot1 => AccessorInstanceVariableSlot2)} ].
	self assert: (aClass hasSlotNamed: #slot1).

	"test reflective write and read"
	slot := aClass slotNamed: #slot1.

	"did we create accessors?"
	self assert: (aClass includesSelector: #slot1).
	self assert: (aClass includesSelector: #slot1:).

	object := aClass new.
	slot write: 5 to: object.
	self assert: (slot read: object) equals: 5.
	object slot1: 10.
	self assert: object slot1 equals: 10.
	
	
]
