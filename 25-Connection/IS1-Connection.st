!classDefinition: #ConnectionTest category: #'IS1-Connection'!
TestCase subclass: #ConnectionTest
	instanceVariableNames: 'logStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 10:57:57'!
test01

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	
	self assert: sentString equals: sent nextLine.
	self assert: sent atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 17:46:16'!
test02

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: sentString equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] ',sentString equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 10:58:42'!
test03

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createZippedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 10:59:43'!
test04

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createEncryptedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'encrypted[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 11:00:51'!
test05

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createZippedEncryptedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[encrypted[',sentString,']]' equals: sent nextLine.
	self assert: sent atEnd.
	
	! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 17:46:39'!
test06

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createZippedEncryptedTracedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[encrypted[',sentString,']]' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] ',sentString equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 18:15:26'!
test07

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedZippedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] zipped[',sentString,']' equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 18:15:32'!
test08

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedEncryptedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'encrypted[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] encrypted[',sentString,']' equals: logStream nextLine.
	self assert: logStream atEnd! !


!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 10:58:06'!
createConnection
	
	^Connection new! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 10:59:51'!
createEncryptedConnection
	
	^EncryptedConnection new! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:50:56'!
createLogStream
	
	logStream := ReadWriteStream on: String new.
	^logStream 
	! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 18:05:54'!
createTracedConnection
	
	^TracedConnection loggingInto: self createLogStream clock: self! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 18:14:22'!
createTracedEncryptedConnection
	
	^TracedEncryptedConnection loggingInto: self createLogStream clock: self! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 18:12:52'!
createTracedZippedConnection
	
	^TracedZippedConnection loggingInto: self createLogStream clock: self! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 10:58:52'!
createZippedConnection
	
	^ZippedConnection new.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 11:01:11'!
createZippedEncryptedConnection
	
	^ ZippedEncryptedConnection new.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 18:05:54'!
createZippedEncryptedTracedConnection
	
	^ZippedEncryptedTracedConnection loggingInto: self createLogStream clock: self! !


!ConnectionTest methodsFor: 'clock' stamp: 'HAW 5/8/2019 10:14:32'!
now
	
	^DateAndTime year: 2019 day: 1 hour: 10 minute: 20 second: 30
! !


!classDefinition: #Connection category: #'IS1-Connection'!
Object subclass: #Connection
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!Connection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:06:40'!
send: aPackage

	stream nextPutAll: aPackage! !

!Connection methodsFor: 'sending' stamp: 'HAW 5/8/2019 10:01:21'!
sentContents
	
	^stream contents ! !


!Connection methodsFor: 'initialization' stamp: 'HAW 5/8/2019 09:01:51'!
initialize

	stream := WriteStream on: String new! !


!classDefinition: #EncryptedConnection category: #'IS1-Connection'!
Connection subclass: #EncryptedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!EncryptedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:06:48'!
send: aPackage

	^super send: 'encrypted[', aPackage, ']'! !


!classDefinition: #TracedConnection category: #'IS1-Connection'!
Connection subclass: #TracedConnection
	instanceVariableNames: 'logStream clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!TracedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:07:21'!
send: aPackage

	self logSendOf: aPackage.
		
	^super send: aPackage
! !


!TracedConnection methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:03:22'!
initializeLoggingInto: aLog clock: aClock 
	
	clock := aClock.
	logStream := aLog ! !


!TracedConnection methodsFor: 'logging' stamp: 'HAW 5/8/2019 17:55:27'!
logSendOf: aPackage

	logStream 
		nextPut: $[;
		print: clock now;
		nextPutAll: '] ';
		nextPutAll: aPackage;
		newLine.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TracedConnection class' category: #'IS1-Connection'!
TracedConnection class
	instanceVariableNames: ''!

!TracedConnection class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:05:54'!
loggingInto: aLog clock: aClock

	^self new initializeLoggingInto: aLog clock: aClock ! !


!classDefinition: #TracedEncryptedConnection category: #'IS1-Connection'!
TracedConnection subclass: #TracedEncryptedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!TracedEncryptedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:15:09'!
send: aPackage

	^super send: 'encrypted[', aPackage, ']'! !


!classDefinition: #TracedZippedConnection category: #'IS1-Connection'!
TracedConnection subclass: #TracedZippedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!TracedZippedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:13:44'!
send: aPackage

	^super send: 'zipped[',aPackage, ']'! !


!classDefinition: #ZippedConnection category: #'IS1-Connection'!
Connection subclass: #ZippedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!ZippedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:07:36'!
send: aPackage

	^super send: 'zipped[', aPackage, ']'! !


!classDefinition: #ZippedEncryptedConnection category: #'IS1-Connection'!
ZippedConnection subclass: #ZippedEncryptedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!ZippedEncryptedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:07:43'!
send: aPackage

	^super send: 'encrypted[', aPackage, ']'! !


!classDefinition: #ZippedEncryptedTracedConnection category: #'IS1-Connection'!
ZippedEncryptedConnection subclass: #ZippedEncryptedTracedConnection
	instanceVariableNames: 'logStream clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!ZippedEncryptedTracedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:08:13'!
send: aPackage

	self logSendOf: aPackage.
	
	^super send: aPackage
		! !


!ZippedEncryptedTracedConnection methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:04:35'!
initializeLoggingInto: aLog clock: aClock 
	
	clock := aClock.
	logStream := aLog ! !


!ZippedEncryptedTracedConnection methodsFor: 'logging' stamp: 'HAW 5/8/2019 18:08:20'!
logSendOf: aPackage

	logStream 
		nextPut: $[;
		print: clock now;
		nextPutAll: '] ';
		nextPutAll: aPackage;
		newLine.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ZippedEncryptedTracedConnection class' category: #'IS1-Connection'!
ZippedEncryptedTracedConnection class
	instanceVariableNames: ''!

!ZippedEncryptedTracedConnection class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:05:54'!
loggingInto: aLog clock: aClock

	^self new initializeLoggingInto: aLog clock: aClock ! !
