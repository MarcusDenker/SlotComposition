# SlotComposition
Experiments for Composing Slots

In Pharo, instance variables are described not by simple Strings (like in ST80),  but instead by objects.

First class variables are described by classes, these define read and write, and privide hooks called on class creation 
and instantiation.

Typical examples are e.g. 
- PropertySlot: stores instance state in one (hidden) dictionary. 
- WeakSlot: wrap the variable in a WeakArray to create real "weak instance variables". 
- AccessorInstanceVariableSlot: shows how a slot can react to class creation by creating accessors.

But what if one wants to have a slot that does all of this together? The current model forces the developer to implement a 
WeakPropertyAccessorSlot class, duplicating all code. The resulting combinatory explosion makes this not practical

The code you find here is an (ongoing) experiment to allow some form of Slot Composition. The model that is explores for now 
take the idea that most kinds of user defines slots are in some form not realluy Slots but instead Decorators for existing Slots.

This means we allow one real Slot to be combined with multiple decorators / wrappers. For example:

#slot1 => PropertySlot + WeakSlot2 + AccessorInstanceVariableSlot2

NOT: this is ongoing exploratory work to find a model that is simple and yet can model all the current examples. It will change a lot.
