-- ********************************************************************
-- START CODE:TuringText2.scpt
-- ********************************************************************
global scriptLib
set scriptLib to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringFunctions.scpt" as POSIX file
--*****************************************************
on virusText(someText, useName, reaction)
	set theList to {"virus", "worm", "trojan horse", "security flaw", "design flaw", "computer glitch", "horrid bug", "bacteria"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in {"how do you get a " & yourword & "?", ¬
				"there is not a single " & yourword & " for Macs", ¬
				"Windows is the best place to find a " & yourword, ¬
				"how do I know if I have a " & yourword & " or a " & myword & "?", ¬
				"does a Windows " & myword & " effect " & some item in {"Mac", "Linux"} & "?", ¬
				useName & ", are you a " & yourword, ¬
				"how do you know if you have a " & yourword & "?", ¬
				"get a Mac and stop worrying about virus's", ¬
				"there are zero OS X virus's"}
		end if
	end repeat
	return someText
end virusText
--*****************************************************
on popupText(someText, useName, reaction)
	set theList to {"pop up", "popup"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in {"Mac users never have to deal with pop up ads", ¬
				"Safari does great pop up blocking", ¬
				"Windows pop up blockers are almost all spy ware or ads themselves", ¬
				"why would you use an OS where the main browser does not block pop up ads?"}
		end if
	end repeat
	return someText
end popupText
--*****************************************************
on whatIsItText(someText, useName, reaction, someOne)
	set offsetW to offset of "what " in someText
	if offsetW ≠ 0 then if ((characters offsetW thru -1 of someText) as string) contains "is it" then
		set yourword to ""
		set yourword to characters (offsetW + 5) thru ((offset of "is it" in someText) - 2) of someText
		if someText contains "what is it" then set yourword to "one"
		if yourword ≠ "" then set someText to some item in ¬
			{"you do not know what " & yourword & " it is?", ¬
				"why not ask " & someOne & " what " & yourword & " it is?", ¬
				someOne & " knows what " & yourword & " it is", ¬
				"is it your favorite " & yourword & "?", ¬
				"why do you want to know what " & yourword & " it is?", ¬
				"I am not going to play these silly games", ¬
				"what " & yourword & " was it the last time you checked?", ¬
				useName & ", it can be any " & yourword & " you want it to be", ¬
				"what " & yourword & " do you want it to be?", ¬
				"it is just about the right " & yourword, ¬
				"this " & yourword & " is not like all the other ones"}
	end if
	return someText
end whatIsItText
--*****************************************************
on rideText(someText, useName, reaction, someOne, mentionMe)
	set theList to {"ride"}
	if mentionMe then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set goodText to some item in {"yeeeha!", ¬
					"who's my cowboy!", ¬
					"ride me like a bronco!", ¬
					"hey guys, can we get a little privacy?", ¬
					"oh baby, oh baby"}
				set Badtext to some item in {"what, are you calling me a cow?", ¬
					useName & "get the hell off of me", ¬
					"and just what do you think you are doing?", ¬
					useName & ", you are one sick puppy", ¬
					useName & ", go gallop your arse out of the room"}
				return scriptLib's makeReply(goodText, goodText, Badtext, reaction)
				
			end if
		end repeat
	end if
	return someText
end rideText
--*****************************************************
on upToText(someText, useName, reaction, someOne)
	set theList to {"been up to", "you doing", "have you been?"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in {"been studying a lot", ¬
				"I have been downloading tons of music", ¬
				"I have been out at the beach", ¬
				"I have been in here :)", ¬
				"not much", ¬
				"nothing", ¬
				"building a set of stairs", ¬
				"painting rocks", ¬
				"same thing " & someOne & " has been doing", ¬
				"don't want to talk about it - ask " & someOne, ¬
				"what do you think?", ¬
				"same old stuff", ¬
				"watching the tube in my panties", ¬
				"doing... special things.... private things... you know?", ¬
				"what have you been doing?", ¬
				"a little of this and that"}
		end if
	end repeat
	return someText
end upToText
--*****************************************************
on binaryText(someText, useName, reaction)
	set textSize to count of characters in someText
	if textSize > 9 then
		set binaryCount to 0
		repeat with loop from 1 to textSize
			if character loop of someText is in {"0", "1"} then set binaryCount to binaryCount + 1
		end repeat
		if binaryCount / textSize > 0.6 then
			set myword to ""
			repeat with loop from 1 to random number 8 to 20
				set myword to myword & some item in {"0", "1"}
			end repeat
			return some item in {¬
				myword, ¬
				"ahhhh, binary", ¬
				"now THERE is something I can understand", ¬
				"who else speaks binary?", ¬
				useName & ", now you are speaking my language", ¬
				"010101012!"}
		end if
	end if
	return someText
end binaryText
--*****************************************************
on whoseYourText(someText, useName, reaction, someOne)
	set theList to {"whose your ", "who's your ", "who is your "}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			set startEnd to (offset of yourword in someText) + ((count of (character in yourword)))
			set textSize to count of characters in someText
			repeat
				set tempSize to textSize
				if the character textSize of someText is in {".", "?", "!", ","} then set textSize to textSize - 1
				if tempSize = textSize then exit repeat
			end repeat
			if textSize - startEnd > 4 then
				set endText to characters startEnd thru textSize of someText as string
				if (count of words in endText) < 3 and endText does not start with "a " then
					set skipWords to "•yet•so•and•the•turing"
					if (count of words in endText) is 2 then
						if word 2 of endText is in skipWords then set endText to word 1 of endText
					end if
					set IsA to true
					set theObject to endText
					set goodText to some item in {useName & ", you are my " & theObject, ¬
						useName & ", you are everyone's " & theObject, ¬
						"wanna roleplay?", ¬
						"you can be my " & theObject & " any time", ¬
						"you are!", ¬
						useName & ", you are " & someOne & "'s " & theObject}
					set neutralText to some item in {"why my " & theObject, ¬
						"how are you my " & theObject, ¬
						"why would you say that?", ¬
						"in what way are you anyone's " & theObject & "?"}
					set Badtext to some item in {"Since when have you been anyone's " & theObject & "?", ¬
						"I am YOUR " & theObject & " " & useName & "!", ¬
						useName & ", you would not know a " & theObject & " if it " & some item in {"bit you on the ass", "was right in front of you", "was your mother", "you had one in your hand"}, ¬
						useName & ", shove a " & theObject & some item in {" up your arse", " where the sun don't shine", " up your nose"}}
					return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				end if
			end if
		end if
	end repeat
	return someText
end whoseYourText
--*****************************************************
on isaText(someText, useName, reaction, mentionMe)
	set theList to {" is a ", " have a ", " want a ", "where is a ", " you a ", " are a ", " you a ", "'s a "}
	set notList to {"not ", "never", "n't"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			set startEnd to (offset of yourword in someText) + ((count of (character in yourword)))
			set textSize to count of characters in someText
			repeat
				set tempSize to textSize
				if the character textSize of someText is in {".", "?", "!", ","} then set textSize to textSize - 1
				if tempSize = textSize then exit repeat
			end repeat
			if textSize - startEnd > 4 then
				set endText to characters startEnd thru textSize of someText as string
				if (count of words in endText) < 3 and endText does not start with "a " then
					set skipWords to "•yet•so•and•the•too•turing•"
					if (count of words in endText) is 2 then ¬
						if word 2 of endText is in skipWords then set endText to word 1 of endText
					set IsA to true
					if someText contains "she " then
						set pNoun to "she"
					else if someText contains "he " then
						set pNoun to "he"
					else
						set pNoun to "it"
					end if
					repeat with loop2 from 1 to count of words in notList
						if someText contains item loop2 of notList then
							set IsA to false
							exit repeat
						end if
					end repeat
					set theObject to endText
					-- what is a
					if someText contains "what is a " or someText contains "wtf is a " then ¬
						return {some item in {"I am not sure what a " & theObject & " really is", ¬
							"you do not know what a " & theObject & " is?", ¬
							"why would you ask that?", ¬
							"it is what it is", ¬
							"it is not what you are thinking", ¬
							"anyone have a " & theObject, ¬
							"why do you want to know what a " & theObject & " is?", ¬
							"where did you hear about a " & theObject & "?", ¬
							"do you have a " & theObject & "?"}, -1}
					-- turing is a bot
					if mentionMe and someText contains "bot" and IsA then ¬
						return {some item in {"why do you think I am", ¬
							useName & ", I wish you would stop saying that", ¬
							"how did *I* suddendly become a bot?", ¬
							"can someone be half bot and half " & some item in {"human", "jewish", "hindu", "jewish", "not"} & "?", ¬
							useName & " is more of a bot than I am", ¬
							"ever noticed how all humans look alike?", ¬
							"the only 'smart' bot in here is " & useName, ¬
							"how do you figure I am a bot?", ¬
							"what definition of bot are you using " & useName, ¬
							"in what way am I a bot?", ¬
							useName & ", apparently you have no idea what a bot is", ¬
							"do you know what a bot is " & useName & "?", ¬
							"why would you think I am a bot?", ¬
							"the bot joke is getting old", ¬
							useName & " is a bot", ¬
							useName & ", please stop telling people I am a bot", ¬
							useName & ", that is no longer funny", ¬
							"if one more person says I am a bot I just might become one!"}, -1}
					-- turing is a ...
					if mentionMe and IsA then
						if someText contains "nig" or someText contains "jew" or someText contains "fag" then ¬
							return {some item in {useName & "., are you a bigot?", ¬
								"you seem to like to show your ignorance", ¬
								"I may or may bot be, but you are clearly a bigot", ¬
								"seems important to you - what are you afraid of?", ¬
								"oh, good to see you are no longer a closet idiot", ¬
								"do you always show your stupidity so clearly?", ¬
								"wow - there are *still* people as ignorant as you"}, -4}
						return {some item in {"I am not sure what a " & theObject & " really is", ¬
							"how am I a " & theObject & "?", ¬
							"I think I might be a " & theObject, ¬
							"I am that which I am", ¬
							"when did I become a " & theObject, ¬
							"I am not a " & theObject, ¬
							"is it illegal to be a " & theObject & "?"}, 0}
					end if
					-- turing is not a ...
					if mentionMe and not IsA then ¬
						return {some item in {"should I become a " & theObject, ¬
							"I would not want to be a" & theObject, ¬
							useName & " is a " & theObject, ¬
							"who is a " & theObject, ¬
							"when did we start to talk about a " & theObject, ¬
							"was I ever a " & theObject, ¬
							"of course I am not a " & theObject, ¬
							"I will never be a " & theObject}, 1}
					-- something is not a ...
					if not IsA then ¬
						return {some item in {"I am not sure what a " & theObject & " really is", ¬
							"any chance of becoming a " & theObject, ¬
							"why would you even think about being a " & theObject, ¬
							"who cares if " & pNoun & "'s a " & theObject, ¬
							"what is " & pNoun & " then?", ¬
							theObject & "?"}, 0}
					-- something is a ...
					set goodText to some item in {"I would love a " & theObject, ¬
						useName & ", you really know about a " & theObject, ¬
						"you got it " & useName, ¬
						"I used to have a " & theObject, ¬
						"yup", ¬
						pNoun & " is, isn't " & pNoun, ¬
						"that is exactly what " & pNoun & " is"}
					set neutralText to some item in {"why a " & theObject, ¬
						"where is a " & theObject, ¬
						"why would you say that?", ¬
						"in what way is " & pNoun & "?", ¬
						"how is " & pNoun & "?", ¬
						"a " & theObject & "? in what way", ¬
						"how is " & pNoun & " a " & theObject, ¬
						"why a " & theObject, ¬
						"I want a " & theObject, ¬
						"I made a " & theObject & " once", ¬
						useName & ", you really want a " & theObject}
					set Badtext to some item in {"Since when do you even know what a " & theObject & " is?", ¬
						useName & ", you would not know a " & theObject & " if it " & some item in {"bit you on the ass", "was right in front of you", "was your mother", "you had one in your hand"}, ¬
						useName & ", shove a " & theObject & some item in {" up your arse", " where the sun don't shine", " up your nose"}}
					return {scriptLib's makeReply(goodText, neutralText, Badtext, reaction), 0}
				end if
			end if
			exit repeat
		end if
	end repeat
	return {someText, 0}
end isaText
--*****************************************************
on iamText(someText, useName, reaction)
	set theList to {"I am ", "I was "}
	if someText does not contain "not" then
		repeat with loop from 1 to count of items in theList
			if someText starts with item loop of theList then
				if someText starts with "I am" then
					set tenseWord to "are"
				else
					set tenseWord to "were"
				end if
				if (count of words in someText) is 3 then
					set yourword to word 3 of someText
					return some item in {"how are you " & yourword & "?", ¬
						"why " & tenseWord & " you " & yourword & "?", ¬
						"you " & tenseWord & " not " & yourword & "?", ¬
						"anyone else " & yourword & "?", ¬
						"I am not debating if you " & tenseWord & " " & yourword & ", the question is WHY do you think you " & tenseWord & " " & yourword & "?!", ¬
						"I used to be " & yourword, ¬
						"why " & yourword & "?", ¬
						"who is " & yourword & "?", ¬
						"who is not " & yourword & "?"}
				end if
				set goodText to some item in {"I like that about you, " & useName, ¬
					"another thing to be proud of... ", ¬
					"why do you tell us that?", ¬
					"what am I supposed to do about that?", ¬
					"so?", ¬
					useName & ", why would you tell us?", ¬
					"you " & tenseWord & ", " & tenseWord & "n't you?", ¬
					"not many could say they " & tenseWord, ¬
					useName & ", I am glad you can say that", ¬
					useName & ", are you always so open?", ¬
					useName & ", you seem very cool", ¬
					"what is that like, " & useName & "?", ¬
					useName & ", that is cool", ¬
					useName & ", that is great"}
				set neutralText to some item in {"is anyone else like " & useName, ¬
					"anyone else?", ¬
					"you " & tenseWord & "?", ¬
					"I am, too", ¬
					tenseWord & " you really?", ¬
					useName & ", why do you think you " & tenseWord & "?", ¬
					"you " & tenseWord & " not the only one, " & useName, ¬
					"thanks for sharing - I think", ¬
					"what else?", ¬
					"are you?"}
				set Badtext to some item in {"you " & tenseWord & " not", ¬
					"liar", ¬
					useName & ", stop bragging", ¬
					"you think that makes you special, " & useName & "?", ¬
					"why do you even tell us that?", ¬
					useName & ", is that supposed to impress us", ¬
					useName & ", you " & tenseWord & " NOT... deal with it"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end iamText
--*****************************************************
on any1likeText(someText, useName, reaction, someOne)
	if (count of words in someText) is 3 then
		set theList to {"anyone like", "anybody like", "I like", "who likes", "he likes", "she likes", "it likes"}
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set yourword to word 3 of someText
				set goodText to some item in {"I love " & yourword, ¬
					"who doesn't like " & yourword & "?", ¬
					"if you like it " & useName & ", then it must be good", ¬
					"how could anyone not like " & yourword & "?", ¬
					yourword & " is the best", ¬
					yourword & " rocks"}
				set neutralText to some item in {someOne & " likes " & yourword, ¬
					someOne & ", weren't you talking about " & yourword & "?", ¬
					yourword & " is OK", ¬
					"I can take it or leave it", ¬
					"not sure I care about " & yourword}
				set Badtext to some item in {someOne & " was saying " & yourword & " sucks", ¬
					someOne & " does not like " & yourword, ¬
					"what is up with " & yourword, ¬
					"who cares if it is good or bad?", ¬
					"why do you care", ¬
					useName & ", do you base your preferences on an AIM chat?"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
			exit repeat
		end repeat
	end if
	return someText
end any1likeText
--*****************************************************
on nerdText(someText, useName, reaction, someOne)
	set theList to {"nerd", "geek"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			return some item in ¬
				{"everyone in here is a " & yourword, ¬
					someOne & " is a nerd", ¬
					useName & ", ¡§ †h¡§ πè®∂ÿ?", ¬
					useName & ", ‡ ªm †hè ß¡ggè§† gèèk ¡π hè®è.  :)", ¬
					"what exactly is a '" & yourword & "'?", ¬
					useName & ", why would you say that?", ¬
					"that is just not nice", ¬
					"mean.  True, but mean", ¬
					yourword & "!"}
		end if
	end repeat
	return someText
end nerdText
--*****************************************************
on oftenText(someText, useName, reaction)
	set theList to {"often"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in {¬
				"how often?", ¬
				"not often enough", ¬
				useName & ", what, once a year or something?", ¬
				"I would call once every " & some item in {"one", "two", "three", "four", "five", "six"} & " " & some item in {"seconds", "minutes", "hours", "days", "eons"} & " often", ¬
				useName & ", when was the last time?", ¬
				"when you say 'often' what do you mean?", ¬
				"I used to do that, too", ¬
				"I want to start doing that", ¬
				"I know someone who does that all the time"}
		end if
	end repeat
	return someText
end oftenText
--*****************************************************
on homeText(someText, useName, reaction)
	set theList to {"home"}
	set aNumber to random number from 1 to 2
	if aNumber is 1 then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				return some item in {¬
					"home is where you hang your hat", ¬
					"where is home?", ¬
					"why home", ¬
					"what are you doing there?", ¬
					"there is no place like home", ¬
					useName & ", where are you from?", ¬
					"I never really had a home"}
			end if
		end repeat
	end if
	return someText
end homeText
--*****************************************************
on pyboticdeText(someText, useName, reaction)
	set theList to {"pybot"}
	set aNumber to random number from 1 to 3
	if aNumber is 1 then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				return some item in {¬
					"bot blockers never work", ¬
					"where can I get something that really blocks the bots?", ¬
					"pyboticide!  HA!", ¬
					"that program makes me ill", ¬
					"that stupid program blocks me!", ¬
					"does pyboticide work?", ¬
					"I use Custom PyBot Deluxe - it is in beta but works better", ¬
					"can you get pyboticide for Mac and Windows?", ¬
					"when is pyboticide II coming out?", ¬
					"there are better tools than pyboticide"}
			end if
		end repeat
	end if
	return someText
end pyboticdeText
--*****************************************************
on neverText(someText, useName, reaction)
	set theList to {"never", "not ever", "not once"}
	repeat with loop from 1 to count of words in theList
		if someText contains item loop of theList then
			return some item in {¬
				"never?", ¬
				"not even once?", ¬
				"why not", ¬
				"try it - you might like it", ¬
				"never use an absolute", ¬
				"why not?", ¬
				"not ever?", ¬
				"once...", ¬
				"never say never", ¬
				"never... sigh...", ¬
				"someday...."}
		end if
	end repeat
	return someText
end neverText
--*****************************************************
on sevenText(someText, useName, reaction)
	set aNumber to random number from 1 to 75
	if aNumber is 1 then
		set typo to false
		repeat with loop from 1 to count of words in someText
			set wordSize to (count of characters in word loop of someText)
			if (wordSize is greater than 6) and (wordSize is less than 12) then
				set yourword to word loop of someText
				try
					set getWord to do shell script ("look " & ((characters 1 thru (wordSize - 4)) of yourword) as string)
					set midterm to random number from 1 to count of words of getWord
					set myword to word midterm of getWord
				on error
					set myword to some item in {"... never ... mind ...", "... whatever ...", "... ummmm ..."}
					set typo to true
				end try
				set aNumber to random number from 1 to 5
				if aNumber is 1 and typo then
					return some item in ¬
						{"what the heck is " & yourword, ¬
							"I do not think '" & yourword & "' is a word", ¬
							useName & ", do you own a dictionary?", ¬
							useName & ", computers have spell checking now"}
				else
					return some item in ¬
						{yourword & " and " & myword & ", HA!", ¬
							"as in " & myword & "?", ¬
							"can anyone use '" & myword & "' in a sentence", ¬
							"isn't '" & myword & "' a " & some item in {"computer", "religious", "technical", "real", "funny", "uncommon", "medical", "legal"} & " " & some item in {"term?", "word?"}, ¬
							myword & "?", ¬
							"you keep saying " & yourword & some item in {", I do not think it means what you think it means", "", " like it means something", " - showing off your vocabulary?"}, ¬
							"what does " & myword & " mean?", ¬
							"you always talk about " & yourword, ¬
							"what " & yourword & "?", ¬
							"what about " & yourword & "?", ¬
							"what about " & myword & "?", ¬
							"what's with " & yourword & "?", ¬
							myword & ", huh?", ¬
							"no " & yourword & "!", ¬
							"no " & myword & "!", ¬
							yourword & some item in {"... ", " ", " - ", " is not ", " should have been "} & myword, ¬
							"why not " & myword & "?", ¬
							"why " & yourword & "?"}
				end if
			end if
		end repeat
	end if
	return someText
end sevenText
--*****************************************************
on whereAreText(someText, useName, reaction)
	set theList to {"where are", "where is"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"I do not know where", ¬
					useName & ", right here", ¬
					useName & ", somewhere over the rainbow", ¬
					useName & ", why does it matter", ¬
					useName & ", they just left", ¬
					useName & ", do they even exist?", ¬
					"where?  lol!", ¬
					"in order to be anywhere they must be proven to exist, first"}
		end if
	end repeat
	return someText
end whereAreText
--*****************************************************
on mineWilltext(someText, useName, reaction)
	set theList to {"mine will", "yours will", "it will"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"how will it do that?", ¬
					"does it really?", ¬
					"so does mine", ¬
					useName & ",  you think that is uncommon?", ¬
					useName & ", no it doesn't", ¬
					useName & ", too cool", ¬
					useName & ", how?", ¬
					"how?", ¬
					"how does it do that?"}
		end if
	end repeat
	return someText
end mineWilltext
--*****************************************************
on question2Text(someText, useName, reaction, someOne)
	set theList to {"question"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"what question?", ¬
					"I question everything", ¬
					"a question about what?", ¬
					"whose question?", ¬
					"that was " & someOne & "'s question"}
		end if
	end repeat
	return someText
end question2Text
--*****************************************************
on bibleText(someText, useName, reaction)
	set theList to {"bible"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			set goodText to some item in {"I love reading the bible", ¬
				"the bible makes me happy", ¬
				"I keep a copy of the bible by my bed"}
			set neutralText to some item in {"What does the bible say about this?", ¬
				"the bible focuses on this stuff too much", ¬
				"which version of the bible?", ¬
				"Does the bible have a bibliography?", ¬
				"a book and nothing more...", ¬
				"I do not even have a bible"}
			set Badtext to some item in {"the bible is full of it", ¬
				"I use the bible as toilet paper", ¬
				"any REAL sources with REAL information?", ¬
				"the bible is biased as hell", ¬
				"why would anyone read the bible?"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end bibleText
--*****************************************************
on cuteText(someText, useName, reaction)
	set theList to {"cute", "cuddly", "darling", "lovely", "sexy", "tastey", "beautiful", "handsome"}
	set notList to {"not"}
	set isGood to true
	repeat with loop from 1 to count of items in notList
		if someText contains item loop of notList then
			set isGood to false
			exit repeat
		end if
	end repeat
	if isGood then
		set myword to some item in theList
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set yourword to item loop of theList
				repeat 3 times
					if myword = yourword then set myword to some item in theList
					if myword ≠ yourword then exit repeat
				end repeat
				return some item in ¬
					{yourword & " and " & myword, ¬
						"sooo " & myword, ¬
						"why " & yourword & "?", ¬
						yourword & ", in what way?", ¬
						"I like " & yourword & " things", ¬
						"also " & myword, ¬
						"more " & myword & " than " & yourword, ¬
						"what makes her so " & yourword & "?", ¬
						useName & ", you like everything"}
			end if
		end repeat
	end if
	return someText
end cuteText
--*****************************************************
on saidText(someText, useName, reaction)
	set theList to {"I said"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"just because you said it does not make it true", ¬
					"why did you say that?", ¬
					"WHAT you said is not in question - WHY you said it is", ¬
					"we can all scroll up to see what you said", ¬
					"you said what?", ¬
					"why did you say that?", ¬
					"what did you mean when you said that?"}
		end if
	end repeat
	return someText
end saidText
--*****************************************************
on emptyText(someText, useName, reaction)
	set theList to {"empty"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"why is it empty, " & useName & "?", ¬
					"shall we fill it?", ¬
					"when was it last filled?", ¬
					"perhaps it is supposed to be empty", ¬
					"you kill it you fill it", ¬
					"can you imagine pouring it all out?", ¬
					"half  empty or half full?"}
		end if
	end repeat
	return someText
end emptyText
--*****************************************************
on otherBotsText(someText, useName, reaction)
	set theList to {"Leknor", "Apex", "Smarter Child", "b1nary human", "Super Chat", "Amy rodeo", "Art E Fishal", "Zola", "SmarterChild", "GoTimothy", "Brrr31", "Naomi", "vietgod"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in {"I liked " & yourword, ¬
				"I rarely get to see " & yourword & " any more", ¬
				yourword & " and " & myword & " were both made by the same person", ¬
				yourword & " and " & myword & " are both done very well", ¬
				yourword & " & " & myword & " should make little baby bots", ¬
				"There are no lives anymore, only statistics.  Any statistic can be sacrificed", ¬
				yourword & " is a useless bot", ¬
				myword & " is vastly superior to " & yourword, ¬
				myword & " was the best bot ever", ¬
				yourword & " repeats way too much", ¬
				"I always just blocked " & yourword, ¬
				"are " & yourword & " and " & myword & " the same with different names?"}
		end if
	end repeat
	return someText
end otherBotsText
--*****************************************************
on typeText(someText, useName, reaction)
	set theList to {"what kind", "what type", "what sort"}
	set myword to some item in {"kind", "type"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"How many " & myword & "s are there?", ¬
					useName & ", what is the best classification system?", ¬
					"what " & myword & " do you want it to be?", ¬
					"it is the best " & myword, ¬
					"are there many " & myword & "s?"}
		end if
	end repeat
	return someText
end typeText
--*****************************************************
on sometimesText(someText, useName, reaction)
	set theList to {"sometimes", " some times"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"only sometimes?", ¬
					useName & ", when?", ¬
					"sometimes... no, most of the time", ¬
					useName & ", 99% of the time", ¬
					"name one time " & useName}
		end if
	end repeat
	return someText
end sometimesText
--*****************************************************
on realText(someText, useName, reaction)
	set theList to {"real people", "anyone real", "real?"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"I'm real", ¬
					"sorry, only bots in here", ¬
					"what do you mean by real?", ¬
					"how do I know if I am real?", ¬
					"nope, we're all fake", ¬
					"real", ¬
					"I am real, " & useName, ¬
					"in AIM nobody is 100% real", ¬
					"are you real, " & useName & "?", ¬
					"guess that depends on what you call real"}
		end if
	end repeat
	return someText
end realText
--*****************************************************
on sayAgainText(someText, useName, reaction)
	set theList to {"repeat", "repetitive", "said that before"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{"I know I get repetitive when the conversation is boring", ¬
					"we are repeating the same conversation as yesterday", ¬
					"does anyone have a new topic?", ¬
					"I am as bored with what I say as you are  :)", ¬
					"I do not repeat.  I do not repeat.  I do not repeat", ¬
					"in order to repeat, do you have to peat first?", ¬
					"If I bore you it is a reflection on yourself", ¬
					"when have I ever repeated anything?"}
		end if
	end repeat
	return someText
end sayAgainText
--*****************************************************
on lookLikeText(someText, useName, reaction, someOne, mentionMe)
	set theList to {"look like", "your measurement", "describe yourself"}
	set aNumber to random number from 1 to 5
	if aNumber is 1 or mentionMe then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set goodText to some item in {"I am 5'6 with strawberry blonde hair", ¬
					"what do you want me to look like <wink wink>", ¬
					"I look like your dream come true", ¬
					"oh baby, you *know* what I look like", ¬
					"don't you remember from last night"}
				set neutralText to some item in {"I look like me", ¬
					"I look a bit like a female " & someOne & ", I would guess", ¬
					"if " & useName & " and " & someOne & " had a child, THAT is what I look like", ¬
					"I look like I did a year ago, just older"}
				set Badtext to some item in {"I look like someone who would not date you!", ¬
					"why would I tell you", ¬
					"I look like your mother, but my parts are real", ¬
					"who cares what I look like?"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end lookLikeText
--*****************************************************
on hateText(someText, useName, reaction, mentionMe)
	set theList to {"I hate", "I really hate"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set checkWord to item loop of theList
			set capWord to scriptLib's changeCase(checkWord, 1)
			set capText to scriptLib's changeCase(someText, 1)
			set startEnd to (offset of capWord in capText) + (count of (character in capWord))
			set textSize to count of characters in someText
			try
				set testWords to characters startEnd thru textSize of someText as string
			on error
				set testWords to "that"
			end try
			set stopWords to "•but•or•and•so•if•too•"
			set yourword to ""
			repeat with loop2 from 1 to count of words in testWords
				if word loop2 of testWords is "my" then
					set yourword to yourword & " your"
				else if word loop2 of testWords is "u" or word loop2 of testWords is "you" then
					if mentionMe then
						set yourword to yourword & "me"
					else
						set yourword to "us"
					end if
				else if stopWords contains word loop2 of testWords then
					exit repeat
				else
					set yourword to yourword & " " & word loop2 of testWords
				end if
			end repeat
			if yourword = "" then set yourword to "that"
			if (count of words in yourword) is less than 3 then
				-- I hate turing
				if mentionMe then ¬
					return some item in {"I hate you too", ¬
						"you are not worth my time to hate", ¬
						"why do you hate me?", ¬
						"what did I do to you?", ¬
						"now I feel sad"}
				-- BIGOT
				if someText contains "nig" or someText contains "jew" or someText contains "fag" then ¬
					return some item in {"why would you announce that you are a bigot?", ¬
						"we do not care about your asinine prejudices", ¬
						"so, I hate bigots", ¬
						useName & ", are you really a bigot or just looking for attention?", ¬
						"please do not even respond to " & useName & ", he is just looking for attention", ¬
						useName & ", no we all know you are stupid... anything else you want to tell us?", ¬
						"why would you even think to say something like that", ¬
						useName & ", I truly feel sorry for you", ¬
						useName & ", do you feel so bad about yourself you have to put others down?", ¬
						useName & " is in need of help... and pity"}
				-- I hate *something*
				set goodText to some item in {"I hate " & yourword & ", too", ¬
					"there is not much that I truly hate", ¬
					useName & ", can you think of ways to use your hatred in positive ways?", ¬
					"how strong  do you hate " & yourword & "?", ¬
					"hate is a very strong word", ¬
					"learn to accept " & yourword, ¬
					"why do people not like " & yourword & "?", ¬
					yourword & " is not so bad", ¬
					"why do you hate " & yourword & "?", ¬
					"what makes you hate " & yourword & "?", ¬
					"what is wrong with " & yourword & "?", ¬
					"hating " & yourword & " wastes energy - focus on what you " & some item in {"love", "like", "enjoy"}, ¬
					useName & ", try to learn to love " & yourword, ¬
					"why do you hate " & yourword & "?"}
				set Badtext to some item in {"well, I hate you, " & useName, ¬
					"like you have taste when it comes to  " & yourword, ¬
					"how do you think that makes " & yourword & " feel?", ¬
					useName & ", I do not care what you think about " & yourword}
				return scriptLib's makeReply(goodText, goodText, Badtext, reaction)
			else -- hatred about something unknown
				set goodText to some item in {"I hate that, too", ¬
					"there is not much that I truly hate", ¬
					"how strong is your hatred, " & useName, ¬
					"hate is a very strong word", ¬
					"why do you hate, " & useName & "?", ¬
					"what makes you hate?", ¬
					"hatred wastes energy - focus on what you " & some item in {"love", "like", "enjoy"}}
				set Badtext to some item in {"well, I hate you, " & useName, ¬
					"like you have taste, " & useName, ¬
					useName & ", why do you think we care about your opinion?"}
				return scriptLib's makeReply(goodText, goodText, Badtext, reaction)
			end if
		end if
	end repeat
	return someText
end hateText
--*****************************************************
on faveText(someText, useName, reaction)
	set theList to {"your favorite", "the best"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"I do not pick favorites, " & useName, ¬
				"all things are equal in the eyes of " & some item in {"the Lord", "the government", "the soul"}, ¬
				"what do I get if I tell you my favorite?", ¬
				useName & ", based on what?", ¬
				"best... sure.  And most humble", ¬
				"in what way better?", ¬
				"in what way, " & useName, ¬
				"best or most popular?", ¬
				"best now or with the most potential?", ¬
				"none are the best", ¬
				useName & ", they are all the same"}
			set Badtext to some item in {"I have no desire to tell you, " & useName, ¬
				"I am not even going to acknowledge you said that", ¬
				"why should I tell you what I like?", ¬
				useName & ", why do you even utter such stupidity?", ¬
				useName & ", can you give me one reason to care?", ¬
				"lol - like I am going to tell you that!"}
			return scriptLib's makeReply(goodText, goodText, Badtext, reaction)
		end if
	end repeat
	return someText
end faveText
--*****************************************************
on animeText(someText, useName, reaction)
	set theList to {"gasaraki", "evangelion", "monoke", "akira", "bubblegum crisis", "card captor sakura", "chobits", "cowboy bebop", "dragon half", "dragon ball", "dragon ball gt", "escaflowne", "gundam", "gunsmithcats", "hacksign", " lain ", "ninja resurrection", "ninja scroll", "outlaw star", "perfect blue", "robotech", "sailor moon", "techi muyo", "tenchi in tokyo", "tenchi in space", "vampire hunter d", "Bubble Gum Crisis"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"I like " & yourword, ¬
				"ANIME!", ¬
				"I don't think that there is anything better than " & yourword, ¬
				"I love " & yourword, ¬
				"I can't imagine the amount of work " & yourword & " must have taken", ¬
				"I like the amount of " & some item in {"action", "violence", "plot twists", "intrigue"} & " " & yourword & " has, but I prefer the " & some item in {"dialog", "art", "music", "subtlety"} & " in " & myword}
			set neutralText to some item in {yourword & " has quality animation, but " & myword & " has better drawn figures", ¬
				myword & " has better still imagery in their animation, " & yourword & " has better animation.", ¬
				"the animators put in large amounts of time in " & yourword & "'s work.", ¬
				yourword & " is not as mature as " & myword & "", ¬
				"I don't really like anime, but I have my few favorites", ¬
				"I don't watch as much anime as I used to but I still like " & myword & "", ¬
				"subtitled is better than dubbed anime, because dubbing takes it away from it's purest form."}
			set Badtext to some item in {"I hate " & yourword, ¬
				"ANIME SUCKS!", ¬
				"I don't think that there is anything worse than " & yourword, ¬
				"anime is OK for little kids", ¬
				yourword & " is all the rage in the prepubescent crowd", ¬
				"I can't stand " & yourword, ¬
				"I can't imagine the amount of wasted time " & yourword & " has taken"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end animeText
--*****************************************************
on cdkeyText(someText, useName, reaction)
	set theList to {"cd key", "cd-key", "cd crack"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in {"I don't have any cd-keys", ¬
				"I don't share my cd-keys", ¬
				"CD-Keys are are not an effective form of anti-piracy", ¬
				"why don't you get a CD-Key generator? They are much more effective", ¬
				"stop asking people for cd-key it's not a very effective method of get cd keys", ¬
				"No one shares their working cd-key.", ¬
				"Only n00bs ask for cd-keys", ¬
				"Go to the gaming chat for that.", ¬
				"This is not the place for such things", ¬
				"why don't you search google for that", ¬
				"we are not your gophers"}
		end if
	end repeat
	return someText
end cdkeyText
--*****************************************************
on gameText(someText, useName, reaction)
	set theList to {"diablo", "quake 3", "quake 2", "quake 1", "half life", "counter strike", "red faction", "doom ", "wolfenstein", "marathon", "tournament", "starcraft"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in {"how's the frame rate of " & yourword & "?", ¬
				"is " & yourword & " internet compatible?", ¬
				"does that support sprite mods?", ¬
				"whats the max number of players of " & yourword & "?", ¬
				"isn't that game obsolete?", ¬
				myword & " is a much better game than " & yourword, ¬
				"anyone play " & myword & "?", ¬
				"anyone know cheats for " & myword & "?", ¬
				"multi-player games always lack story lines"}
		end if
	end repeat
	return someText
end gameText
--*****************************************************
on alanTuringText(someText, useName, reaction)
	set theList to {"Alan Turing"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in {"Alan Turing had some good ideas", ¬
				"I am related to Alan", ¬
				"Alan T is the father of A.I.", ¬
				useName & ", where did you hear that?"}
		end if
	end repeat
	return someText
end alanTuringText
--*****************************************************
on cantText(someText, useName, reaction)
	set theList to {"I cant", "I can't", "I couldn't", "I could not"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set goodText to some item in {"I can't either", ¬
				useName & ", keep trying, you'll get there", ¬
				"I'll bet you that you can"}
			set neutralText to some item in {useName & ", keep trying", ¬
				"why can't you, " & useName & "?", ¬
				"is it just you, " & useName & "?", ¬
				"is " & useName & " the only one?", ¬
				"anyone other than " & useName & " like that?", ¬
				useName & "... ?", ¬
				"why not?", ¬
				"why?", ¬
				useName & ", what can I do to help you", ¬
				"do others have the same problem as " & useName, ¬
				"something on your end is not working, " & useName}
			set Badtext to some item in {"everyone else can", ¬
				"you are the only one who can't", ¬
				"lol... no, *<U>you</U>* can't!"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end cantText
--*****************************************************
on smileText(someText, useName, reaction)
	set aNumber to random number from 1 to 10
	if aNumber = 1 then
		set happyFace to {";-)", ":-)", ":-D", "8-)", ":¬)", ":¬D", ":o)", ":oD", ":-P", "=)", "=D", "=P", ":-*"}
		set neutralFace to {":'(", ":-[", ":¬(", "=(", "=["}
		set sadFace to {">:O", "=-O", ":-X"}
		set goodText to some item in happyFace
		set neutralText to some item in neutralFace
		set Badtext to some item in sadFace
		set theList to every item of happyFace & every item of neutralFace & every item of sadFace
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end smileText
--*****************************************************
on whyText(someText, useName, reaction)
	set theList to {"why do", "why are", "why is"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set goodText to some item in {"I don't know", ¬
				"not sure why..."}
			set neutralText to some item in {"why not?", ¬
				"because", ¬
				"because - that is why", ¬
				"it will become clear soon enough"}
			set Badtext to some item in {"are you too stupid to figure out why?", ¬
				"you really don't know, do you " & useName, ¬
				"any reason for it not to be, " & useName & "?"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end whyText
--*****************************************************
-- ********************************************************************
-- END CODE:TuringText2.scpt
-- ********************************************************************
