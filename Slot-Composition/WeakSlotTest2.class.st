Class {
	#name : #WeakSlotTest2,
	#superclass : #SlotSilentTest,
	#category : #'Slot-Composition'
}

{ #category : #tests }
WeakSlotTest2 >> testReadWeakSlotCompiled [
	| object slot |
	slot := #slot1 => WeakSlot2.
	aClass := self make: [ :builder | builder slots: {slot} ].
	self assert: (aClass hasSlotNamed: #slot1).
	
	object := aClass new.
	
	"now compile an accessor and read"
	self compileAccessorsFor: slot.
	self assert: object slot1 equals: nil.
]

{ #category : #tests }
WeakSlotTest2 >> testReadWriteWeakSlotReflective [
	| slot object |
	slot := #slot1 => WeakSlot2.
	aClass := self make: [ :builder | builder slots: {slot} ].
	self assert: (aClass hasSlotNamed: #slot1).
	object := aClass new.
	
	slot write: 5 to: object.
	self assert: (slot read: object) equals: 5.
]

{ #category : #tests }
WeakSlotTest2 >> testWeakSlotIsWeak [
	| slot object |
	slot := #slot1 => WeakSlot2.
	aClass := self make: [ :builder | builder slots: {slot} ].
	self assert: (aClass hasSlotNamed: #slot1).
	object := aClass new.
	
	slot write: Object new to: object.
	Smalltalk garbageCollect.
	"the value is GCed and we get nil"
	self assert: (slot read: object) equals: nil.
]

{ #category : #tests }
WeakSlotTest2 >> testWriteWeakSlotCompiled [
	| slot object |
	slot := #slot1 => WeakSlot2.
	aClass := self make: [ :builder | builder slots: {slot} ].
	self assert: (aClass hasSlotNamed: #slot1).
	
	object := aClass new.
	
	"now compile an accessor and write"
	self compileAccessorsFor: slot.
	object slot1: 10.
	self assert: object slot1 equals: 10.
]
