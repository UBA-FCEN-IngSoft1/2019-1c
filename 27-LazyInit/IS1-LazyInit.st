!classDefinition: #ProviderTest category: #'IS1-LazyInit'!
TestCase subclass: #ProviderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit'!

!ProviderTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 20:03:39'!
test01

	| juanPerez |
	
	juanPerez := Provider named: 'Juan' surnamed: 'Perez'.
	
	self assert: (PhoneBook phonesFor: juanPerez) equals: juanPerez phones.
	self assert: juanPerez phones == juanPerez phones! !

!ProviderTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 20:03:24'!
test02

	| juanPerez |
	
	juanPerez := Provider named: 'Juan' surnamed: 'Perez'.
	
	self assert: (AddressBook addressesFor: juanPerez) equals: juanPerez addresses.
	self assert: juanPerez addresses == juanPerez addresses ! !


!classDefinition: #AddressBook category: #'IS1-LazyInit'!
Object subclass: #AddressBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddressBook class' category: #'IS1-LazyInit'!
AddressBook class
	instanceVariableNames: ''!

!AddressBook class methodsFor: 'querying' stamp: 'HAW 5/8/2019 20:00:45'!
addressesFor: aProvider

	^aProvider name = 'Juan' 
		ifTrue: [ Array with: 'Alem 888' with: 'Maipu 333' ]
		ifFalse: [ #() ]! !


!classDefinition: #PhoneBook category: #'IS1-LazyInit'!
Object subclass: #PhoneBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PhoneBook class' category: #'IS1-LazyInit'!
PhoneBook class
	instanceVariableNames: ''!

!PhoneBook class methodsFor: 'quering' stamp: 'HAW 5/8/2019 20:01:06'!
phonesFor: aProvider 

	^aProvider name = 'Juan' 
		ifTrue: [Array with: '3434-1111' with: '5555-6666' ]
		ifFalse: [ #() ]! !


!classDefinition: #Provider category: #'IS1-LazyInit'!
Object subclass: #Provider
	instanceVariableNames: 'firstName lastName phones addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit'!

!Provider methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:47:08'!
initializeNamed: aFirstName surnamed: aLastName 

	firstName := aFirstName.
	lastName := aLastName ! !


!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 19:57:02'!
addresses

	addresses isNil ifTrue: [ addresses := AddressBook addressesFor: self ].
	^addresses! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:10'!
firstName

	^firstName ! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:15'!
lastName

	^lastName! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 19:56:32'!
phones

	phones isNil ifTrue: [ phones := PhoneBook phonesFor: self ].
	^phones! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Provider class' category: #'IS1-LazyInit'!
Provider class
	instanceVariableNames: ''!

!Provider class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:45:58'!
named: aFirstName surnamed: aLastName

	^self new initializeNamed: aFirstName surnamed: aLastName ! !
