"
NOTE: this is an example of what can be done with Slots. It is *not* an example of what *should* be done with Slots.

I am a slot decorator that compiles accessor methods in the Class that it is installes in.

This example shows how Slots can change the class that they are part of.
"
Class {
	#name : #AccessorInstanceVariableSlot2,
	#superclass : #SlotDecorator,
	#category : #'Slot-Composition'
}

{ #category : #'class building' }
AccessorInstanceVariableSlot2 >> installingIn: aClass [
	| reader writer | 
	
	reader := String streamContents: [ :str |
		str 
			nextPutAll: self name;
			cr;tab;
			nextPutAll: ' ^';
			nextPutAll: self name].

	writer := String streamContents: [ :str |
		str 
			nextPutAll: self name;
			nextPutAll: ': anObject';
			cr;tab;
			nextPutAll: self name;
			nextPutAll: ':= anObject.'].

	aClass compile: reader classified: 'accessing'.
	aClass compile: writer classified: 'accessing'.
]
