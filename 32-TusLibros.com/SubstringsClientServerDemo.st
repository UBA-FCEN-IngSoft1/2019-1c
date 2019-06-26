!classDefinition: #SubstringsClientWindow category: #SubstringsClientServerDemo!
Panel subclass: #SubstringsClientWindow
	instanceVariableNames: 'sentenceTextBox substringsList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SubstringsClientServerDemo'!

!SubstringsClientWindow methodsFor: 'initialization' stamp: 'NR 6/24/2019 03:31:46'!
defaultExtent

	^ 630@435
	! !

!SubstringsClientWindow methodsFor: 'initialization' stamp: 'NR 6/25/2019 19:07:41'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (SubstringsClientWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	self model when: #newSubstringsArrived send: #refreshSubstringList to: self.! !


!SubstringsClientWindow methodsFor: 'access' stamp: 'NR 6/25/2019 23:27:24'!
refreshSubstringList
	
	substringsList updateList.
	substringsList setSelectionIndex: 0.
	! !


!SubstringsClientWindow methodsFor: 'GUI building' stamp: 'NR 6/25/2019 22:12:15'!
build1stColumn2ndRow
	| firstColumnLayoutOfSecondRow |
	
	substringsList := PluggableListMorph model: self model listGetter: #substringList indexGetter: #substringsListIndex indexSetter: #substringsListIndex:.
	substringsList  borderColor: Color skyBlue.
	substringsList  borderWidth: 1.
		
	firstColumnLayoutOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Results');
	addMorph: substringsList.
		
	^firstColumnLayoutOfSecondRow.
	! !

!SubstringsClientWindow methodsFor: 'GUI building' stamp: 'NR 6/25/2019 22:12:35'!
build1stRow
	| sendRequestButton firstRowLayout |
	
	sendRequestButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendSubtringsRequest  label: 'Send Request To Server'.
	
	sentenceTextBox := TextModelMorph textProvider: self model textGetter: #sentenceText textSetter: #sentenceText:. 
	sentenceTextBox textMorph setProperty: #keyStroke: toValue: [ :key | sentenceTextBox textMorph acceptContents ] .
	sentenceTextBox  borderWidth: 1; borderColor: Color skyBlue.
		
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 25;
	padding: #left;
	addMorph: (StringMorph contents:'Enter sentence:');
	addMorph: sentenceTextBox;
 	addMorph: sendRequestButton.
	
	^firstRowLayout.! !

!SubstringsClientWindow methodsFor: 'GUI building' stamp: 'NR 6/25/2019 22:13:02'!
build2ndRow
	| showInTranscriptButton secondRowLayout |
	
	showInTranscriptButton := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: 'Show Selected Word In Transcript'.	
	
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 25;
	padding: #left;
	addMorph: self build1stColumn2ndRow;
	addMorph: showInTranscriptButton.
	
	^secondRowLayout.
	! !

!SubstringsClientWindow methodsFor: 'GUI building' stamp: 'NR 6/24/2019 06:59:15'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build2ndRow.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SubstringsClientWindow class' category: #SubstringsClientServerDemo!
SubstringsClientWindow class
	instanceVariableNames: ''!

!SubstringsClientWindow class methodsFor: 'instance creation' stamp: 'NR 6/24/2019 02:25:18'!
open
	
	^self new initializeWith: 'Substrings-Service Client Window'.! !


!classDefinition: #SubstringsClientWindowModel category: #SubstringsClientServerDemo!
Object subclass: #SubstringsClientWindowModel
	instanceVariableNames: 'sentence listOfWords selectedIndex webClient'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SubstringsClientServerDemo'!

!SubstringsClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'NR 6/24/2019 06:26:32'!
substringList
	
	^listOfWords.
! !

!SubstringsClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'NR 6/25/2019 21:44:28'!
substringsListIndex
	
	^selectedIndex.! !

!SubstringsClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'NR 6/25/2019 21:45:21'!
substringsListIndex: anIndex
	
	selectedIndex := anIndex.! !


!SubstringsClientWindowModel methodsFor: 'initialization' stamp: 'NR 6/25/2019 21:47:58'!
initialize

	listOfWords := OrderedCollection new.
	sentence:=''.
	selectedIndex:=0.
	webClient := SubstringsWebClient new.! !


!SubstringsClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'NR 6/25/2019 21:43:32'!
sentenceText
	
	^sentence.! !

!SubstringsClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'NR 6/25/2019 21:43:51'!
sentenceText: aSentence

	sentence:=aSentence.
	^true.! !


!SubstringsClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'NR 6/25/2019 21:45:45'!
sendSubtringsRequest
		
	listOfWords := webClient sendRequest: sentence.
	
	self triggerEvent: #newSubstringsArrived with: self.
	! !

!SubstringsClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'NR 6/25/2019 22:13:32'!
showWordInTranscript
	
	(selectedIndex = 0) ifFalse: 
		[TranscriptWindow openTranscript.
		Transcript clear.
		Transcript show: 'The word selected is: '.
		Transcript show: (listOfWords at: selectedIndex).
		Transcript show: ' '.].
! !


!classDefinition: #SubstringsServerController category: #SubstringsClientServerDemo!
Object subclass: #SubstringsServerController
	instanceVariableNames: 'webServer port hiList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SubstringsClientServerDemo'!

!SubstringsServerController methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:51:52'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!SubstringsServerController methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:52:06'!
startListening
	
	webServer startListener ! !

!SubstringsServerController methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:52:12'!
stopListening
	
	webServer stopListener! !


!SubstringsServerController methodsFor: 'initialization' stamp: 'NR 6/25/2019 19:15:47'!
initialize

	hiList := self hiList.
	
	webServer := WebServer new listenOn: self port.
	
	webServer addService: '/sayHi' action:[:request |	
		
		request send200Response: (self sayRandomHi)].
	
	webServer addService: '/substrings' action:[:request | |substringsAsJson sentence substrings |
		
		[sentence := (request fields at:'sentence').
		substrings := sentence substrings.
		substringsAsJson:= WebUtils jsonEncode: (substrings).
		request send200Response: (substringsAsJson)
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
! !

!SubstringsServerController methodsFor: 'initialization' stamp: 'NR 6/25/2019 22:14:59'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	
	! !


!SubstringsServerController methodsFor: 'private' stamp: 'NR 6/24/2019 07:16:54'!
hiList
	
	^OrderedCollection with: 'Hi!!' with: 'Hodor!!' with: 'I am Groot!!' with: 'My name is Homer Simp... Doh!!' with: 'I am inevitable...' with: 'Because Im Baaaatman!!'.
	
	! !

!SubstringsServerController methodsFor: 'private' stamp: 'NR 6/24/2019 07:15:43'!
sayRandomHi
	
	^hiList at: (hiList size atRandom).
	! !


!classDefinition: #SubstringsWebClient category: #SubstringsClientServerDemo!
Object subclass: #SubstringsWebClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SubstringsClientServerDemo'!

!SubstringsWebClient methodsFor: 'sending requests' stamp: 'NR 6/25/2019 22:25:36'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!SubstringsWebClient methodsFor: 'sending requests' stamp: 'NR 6/25/2019 22:25:21'!
sendRequest: sentence

	| fieldDict resp urlEncodedSentence |
	
	urlEncodedSentence := self correctlyEncodeSpacesForUrlRequestParameter: sentence.	
	fieldDict := Dictionary newFromPairs: {'sentence'. urlEncodedSentence.}.		
	
	resp:= WebClient htmlSubmit: (self url,'/substrings') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content].! !


!SubstringsWebClient methodsFor: 'initialization' stamp: 'NR 6/25/2019 22:15:16'!
port
	
	^port ifNil: [port:=8080].! !

!SubstringsWebClient methodsFor: 'initialization' stamp: 'NR 6/24/2019 06:52:37'!
url
	
	^'http://localhost:', self port asString! !
