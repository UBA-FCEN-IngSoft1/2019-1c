!classDefinition: #TextFieldTest category: #'IS1-Showable'!
TestCase subclass: #TextFieldTest
	instanceVariableNames: 'drawn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 18:49:11'!
test01

	| juanPerez textField |
	
	juanPerez := Customer named: 'Juan' surnamed: 'Perez'.
	textField := TextField showing: juanPerez.
	
	textField showUsing: self.
	
	self assert: 'Perez, Juan' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 18:54:32'!
test02

	| paenza textField |
	
	paenza := Professor named: 'Paenza' teaches: 'Analisis I'.
	textField := TextField showing: paenza.
	
	textField showUsing: self.
	
	self assert: 'Paenza -> Analisis I' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 18:58:36'!
test03

	| roque textField |
	
	roque := Student named: 'Roque Sanchez' identifiedAs: '233/19'.
	textField := TextField showing: roque.
	
	textField showUsing: self.
	
	self assert: '233/19: Roque Sanchez' equals: drawn! !


!TextFieldTest methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:48:56'!
show: aShowable

	drawn := aShowable ! !


!classDefinition: #Customer category: #'IS1-Showable'!
Object subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!Customer methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:47:08'!
initializeNamed: aFirstName surnamed: aLastName 

	firstName := aFirstName.
	lastName := aLastName ! !


!Customer methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:10'!
firstName

	^firstName ! !

!Customer methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:15'!
lastName

	^lastName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #'IS1-Showable'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:45:58'!
named: aFirstName surnamed: aLastName

	^self new initializeNamed: aFirstName surnamed: aLastName ! !


!classDefinition: #Professor category: #'IS1-Showable'!
Object subclass: #Professor
	instanceVariableNames: 'name subject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!Professor methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:24'!
name

	^name! !

!Professor methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:31'!
subject

	^subject ! !


!Professor methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:55:22'!
initializeNamed: aName teaches: aSubject

	name := aName.
	subject := aSubject ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Professor class' category: #'IS1-Showable'!
Professor class
	instanceVariableNames: ''!

!Professor class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:55:01'!
named: aName teaches: aSubject

	^self new initializeNamed: aName teaches: aSubject

	! !


!classDefinition: #Student category: #'IS1-Showable'!
Object subclass: #Student
	instanceVariableNames: 'name lu'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!Student methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:59:31'!
initializeNamed: aName identifiedAs: aLU

	name := aName.
	lu := aLU ! !


!Student methodsFor: 'accessing' stamp: 'HAW 5/8/2019 19:02:21'!
lu

	^lu ! !

!Student methodsFor: 'accessing' stamp: 'HAW 5/8/2019 19:02:15'!
name

	^name ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Student class' category: #'IS1-Showable'!
Student class
	instanceVariableNames: ''!

!Student class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:59:07'!
named: aName identifiedAs: aLU

	^self new initializeNamed: aName identifiedAs: aLU! !


!classDefinition: #TextField category: #'IS1-Showable'!
Object subclass: #TextField
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!TextField methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:37:32'!
showUsing: aCanvas

	aCanvas show: model asShowable! !


!TextField methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:48:04'!
initializeShowing: aModel

	model := aModel ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TextField class' category: #'IS1-Showable'!
TextField class
	instanceVariableNames: ''!

!TextField class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:47:46'!
showing: aModel

	^self new initializeShowing: aModel! !
