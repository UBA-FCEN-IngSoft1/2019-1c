'From Cuis 5.0 of 7 November 2016 [latest update: #3805] on 25 June 2019 at 8:59:28 pm'!

!InnerTextMorph methodsFor: 'events-processing' stamp: 'HAW 6/25/2019 20:55:35'!
processKeystroke: aKeyboardEvent localPosition: localEventPosition
	"System level event handling."
		"localEventPosition?????"

	aKeyboardEvent wasHandled ifTrue:[^self].
	self handlesKeyboard ifFalse: [^ self].
	aKeyboardEvent wasHandled: true.
	self keyStroke: aKeyboardEvent.
	
	self 
		valueOfProperty: #'keyStroke:'
		ifPresentDo: [ :handler | handler value: aKeyboardEvent ]! !
