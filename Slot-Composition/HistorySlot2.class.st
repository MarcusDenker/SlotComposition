"
This is the History slot. It saves (by default 5) older values. 
The complete history can be read with #readHistory:
"
Class {
	#name : #HistorySlot2,
	#superclass : #SlotDecorator,
	#instVars : [
		'baseSlot',
		'size'
	],
	#category : #'Slot-Composition'
}

{ #category : #accessing }
HistorySlot2 class >> size: anInteger [
	^self new size: anInteger
]

{ #category : #'meta-object-protocol' }
HistorySlot2 >> afterWrite: aValue to: anObject [
	(self readHistory: anObject) addLast: aValue
]

{ #category : #initialization }
HistorySlot2 >> initialize [
	size := 5
]

{ #category : #'meta-object-protocol' }
HistorySlot2 >> installingIn: aClass [
	| historySlots myNumber |
	
	historySlots := aClass allSlots select: [ :each | each isKindOf: self class ].	
	myNumber := historySlots size + 1.
	
	"we add a new base slot for each history slot"
	baseSlot := ('_booleanBaseSlot', myNumber asString) asSymbol => 
		BaseSlot default: (OrderedCollection new).
	
	aClass classLayout 
		resolveSlot: baseSlot name  
		ifFound:  [:slot | baseSlot := slot ]
		ifNone: [aClass addSlot: baseSlot].
]

{ #category : #'meta-object-protocol' }
HistorySlot2 >> readHistory: anObject [
	^baseSlot read: anObject
]

{ #category : #accessing }
HistorySlot2 >> size: anObject [
	size := anObject
]
