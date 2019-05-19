Class {
	#name : #ComposedSlotTest,
	#superclass : #SlotSilentTest,
	#category : #'Slot-Composition'
}

{ #category : #tests }
ComposedSlotTest >> testComposedSlotAutoCompose [
	| slot |
	"if we use a decorator only, it auto-composes with an InstanceVariableSlot"
	
	slot := #slot1 => WeakSlot2.
	
	self assert: slot class equals: ComposedSlot. 
	"we share the name with the storage slot"
	self assert: slot name equals: #slot1.
	"as our storage slot is a normal ivar, we are not virtual"
	self deny: slot isVirtual.
	
	self assert: slot base class == InstanceVariableSlot.
]

{ #category : #tests }
ComposedSlotTest >> testComposedSlotPrint [
	| slot |
	slot := #slot1 => WeakSlot2.
	self assert: slot printString equals: '#slot1 => WeakSlot2'.
	
	slot := #slot1 => PropertySlot + WeakSlot2.
	self assert: slot printString equals: '#slot1 => PropertySlot + WeakSlot2'.
	
	slot := #slot1 => AccessorInstanceVariableSlot2.
	self assert: slot printString equals: '#slot1 => AccessorInstanceVariableSlot2'.
	
	slot := #slot1 => PropertySlot + AccessorInstanceVariableSlot2.
	self assert: slot printString equals: '#slot1 => PropertySlot + AccessorInstanceVariableSlot2'.
	
	slot := #slot1 => PropertySlot + WeakSlot2 + AccessorInstanceVariableSlot2.
	self assert: slot printString equals: '#slot1 => PropertySlot + WeakSlot2 + AccessorInstanceVariableSlot2'.
	
]

{ #category : #tests }
ComposedSlotTest >> testComposedSlotSimpleCompose [
	| slot |
	slot := #slot1 => InstanceVariableSlot + WeakSlot2.
	
	self assert: slot class equals: ComposedSlot. 
	"we share the name with the storage slot"
	self assert: slot name equals: #slot1.
	"as our storage slot is a normal ivar, we are not virtual"
	self deny: slot isVirtual.
	
	slot := #slot1 => PropertySlot + WeakSlot2.
	
	self assert: slot class equals: ComposedSlot. 
	"we share the name with the storage slot"
	self assert: slot name equals: #slot1.
	"as our storage slot is a Property, we are virtual"
	self assert: slot isVirtual.
	self assert: slot base class equals: PropertySlot.

]
