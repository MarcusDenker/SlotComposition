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

{ #category : #initialization }
HistorySlot2 >> initialize [
	size := 5
]

{ #category : #'meta-object-protocol' }
HistorySlot2 >> readHistory: anObject [
	^baseSlot read: anObject
]

{ #category : #accessing }
HistorySlot2 >> size: anObject [
	size := anObject
]
