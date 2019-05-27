Class {
	#name : #HistorySlotTest2,
	#superclass : #SlotSilentTest,
	#category : #'Slot-Composition'
}

{ #category : #tests }
HistorySlotTest2 >> testAddOneElement [
	| slot instance |
	slot := #slot1 => HistorySlot2.
	aClass := self make: [ :builder | builder slots: {slot} ].

	self compileAccessorsFor: slot.

	instance := aClass new.
	instance slot1: 25.
	self assert: instance slot1 equals: 25
]

{ #category : #tests }
HistorySlotTest2 >> testAddOneElementAndModifyClass [
	| slot instance |
	slot := #slot1 => HistorySlot2.
	aClass := self make: [ :builder | builder slots: {slot} ].

	self compileAccessorsFor: slot.

	instance := aClass new.
	instance slot1: 25.
	
	aClass addInstVarNamed: 'x'.
	self assert: instance slot1 equals: 25
]

{ #category : #tests }
HistorySlotTest2 >> testAddTwoElements [
	| slot instance |
	slot := #slot1 => HistorySlot2.
	aClass := self make: [ :builder | builder slots: {slot} ].

	self compileAccessorsFor: slot.

	instance := aClass new.
	instance slot1: 25.
	instance slot1: 35.
	self assert: instance slot1 equals: 35
]

{ #category : #tests }
HistorySlotTest2 >> testAddTwoElementsHistoryRead [
	
	| slot instance |
	self flag: #TODO.
	slot := #slot1 => HistorySlot.
	aClass := self make: [ :builder | builder slots: {slot} ].

	self compileAccessorsFor: slot.

	instance := aClass new.
	instance slot1: 25.
	instance slot1: 35.
	self assert: instance slot1 equals: 35.
	self assert: (slot readHistory: instance) asArray equals: #(nil 25 35)
]

{ #category : #tests }
HistorySlotTest2 >> testHistoryGreaterThanThree [
	| slot instance |
	self flag: #TODO.
	slot := #slot1 => HistorySlot size: 3.
	aClass := self make: [ :builder | builder slots: {slot} ].

	self compileAccessorsFor: slot.

	instance := aClass new.
	instance slot1: 25.
	instance slot1: 35.
	instance slot1: 35.
	instance slot1: 35.
	instance slot1: 35.
	instance slot1: 35.
	self assert: (slot readHistory: instance) size equals: 3
]

{ #category : #tests }
HistorySlotTest2 >> testModifyIvarToHistory [
	"test if we can transform a standard ivar to a history slot when instances are present"

	| slot instance |
	self flag: #TODO.
	slot := #slot1 =>InstanceVariableSlot .
	aClass := self make: [ :builder | builder slots: {slot} ].

	self compileAccessorsFor: slot.

	instance := aClass new.
	instance slot1: 25.
	slot := #slot1 =>HistorySlot.
	aClass := self make: [ :builder | builder slots: {slot} ].
	
	self assert: instance slot1 equals: 25.
	self assert: (slot readHistory: instance) asArray equals: #(nil 25)
]
