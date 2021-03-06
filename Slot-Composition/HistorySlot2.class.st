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
	| instance |
	instance := self new.
	"size: return the compisition, this this method is a bit odd"
	instance size: anInteger.
	^instance
]

{ #category : #'meta-object-protocol' }
HistorySlot2 >> afterWrite: aValue to: anObject [
	| collection |
	collection := self readHistory: anObject.
	collection addLast: aValue.
	(collection size > size) ifTrue: [  
		collection removeFirst]
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
	<exposeToComposition>
	^baseSlot read: anObject
]

{ #category : #accessing }
HistorySlot2 >> size: anObject [
	"initalizers need to retunr the composition"
	<exposeToComposition>
	size := anObject.
	^composition
]
