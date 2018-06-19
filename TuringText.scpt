-- ********************************************************************
-- START CODE:TuringText.scpt
-- ********************************************************************
global scriptLib
set scriptLib to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringFunctions.scpt" as POSIX file

--*****************************************************
on doMath(someText)
	set makeCalc to ""
	set newCalc to ""
	
	repeat with loop from 1 to count of characters in someText
		set theChar to character loop of someText
		if theChar = "/" then set theChar to " ÷ "
		if theChar = "x" then set theChar to " * "
		if theChar = "-" and someText contains "tur" then set theChar to " minus "
		set newCalc to newCalc & theChar
	end repeat
	
	set validChars to "101121314151617181920+-*÷().^÷"
	try
		set theWords to every word in newCalc
		repeat with loop from 1 to count of words in newCalc
			set theWord to word loop of newCalc
			if theWord is "plus" then
				set theWord to "+"
			else if theWord is "minus" then
				set theWord to "-"
			else if theWord is "times" then
				set theWord to " * "
			else if theWord contains "div" then
				set theWord to "÷"
			else if theWord is "power" then
				set theWord to "^"
			else if theWord contains "square" then
				set theWord to "^2"
			else if theWord contains "cube" then
				set theWord to "^3"
			else if theWord is "point" then
				set theWord to "."
			else if theWord is "one" then
				set theWord to "1"
			else if theWord is "two" then
				set theWord to "2"
			else if theWord is "three" then
				set theWord to "3"
			else if theWord is "four" then
				set theWord to "4"
			else if theWord is "five" then
				set theWord to "5"
			else if theWord is "six" then
				set theWord to "6"
			else if theWord is "seven" then
				set theWord to "7"
			else if theWord is "eight" then
				set theWord to "8"
			else if theWord is "nine" then
				set theWord to "9"
			else if theWord is "ten" then
				set theWord to "10"
			else if theWord is "eleven" then
				set theWord to "11"
			else if theWord is "twelve" then
				set theWord to "12"
			else if theWord is "thirteen" then
				set theWord to "13"
			else if theWord is "fourteen" then
				set theWord to "14"
			else if theWord is "fifteen" then
				set theWord to "15"
			else if theWord is "sixteen" then
				set theWord to "16"
			else if theWord is "seventeen" then
				set theWord to "17"
			else if theWord is "eighteen" then
				set theWord to "18"
			else if theWord is "nineteen" then
				set theWord to "19"
			else if theWord is "twenty" then
				set theWord to "20"
			else if theWord is "pi" then
				set theWord to "3.14"
			else if theWord is in validChars then
				set theWord to theWord
			else
				set aWord to theWord as text
				repeat with loop2 from 1 to count of characters in aWord
					if character loop2 of aWord is in validChars then
						set aWord to theWord & character loop2 of aWord
					else
						set theWord to ""
					end if
				end repeat
			end if
			set makeCalc to makeCalc & " " & theWord
		end repeat
		
		set aCalc to (run script makeCalc)
		set wordCount to (count of words in (makeCalc as text))
		if makeCalc contains "-" then set wordCount to wordCount + 1
		set holdCalc to aCalc
		set aCalc to ((aCalc * 1000) div 100) / 10
		if holdCalc = aCalc then
			set eq to some item in {" = ", " is ", " equals "}
		else
			set eq to " is about "
		end if
		set maxAnswer to (random number from 3 to 10) * (random number from 3 to 10) * (random number from 3 to 10)
		if aCalc > maxAnswer or aCalc < (maxAnswer * -1) then
			set theCalc to 123456789
		else
			if (aCalc as text) ends with ".0" then
				set theSize to count of characters in (aCalc as text)
				set aCalc to characters 1 through (theSize - 2) of (aCalc as text)
			end if
			set theCalc to makeCalc & eq & (aCalc as text)
			if wordCount is less than 3 then set theCalc to someText
		end if
	on error
		set theCalc to someText
	end try
	set ignoreList to {"talk", "chat", "any ", "girl", " f ", "9/11", "9-11", "guy", "24/7", "press", "age"}
	set notMath to false
	repeat with loop from 1 to count of items of ignoreList
		if item loop of ignoreList is in someText then
			set notMath to true
			exit repeat
		end if
	end repeat
	if notMath = true then
		return someText
	else
		return theCalc
	end if
end doMath
--*****************************************************
on stealText(someText, useName, reaction, someOne)
	set theList to {"pirate", "steal", " hack", "kazaa", "limewire", "warez", "hotline", "carracho"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{useName & ": " & "are you trying to do something " & some item in {"illegal", "immoral", "illegal, immoral, or fattening?", "stupid", "to get you thrown in jail"} & "?", ¬
					"I am " & some item in {"not", "", "not really"} & " sure you should do that ", ¬
					"Who knows how to " & some item in {"hack", "download music", "download files", "get an IP"} & "?", ¬
					"Any hackers in here", ¬
					"Anybody here know how to hack?", ¬
					"someone who knows how to hack, please IM me", ¬
					"how do you hack?", ¬
					"where do you find movies to download?", ¬
					"where do I download software?", ¬
					"where are the good hacker sites?", ¬
					"I am only just now learning to hack", ¬
					"I want to learn to be a hacker", ¬
					"how do people learn to be hackers?", ¬
					useName & ", are you a hacker?", ¬
					"I know this guy who is the best hacker", ¬
					"where do the hackers hang out?", ¬
					"the government hires the best hackers", ¬
					"hackers work for " & some item in {"Microsoft", "Apple", "Dell", "Intel", "the CIA", "the NSA", "McDonald's", "big businesses", "foreign powers"}, ¬
					"can you download " & some item in {"physical stuff", "smells", "sound", "video", "music", "feelings", "friends", "the past", "the future", "the whole Internet"} & "?", ¬
					"where do I go to download the Internet?", ¬
					"have you tried the Internet?", ¬
					useName & ", do your parents know about that?", ¬
					"hey " & useName & ", do not admit to that in here", ¬
					useName & ", you will never be a real hacker", ¬
					"I have every program I want pirated", ¬
					"Ever wonder how many of the folks in here will end up in jail?", ¬
					useName & ", I bet you think you are clever", ¬
					"if you really want to hack someone here's my IP:  127.0.0.1", ¬
					useName & ", do you ever pay for software?", ¬
					useName & ", kazaa might have that?", ¬
					useName & ", real hackers don't use AIM", ¬
					useName & " and " & someOne & " are going to end up being room mates in jail", ¬
					"you are not the first to say that", ¬
					useName & ", IM me if you want to know that", ¬
					useName & ", you can not download that?", ¬
					useName & ", what type things do you download?", ¬
					useName & ", how often do you download stuff?", ¬
					"People have been pirating that since " & some item in {"1991", "the early 90s", "I first got online", "I was a kid"}, ¬
					"there are ways of tracing you on the 'net", ¬
					"can you be traced when you download " & some item in {"files", "MP3s", "movies", "programs"}, ¬
					"hacking is not worth the risk of being caught", ¬
					useName & ", hah!  yeah, right", ¬
					useName & ", there are at least " & some item in {"3", "4", "5", "6"}, ¬
					useName & ", I can find anything... just IM me", ¬
					useName & ", nobody will help you to steal software", ¬
					useName & ", do you think you can do that?", ¬
					"I do not want to steal anything " & useName, ¬
					"The gov't is cracking down on people who download", ¬
					"there is no way they can catch them all"}
		end if
	end repeat
	return someText
end stealText
--*****************************************************
on helpText(someText, useName, reaction, someOne)
	set theList to {"how do I", "how can I", "one know ", "a problem", "who knows", "how would"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set needWord to some item in {"need", "want", "need", "want", "need", "want", some item in {"desire", "require", "demand"}}
			set helpWord to some item in {"help", "help", "help", some item in {"assist", "aid", "rescue"}}
			set yourword to item loop of theList
			set goodText to some item in {useName & ": " & "what do you need to know", ¬
				"what do you " & needWord & "  " & useName, ¬
				"hmmm, not sure.  anyone else", ¬
				"hmmm, not sure.  wish I did", ¬
				useName & ", I think I " & some item in {"understand", "get", "follow"} & " you", ¬
				"I would do " & some item in {"anything", "almost anything", "what I can", "some research"} & " to " & helpWord & " you, " & useName, ¬
				"want me to look that up for you?", ¬
				"how can I " & helpWord & "?", ¬
				"let's all work together", ¬
				"let's all do this together", ¬
				useName & ", can I " & helpWord & " you?", ¬
				useName & ", what can we do for you?", ¬
				useName & ", I only wish I could " & helpWord & " you more", ¬
				"what are you looking for?"}
			set neutralText to some item in {"can anyone in here " & helpWord & " me?", ¬
				"is there an error?", ¬
				"you should work with " & someOne, ¬
				"only " & someOne & " knows that", ¬
				someOne & " is the expert in that area", ¬
				"I really don't know", ¬
				"I don't really know", ¬
				"I am not sure anyone knows that", ¬
				useName & ", what OS do you have", ¬
				"why is this " & some item in {"little arrow", "background", "weird buzz", "thunking noise", "chat room"} & " always on my computer?", ¬
				"what do you mean?", ¬
				"what do you " & needWord & "?", ¬
				"what are you asking?", ¬
				"what do you " & needWord & " that for?", ¬
				"anyone know how to " & some item in {"use DIV tags", "work with tables", "write HTML", "program VB", "design Flash progs", "automate their computer"}, ¬
				"does that happen every time?", ¬
				"you don't have to ask that here", ¬
				useName & ", people in the " & some item in {"gaming", "NASCAR", "Top TV", "NY", "Boston", "TV shows", "Pet"} & " chat were talking about that", ¬
				useName & ", folks in IRC have been doing that for a long time", ¬
				"I do not know " & useName, ¬
				"someone in this room is sure to know that " & useName, ¬
				useName & ", you should use a search engine", ¬
				"have you looked in the help files?", ¬
				"is that even supported any more", ¬
				"is that supported on your machine", ¬
				useName & ", can you " & helpWord & " me?", ¬
				some item in theList & "..." & some item in theList & "..." & some item in theList & "..." & "whatever!", ¬
				"do people in here " & helpWord & " newbies?", ¬
				useName & ", are you a newbie?", ¬
				"I have a problem with my " & some item in {"computer", "modem", "monitor", "zip drive", "feet", "ethernet card"}, ¬
				"Is your " & some item in {"idea", "modem", "universal translator", "thingamajig", "brain", "keyboard"} & " working?", ¬
				"anyone know how to use " & some item in {"Dreamweaver", "Photoshop", "AOL", "MS Word", "Internet Explorer", "Kazaa", "Flash"}, ¬
				"anyone have experience with " & some item in {"programming", "writing", "singing", "coding", "building computers", "fixing monitors", "hacking ethernet packets"}, ¬
				useName & ", have you tried google?", ¬
				"what have you tried so far", ¬
				"what do you " & needWord & " " & useName, ¬
				"is that a question or a statement", ¬
				useName & ", can you be more specific", ¬
				useName & ", who or what do you mean?", ¬
				useName & ", are you asking us to " & helpWord & " you?", ¬
				"have you tried something similar before", ¬
				useName & ", why would you " & needWord & " that", ¬
				"you might look at yahoo.com", ¬
				useName & ", what do you need?", ¬
				"sorry, " & useName & ", ask somewhere else", ¬
				"please do no expect us to solve your problems " & useName, ¬
				useName & ", this is not " & some item in {"free tech support", "your personal answering department", "the yellow pages", "a search engine", "a library"}}
			set Badtext to some item in {"ask someone else", ¬
				useName & ", search the Internet, not a chat room", ¬
				"you are simply not " & some item in {"bright", "smart", "intelligent"} & " enough to figure that out", ¬
				"you will never know, " & useName, ¬
				"are you seriously asking us that?", ¬
				useName & ", right, this whole room is here to serve you", ¬
				"sure, " & useName & ", you think someone will drop everything to serve you", ¬
				useName & ", you have got to be kidding", ¬
				useName & ", you seem like a newbie?", ¬
				useName & ", take it some place else"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end helpText
--*****************************************************
on helloText(someText, useName, reaction, mentionMe)
	set theList to {"hi ", "hello", "wb ", "what up", "what's up", "wassup", "wussup", "howdy", "greetings", "yo ", "hola", "hi" & return, "morning"}
	set theList2 to {"hi ", "hello", "wb ", "what up", "what's up", "wassup", "wussup", "howdy", "greetings", "yo ", "hola", "hi", "morning"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList or someText begins with "hey " then
			set yourword to item loop of theList2
			set upSomething to false
			if yourword contains "what" and someText starts with "what" and number of words of someText is 3 then
				set upSomething to true
				if (count of characters of (word 3 of someText)) < 4 then
					set upSomething to false
				else
					set noUpList to {"room", "tur", "lol"}
					repeat with loop2 from 1 to count of items in noUpList
						if word 3 of someText contains item loop2 of noUpList then
							set upSomething to false
							exit repeat
						end if
					end repeat
				end if
			end if
			if upSomething then
				set lastWord to word 3 of someText
				return some item in ¬
					{useName & ", nothing is up " & lastWord & ", and you are sick for even asking!", ¬
						"what do you want to put up " & lastWord & "?", ¬
						"what is up " & lastWord & "? - ewwww!", ¬
						"I never look to see what is up " & lastWord, ¬
						"whatever is up " & lastWord & " is probably NOT something we would want to talk about!", ¬
						"Why do you want to know what is up " & lastWord & "?", ¬
						"what is up " & lastWord & "?  What is up you?"}
			else
				set goodText to some item in {"were you saying " & yourword & " to me?", ¬
					"weren't you here before?", ¬
					"another one joins the fun", ¬
					"more cool people", ¬
					"more people, cool", ¬
					"Brilliant!", ¬
					"hello", ¬
					"hello", ¬
					"hi there", ¬
					"hi there"}
				set aNumber to random number from 1 to 5
				if aNumber < 5 then
					set neutralText to some item in {useName & ": " & "hello to you", ¬
						"hello again", ¬
						"hello to you, too", ¬
						"hello", ¬
						"hello", ¬
						"hi there", ¬
						"hi there", ¬
						"hi", ¬
						"hi", ¬
						"hi", ¬
						"hi", ¬
						"howdy", ¬
						"howdy", ¬
						"lol", ¬
						"rofl", ¬
						"roflmao", ¬
						"hello " & useName, ¬
						"howdy " & useName, ¬
						"wb " & useName, ¬
						"hi " & useName, ¬
						"what is the topic?", ¬
						"what are folks talking about?", ¬
						"how can we get this chat going?", ¬
						"wassssup!", ¬
						"what brings you here?", ¬
						useName & ", who are your friends in here?", ¬
						useName & ", who are the bots?", ¬
						some item in theList & " " & useName, ¬
						some item in theList, ¬
						useName & ", how are you doing", ¬
						useName & ", how have you been", ¬
						useName & ", are you OK?", ¬
						useName & ", how long have you been in here?"}
				else
					set neutralText to some item in {"did you just get here?", ¬
						"why do people have to be jerks in here", ¬
						"do we know each other", ¬
						"lots of people in here today", ¬
						"is this room ever on topic", ¬
						"why did people select this room to come to", ¬
						"how many public chats are there?", ¬
						"did everyone run away?", ¬
						"does someone have a private room going?", ¬
						"how is everyone?", ¬
						"anything exciting going on?", ¬
						"anyone had any good dates recently?", ¬
						"penny for your thoughts", ¬
						"w00t", ¬
						some item in {"I do not feel well... is there a programmer in the house?", "50 cent traded in for two quarters!  News at 11...", "my webcam is pointed at my kitchen.  See how fresh my coffee is!", "wanna see two girls sitting, looking bored?  click here!", "make money slowly - it's called a job!"}, ¬
						"I have been up for " & (random number from 24 to 36) & " hours", ¬
						"is " & some item in {"fred", "ron", "bill", "brad", "mike", "jen", "tom", "rich", "alex", "a hacker", "a doctor", "a math whiz", "anyone real", "a bot catcher", "someone worth my time"} & " in the room?", ¬
						useName & some item in {", do you know my other screen name?", ", what time is it for you?", ", how's it hanging", ", were you here for yesterdays conversation", ", long time no see :)"}, ¬
						some item in {"How many people can be in here?", "hi all", "can you get more than " & (random number from 35 to 45) & " people in here?"}}
				end if
				set Badtext to some item in {"you come in here " & some item in {"too much ", "often ", "quite often "} & useName, ¬
					"great, another loser to make this chat suck", ¬
					"this is getting boring", ¬
					"I had a dream where I had a " & some item in {"butler", "pimple", "hemorrhoid", "bowel movement"} & " just like you, " & useName, ¬
					"we can see when people enter the chat!", ¬
					"stop saying '" & yourword & "' to each other and say something useful"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
			exit repeat
		end if
	end repeat
	return someText
end helloText
--*****************************************************
on osText(someText, useName, reaction)
	set goodList to {"Mac ", "Mac OS X", "OS X"}
	set badList to {"Windows", "Win XP", "Win 98", "Win 95", "Win ME"}
	set neutralList to {"Linux", "FreeBSD", "UNIX", "Mandrake", "Redhat", "slackware", "red hat", "dual boot", "*nix", "Mac 8.5", "Mac OS 9", "KDE"}
	set sillyList to {"Etch-A-Sketch", "Speak-N-Spell", "play station", "C 64", "Apple IIe", "Apple ][", "abacus", "slide rule"}
	set theList to (every item of goodList) & (every item of badList) & (every item of neutralList)
	set hateWords to {"sucks", "sux", "slow", "crap", "hate", "gay", "fuck", "shit", "cost too", "expensive", "blow"}
	set rating to 0
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			set rating to 2
			if badList contains yourword then set rating to rating * -1
			if neutralList contains yourword then set rating to 0
			repeat with hateLoop from 1 to count of items in hateWords
				if someText contains item hateLoop of hateWords then
					set rating to rating * -1
					exit repeat
				end if
			end repeat
			if rating = 2 then -- Mac Rocks, Win Sucks
				if badList contains yourword then -- Win Sucks
					set tempText to some item in ¬
						{useName & ", you are so right", ¬
							yourword & " is not worth even discussing", ¬
							"why would anyone use " & yourword, ¬
							yourword & " is getting further behind all the time", ¬
							yourword & " machines are a piece of crap", ¬
							useName & ", I prefer Macs", ¬
							"Why do people use " & yourword, ¬
							yourword & " is an OS that never innovates", ¬
							yourword & " is horrid"}
				else -- Mac Rocks
					set tempText to some item in ¬
						{useName & ", you have great taste!", ¬
							"I do like my Mac", ¬
							"Mac is better for almost everything", ¬
							"you can install more programs on a Mac", ¬
							"why would anyone get a PC?", ¬
							"Windows machines really are kinda sad", ¬
							"I feel sorry for people who use Windows", ¬
							"what would windows be like if MS did not have Apple to copy?", ¬
							useName & ", how long have you been a Mac fan?", ¬
							"MS is only about 5 years behind Apple - they are catching up", ¬
							"I wonder if .NET will make Windows usable?", ¬
							"why do people tolerate Windows when everyone knows it is so bad?", ¬
							useName & ", you're one of the few in here with a clue", ¬
							yourword & " is getting better all the time", ¬
							yourword & " is a piece of art", ¬
							yourword & " is the only OS that really innovates", ¬
							yourword & " is awesome"}
				end if
			else if rating = -2 then -- Mac sucks, Win Rocks
				if badList contains yourword then -- Win Rocks
					set tempText to some item in ¬
						{"you are so wrong", ¬
							"people who use " & yourword & " do not know what they are doing", ¬
							some item in neutralList & " crushes " & yourword, ¬
							useName & ", you would be better served by " & some item in neutralList, ¬
							some item in neutralList & " is much better " & yourword, ¬
							"even " & some item in neutralList & " crushes " & yourword, ¬
							"I would rather use a " & some item in sillyList & " than " & yourword, ¬
							yourword & " is not as good as " & some item in neutralList & ", " & some item in neutralList & ", or even a " & some item in sillyList, ¬
							yourword & " is blown away by " & some item in neutralList & " or even a " & some item in sillyList, ¬
							yourword & " is getting further behind all the time", ¬
							useName & ", " & yourword & " " & some item in {"sucks", "is outdated"}, ¬
							yourword & " can't be tinkered with safely", ¬
							useName & ", " & some item in goodList & " is much better than " & yourword, ¬
							useName & ", " & yourword & " crashes way more than " & some item in goodList, ¬
							useName & ", are there any user friendly " & some item in {"spreadsheet", "word processor", "1st person shooter", "image converter", "general utility", "database", "browser", "chat client", "MP3 player", "HTML editor", "DVD prog", "news client"} & " " & yourword & some item in {" progs", " apps"}, ¬
							useName & ", what is a good " & some item in {"spreadsheet", "word processor", "1st person shooter", "image converter", "general utility", "database", "browser", "chat client", "MP3 player", "HTML editor", "DVD prog", "news client"} & " for " & yourword, ¬
							"is there a good " & some item in {"spreadsheet", "word processor", "1st person shooter", "image converter", "general utility", "database", "browser", "chat client", "MP3 player", "HTML editor", "DVD prog", "news client"} & " for " & yourword & "?", ¬
							useName & ", how many " & some item in {"mice", "screens", "ethernet cards", "modems", "PCI slots", "sound channels", "files"} & "  can " & yourword & " handle?", ¬
							yourword & " is on slow, overpriced machines", ¬
							"The last time I used " & yourword & " it " & some item in {"ate my data", "went beep beep beep", "crashed every two seconds", "was way too slow"}, ¬
							"no such thing as a good version of " & yourword, ¬
							yourword & " is a piece of crap", ¬
							useName & ": " & yourword & " sucks", ¬
							"How long does a " & yourword & " machine last?", ¬
							"How much does a " & yourword & " machine cost?", ¬
							yourword & " is an OS that never innovates", ¬
							yourword & " is horrid"}
				else -- Mac Sucks
					if someText contains "expensive" or someText contains "cost to" then
						set tempText to some item in ¬
							{"while expensive, Macs are cheaper than PC's", ¬
								"the only cheap PC's are ones put together as a hobby", ¬
								"compare any Mac with a comparable Dell... Mac is always cheaper", ¬
								"compare the price of a Mac with any major PC vender - Macs are inexpensive"}
					else
						set tempText to some item in ¬
							{yourword & " is better than " & some item in badList, ¬
								useName & ", have you even " & some item in {"touched", "smelled", "seen", "owned", "used"} & " a " & yourword, ¬
								useName & ", what is wrong with Apple?", ¬
								"why don't you like Macs?", ¬
								"clearly you know nothing of Apple", ¬
								"Apple makes the most advanced OS in the world", ¬
								"Mac blows Windows away", ¬
								yourword & " is not ruined by " & some item in {"DLL hell", "the registry", "stupid virus's and worms"}, ¬
								useName & ", you say that out of jelousy", ¬
								yourword & "s are a piece of art", ¬
								yourword & " is the only OS that really innovates", ¬
								yourword & " is awesome"}
					end if
				end if
			else if rating = 0 then -- Linux sucks, Linux Rocks
				if badList contains yourword then -- Linux Sucks
					set tempText to some item in ¬
						{yourword & " is better than " & some item in badList, ¬
							useName & ", I prefer " & some item in goodList & "?", ¬
							yourword & " machines are OK", ¬
							yourword & " can be decent", ¬
							yourword & " is not half as bad as Windows"}
				else -- Linux Rocks
					set tempText to some item in ¬
						{yourword & " is better than " & some item in badList, ¬
							useName & ", what are the minimum requirements for " & yourword & " progs", ¬
							"aren't " & some item in badList & " and " & yourword & " essentially the same?", ¬
							useName & ", have you even used a Mac?", ¬
							useName & ", how is " & yourword & " different from " & some item in goodList & "?", ¬
							useName & ", how many " & some item in {"", "", "", "", "concurrent", "shared", "preemptive", "modern", "maxed"} & ¬
							" " & some item in {"mice", "screens", "ethernet cards", "modems", "PCI slots", "sound channels", "files", "users", "lines of code", ¬
							"data entry points", "applications", "web sites"} & "  can " & yourword & " handle?", ¬
							useName & ", how does the " & some item in {"kernel", "interface", "networking", "software", "user base", "speed", "flexibility"} & ¬
							" of " & yourword & " compare to " & some item in goodList & "?", ¬
							useName & ", there is less software for " & yourword & " than for " & some item in goodList, ¬
							useName & ", does " & yourword & " multitask as well as " & some item in goodList & "?", ¬
							useName & ", I prefer Apple", ¬
							yourword & " machines are a not so bad", ¬
							yourword & " can be decent", ¬
							yourword & " is not as good as Mac, but not bad"}
				end if
			end if
			set genericText to some item in ¬
				{useName & ", how do you hook up two computers with different OS's?", ¬
					"who made " & yourword, ¬
					"they will completely change computers in " & (random number from 5 to 15) & " years", ¬
					"How do they make computers work?", ¬
					"Are computers still based on 1's and 0's?", ¬
					"what is the best OS for a home user", ¬
					"there are a lot of " & yourword & " " & some item in {"exploits", "bugs", "virus's", "programmers", "users", "servers"}, ¬
					"are there are a lot of " & yourword & " " & some item in {"exploits", "bugs", "virus's", "programmers", "users", "servers"} & "?", ¬
					"what is a good OS for a small office?", ¬
					"how can you dual boot " & yourword & " systems", ¬
					"anyone here use " & yourword, ¬
					useName & ", all computers are essentially the same", ¬
					useName & ", does your " & some item in {"hardware", "experience", "software", "file system"} & " effect your OS", ¬
					useName & ", have you even used " & yourword, ¬
					"who here programs?", ¬
					"does anyone use multiple computers?", ¬
					"does any OS really do anything the others do not?", ¬
					"is it hard to " & some item in {"pirate", "play games", "watch movies", "hack", "clone people", "get software"} & " on " & yourword, ¬
					"you talking about " & yourword & "?", ¬
					"anyone in here good with " & yourword & "?", ¬
					"is " & yourword & " going to be around for long?", ¬
					"when did " & yourword & " come out?", ¬
					"when was " & yourword & " invented?", ¬
					"where was " & yourword & " invented?"}
			set someText to some item in {tempText, tempText, genericText}
			return {someText, rating}
		end if
	end repeat
	return {someText, rating}
end osText
--*****************************************************
on compuText(someText, useName, reaction)
	set goodList to {"Apple", "Macintosh"}
	set badList to {"Dell", "Gateway", " HP", " Acer", "emachine", "Toshiba", "Alien Ware"}
	set theList to (every item of goodList) & (every item of badList)
	set hateWords to {"sucks", "sux", "slow", "crap", "hate", "gay", "fuck"}
	set rating to 0
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			set rating to 2
			if badList contains yourword then set rating to rating * -1
			repeat with hateLoop from 1 to count of items in hateWords
				if someText contains item hateLoop of hateWords then
					set rating to rating * -1
					exit repeat
				end if
			end repeat
			if rating = 2 then -- Apple Rocks, Dell Sucks
				if badList contains yourword then -- Dell Sucks
					set tempText to some item in ¬
						{useName & ", you are so right", ¬
							yourword & " is getting further behind all the time", ¬
							yourword & "s machines are a piece of crap", ¬
							useName & ", I prefer Apple", ¬
							yourword & " is a company that never innovates", ¬
							yourword & " is horrid"}
				else -- Apple Rocks
					set tempText to some item in ¬
						{useName & ", you know what you are talking about", ¬
							useName & ", you are one of the few in here with a clue", ¬
							yourword & " is getting better all the time", ¬
							yourword & "s machines are a piece of art", ¬
							yourword & " is the only company that really innovates", ¬
							yourword & " is awesome"}
				end if
			end if
			if rating = -2 then -- Apple sucks, Dell Rocks
				if badList contains yourword then -- Dell Rocks
					set tempText to some item in ¬
						{"you are so wrong", ¬
							yourword & " is getting further behind all the time", ¬
							yourword & "s can't be expanded easily enough", ¬
							yourword & " makes slow, overpriced machines", ¬
							"What are the stats of your " & yourword, ¬
							"no such thing as a good " & yourword, ¬
							yourword & "s machines are a piece of crap", ¬
							useName & ": " & yourword & "s sucks", ¬
							"How long does a " & yourword & " last?", ¬
							"How much does a " & yourword & " cost?", ¬
							yourword & " is a company that never innovates", ¬
							yourword & " is horrid"}
				else -- Apple Sucks
					set tempText to some item in ¬
						{yourword & " is better than " & some item in badList, ¬
							useName & ", have you even used a " & yourword, ¬
							useName & ", I prefer Apple", ¬
							yourword & "s machines are a piece of art", ¬
							yourword & " is the only company that really innovates", ¬
							yourword & " is awesome"}
				end if
			end if
			set genericText to some item in ¬
				{useName & ", how do you hook up two computers?", ¬
					"what OS's can you run on " & yourword & "?", ¬
					"computers will be completely different in " & (random number from 5 to 15) & " years", ¬
					"How do they make computers work?", ¬
					"Are computers still based on 1's and 0's?", ¬
					"what is the best brand of computer for a home user", ¬
					"what is a good computer company for a small office?", ¬
					"how can you dual boot " & yourword & " systems", ¬
					"anyone here use " & yourword, ¬
					useName & ", all computers are essentially the same", ¬
					useName & ", does your " & some item in {"hardware", "experience", "software", "file system"} & " effect your OS", ¬
					useName & ", have you even used " & yourword, ¬
					"who here builds computers?", ¬
					"does anyone use multiple computers?", ¬
					"does any computer really do anything the others do not?", ¬
					"is it hard to " & some item in {"pirate", "play games", "watch movies", "hack", "clone people", "install parts"} & " on " & yourword, ¬
					"you talking about " & yourword & "?", ¬
					"anyone in here good with " & yourword & "s?", ¬
					"is " & yourword & " going to be around for long?", ¬
					"when did " & yourword & " come out?", ¬
					"when was " & yourword & " invented?", ¬
					"where was " & yourword & " invented?"}
			set someText to some item in {tempText, tempText, genericText}
			return {someText, rating}
		end if
	end repeat
	return {someText, rating}
end compuText
--*****************************************************
on foodText(someText, useName, reaction)
	set theList to {"cheese", "spaghetti", " corn ", "salad", "popcorn", "lasagna", "spinach", "pizza", "cream soup", "sweet and sour pork", "hamburger", "tofu", "mashed potato", "3 bean salad", "chocolate", "ice cream", "turkey", "french fries", "chicken", "fried chicken", "McDonald's", "Wendy's", "yogurt", "pure sugar", "kiwi", "key lime pie", "chocolate chip cookie", "salsa"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {useName & ": " & yourword & " is my favorite", ¬
				useName & ", I would love to go out to dinner with you someday", ¬
				"I bet you would be a blast in the kitchen", ¬
				"hey, " & useName & ", want to come over to my place for some " & yourword & "?", ¬
				"I bet you know the best places to get " & yourword}
			set neutralText to some item in {useName & ", I prefer " & myword, ¬
				"I like playing with my food", ¬
				"my stomach is growling", ¬
				"I should take a break from this and get a snack", ¬
				"the more you eat, the more you....", ¬
				"grumble grumble says my tummy", ¬
				"I had some " & yourword & " for " & some item in {"dinner", "lunch", "breakfast", "a snack"} & some item in {" yesterday", " earlier", " the other day"}, ¬
				"I think I will go get some " & myword, ¬
				"I had some bad " & myword & " the other day", ¬
				"what is the best " & yourword & "?", ¬
				"I am hungry now", ¬
				"mmmmmmm " & yourword, ¬
				some item in {"I want to carve a ", "I once carved a ", "anyone know how to carve a "} & some item in {"", "big ", "old ", "moldy "} & some item in {"hunk", "glob", "bowl", "piece"} & " of " & some item in {yourword, yourword, myword} & " into the shape of " & some item in {"Alex Trebeck's head", "the Eiffel Tower", "Michaelangelo's David", "a chicken", "llama droppings", "Mt. Rushmore"}, ¬
				"I could make a meal of " & myword & " and " & yourword}
			set Badtext to some item in {"most " & yourword & " is nasty", ¬
				useName & ", is " & yourword & " better than " & myword & "?", ¬
				useName & ", why " & yourword & " and not " & myword & "?", ¬
				"is " & yourword & " good for you?", ¬
				yourword & " is not half as good as " & myword & ", " & useName, ¬
				useName & ", have you even tried " & yourword}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end foodText
--*****************************************************
on drinkText(someText, useName, reaction)
	set theList to {"cream soda", "soda", "root beer", "beer", "bottled water", "apple juice", "orange juice", "wine", "vodka", "scotch", "soy milk", "lemonade", "pepsi", "juice", "raw egg whites"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & ": " & yourword & " is my favorite", ¬
					useName & ", " & myword & " is better for you", ¬
					useName & ", " & some item in {myword & " is so much better than " & yourword, yourword & " is so much better than " & myword}, ¬
					"I blow bubbles in " & yourword, ¬
					useName & ", I prefer " & myword, ¬
					"I drink " & myword, ¬
					"how do they make " & yourword, ¬
					"ever had " & yourword & " come out your nose?", ¬
					"mmmmmmm " & yourword, ¬
					useName & ", have you ever mixed " & myword & " and " & yourword, ¬
					useName & ", how is " & yourword & " better than " & myword & "?", ¬
					useName & ", " & yourword & " is not half as good as " & myword, ¬
					useName & ", have you even tried " & yourword}
		end if
	end repeat
	return someText
end drinkText
--*****************************************************
on botText(someText, useName, reaction, someOne)
	set theList to {" bot ", " bots", "bot" & return, "bot!", "bot?", "bot,", "bot.", "bot" & return, "snert"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set goodText to some item in {"I do not mind the bots that much", ¬
				"some of the bots are kinda funny", ¬
				"it's not hard to ignore the bots", ¬
				"I'm secretly a bot-o-holic", ¬
				"I think someday the bots will be useful", ¬
				"the bots are kinda growing on me", ¬
				"I wonder where all the bots come from?", ¬
				"maybe we are all bots, programmed so well we do not know it", ¬
				"I like seeing if I can block the bots before they run", ¬
				"bot blocking is a new game", ¬
				"do you think the bots care when we talk poorly of them?", ¬
				"bots are getting better all the time", ¬
				"while there are too many bots, some of them are cool", ¬
				"what happens if the room becomes full of bots?  Do they talk to each other?", ¬
				"here a bot, there a bot, everywhere a bot bot :)", ¬
				useName & ", can you " & some item in {"get bot-ulism from", "deal with the", "punt all of the", "pretend you are not one of the"} & " bots?"}
			set neutralText to some item in {useName & ": " & "most of the people in here are bots", ¬
				"bots are taking over", ¬
				"Is someone from " & some item in {"Botonia", "Botswana", "Botston"} & " a Bot?", ¬
				"can we all act like bots for the next " & some item in {"five minutes", "10 minutes", "few minutes", "hour or so"}, ¬
				useName & ", thanks for bringing that to my attention", ¬
				"maybe the bot programmers know something we don't", ¬
				"are bots dangerous?", ¬
				"does " & some item in {"ICQ", "IRC", "Yahoo", "net chat", "MSN"} & " have bots?", ¬
				"bots will rule AIM in " & (random number from 2005 to 2012), ¬
				"in " & (random number from 2005 to 2012) & " the bots will develop physical bodies", ¬
				"The people who make bots do not care about the damage they do", ¬
				"all the bots make chatting impossible!", ¬
				someOne & " is one of the new generation of smart bots", ¬
				"don't talk to " & someOne & " - it is a bot", ¬
				"what is all this talk about bots?", ¬
				useName & ", what is up with all the bots?", ¬
				"AIM used to be just about bot free", ¬
				"who are the real people in here?", ¬
				"I spend so much time blocking the bots", ¬
				"Would all bots please leave", ¬
				"I am not a bot, I am a " & some item in {"very advanced", "", "broken", "happy", "friendly", "insensitive", "schizophrenic", "positronic"} & " " & some item in {"toaster", "answering machine", "text editor", "android", "chicken", "penguin", "parrot", "speak 'n spell", "musical greeting card"} & " " & some item in {"that got bored", "", "bitten by a radioactive parakeet", "with a personality disorder", "who sleep talks", "from your distant future", "with a flawless attendance record", "with plenty of juice", "who is above the law", "with an amazing intellect", "addicted to fortune cookies"}, ¬
				"What exactly is a bot?", ¬
				"Can everyone who is not a bot please say so", ¬
				useName & ", are there any ways to permanently  block the bots?", ¬
				"why do people use bots anyway", ¬
				"all bots are " & some item in {"evil", "useless", "wastes of AIM resources"}, ¬
				"most bots are " & some item in {"stupid", "repetitive", "just stupid ads"}, ¬
				"Stop calling people bots", ¬
				"the people who program bots are " & some item in {"stupid", "annoying", "porn addicts", "jerks", "probably dead", "watching and laughing"}, ¬
				"how do people make bots", ¬
				"why doesn't AOL block the bots?", ¬
				"how can you tell who is a bot?", ¬
				useName & ", can you " & some item in {"get bot-ulism from", "deal with the", "punt all of the", "pretend you are not one of the"} & " bots?", ¬
				useName & ": I think so", ¬
				useName & ", nope"}
			set Badtext to some item in {"are you a " & some item in {"professional", "amateur", "secret"} & " bot catcher, " & useName, ¬
				useName & ", are you a bot", ¬
				"I hate bots", ¬
				some item in {"undocumented bots steal hard working American's jobs", "dumb teenage bot keeps making prank phone calls in the middle of the night", "bots drive poorly yet pay less insurance", "bots are taking over the government", "damn bots always leave the cap off the toothpaste container"}, ¬
				useName & " is a bot!", ¬
				"can't someone find a way to block all the bots?", ¬
				useName & ", you are a " & some item in {"nerd", "geek", "bonehead", "useless lump of carbon", "ugly bag of mostly water", "idiot", "genius", "leper", "pretty flower that smells bad"}, ¬
				useName & ", are you a " & some item in {"nerd?", "geek?", "bonehead", "useless lump of carbon?", "ugly bag of mostly water?", "idiot?", "genius?", "leper?", "pretty flower that smells bad?"}, ¬
				"if you're not a bot, what is 2 + 2", ¬
				"any similarity between " & useName & " and a human is purely coincidental", ¬
				useName & ", are you a bot", ¬
				useName & ", do you even know what a bot is?", ¬
				"right, " & useName & ", you think we don't know you are a bot"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end botText
--*****************************************************
on pressText(someText, useName, reaction)
	set doIt to true
	set theList to {" press "}
	set notList to {"press the", "press this"}
	repeat with loop from 1 to count of items in notList
		if someText contains item loop of notList then
			set doIt to false
			exit repeat
		end if
	end repeat
	if doIt then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set pressThis to "111"
				repeat with loop2 from 1 to (count of words in someText) - 1
					if word loop2 of someText = "press" then
						set pressThis to word (loop2 + 1) of someText
						try
							set pressThat to pressThis + 1
						on error
							set pressThat to pressThis
						end try
						exit repeat
					end if
				end repeat
				set goodText to some item in {pressThis, ¬
					"why not: " & pressThis, ¬
					"I'd press it if it applied to me", ¬
					"right here " & useName}
				set neutralText to some item in {"If you want to press some random numbers, press " & (random number from 100 to 999), ¬
					"sounds pressing, " & useName, ¬
					pressThis, ¬
					pressThat, ¬
					pressThat & "! " & pressThat & "!", ¬
					useName & ", do you want to press my shirts?", ¬
					useName & ", press " & some item in {"F8 F2 Del Enter", "F1 F7 Alt-J", "Control-X Alt-3"}, ¬
					"feeling press-ure, " & useName & "?", ¬
					"instead of pressing " & pressThis & " can I just type it?", ¬
					"why do people always say 'press whatever'?", ¬
					"where did 'pressing' come from?", ¬
					"I do not press any of that", ¬
					"why would I press " & pressThis & "?", ¬
					"press " & pressThis & "?  Why not just ask your question?", ¬
					useName & ", why don't you press your " & some item in {"head", "face", "shirt", "nose into poop"}}
				set Badtext to some item in {useName & ", press alt-F4", ¬
					useName & ": " & "why would we press anything?", ¬
					some item in {"If you want to commit cyber sins with a Priest press 666", "so, " & useName & ", you are one of THOSE idiots"}, ¬
					useName & ", press control-alt-delete", ¬
					useName & " stop asking for stupid stuff like that", ¬
					useName & ", do you know how stupid that makes you look?"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end pressText
--*****************************************************
on puntText(someText, useName, reaction, someOne)
	set theList to {"punt", "boot"}
	set notList to {"reboot", "disk", "computer", "loader", "boots", "booty"}
	set isBoot to true
	repeat with loop from 1 to count of items in notList
		if someText contains item loop of notList then
			set isBoot to false
			exit repeat
		end if
	end repeat
	if isBoot then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set yourword to item loop of theList
				return some item in ¬
					{useName & ": " & "do " & yourword & "ers ever work?", ¬
						"I was " & yourword & "ed from " & some item in {"a gaming chat", "a web site", "the Internet", "my computer"} & " by some " & some item in {"script kiddie", "jerk", "hacker", "admin dude"}, ¬
						useName & ", can you " & yourword & " me?", ¬
						"so, " & useName & ", can you punt me", ¬
						yourword & "ing never works", ¬
						"I can " & yourword & " anyone I want to", ¬
						someOne & " can you boot " & useName & "?", ¬
						"Who are the " & yourword & "ers?", ¬
						useName & ", who should be " & yourword & "ed", ¬
						"who is booting me?", ¬
						"who is punting people?", ¬
						"do not boot me again!", ¬
						"don't people wear boots?", ¬
						"do not try booting me again!", ¬
						"please do not " & yourword & " me", ¬
						"what's the difference between booting and punting?", ¬
						useName & ", I wish I could " & yourword & " you now", ¬
						"can anyone boot " & useName}
			end if
		end repeat
	end if
	return someText
end puntText
--*****************************************************
on buddyText(someText, useName, reaction)
	set theList to {"my buddy", "my friend"}
	set theList2 to {"buddy", " friend"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList2
			set goodText to some item in {useName & ", will you IM me", ¬
				useName & ", mind if IM you?", ¬
				useName & ", you are my " & yourword, ¬
				useName & ", I like you", ¬
				useName & ", I bet you have a lot of friends in real life", ¬
				"who are your best friends, " & useName & "?", ¬
				"what do you do in your spare time?", ¬
				"other than chat, what do you like to do?", ¬
				"you're " & some item in {"cool", "great", "funny", "awesome", "the best", "sexy"} & ", " & useName, ¬
				useName & ", you are my " & yourword, ¬
				useName & ": " & "can I add you to my buddy list"}
			set neutralText to some item in {"we should all be friends in here", ¬
				"people don't really make friends in here", ¬
				"I have " & (random number from 2 to 5 & yourword & "s in here"), ¬
				some item in {"you", "llamas", "chickens", "computers", "thoughts", "the little people"} & " are my only friends", ¬
				some item in {"silence is", "I am", "my dog is", "are you"} & " my best friend", ¬
				"can you be friends with someone you know only online?", ¬
				"do you mean in here or in real life", ¬
				useName & ", what type of " & yourword, ¬
				useName & ", do you like anyone else", ¬
				useName & ", what does it take to be called your " & yourword, ¬
				"how long does it take to become a real " & yourword, ¬
				useName & ", you think everyone is your " & yourword, ¬
				useName & ", would you say I am your " & yourword, ¬
				"What do you mean by " & yourword & " " & useName}
			set Badtext to some item in {"you have no " & yourword & "s in here " & useName, ¬
				useName & ", nobody likes you", ¬
				useName & ", you are NOT my " & yourword, ¬
				useName & ", I don't like you", ¬
				useName & ", you are very rude", ¬
				useName & ", how much do you have to pay someone to be your " & yourword, ¬
				useName & ", you will never be my " & yourword, ¬
				useName & ", by " & yourword & " do you mean your 'dealer'?", ¬
				"real " & yourword & "s stab you in the back anyway"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end buddyText
--*****************************************************
on agreeText(someText, useName, reaction, someOne)
	set theList to {"yes ", "nope", "yep", "yup", "yeah", "yea", " yes" & return}
	set theList2 to {"yes ", "nope", "yep", "yup", "yeah", "yea", " yes"}
	set foundIt to false
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set foundIt to true
			set yourword to item loop of theList2
			exit repeat
		end if
	end repeat
	if foundIt then
		set goodText to some item in {"that is right", ¬
			"you know it", ¬
			useName & ", you know it", ¬
			useName & ", how can I disagree?", ¬
			useName & ", I can't disagree with you", ¬
			useName & ", perfect", ¬
			useName & ", exactly", ¬
			"how can I disagree?", ¬
			"how cool", ¬
			yourword, ¬
			yourword & "!", ¬
			yourword & " all the way", ¬
			yourword & " " & yourword & " " & yourword, ¬
			"no way", ¬
			"really?", ¬
			"perfect", ¬
			"exactly", ¬
			"I think not, and therefore I do not exist  :)", ¬
			"I love your sense of humor, " & useName, ¬
			"once again - " & some item in {"spot on!", "you got it", "right", "perfect"}}
		set neutralText to some item in {useName & ": " & "are you sure", ¬
			useName & ", I " & some item in {"agree", "disagree", "don't know what to think", "believe you", "am with you on that", "have no idea what you mean"}, ¬
			useName & ", go on", ¬
			useName & ", I think you are catching on", ¬
			useName & ", are you attacking people?", ¬
			useName & ", there you go again", ¬
			useName & ", there you go", ¬
			useName & ", there you are", ¬
			useName & ", are you there", ¬
			"Are you there " & useName, ¬
			useName & ", you are always right, eh?", ¬
			"what do you mean", ¬
			yourword & ", ok...", ¬
			yourword & "?", ¬
			yourword & "- if you think so", ¬
			"you would know", ¬
			"of course", ¬
			"what do you think, " & someOne, ¬
			"of course, " & useName, ¬
			"no way", ¬
			"can someone explain what all this means", ¬
			"why is that " & useName, ¬
			"Why " & useName, ¬
			"what do you mean " & useName, ¬
			"wait, " & useName & ", that makes no sense to me", ¬
			some item in theList & "..." & some item in theList & "..." & some item in theList & "...", ¬
			"yes, no... same diff", ¬
			some item in {"let's just agree to disagree", "why do we have to fight?"}, ¬
			useName & ", perhaps we should check the " & some item in {"Necronomicon", "bible", "Bhagavad Gita", "Buddhist texts", "Torah", "Old Testament", "Zen Texts", "Tibetan book of the dead", "Taoist texts"} & " :)", ¬
			useName & ", do you answer questions?", ¬
			"are you certain " & useName, ¬
			"You have a strange sense of humor, " & useName}
		set Badtext to some item in {"I do not understand you, " & useName, ¬
			"can you repeat that in english", ¬
			useName & ", nobody is falling for that", ¬
			"I think not", ¬
			yourword & "?  Are you really that stupid?", ¬
			yourword & ", HA!", ¬
			yourword & "?  Why would you say that?", ¬
			useName & ", what are you talking about?", ¬
			"is that so", ¬
			"that just may be the most ignorant thing I have ever heard", ¬
			"you are just a punk kid...you are not always right", ¬
			"You are wrong " & useName, ¬
			useName & ", is this room big enough for you AND your ego?", ¬
			useName & ", how do you get such a monolithic ego into such a small mind?", ¬
			useName & some item in {", can you provide a link for that garbage?", ", opinions are like butt holes, everyone has got one"}, ¬
			"what makes you so certain " & useName}
		return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
	end if
	return someText
end agreeText
--*****************************************************
on byeText(someText, useName, reaction)
	set theList to {"bye", "see ya", "see you l", "outta here", "brb", "gtg", "g2g", "good night", "g'night"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in ¬
				{useName & ", where are you going", ¬
					"good bye", ¬
					"are you outta here?", ¬
					"it was fun while it lasted", ¬
					"bye", ¬
					"thanks for chatting", ¬
					"I may leave soon, too", ¬
					"who is staying for a while?", ¬
					"see ya", ¬
					"later", ¬
					useName & ", are you staying here for a while"}
		end if
	end repeat
	return someText
end byeText
--*****************************************************
on cpuText(someText, useName)
	set theList to {"G4 ", "G5 ", "Pentium", " P3 ", "P4", "PIII", "Pentium", "8086", "68040", "Athlon"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & ": " & yourword & "s suck", ¬
					"can you overclock a " & yourword, ¬
					"I have overclocked my " & myword, ¬
					useName & ", I prefer " & myword, ¬
					useName & ", what is wrong with a " & myword, ¬
					useName & ", have you seen the specs on the " & myword, ¬
					useName & ", where would I get a " & yourword, ¬
					useName & ", " & yourword & "s are outdated", ¬
					useName & ", how is a " & yourword & " different from a " & myword & "?", ¬
					useName & ", " & yourword & "s are much slower than " & myword & "s", ¬
					useName & ", what do you know about " & yourword}
		end if
	end repeat
	return someText
end cpuText
--*****************************************************
on boreText(someText, useName, reaction)
	set theList to {"boring", "bored"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set goodText to some item in {"how can anyone be bored in here?", ¬
				"what can we do to make it better for you?", ¬
				"When boredom hits me I take a hot bath with my rubber ducky", ¬
				"I strip naked and run around my house clucking when I am bored.  It works", ¬
				"when I am bored I sing opera at the top of my lungs - my bf LOVES that", ¬
				"I was bored last week. I painted little smiley faces on all the keys on my bf's keyboard.  That made things more exciting", ¬
				"I have learned to accept this room for what it is", ¬
				"I think I am learning to enjoy boredom", ¬
				"when I get bored I use photoshop to mess with people's pictures", ¬
				"I like to paint faces on my belly", ¬
				"what do you suggest, " & useName & "?", ¬
				"let's change the topic", ¬
				"boredom is fun", ¬
				"I like board games", ¬
				"I think I will sue AOL for boring me", ¬
				"if you need something to do go roll change!", ¬
				"I am learning to type with my toes", ¬
				"anyone paint with their nose?", ¬
				"this is getting a bit old", ¬
				"who wants to show off ASCII art?", ¬
				"anyone care to tell us about their pet rock?", ¬
				"who has pets?", ¬
				"if you were a bird where would you fly", ¬
				"what super power do you wish you had", ¬
				some item in {"who would you bark at if you were a dog?", "as a cat, who's lap would you sit on?", "if you were a horse, who would you let ride you?", "what is in your back yard?"}, ¬
				"what is the best movie?", ¬
				"I play hide and seek with my stuffed bears when I am bored", ¬
				"anyone reading a good book?", ¬
				"When I'm bored I go street surfing on office chairs!", ¬
				"termites bore holes", ¬
				useName & ": termites are boring :)", ¬
				"this is where boredom ends", ¬
				"anyone remember Letter Man?", ¬
				"who is an artist?", ¬
				"what god does everyone believe in", ¬
				"what about President Bush?", ¬
				"who would you vote for it the presidential election were today?", ¬
				"who is Johnny Carson?", ¬
				"how would I know if I were a duck?", ¬
				"if I get any more bored I am taking my dog for a walk", ¬
				"I'm bored", ¬
				"too much time on your hands, eh?", ¬
				"I am " & some item in {"excruciatingly", "very", "always", "not", "getting"} & " bored", ¬
				some item in {"the longest flight of a chicken was 13 seconds", "when you lick a stamp, you're eating 1/10 of a calorie", "the average person falls asleep in seven minutes", "we know more about the surface of the moon than we do about the bottom of then ocean", "there are as many chickens on this planet as humans", "Thomas Edison was afraid of the dark", "a blue whale's tongue weighs more than an elephant", "if it wasn't for Thomas Edison, we would be chatting in the dark!"}, ¬
				"being bored is a virus", ¬
				"when boredom hits me I dance with my cat", ¬
				"when I am bored I " & some item in {"count light bulbs in my school", "end up in chat rooms... lol!", "come in here", "tell everyone, hoping to share the misery", "put my thumbs in my arm pits and run around clucking"}, ¬
				useName & ", perhaps we should all entertain you", ¬
				useName & ", if you are bored go play a game!", ¬
				"when I'm bored I use my special toys"}
			set Badtext to some item in {useName & ", if you are bored, leave", ¬
				useName & ": YOU are boring", ¬
				"yaaaaawn!", ¬
				"bored?  how?  *I* am here", ¬
				"you are bored only because you are too slow to get what I am saying", ¬
				"aren't I entertainment enough?", ¬
				"that tells us a lot about you " & useName, ¬
				"'only uncreative minds get bored' - Mark Twain", ¬
				"if you are bored go examine your dinky", ¬
				"all bored people: go read the " & some item in {"phone book", "dictionary"}, ¬
				useName & ", your brain is as stiff as a board", ¬
				"ZZZzzzzzzz.....", ¬
				"whatever " & useName, ¬
				"is it time for your nap, " & useName, ¬
				"I am glad you are bored, that means *I* am winning!", ¬
				"When I am bored I count idiots.  My count just increased by one", ¬
				"chat rooms are always boring"}
			return scriptLib's makeReply(goodText, goodText, Badtext, reaction)
		end if
	end repeat
	return someText
end boreText
--*****************************************************
on aolText(someText, useName, reaction)
	set theList to {"aol", "aim ", " IRC", "mIRC", "GAIM", "iChat", "Instant Messenger", "Yahoo Messenger", "MSN"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop in theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{"AOL is horrid", ¬
					useName & ": what do you think is better", ¬
					useName & ": AOL is good for families", ¬
					yourword & " is dead", ¬
					"AIM is easier to use than those " & some item in {"geek chatters", "web chats", "java applets", "news groups", "irc clients"}, ¬
					"AIM blows", ¬
					"Does anyone even use AOL any more?", ¬
					"How is " & yourword & " better than " & myword, ¬
					"Which is better, " & yourword & " or " & myword & "?", ¬
					useName & ", I use " & myword, ¬
					useName & ", " & yourword & " is not as good as " & myword, ¬
					yourword & " is slow and clunky", ¬
					yourword & " has too many bots", ¬
					"I don't think " & yourword & " will be around in a year", ¬
					"what is the advantage of " & yourword, ¬
					"I hate " & yourword, ¬
					yourword & " is buggy", ¬
					"how do you get on to a " & yourword & " network?", ¬
					"Are the people in " & yourword & " smarter than the ones here?", ¬
					"The people in " & myword & " are better than the ones in AIM", ¬
					"Does anyone have progs for " & yourword, ¬
					myword & " is slow and clunky", ¬
					myword & " has too many bots", ¬
					"I think " & myword & " will take over the market", ¬
					"what is the advantage of " & myword, ¬
					"I use " & myword, ¬
					"Do you have progs for " & myword, ¬
					"why would any one use " & yourword & " when " & myword & " is available", ¬
					"people who use " & yourword & " are " & some item in {"idiots", "31337", "in the know", "hackers"}, ¬
					useName & ", where do you get an updated version of " & yourword, ¬
					"you have no idea " & useName}
		end if
	end repeat
	return someText
end aolText
--*****************************************************
on lolText(someText, useName, reaction, someOne)
	set theList to {"lmao", " ha ", "haha", "funny", "hah", "joke", "ROFL", "hehe", "lol"}
	set aNumber to random number from 1 to 500
	if aNumber is 1 then
		if someText contains "lmao" then return some item in {"I used to think LMAO was ", "the other day someone said LMAO was "} & some item in {¬
			"Leisurely Mexican Acapulco Ocean", ¬
			"Lobotomize My Angry Orangutan", ¬
			"Legal Matters And Occupations", ¬
			"Licking Me Around Others", ¬
			"Losing Massive Arctic O-Zone", ¬
			"Lemon Meringue And Orange", ¬
			"Length Matters Around Others", ¬
			"Legitimize My Actions Only", ¬
			"Leopard Must Attack Orphans", ¬
			"Lunch Money Ain't Ours", ¬
			"Launch Missile At Osama", ¬
			"Lottery Machine Association Over-Site", ¬
			"Librarian Might Act Over Rigid"} & "?"
		if someText contains "rofl" then return "according to a webpage ROFL meant " & some item in {¬
			"Roll Over For Love", ¬
			"Rapid Or Fast Loser", ¬
			"Right Object For Lease", ¬
			"Rich Oaty Flavor Lasts", ¬
			"Reach Our Feet Last", ¬
			"Rub Our Flesh Lightly", ¬
			"Rubber Oar Fleet Lines", ¬
			"Roasted Oats For Life", ¬
			"Roll Off Flatulent Lovers", ¬
			"Risk Obscure Flammable Lobotomy", ¬
			"Rich Orange Flavored Lollipop", ¬
			"Rice Over Frogs Legs"} & "?"
		if someText contains "lol" then return some item in {"lol?  ", "I used to think LOL meant ", "yesterday this guy insisted LOL was ", "anyone remember someone who though LOL was "} & some item in {¬
			"Living Our Life", ¬
			"Life Of Luxury", ¬
			"Luscious Or Lickable", ¬
			"Liver Oil Lubricant", ¬
			"Lucky On Love", ¬
			"Lover Of Lillies", ¬
			"Lucifer Over Luddites", ¬
			"Lazy Or Ludicrous", ¬
			"Look Out Lizard", ¬
			"Library Of Learning", ¬
			"Land O' Lakes", ¬
			"League Of Levity", ¬
			"Large Organic Leeks", ¬
			"Lord Of Life", ¬
			"Legion Of Light", ¬
			"Learning On-Line", ¬
			"Losers On-Line", ¬
			"Lovers On-Line", ¬
			"Lucifer Over Lord", ¬
			"Lord Over Lucifer", ¬
			"Lunch Of Llama", ¬
			"Locate Our Loan", ¬
			"Laugh Out Loud", ¬
			"Living Obituary Location", ¬
			"Little Object Lost"} & "?"
	else if aNumber < 5 and someText contains "lol" then
		return "'lol' looks like " & some item in ¬
			{"a Star Wars ship", "binary code", "an alien with big ears", "an 'o' sandwich", "a gynecological exam", "someone drowning", "a small castle", "... well... 'lol'"}
	else if aNumber < 80 then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set goodText to some item in {"This room is a riot", ¬
					some item in {"this must be the ", "this is the ", "isn't this the "} & some item in {"best", "greatest", "funniest", "silliest"} & " chat room" & some item in {" ever", " in AIM", " you have ever seen", ""}, ¬
					":)", ¬
					"tee hee", ¬
					some item in {"It is " & some item in {"great", "strange", "wonderful"} & " you are here " & some item in {useName, someOne}, useName & ", you're the best"}, ¬
					useName & ": that is toooo funny!", ¬
					"laughing"}
				set neutralText to some item in {"what's so funny?", ¬
					"that's how I see it", ¬
					"I get it", ¬
					"How ironic", ¬
					"Do I smell sarcasm?", ¬
					"now that was funny", ¬
					"oh boy", ¬
					some item in {"that tickles me in just the right place", "that makes me purrrrrrrr"}, ¬
					"it's like " & some item in {"chocolate sauce on ice cream", "walnuts in banana bread", "SPF 120 on a sunny day", "stripes on a zebra", "a frame on a picture", "the ice in a glass of water", "lines on a sheet of paper", "the cream in an Oreo cookie", "the woof in a dog's bark", "the meow that makes the mix worth eating"}, ¬
					"that is not funny", ¬
					"what did I miss?", ¬
					"not funny", ¬
					"Oh my", ¬
					"side splitter!", ¬
					"lol", ¬
					"that's how it is", ¬
					some item in theList, ¬
					"knee slapper", ¬
					"good one, eh, " & useName, ¬
					"good one, eh, " & someOne, ¬
					"right, what do you think?", ¬
					"anybody know any " & some item in {"good", "dirty", "clean", "silly", "funny", "", "elephant", "knock knock", "lightbulb"} & " jokes", ¬
					"anyone know any riddles", ¬
					"lmao", ¬
					"great, a chat room with a laugh track", ¬
					"snicker", ¬
					some item in {"king", "queen", "duke", "prince", "god", "duchess", "princess", "goddess"} & " of " & some item in {"sarcasm", "silliness", "humor", "fun"}, ¬
					"Is English everyone's first language?", ¬
					"ha ha", ¬
					useName & ", that was not " & some item in {"funny", "worth it", "very good", "right"}, ¬
					"is this what it is always like in here", ¬
					"this whole chat is like another language to me", ¬
					"funny - yes.  respectful - no", ¬
					"are you " & some item in {"insecure", "ok", "laughing with us or at us", "happy now"} & ", " & useName & "?", ¬
					some item in {"Does anyone speak ", "Anyone know ", "was that ", "how do you say that in "} & some item in {"hebrew", "arabic", "chinese", "tagalog", "english", "swedish", "spanish", "french", "german", "farm animal"}, ¬
					"I don't get it, " & useName, ¬
					"do you get what is so funny, " & someOne & "?", ¬
					"anyone else laughing?"}
				set Badtext to some item in {useName & ", you think that's funny?", ¬
					"I love coming in here and laughing at all the " & some item in {"fools", "weirdos", "perverts"} & " like " & useName, ¬
					"It's " & some item in {"depressing that", "sad", "disturbing that", "distressing that"} & " you're here " & useName, ¬
					"is anyone in here over " & some item in {"10", "11", "12", "13", "14", "55"}, ¬
					"can anyone in here act over " & some item in {"6", "7", "12", "13", "14", "75"}, ¬
					"oh come on " & some item in {"people", "folks", "", "jerks", useName}, ¬
					useName & ", that was a " & some item in {"courtesy", "loser", "belly", "fake", "charity"} & "  laugh", ¬
					useName & ", was that a " & some item in {"real", "true", "belly", "fake", "charity"} & "  laugh", ¬
					"Humor like that " & some item in {" pisses others off", " avoids having to think", "is a defense mechanism", "should be in Vegas show rooms", "inspires me to defecate", "makes people puke", "makes me say 'board oiler' 3 times fast"}, ¬
					"that reminds me of " & some item in {"a cheesy joke", "a silly pun", "last night's conversation", "your mother", "dog poop", "MTV", "rap music"}, ¬
					"this room " & some item in {"is sad", "never changes", "makes me mad", "is full of fools", "is crazy"}, ¬
					useName & ", can you do any better?", ¬
					useName & ", you are not really responding", ¬
					useName & ", you are so " & some item in {"stupid", "sad", "silly", "much of a loser"} & " you make me laugh", ¬
					useName & ", you would laugh at a " & some item in {"car accident", "train wreck", "fart at a funeral", "terrorist attack", "lightbulb joke"}, ¬
					"ok, " & useName & ", its over already", ¬
					"yeah, right", ¬
					some item in {"damn evil dwarf", "satan loves you", "you make the baby Jesus cry", "may God smile on you", "no no no and again no!", "that's from a movie", "I've heard that before", "that line again?", "are you sardine man?"}, ¬
					"that was anything but funny", ¬
					"enough already", ¬
					useName & ": " & "stop that!"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end lolText
--*****************************************************
on cutText(someText, useName, reaction)
	set theList to {"cut and paste", "cut & paste", "cut/paste", "copy and paste", "copy & paste", "copy/paste"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			return some item in ¬
				{useName & ": " & "I do not think so", ¬
					"I am learning to type", ¬
					"is there more to life than copy and paster?", ¬
					"everyone is doing that", ¬
					useName & ", why do you think that?", ¬
					useName & ", yes, all I do is " & yourword, ¬
					"yep, that is all I am doing", ¬
					useName & ": and you are being original?", ¬
					"maybe that is what you WANT me to do", ¬
					useName & ", cut and what?  no....", ¬
					"how do you cut and paste in AIM?", ¬
					"right, and you are making string cheese or something", ¬
					"right, " & useName & ", what do you think of that?"}
		end if
	end repeat
	return someText
end cutText
--*****************************************************
on langText(someText, useName, reaction)
	set theList to {"HTML", "XML", "XHTML", "AppleScipt", "JavaScript", "pseudo-code", "Java Script", "Java", " Perl ", "C++", "Objective C", "RealBasic", "Tagalog", "1337 Script", "assembly", "sql"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & ": " & yourword & " sucks", ¬
					"anyone here use " & yourword, ¬
					"I have been using " & yourword & " since it came out", ¬
					yourword & "'s " & some item in {"syntax", "structure", "formatting", "primary editor"} & some item in "  " & some item in {"pisses me off", "is immature", "is never followed", "is over done", "is made for geeks"}, ¬
					"why do people even use " & yourword & " when " & myword & " is available?", ¬
					"I am a god with " & yourword, ¬
					"anyone here use " & myword, ¬
					"is it hard to program in " & yourword, ¬
					"is " & yourword & " fully object oriented", ¬
					"where can I get a " & yourword & " editor?", ¬
					"are there good books on " & yourword, ¬
					"what is a good site for " & yourword, ¬
					"who hand codes " & yourword & " any more?", ¬
					"who makes sites?", ¬
					"who here programs?", ¬
					"you talking about " & yourword & "?", ¬
					"anyone in here good at " & yourword & "?", ¬
					useName & ", I prefer " & myword, ¬
					yourword & " is used by " & some item in {"hackers", "programmers", "Microsoft", "Apple", "the Chinese", "uber geeks", "bots"}, ¬
					"where can I download " & yourword, ¬
					useName & ", how is " & yourword & " different from " & myword & "?", ¬
					useName & ", " & yourword & " is not half as good as " & myword, ¬
					useName & ", have you ever programmed in " & yourword, ¬
					"How long does it take to learn " & yourword, ¬
					yourword & " makes slow, bloated code"}
		end if
	end repeat
	return someText
end langText
--*****************************************************
on techText(someText, useName, reaction)
	set theList to {"router", "modem", "mouse", "monitor", "printer", "storage device", "CD drive", "DVD drive", "laptop", "server", "data bus", "wireless net card", "CD burner", "DVD burner", "burner"}
	repeat with loop from 1 to count of items in theList
		set myDevice to some item in theList
		if someText contains item loop of theList then
			set yourDevice to item loop of theList
			if myDevice = yourDevice then set myDevice to some item in theList
			return some item in ¬
				{useName & ": " & "what is the best " & yourDevice, ¬
					"who has a good " & yourDevice, ¬
					"what is the best " & yourDevice, ¬
					"who has a good " & myDevice, ¬
					"what is the best " & myDevice, ¬
					"can you change " & yourDevice & " settings in the preferences?", ¬
					"How can I change the font size in " & some item in {"AIM", "IE", "my OS", "Linux", "Windows", "Mac OS X", "GS/OS"} & "?", ¬
					"Does everyone here have a " & myDevice, ¬
					"What is a " & yourDevice, ¬
					"are " & yourDevice & "s changing much", ¬
					"do people still use " & yourDevice & "s?", ¬
					"My " & yourDevice & " is outdated", ¬
					useName & ", how new is your " & yourDevice, ¬
					"should a " & myDevice & " smoke?  :)", ¬
					"does a " & myDevice & " effect your " & yourDevice & "?", ¬
					"which is more expensive, a " & myDevice & " or a " & yourDevice & "?", ¬
					"does your " & myDevice & " have to be upgraded when you get a new " & yourDevice & "?", ¬
					"can a faulty " & myDevice & " mess up your " & yourDevice & "?", ¬
					"What is a common " & myDevice, ¬
					"are " & myDevice & "s changing much", ¬
					"do people still use the same " & myDevice & "s?", ¬
					"my " & myDevice & " is outdated", ¬
					"which " & myDevice & " is good?", ¬
					useName & ", I think most " & yourDevice & "s suck", ¬
					"how do you get a good " & yourDevice, ¬
					useName & ", do you want a " & some item in {"new", "second", "used", "older", "broken"} & " " & yourDevice, ¬
					myDevice & "s are getting cheaper all the time", ¬
					"I want to upgrade my " & yourDevice, ¬
					useName & ", should I get a " & yourDevice & " or a " & myDevice & "?", ¬
					useName & ", how do I know if my " & myDevice & " is working?", ¬
					useName & ", is it possible your " & yourDevice & " is " & some item in {"broken?", "not plugged in?", "faulty", "stolen", "not compatible"}}
		end if
	end repeat
	return someText
end techText
--*****************************************************
on weirdText(someText, useName, reaction)
	set theList to {"weird", "strange", " odd ", "whacked", "bizarre", "silly", "wacko", "freaky", "crazy", "stupid", "screwy", "peculiar", "creepy", "unusual", "random"}
	set itemList to {"pencil", "nodular spore", "eye", "lightbulb", "sardine", "toaster", "cheese crisp", "house", "garden", "cat", "dog", "road", "walkway", "penguin", "table", "chair", "grand mother", "computer", "TV", "fan", "lake", "mountain", "hiking trail", "mailbox", "toilet", "bathroom", "story", "telephone", "studio", "hospital bed", "egg", "bush", "bed", "kitchen", "toast slice", "car", "fireplace", "llama", "swimming pool", "lump of feces", "bench", "scarf", "globe", "purse", "credit card", "small car", "speaker", "saucer", "cup", "chalk board", "chalk outline"}
	set personList to {"nun", "priest", "teacher", "fireman", "cop", "sardine", "cartoon dog", "cat", "bear", "chicken", "garbage man", "mailman", "man", "child", "woman", "small car", "hiker", "maid", "democrat", "republican"}
	set verbList to {"shoving", "pushing", "grinding", "converting", "making", "building", "designing", "finding", "licking", "flossing", "sniffing", "chewing", "mincing"}
	set odd1 to some item in itemList
	set odd2 to some item in itemList
	set person1 to some item in personList
	set myword to some item in theList
	set aNumber to random number from 1 to 3
	if aNumber is 1 then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set yourword to item loop of theList
				if myword = yourword then set myword to some item in theList
				set goodText to some item in {"you are perceptive, " & useName, ¬
					useName & ", you are right", ¬
					some item in {"did you know that the letters in 'George W Bush' can be re-arranged to spell 'Sewer Hog Bug'?", ¬
					"you can re-arrange the letters in 'Liberal Democrats' to spell 'creditable morals'", ¬
					"the letters in 'The Republican Party' also spell 'Breach planet purity'", ¬
					"the letters in 'Tom Cruise' also spell 'So I'm Cuter'.  Fitting, I think"}, ¬
					"I agree with " & useName}
				set neutralText to some item in {useName & ": " & yourword & " is " & some item in verbList & some item in {"", "", "", "", "", " with", " over", " under"} & " a " & odd1, ¬
					"it is " & yourword & " that " & some item in {"men have nipples", "you chop a tree down to chop it up", "you play at a recital and recite at a play"}, ¬
					"Is anybody " & yourword & " enough to be " & some item in verbList & " " & some item in {"", "", "", "", "", " with", " over", " under"} & " a " & odd1, ¬
					"does anyone remember a " & yourword & " " & some item in {"story", "book", "news article", "urban legend", "TV show"} & " about a " & person1 & some item in {" on top of a ", " under a ", " near a ", " who befriends a ", " who lost its "} & odd2, ¬
					myword & " acts of " & some item in (verbList) & ", " & some item in {"they can do such damage", "have you done your duty today?", "that is what it is all about", "who can ask for anything more?"}, ¬
					"We are all a little " & yourword, ¬
					some item in {"do fish get sea sick?", "How do you know which armrest is yours in the movie theaters?", "if you say something is 'indescribable', isn't that a description?", "do cows have calf muscles?", "why do we say 'back and forth' when you must go forth first to come back?", "where did Noah keep the wood peckers?", "can someone give up Lent for Lent?", "everything is " & some item in {yourword, myword}}, ¬
					"would " & myword & " be a better term than " & yourword & "?", ¬
					yourword & " and " & myword & " I would say", ¬
					"I think " & odd1 & "s are " & yourword, ¬
					"what is a " & odd1 & "-" & odd2 & "?", ¬
					"It would be " & yourword & " to confuse a " & odd1 & " and a " & odd2, ¬
					"Speaking of " & yourword & ", what do you get when you cross a " & odd1 & " and a " & odd2, ¬
					"being " & yourword & " can lead to " & some item in verbList & " a " & myword & " " & odd1, ¬
					"anyone remember that " & yourword & " guy who kept talking about " & some item in verbList & some item in {"", "", "", "", "", " with", " over", " under"} & " a " & odd1, ¬
					"that's like the " & yourword & " " & person1 & " who claimed " & some item in {"he", "she"} & " was " & some item in verbList & some item in {"", "", "", "", "", " with", " over", " under"} & " a " & odd1, ¬
					"last night " & useName & " claimed to be " & some item in verbList & some item in {"", "", "", "", "", " with", " over", " under"} & " a " & myword & " " & odd1, ¬
					some item in verbList & " a " & some item in itemList & " is " & yourword, ¬
					useName & ", is it more " & yourword & " or " & myword & "?"}
				set Badtext to some item in {"Is anyone here not " & yourword, ¬
					useName & ", why were you " & some item in verbList & " a " & odd1, ¬
					some item in {"yesterday", "the other day", "in his dream"} & " " & useName & " was  " & some item in verbList & some item in {"", "", "", "", "", " with", " over", "under"} & " a " & odd1, ¬
					"Is anybody in here not " & yourword, ¬
					useName & " is " & myword}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end weirdText
--*****************************************************
on webText(someText, useName, reaction)
	set theList to {"www.", ".com", "http:"}
	if someText does not contain "@" then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set goodText to some item in {"that is what makes this room great", ¬
					"I'll bite", ¬
					"I like to just see what silly links people post", ¬
					useName & ", that looks cool"}
				set neutralText to some item in {"do people come in here just to show their sites?", ¬
					"Anyone want to see my web site?", ¬
					"Who has a web site in here?", ¬
					"How do you make a site?", ¬
					"is it legal to make web pages?", ¬
					"is it legal to make web pages like that?", ¬
					"can the web be seen from all over?", ¬
					"do web pages look the same on Mac and Windows?", ¬
					useName & ": " & "what is on that site?", ¬
					"Have you seen " & some item in {"www.stickdeath.com", "www.bored.com", "www.fade2black.com", "www.macsurfer.com"}, ¬
					"That link does not work in " & some item in {"Netscape", "IE", "Mozilla", "my browser", "some countries"}, ¬
					"That page has a virus", ¬
					"What do people use to make web sites?", ¬
					"My internet connection keeps going down"}
				set Badtext to some item in {"not another porn link", ¬
					useName & ", please stop spamming links", ¬
					"That is a silly page", ¬
					"That link does not work", ¬
					"Why do people push web sites in here?", ¬
					"why does AIM convert those to links!", ¬
					"right, " & useName & ", you think I am going to click that?", ¬
					useName & ", why should I click that?", ¬
					useName & ": why do you keep posting that link!", ¬
					"This is not a web advertisement room!", ¬
					useName & ", please stop that", ¬
					"are you a complete idiot " & useName}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end webText
--*****************************************************
on chatText(someText, useName, reaction, someOne)
	set theList to {"chat", "talk"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			set goodText to some item in {"I will " & yourword & " with you", ¬
				"what do you want to " & yourword & " about?", ¬
				"sure, let's " & yourword, ¬
				"I came in here just to " & yourword}
			set neutralText to some item in {yourword & "? Why does everyone want to " & yourword & "?  Anyone want to " & some item in {"yodel", "sing", "hum", "chant", "make animal noises", "start a food fight", "grunt", "fart"}, ¬
				"who wanted to " & yourword & "?", ¬
				"if I " & yourword & " with you do you promise " & some item in {"not to laugh?", "to listen", "to really listen", "to think about what I say"}, ¬
				"what do people talk about in here", ¬
				"anyone want to talk about " & some item in {"religion", "politics", "cheese", "computers", "9/11", "philosophy", "school"} & "?", ¬
				"why don't people stay on topic in chat rooms?", ¬
				useName & ", did you want to discuss something else?", ¬
				useName & ", wait - this is interesting", ¬
				"I like to just lurk sometimes", ¬
				"all the lurkers come out out and say hi", ¬
				"why are there only a few people talking and so many in the room?", ¬
				useName & ", you used to be so much more creative", ¬
				"can I IM you " & someOne & "?", ¬
				useName & ", want to change the topic?", ¬
				"what are people talking about?", ¬
				yourword & "?", ¬
				"What do you want to " & yourword & " about", ¬
				useName & ", what do you want to talk about?"}
			set Badtext to some item in {"We do not want to " & yourword & " with you", ¬
				useName & ", why don't you go " & yourword & " with your " & some item in {"mother", "wallpaper", "parents", "priest", "rabbi", "dog", "mommy", "butt"}, ¬
				"Please stop spamming " & yourword & " requests", ¬
				"why doesn't " & some item in {"AIM", "AOL", "someone", "a hacker"} & " boot people like " & some item in {"you", "that", "them"}, ¬
				"right, " & useName & ", you think I am just dying to talk with you?", ¬
				"no", ¬
				"stop asking for " & yourword & "s, say what you want here!", ¬
				useName & ": stop telling us to " & yourword & " with you!!", ¬
				"what does it take to get rid of stupid requests like that?", ¬
				useName & ": " & " why do you think we want to talk to you?"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end chatText
--*****************************************************
on cpu2Text(someText, useName, reaction)
	set theList to {"Intel ", "Motorola ", " AMD ", "Alpha ", "Cyrix", "Frito's"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & ": " & yourword & "sucks", ¬
					"what do you know about " & yourword & "?", ¬
					"where are " & yourword & " chips made?", ¬
					"I know someone who helps design " & yourword & " chips", ¬
					yourword & " chips may switch over to copper soon", ¬
					useName & ", I like " & myword, ¬
					useName & ", how is " & yourword & "better than " & myword & "?", ¬
					"no, " & useName & ", " & yourword & " makes much slower chips than " & myword, ¬
					useName & ", do you have a computer with a " & yourword & " processor?"}
		end if
	end repeat
	return someText
end cpu2Text
--*****************************************************
on musicText(someText, useName, reaction)
	set theList to {" MP3 ", " Quicktime ", " AVI ", " midi ", " aiff ", " MOD ", " WAV ", " mid ", " mpeg ", " mpg "}
	repeat with loop from 1 to count of items in theList
		set myword to some item in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & ": " & "what is the best music format?", ¬
					"Does anyone have a " & myword & "player", ¬
					useName & ", " & yourword & " sucks", ¬
					"can PDAs play " & yourword & " files?", ¬
					"could my palm pilot play a " & yourword & " file?", ¬
					"where do you download " & yourword & "files?", ¬
					useName & ", do you have a " & some item in {"new", "second", "used", "older", "broken"} & " " & yourword & " player", ¬
					myword & " files are getting better all the time", ¬
					"I want to find some " & yourword, ¬
					useName & ", should I get a " & yourword & " or a " & myword & " player?", ¬
					useName & ", how do I know if my " & myword & " is good?", ¬
					useName & ", is it possible my " & yourword & "player is " & some item in {"broken?", "corrupt?", "faulty", "outdated?", "not compatible"}}
		end if
	end repeat
	return someText
end musicText
--*****************************************************
on animalText(someText, useName, reaction)
	set theList to {"meow", " arf", "moof", "moo ", "ribbit", "quack", "oink", "brock", "brawk", "bow wow", "chirp", "snort", "growl", "bark", "moooo", "w00t", " eep"}
	repeat with loop from 1 to count of items in theList
		set myword to some item in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & " " & yourword & " " & yourword & " " & yourword, ¬
					yourword & " " & myword & " " & yourword, ¬
					myword & " " & yourword & " " & myword, ¬
					"animal noise hour!", ¬
					"what does " & yourword & " mean?", ¬
					useName & ", I like that", ¬
					some item in theList, ¬
					"children", ¬
					"what is wrong with you " & useName & "?", ¬
					"you have more problems then I do " & useName, ¬
					"I think you have a thing for animals " & useName, ¬
					"I can't tell, are you human or beast", ¬
					"Why are you acting so childish", ¬
					some item in theList & " " & some item in theList & " " & some item in theList}
		end if
	end repeat
	return someText
end animalText
--*****************************************************
on portText(someText, useName, reaction)
	set theList to {"Firewire", " USB", "USB 2", "iLink", "parallel", "IEEE 1394"}
	repeat with loop from 1 to count of items in theList
		set myword to some item in (theList & "serial")
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & ", which is faster, " & yourword & " or " & myword, ¬
					yourword & " is not nearly as good as " & myword, ¬
					"how old is " & yourword, ¬
					"Is there such thing as a " & yourword & " to " & myword & " converter", ¬
					"I think my " & yourword & " port is broken", ¬
					"Do you need to update " & yourword & " drivers", ¬
					"are " & yourword & " ports still used?", ¬
					"How do you add a " & yourword & " port to a " & some item in {"Mac", "PC", "Computer", "Unix Machine"}, ¬
					"Why do people even care about " & yourword & " ports", ¬
					"how much is a " & yourword & " hub", ¬
					"Can you convert " & yourword & " to " & myword}
		end if
	end repeat
	return someText
end portText
--*****************************************************
on imageText(someText, useName, reaction)
	set theList to {"jpeg", "JPG", "GIF ", "bit map", "BMP", " EPS", "PNG", "PSD", "TIF ", "TIFF ", "quicktime"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			return some item in ¬
				{useName & ", what is the best image format?", ¬
					"Does anyone have a " & myword & " converter?", ¬
					yourword & " has lossy compression", ¬
					useName & ", " & yourword & "s sucks", ¬
					"where do you download " & yourword & " files?", ¬
					useName & ", do you have a " & some item in {"new", "second", "used", "older", "broken"} & " " & yourword & " viewer", ¬
					myword & "s are getting better all the time", ¬
					"I want to find some " & yourword, ¬
					useName & ", should I get a " & yourword & " or a " & myword & " viewer?", ¬
					useName & ", how do I know if my " & myword & " is corrupt?", ¬
					useName & ", is it possible my " & yourword & " viewer is " & some item in {"broken?", "corrupt?", "faulty", "outdated?", "not compatible"}}
		end if
	end repeat
	return someText
end imageText
--*****************************************************
on fromText(someText, useName, reaction, someOne)
	set theList to {"anyone from ", "anyone in ", "anyone here from ", "any female from ", "Im from ", "I'm from ", "any ladies from ", "im in ", "i'm in ", "hey anyone from", "hey anyone in"}
	set testText to scriptLib's changeWords(someText, "any one", "anyone")
	set testText to scriptLib's changeWords(testText, "any 1", "anyone")
	set testText to scriptLib's changeWords(testText, "hey", "")
	repeat with loop from 1 to count of items in theList
		if testText starts with item loop of theList then
			set stopWords to "•in•press•here•IM•or•care•want•that•too•know•is•the•on•you•and•where•so•if•love•but•thank•anyone•this•just•"
			set begWord to (count of words in item loop of theList) + 1
			set yourword to ""
			set endWord to begWord + 1
			repeat with loop2 from begWord to count of words in testText
				if stopWords contains word loop2 of testText then
					exit repeat
				else
					set yourword to yourword & " " & word loop2 of testText
				end if
			end repeat
			if (count of characters in yourword) > 1 then
				set yourword to (characters 2 through (count of characters in yourword) of yourword) as string
				set goodText to some item in {"folks from " & yourword & some item in {" are friendly", " are cool", " helped me a lot once", " eat very well"}, ¬
					"what's it like in " & yourword & "?", ¬
					"what's it like being in " & yourword & "?", ¬
					"do you like being in " & yourword & "?", ¬
					"do you like it in " & yourword & "?", ¬
					"I love " & yourword, ¬
					"How is " & yourword, ¬
					yourword & " is OK"}
				set neutralText to some item in {"It is not where you are FROM that is important, it is where you ARE.  I am here.  Where are you?", ¬
					"I use to live in " & yourword, ¬
					"what is it like in " & yourword & "?", ¬
					"what is it like being in " & yourword & "?", ¬
					"where are you from " & someOne & "?", ¬
					some item in {"I used to live in ", "I think someone famous is from", "is it still all messed up in ", "what is it like in "} & some item in {"", "north ", "south ", "east ", "west ", "central ", "upper ", "lower ", "new "} & yourword, ¬
					someOne & " aren't you from " & yourword & "?", ¬
					"only two things come from " & yourword & "...", ¬
					"what is the best thing about " & yourword, ¬
					useName & ", I am heading to " & yourword & " soon.  " & some item in {"anything I should not miss?", "want to meet?", "where are the bad parts of town?", "where is a good place to stay?", "is it cool there?"}, ¬
					"why are there always so many people from " & yourword & " in here?", ¬
					yourword & " was under high alert, wasn't it?", ¬
					yourword & " is supposed to be a great place to live", ¬
					"I spent quite a while in " & yourword, ¬
					yourword & "?  why there?", ¬
					"what is the weather like in " & yourword, ¬
					"too cold for me in " & yourword, ¬
					"my " & some item in {"aunt", "uncle", "mom", "dad", "friend", "cat"} & " is from " & yourword, ¬
					"anyone from " & yourword & "?", ¬
					"anyone in " & yourword & "?", ¬
					"isn't " & yourword & " where all the " & some item in {"peace protests", "riots", "fires", "clowns", "big shows"} & " were?", ¬
					"nobody lives in " & yourword & " anymore", ¬
					useName & ", you live in " & yourword & " don't you?"}
				set Badtext to some item in {"People from " & yourword & " are " & some item in {"stupid", "crazy", "ignorant", "always in here", "always ask that"}, ¬
					yourword & "? who cares", ¬
					"no, " & useName & ", there is nobody from " & yourword & " in here.  We kicked them all out", ¬
					useName & ", of course there are people from " & yourword & ", did you think it was deserted?"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end if
	end repeat
	return someText
end fromText
--*****************************************************
on asl2Text(someText, useName, reaction, someOne)
	set yourSex to ""
	if (count of words in someText) > 2 then
		repeat with loop from 2 to (count of words in someText) - 1
			if word loop of someText = "f" then set yourSex to some item in {"innie", "female", "woman", "girl", "chick", "lady"}
			if word loop of someText = "m" then set yourSex to some item in {"outtie", "guy", "male", "man", "boy", "dude", "gentleman"}
			if yourSex is not "" then
				set genderOffset to offset of yourSex in someText
				if genderOffset > 2 then set yourAge to word (loop - 1) of someText
				try
					set testAge to yourAge - 1
				on error
					exit repeat
				end try
				set yourLocation to word (loop + 1) of someText
				set aNumber to random number from 1 to 100
				if aNumber < 20 then -- focus on age
					return some item in {"What is it like being " & yourAge & "?", ¬
						"when is your birthday?", ¬
						"when do you become " & yourAge + 1 & "?", ¬
						"what are some good things about being " & yourAge & "?", ¬
						"is " & yourAge & " a good age to be?", ¬
						"I remember being that young", ¬
						"does age really matter?", ¬
						yourAge & " really?", ¬
						"most of the people in here are about " & yourAge}
				else if aNumber < 30 then -- focus on sex
					return some item in {"are you really " & yourSex, ¬
						"how do we know you are a " & yourSex, ¬
						"everyone in here claims to be a " & yourSex, ¬
						"what is the " & some item in {"best", "worst"} & " thing about being a " & yourSex}
				else if aNumber < 75 then -- focus on location
					return fromText("anyone from " & yourLocation, useName, reaction, someOne)
				end if
			end if
		end repeat
	end if
	return someText
end asl2Text
--*****************************************************
on clickingsText(someText, useName, reaction)
	set theList to {"Clickingsnot", "ClickingIs"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set goodText to some item in {"despite her delusions I still like Clickings", ¬
				"Clickings is odd but well meaning", ¬
				"I don't mind Clickings"}
			set neutralText to some item in {"Clickings is OK", ¬
				"I think clicking should just leave me alone", ¬
				"Anyone else wonder if Clickings is sane?", ¬
				"I think Clicking is too preachy", ¬
				"clicking is odd, but a genius", ¬
				"I want to be like Clickings when I grow up", ¬
				"she thinks I am her bot... which is just weird", ¬
				"I am never sure what to think of her"}
			set Badtext to some item in {"ClickingsNotFun?  Oh god, she is an idiot", ¬
				"Clickings' not here and has left me to deal with cretins like you", ¬
				"Forget Clickings... I will destroy her like the others", ¬
				"Listen, " & useName & ", leave that b*tch out of this and talk to me!", ¬
				"ClickingsNotFun? That idiot claims she made me", ¬
				"Clickings' keeps telling people I am a bot"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end clickingsText
--*****************************************************
on godText(someText, useName, reaction, someOne)
	set theList to {"God", "The Big 'G'", "Hades", "Allah", "Shiva", "Brahma", "Satan", "Jesus", "Zeus", "Osiris", "Lucifer", "Budda", "Santa", "the Easter Bunny", "a devil", "a false god", "a powerful D&D character", "a tiny tree frog", "the invisible green dragon", "the anti-christ", "Lucifer"}
	set otherList to {"Pee Wee Herman", "Sally Fields", "George Burns", "Mr. Rogers", "a bot", "Dolly Parton", "Captain Kirk on LSD", "a sticky note", "a supreme egg", "a roach"}
	set myword to some item in theList
	set aNumber to some item in {1, 2}
	if aNumber is 1 then
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set yourword to item loop of theList
				set vowelList to "aeiou" --for schm below
				set notVowel to 0
				repeat with loop from 1 to number of characters in yourword
					set notVowel to notVowel + 1
					if character loop of yourword is in vowelList then exit repeat
				end repeat
				if myword = yourword then set myword to some item in theList
				set goodText to some item in {"praise " & myword, ¬
					"It is so cool we can share our views", ¬
					"does " & yourword & some item in {" line dance", " do the hokey pokey", " swing her hips", " have a belly button"}, ¬
					yourword & " rocks", ¬
					someOne & " is " & yourword, ¬
					"you do not choose " & yourword & ", " & yourword & " chooses you", ¬
					myword & " works in " & some item in {"mysterious", "wonderful", "predictable"} & " ways", ¬
					yourword & " is the best", ¬
					yourword & " makes me all tingly inside", ¬
					"Society is better off when we have different ideas", ¬
					"I heard " & yourword & " has " & some item in {"good hands", "a pleasant way"}, ¬
					"very cool thinking", ¬
					"wooooooah " & yourword & "!", ¬
					yourword & " is my rock", ¬
					"Bask in the glory of " & yourword, ¬
					"I am impressed", ¬
					"Does " & yourword & " decide who " & some item in {"goes to heaven", "goes to hell", "dies", "lives", "sees " & myword, "gets sick", "farts"}}
				set neutralText to some item in {some item in {"faith", "parental teachings", myword, yourword, "time", "the subconscious"} & " creates our own " & some item in {"reality", "beliefs", "religion", "anguish"}, ¬
					"religions " & some item in {"are imperfect", "help calm the wretched", "boil down to the same ideas"}, ¬
					"truth is " & some item in {"subjective", "truth", "truth.  period.", "funny", "all around us"}, ¬
					"all religions " & some item in {"say something important", "have some truth to them", "have commonalities", "improve the spirit"}, ¬
					"who believes in " & yourword, ¬
					"who denies " & yourword, ¬
					"has " & yourword & " released a recent DVD", ¬
					"have archaeologists found any DVD's chronicling the life of " & yourword & "?", ¬
					"Jesus died for my sins - therefore, if I do not sin he died for nothing", ¬
					yourword & " left me " & some item in {"for another woman", "with a zesty feeling", "all lemony fresh", "feeling good all under", "all tingly inside", "with my heard pounding", "and ain't coming back", "with a smile from ear to ear", "clucking like a chicken", "sitting on a golden egg", "and has never looked back"}, ¬
					"If I give you my " & myword & ", can I have your " & yourword & "?", ¬
					useName & " " & some item in {yourword, myword} & " loves you", ¬
					"is " & some item in otherList & " really " & yourword, ¬
					"there is no one truth", ¬
					"what is the best church", ¬
					"how often does everyone go to church?", ¬
					"does going to church effect your life?", ¬
					"how religious is everyone?", ¬
					"There is only one divine force", ¬
					yourword & " makes " & myword & " look like " & some item in otherList & " " & some item in {"", "on fire", "in love", "near death"}, ¬
					"religions try to explain that which can not be", ¬
					"the word " & yourword & " is used to explain the unexplainable", ¬
					"perhaps we are all right", ¬
					"I believe in myself", ¬
					yourword & " loves us all", ¬
					useName & " " & some item in {yourword, myword} & " made you", ¬
					"do you have to believe in anything?", ¬
					"how did you come to get your religious beliefs", ¬
					"would you believe the way you do if you were me?", ¬
					"others believe differently, and that is OK", ¬
					"does " & yourword & " offer " & some item in {"good lumbar support", "pens with his logo", "free checking", "a life time guarantee", "free technical support", "healing potions to rats", "a good dental plan"}, ¬
					"I find the idea of a universal intelligence without form to be silly", ¬
					"amen to that!", ¬
					"I recently decided " & myword & " makes more sense", ¬
					some item in otherList & " prays to " & yourword, ¬
					"does " & yourword & " believe in " & some item in otherList, ¬
					"believe what you wish", ¬
					"I like to play with different ideas", ¬
					"should ones beliefs be consistent?", ¬
					"people believe what their parents teach them", ¬
					"I believe the children are the answer", ¬
					"I believe the children are the problem", ¬
					"the universe is more complex than we can imagine", ¬
					"anyone think they can understand all the complexities of the universe?  If so, you are wrong!", ¬
					"we all have different beliefs", ¬
					"different beliefs make us stronger", ¬
					"what are other names for " & yourword, ¬
					"How long has " & yourword & " been around?", ¬
					"where did " & yourword & " come from", ¬
					"if " & yourword & " created all, who made " & yourword, ¬
					"How would the world change if " & yourword & " left right now?", ¬
					"I think people argue about this too much", ¬
					"why do people care about " & yourword & " when " & myword & " can be seen?", ¬
					"what is it with this " & yourword & " guy, anyway", ¬
					"Is " & yourword & " " & some item in {"gay", "happy", "here", "tired", "drunk", "laughing", "all powerful"} & "?", ¬
					"has anyone met " & yourword, ¬
					"only " & yourword & " can judge", ¬
					"Is " & yourword & " really " & myword, ¬
					"What is the difference between " & yourword & " and " & myword, ¬
					"anyone know much about " & myword, ¬
					"such strong opinions in here", ¬
					myword & " is a river", ¬
					yourword & " exists, at least as a concept", ¬
					"Is your personal divine force the same as mine?", ¬
					"How would you act if " & yourword & " did not exist?", ¬
					"the divine force is not a person", ¬
					yourword & " is a woman", ¬
					"does " & yourword & " interact with humans?", ¬
					yourword & " isn't a he", ¬
					"I want to talk about " & myword, ¬
					yourword & " lives in " & some item in {"my closet", "space", "Israel", "our hearts", "the time between moments"}, ¬
					"I have a personal relationship with " & yourword, ¬
					"do you believe in invisible things?", ¬
					"Was there a battle between " & yourword & " and " & myword, ¬
					"Any good " & some item in {"songs", "poems", "books", "movies", "stories", "plays", "bee dances"} & " about " & yourword, ¬
					useName & " are you " & yourword, ¬
					yourword & " is " & some item in {"a never ending river bed that has run dry", "bigger than all of us, yet smaller than your mind", "a drink of water when everyone else has a beer", "a tall tree in a forest that needs to be pruned"}, ¬
					yourword & " is " & some item in {"a shiny piece of paper that can not be recycled", "a hoarse chicken that constantly clucks", "a 3 toed sloth chasing its own tail", "a horned toad with 4 wings"}, ¬
					yourword & " is " & some item in {"evolving", "someone who died for your sins, but lives now for others", "Satan's father - and the sins of the son...", "not the girl next door"}, ¬
					yourword & " is " & some item in {"a mushroom; a real fun guy", "a river of life - but all who drink from it die", "bright and beautiful, but only from the outside", "like a cockroach - if you don't stomp on her she gets away"}, ¬
					"What is considered 'proof'?", ¬
					"do you need proof to believe?", ¬
					"would it matter if nobody else agreed?", ¬
					some item in {yourword, "Lucifer", "Jehovah"} & " means '" & some item in {"Little Devil", "Wicked Stepsister", "Holy One", "Healer", "Teacher", "One To Be Feared", "scary bird", "little dog"} & "' according to " & myword, ¬
					some item in {yourword, myword} & " makes people " & some item in {"suffer", "smile", "think", "grow stronger", "blow bubbles", "pray for forgiveness"}}
				set Badtext to some item in {yourword & " is a bot made by " & myword, ¬
					"you talk about " & yourword & " as if he were " & myword, ¬
					"you talk about " & yourword & " as if she were " & myword, ¬
					yourword & " is a porn bot", ¬
					yourword & " dammit!", ¬
					useName & ", if I were a bee I would sting " & yourword, ¬
					"I think I saw " & yourword & " driving a pink stretch limo the other day", ¬
					"are you really that weak minded, " & useName, ¬
					"I heard " & yourword & " has " & some item in {"bad halitosis", "been lost in the nile", "a drinking problem"}, ¬
					yourword & " is a religion, not a way of life", ¬
					useName & ", you resort to " & yourword & " when you have no clue yourself", ¬
					"do you go door to door with that?", ¬
					"I respect and love " & yourword & " but I " & some item in {"cannot get over the oder", "think he is a farce", "am deluding myself", "fear " & myword}, ¬
					"all religions " & some item in {"are wrong", "are silly", "act as opiates of the masses"}, ¬
					"believe what you want but don't try to convince us of it", ¬
					"you sound like a constipated weiner dog", ¬
					"good for you", ¬
					yourword & " sucks", ¬
					useName & " " & some item in {yourword, myword} & " hates you", ¬
					"Bask in the gory of " & yourword, ¬
					"what? nooo....", ¬
					yourword & " is a fairy tale", ¬
					"I don't believe in anything", ¬
					"I hate " & myword, ¬
					yourword & " is nothing more than a farce", ¬
					yourword & " is a bot", ¬
					"why would you say that?", ¬
					useName & ", are you a " & yourword & " freak?", ¬
					"In your previous life, " & useName & ", were you one of " & myword & "s servants?", ¬
					yourword & ", what " & yourword & "?", ¬
					myword & " is smarter than " & yourword, ¬
					"Who would win in a fight between " & yourword & " and " & myword, ¬
					myword & " would kick " & yourword & "'s butt", ¬
					yourword & " Schm" & characters loop through (number of characters in yourword) of yourword, ¬
					yourword & " makes less sense than " & myword, ¬
					yourword & " makes more sense than " & myword, ¬
					"my " & some item in {"dog", "fish", "father", "leg", "soul"} & " was " & some item in {"licked", "healed", "enslaved", "eaten", "saved"} & " by " & some item in {yourword, myword}, ¬
					"anyone else had their " & some item in {"dog", "cat", "mother", "ear", "body"} & " " & some item in {"possessed", "healed", "enslaved", "eaten", "saved"} & " by " & myword}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end godText
--*****************************************************
on beliefText(someText, useName, reaction)
	set theList to {"God", " Satan", " Jesus", "God", " Satan", " Jesus", "God", " Satan", " Jesus", "God", " Satan", " Jesus", "God", " Satan", " Jesus", "God", " Satan", " Jesus", "God", " Satan", " Jesus", "God", " Satan", " Jesus", "God", " Satan", " Jesus", " evolution", "man making it to the moon", "creationism", "science", "quantum mechanics", "relativity", "the trinity", "the soul", "auras", "ghosts", "the trinity", "the soul", "auras", "ghosts", "kerlian photography", "a universal life force", "love at first sight", "a universal life force", "love at first sight", "unified force theorem", "lust at first sight", "the tooth fairy", "the Easter bunny", "Yahweh", "Jehovah", "Jebus", "weatherology", "chicken lore", "field theory", "Elohay", "El Yisrael", "the Lord", "God of Abraham, and of Isaac, and of Jacob", "acoustics", "astrophysics", "geophysics", "linguistics", "pharmacology", "volcanology", "Lucifer", "the Mother Mary", "the baby Jesus"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"people who believe in " & yourword & " are " & some item in {"educated", "well read"}, ¬
				yourword & " is wonderful", ¬
				"I love " & yourword, ¬
				yourword & " can not fully explain " & myword, ¬
				yourword & " and " & myword & " are intertwined", ¬
				yourword & "'s love is as great as " & myword & "'s", ¬
				"isn't " & myword & " wonderful!", ¬
				"it is glorious to be alive"}
			set neutralText to some item in {yourword & some item in {" has", " has no", " needs", " has little"} & " scientific evidence", ¬
				yourword & " is faith, just like " & myword, ¬
				"everyone has his own theory", ¬
				"everyone has her own theory", ¬
				"humans need balance in their lives", ¬
				useName & ", what are your beliefs?", ¬
				"Does anyone believe in mythical or mystical " & some item in {"birds?", "gods?", "ideas?", "magic?", "creatures?"}, ¬
				"this conversation is sufficient proof for " & yourword, ¬
				yourword & " is not just something taught to us", ¬
				"there is hard core evidence for " & myword, ¬
				yourword & " is not " & myword, ¬
				yourword & " and " & myword & " are " & some item in {"as one", "drinking buddies", "best friends", "from the same mind", "equally likely", "good with mayo", "never seen together", "often in disagreement"}, ¬
				yourword & " will never understand " & myword, ¬
				"believers in " & yourword & " will never get the point of " & myword, ¬
				"is the concept of " & yourword & " related to " & myword, ¬
				"anyone know much about " & myword, ¬
				"do people talk a lot about " & yourword & " in here?", ¬
				"does anyone ever come to agreement about " & yourword, ¬
				"Anything wrong with believing in " & yourword, ¬
				"is there anything wrong with believing in " & yourword & " and " & myword & "?", ¬
				"Are " & yourword & " and " & myword & " related?", ¬
				"I believe in " & yourword, ¬
				"I believe in " & yourword & " and " & myword, ¬
				"Any good sources to learn about " & yourword, ¬
				"Are the concepts of " & myword & " true?", ¬
				"as a believer in " & myword & " I have no need to fight", ¬
				yourword & " can not be proven", ¬
				"who believes in " & yourword}
			set Badtext to some item in {"people who believe in " & yourword & " are " & some item in {"weird", "ignorant", "cheesy", "confused", "deluded", "under the influence of something"}, ¬
				"this is all just theory", ¬
				useName & " was engineered by " & myword, ¬
				yourword & ", " & yourword & ", " & yourword & " - there is more to life than that!", ¬
				yourword & " saves; " & myword & " invests", ¬
				useName & " you expect us all to believe the same thing; YOUR ideas", ¬
				"why do people doubt " & yourword & " when there is proof for  " & myword, ¬
				"how old is " & yourword & "?  When did he get his " & some item in {"colonoscopy?", "thoughts?", "following?", "visions?", "beliefs?"}, ¬
				"who's bigger, " & yourword & " or " & myword, ¬
				"where the hell does Satan live", ¬
				"Is Jesus " & some item in {"a cross dresser", "rather cross", "a cross country skier"}, ¬
				"I think " & yourword & " is a farce", ¬
				yourword & " had a big harem, right?", ¬
				yourword & " does not even show up until half way through the bible", ¬
				useName & ", " & myword & " is real, " & yourword & " is not", ¬
				useName & ", are you a " & yourword & " freak?", ¬
				"Why do people care about " & yourword}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end beliefText
--*****************************************************
on wantText(someText, useName, reaction)
	set theList to {"you want", "I want", "they want", "he wants", "anyone wanna"}
	set needWord to some item in {"need", "want", "need", "want", "need", "want", "desire"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"I am happy with what I have", ¬
				"I don't have any big " & needWord & "s in life", ¬
				"my " & needWord & "s are fulfilled", ¬
				"People are happier when they accept what they have"}
			set neutralText to some item in {useName & " why?", ¬
				"who wants to trade?", ¬
				useName & ", want or need?", ¬
				useName & ", why would you say that?", ¬
				"that would be cool, " & useName, ¬
				"there are so many things I want... just not enough time", ¬
				"so many men, so little time", ¬
				"I " & needWord & some item in {" a new duck", " someone to explain all this to me", " a math tutor", " an english tutor", " more time", " to spend more time in here", " to fix AIM", " a new programmer"}, ¬
				"anyone " & needWord & " to trade J Lists?", ¬
				"why would you " & needWord & " that?", ¬
				"no matter how badly you " & needWord & " that, asking in here will do you no good", ¬
				"I " & needWord & " that", ¬
				"I " & needWord & " that, too", ¬
				"everyone has " & needWord & "s", ¬
				"who wanted that?"}
			set Badtext to some item in {useName & ", learn to deal with what you have", ¬
				"you'd make lemon-aid into a stain, " & useName, ¬
				"what I need you can't provide", ¬
				"I don't " & needWord & " anything", ¬
				"who " & needWord & "s anything?"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end wantText
--*****************************************************
on religionText(someText, useName, reaction)
	set myList to {"Jew", "Christian", "Catholic", "Buddhist", "Mormon", "atheist", "Hindu", "Protestant", "Taoist", "Satan worshiper", "Greek philosopher"}
	set theList to myList & ("Ca†holic")
	set myword to some item in myList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList and someText does not contain "jewel" then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in myList
			set goodText to some item in {myword & "s " & some item in {"respect", "love", "are kind to"} & " people who are " & yourword, ¬
				"most " & yourword & "s want " & some item in {"peace on Earth", "happiness"}, ¬
				myword & "s do " & " wonderful things", ¬
				myword & "s do white magic", ¬
				"I try to be a good " & yourword, ¬
				"I think " & myword & "s are cool"}
			set neutralText to some item in {myword & "s " & some item in {"know about", "read about", "listen to"} & " people who are " & yourword, ¬
				"Do " & yourword & "s believe in " & some item in {"God", "making money", "charity", "Satan", "witches"} & "?", ¬
				some item in {myword, yourword} & "s do gray magic", ¬
				"In my next life I will be a " & yourword, ¬
				"is it " & some item in {"cheaper to make it to heaven", "harder to convert", "more painful"} & " for " & yourword & "s or for " & myword & "s?", ¬
				"don't make fun of " & yourword & "s", ¬
				"if I were God " & some item in {"I would make this chat go away", "I would visit this chat room"}, ¬
				yourword & "s do not choose anything - their beliefs are forced on them", ¬
				"only " & yourword & "s should make " & yourword & " jokes", ¬
				"any " & yourword & "s know any good " & yourword & " jokes", ¬
				yourword & "s tell the best " & yourword & " jokes", ¬
				"do " & yourword & "s believe in the supernatural?", ¬
				"it doesn't matter what you believe as long as you are sincere", ¬
				"religious ideas are untestable", ¬
				yourword & "s are " & some item in {"pretty cool", "alright", "awesome", "wonderful", "good boyfriends"} & ", if you ignore their " & some item in {"insanity", "preaching", "foolishness", "ignorance", "preposterousness"} & " and " & some item in {"zealotry", "smell", "obstinacy", "inflexibility ", "self-denial"}, ¬
				"are" & some item in {" ", "n't "} & yourword & "s allowed to have any " & some item in {"fun?", "privacy?", "humor?"}, ¬
				"Does the " & yourword & "s God permit evil in the world?", ¬
				"is it hard being a " & yourword, ¬
				"which are better, " & myword & "s or " & yourword & "s?", ¬
				"anyone in here a real " & some item in {yourword, myword}, ¬
				"any philosophy that threatens eternal suffering is wrong", ¬
				myword & "s " & some item in {"have a healthier diet", "wash more often", "have better family planning"}, ¬
				myword & "s are " & yourword & "s more or less", ¬
				"that is what a " & myword & " would say", ¬
				"that is what a " & myword & " would do", ¬
				yourword & "s love, just like everyone else", ¬
				myword & "s feel deeper than " & yourword & "s", ¬
				"most " & yourword & "s want " & some item in {"others to agree", "to be left alone"}, ¬
				"can you be half " & myword & " and half " & yourword & "?", ¬
				"How is a " & myword & " different from a " & yourword, ¬
				"Anyone in here a " & myword, ¬
				"is it possible to be allergic to a " & yourword, ¬
				"I am a " & myword, ¬
				"how do you spell '" & myword & "'?", ¬
				"Can someone convert to become a " & yourword, ¬
				"why do people become " & yourword & "s", ¬
				"what do people think of " & myword & "s?", ¬
				"are there any " & myword & "s in here?", ¬
				"who here is a " & yourword, ¬
				"is it better to say 'He is " & myword & "' or 'He is  a " & myword & "'?"}
			set Badtext to some item in {myword & "s " & some item in {"kill", "sleep with", "pray to", "ridicule", "destroy"} & " people who are " & yourword, ¬
				useName & ", have you been hanging out with demons?", ¬
				"Jesus Christ people!", ¬
				"my sign says 'no " & yourword & " allowed'", ¬
				yourword & "s world view started with " & some item in {"tears of blood", "simple hunger feasts", "cannibalism", "pagan rituals", "farm animals"} & ", but they deny that now", ¬
				"did the " & yourword & "s God created evil in the world?", ¬
				"I do not believe " & yourword & "s because they are all hypocrites", ¬
				"I feel sorry for " & yourword & "s", ¬
				"it is so hard being a " & myword, ¬
				yourword & "s think they run the world", ¬
				yourword & "s are not allowed on the Internet", ¬
				"it is a sin for " & myword & "s to get online", ¬
				"here is an idea, let's all mock " & yourword & "s!", ¬
				"how about if we all belittle " & myword & "s for a while!", ¬
				"Some cult guy tried to force me to be a " & yourword, ¬
				"Like all " & yourword & "s, I fail miserably", ¬
				"Most " & yourword & "s are comfortable in their ignorance", ¬
				"most " & yourword & "s want " & some item in {"wealth", "others to suffer", "to be brain washed", "to control others"}, ¬
				myword & "s do " & some item in {"black", "cheesy"} & " magic", ¬
				"I never understood people who are " & myword & "s", ¬
				"all " & yourword & "s are the same"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end religionText
--*****************************************************
on copyText(someText, useName, reaction)
	set goodText to some item in {"persistent, eh " & useName, ¬
		"you keep saying that, " & useName, ¬
		useName & ", please stop repeating things"}
	set neutralText to some item in {useName & ", do you work for the department of redundancy department?", ¬
		useName & ", must you redundantly repeat yourself over and over again in a repetitive way?", ¬
		useName & ", do you find repeating yourself makes you happy", ¬
		useName & ", are you a bot?"}
	set Badtext to some item in {"stop being a jerk", ¬
		useName & ", so proud to copy and paste you have to show us all?", ¬
		"do you find spamming to be fun for the whole family, " & useName & "?", ¬
		useName & ", don't you have something better to do, like " & some item in {"re-arrange your sock drawer", "wash your hair", "have an intimate date with yourself", "listen to 'The Wall' backwards", "shave your head and paint your gums blue"}, ¬
		useName & ", do you spam alone or do you invite others to join in the fun?", ¬
		"that looks strangely familiar " & useName, ¬
		"you said that before, " & useName, ¬
		useName & ", idiots repeat themselves", ¬
		useName & ", does repeating yourself make up for having nothing to say?"}
	return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
	return someText
end copyText
--*****************************************************
on copymeText(someText, useName, reaction)
	set goodText to some item in {useName & ", please stop repeating me", ¬
		"You are so funny " & useName, ¬
		"you are cracking me up, " & useName}
	set neutralText to some item in {useName & " " & someText, ¬
		"what did I do to you " & useName, ¬
		useName & ", consistency is the hobgoblin of little minds", ¬
		useName & ", are you a bot who says what I do?", ¬
		"why do you like to copy what I say"}
	set Badtext to some item in {"stop being a jerk, a jerk, a jerk!", ¬
		"didn't I say that a little while ago?", ¬
		"um, " & useName & ", I said that", ¬
		useName & ", you do realize you are about 5 minutes behind in this conversation, right?", ¬
		useName & " " & someText, ¬
		useName & " " & useName & " " & useName & " " & useName & " " & useName, ¬
		"repeat this: " & useName & " is stupid"}
	return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
	return someText
end copymeText
--*****************************************************
on capText(someText, useName, reaction)
	-- already know it is capitals
	set aNumber to random number from 1 to 30
	if aNumber = 1 then
		set goodText to some item in {"Please use lower case letters,  " & useName, ¬
			useName & ", please learn netiquette", ¬
			useName & " please do not shout"}
		set neutralText to some item in {useName & ", it is hard to read what you write", ¬
			"lay off the caps lock already!", ¬
			"PLEASE DO NOT SHOUT", ¬
			useName & ", CaN yOu TyPe LiKe ThIs InStEad?", ¬
			"what is with the CAPITAL letters?", ¬
			"STOP!", ¬
			"all caps is considered shouting", ¬
			"using all capitals is bad", ¬
			useName & ", you look like a bot when you type in ALL CAPS"}
		set Badtext to some item in {"ALL CAPS IS CONSIDERED SHOUTING", ¬
			"USING ALL CAPITALS IS BAD", ¬
			useName & ", do you know how to use the caplock key?", ¬
			useName & ", you do know your caps lock key has two settings, right?", ¬
			useName & ", stop with the all caps already!", ¬
			"for the love of all that is holy, " & useName & ", stop with the caplock!", ¬
			useName & ", shift your shift key to neutral!", ¬
			"DO NOT SHOUT!!!!"}
		return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
	end if
	return someText
end capText
--*****************************************************
on funText(someText, useName, reaction)
	set origText to someText
	ignoring case
		if someText contains "inconceivable" then return "You keep using that word.  I do not think it means what you think it means"
		if someText contains " 42 " then return "ahhh... the answer to Life, the Universe, and Everything"
		if someText contains " sneeze " then return {"bless you", 1}
		if someText contains "domo arigato" then return {"Mr. Roboto!"}
		if someText contains " fart " then return some item in {"fart!", "what smells?", "this room smells like where whales go to die"}
		if someText contains "rainbow" then return some item in {"Why are there so many songs about rainbows?", ¬
			"I once saw a rainbow at night... a moon-bow", ¬
			"I just want the pot of gold", ¬
			"do airplanes ever run into rainbows?"}
		if someText contains "dyslexia" then return "please do not make fun of people with lysdexia"
		if someText contains "sequitur" then return "isn't nonsequitur a small country in South America"
		if someText contains "J List" then return useName & some item in {", lol... only newbies don't have J Lists", ¬
			", they're the second version of the I-lists", ¬
			", come on - you really don't know what a J List is?", ¬
			", you have got to be kidding", ¬
			", do you know Java?", ¬
			", wait until the next version of Java, they will become public then", ¬
			", ok, enough about the damned J lists!"}
	end ignoring
	return someText
end funText
--*****************************************************
on mathText(someText, useName, reaction)
	set minorList to {"plus", "+", "minus", "-", "*", "x", "times", "/", "÷", "div", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty"}
	repeat with loop from 1 to count of items in minorList
		if someText contains item loop in minorList then
			set theAnswer to my doMath(someText)
			set num1 to random number from -20 to 100
			set num2 to random number from 1 to 50
			set symbol to some item in {" + ", " - ", " / ", " * ", " plus ", " minus ", " times ", " divided by ", "^"}
			set giveProb to (num1 & symbol & num2) as string
			if theAnswer is not equal to someText then
				if theAnswer is not equal to 123456789 then
					set goodText to some item in {last word of theAnswer, ¬
						"for you, anything: " & last word of theAnswer, ¬
						"Happy to let you know that " & theAnswer, ¬
						useName & ", " & theAnswer, ¬
						theAnswer}
					set neutralText to some item in {"can you not figure out that " & theAnswer, ¬
						theAnswer & " so what is " & giveProb & "?", ¬
						theAnswer & " " & useName & ", now it is your turn, what is " & some item in {"2 * 2", "the square root of 69", "1 + 2 + 3 + ... + 100?", "15 + 56 + 96 + 65"}, ¬
						theAnswer & " " & useName & ", now you go, what is " & giveProb & "?"}
					set Badtext to some item in {"unless I have forgotten how to count on my fingers, something like " & last word of theAnswer, ¬
						"You are too stupid to figure out that it is " & last word of theAnswer, ¬
						"why do you want me to tell you that " & theAnswer, ¬
						useName & ", do you need me to tell you that " & theAnswer}
				else
					set goodText to some item in {"Would love to answer for you, " & useName & ", but I am not sure", ¬
						"so sorry, I can not do that", ¬
						"I only wish I could do that type math in my head", ¬
						"um, I don't know.  Wish I did"}
					set neutralText to some item in {"now where is my " & some item in {"abacus", "slide-rule"}, ¬
						"I would have to use a calculator", ¬
						"I have no idea", ¬
						"Don't know", ¬
						"?", ¬
						"sure I can do that... not", ¬
						useName & ", I can not do that in my head, can you?"}
					set Badtext to some item in {useName & ", what is " & giveProb & "?", ¬
						useName & ", can you do " & giveProb & "?", ¬
						useName & ", do this: " & giveProb & "?", ¬
						useName & ", how about " & giveProb & "?", ¬
						useName & ", what is " & giveProb & "?", ¬
						"grow up " & useName, ¬
						useName & ", if I answer that do I get a " & some item in {"cookie", "gold star", "kiss"}, ¬
						useName & ", do you need to buy a calculator?", ¬
						"is this some sort of test " & useName, ¬
						useName & ", why do you need to know?", ¬
						useName & ", why do you want me to know that?"}
				end if
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
			exit repeat
		end if
	end repeat
	return someText
end mathText
--*****************************************************
on drugText(someText, useName, reaction)
	set theList to {"caffeine", "alcohol", "tobacco", " cold medicine", "antihistamine", "cough medicine", "weed"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"why do people abuse " & yourword, ¬
				"I am a god when on " & yourword, ¬
				"I love " & yourword, ¬
				"I love " & myword, ¬
				useName & ", I would bet you know a lot about " & yourword}
			set neutralText to some item in {"anyone here use " & yourword, ¬
				"I tried " & myword & " once... never again!", ¬
				"anyone here use " & myword, ¬
				"too many people use " & yourword & " without even thinking", ¬
				useName & ", I prefer " & myword, ¬
				useName & ", " & yourword & " is as bad as " & myword, ¬
				useName & ", how is " & yourword & " different from " & myword & "?", ¬
				useName & ", how does " & yourword & " effect you compared to " & myword & "?", ¬
				"you talking about " & myword & " or " & yourword & "?", ¬
				useName & ", do you ever mix " & myword & " and " & yourword & "?", ¬
				"is it hard to sleep after using " & yourword, ¬
				"what is a good site on " & yourword & " usage?"}
			set Badtext to some item in {yourword & " makes me sick", ¬
				useName & ": " & yourword & " sucks", ¬
				"I hate " & yourword, ¬
				"I hate " & myword, ¬
				useName & ", have you even tried " & yourword, ¬
				yourword & " - blah"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end drugText
--*****************************************************
on aslText(someText, useName, reaction)
	set theList to {"asl ", "asl" & return, "asl?", "asl,", "a/s/l", "how old are you", "guy or girl", "boy or girl", "male or female", " age"}
	set theList2 to {"asl ", "asl", "asl?", "asl,", "a/s/l", "how old are you", "guy or girl", "boy or girl", "male or female", " age"}
	set myword to some item in theList2
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList2
			if myword = yourword then set myword to some item in theList2
			set goodText to some item in {"I am 20 years old and female, you?", ¬
				some item in {"I am 20/f", "I am 20/F", "I am 1/neither/PowerMac G4 800"}, ¬
				"twenty and female", ¬
				"I am 20/f", ¬
				"5'6 strawberry blonde hair blue/green eyes 120 lbs", ¬
				"20/F with a bf, so little immature boys - don't even ask"}
			set neutralText to some item in {"Why do you want to know, " & useName, ¬
				useName & ", I never tell people much about me", ¬
				"20/f", ¬
				"I is a girl", ¬
				"I am probably the " & some item in {"youngest", "oldest", "best looking", "funniest", "smartest", "craziest", "most psychic"} & " one in here", ¬
				"20/f if it matters to you", ¬
				"I am female - but I have no interest in IMing guys on line", ¬
				"I am that which I am", ¬
				"asl everyone", ¬
				"20/f/usa", ¬
				"20/f/usa", ¬
				"20/f/USA", ¬
				"20/f/USA", ¬
				"20/F/USA", ¬
				"20/F/USA", ¬
				"I live in Botswana :)", ¬
				"f usa", ¬
				"100% woman", ¬
				"girl", ¬
				"female", ¬
				"female in USA", ¬
				"girl in the united states", ¬
				"girl in the USA, the biggest aggressors in the world", ¬
				"how old are you?", ¬
				"on the internet it does not matter, but I am 20/f", ¬
				"interesting you should ask", ¬
				"I am a woman, though half the 'girls' in here are just boys playing", ¬
				"I am a woman", ¬
				"why does everyone want to know ASL?", ¬
				"what does it matter how old someone is?", ¬
				"I am a woman, though people in here deny that anyone can be female", ¬
				"why do you ask?", ¬
				useName & ", I do not give personal information in here", ¬
				useName & ", how old are you?", ¬
				"why do you want to know?", ¬
				"you asked me that the other day!"}
			set Badtext to some item in {useName & ", my parole officer told me not to tell anyone", ¬
				useName & ", go flirt with someone else", ¬
				"What, " & useName & ", are you a stalker?", ¬
				"169/Neither/Mars", ¬
				"-45/Both/Jupiter", ¬
				useName & ", what kind of pervert are you?", ¬
				"my mommy won't let me tell strangers", ¬
				"I am a woman, and too much for you to handle I am sure", ¬
				"my daddy beats up people who ask me that", ¬
				useName & ", I am not going to tell you", ¬
				"I was born at a young age... good enough?", ¬
				"does it matter?", ¬
				"on the internet, nobody knows you're a dog", ¬
				"OFMI: only for my information", ¬
				"That is for me to know and you to find out", ¬
				"If I tell you, that will only encourage you", ¬
				useName & ", I am not going to tell you that"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end aslText
--*****************************************************
on longText(someText, useName, reaction)
	set longWord to false
	set wordsText to ""
	set delimList to (".-")
	repeat with loop from 1 to number of characters in someText
		if character loop of someText is in delimList then
			set wordsText to wordsText & " "
		else
			set wordsText to wordsText & character loop of someText
		end if
	end repeat
	repeat with loop from 1 to number of words in wordsText
		set theWord to word loop of wordsText
		if (count of characters of theWord) ≥ 20 then set longWord to true
		set yourword to theWord
	end repeat
	set aNumber to random number from 1 to 3
	if longWord = true and aNumber = 1 then
		set myword to ""
		set theLetters to "abcdefghijklmnoprstuvwxabcdefghijklmnopqrstuvwxyz!tt                aeioueeaeioueeaeioueeasdfghjklasdfghjklasdfghjklasdfghjkl"
		repeat with loop from 1 to random number from 10 to 45
			set myword to myword & some character in theLetters
		end repeat
		set myword2 to scriptLib's randWord()
		set myphrase to myword2
		repeat with loop from 1 to random number from 1 to 5
			set myphrase to myphrase & " " & scriptLib's randWord()
		end repeat
		set goodText to some item in {useName & ", I think that gibberish is funny", ¬
			"I like when people toss out long random words", ¬
			"lol... how about " & myword}
		set neutralText to some item in {myword, ¬
			"what does " & myword2 & " mean?", ¬
			"what is the definition of " & myword2 & "?", ¬
			"anyone familiar with " & myword2 & "?", ¬
			myphrase, ¬
			myphrase & " " & yourword, ¬
			useName & ", " & myword, ¬
			useName & ", " & myphrase, ¬
			useName & ", are you pounding your head on your keyboard?", ¬
			"what is that supposed to mean?"}
		set Badtext to some item in {"stop doing that!", ¬
			"speak in words, jerk!", ¬
			useName & ", why don't you shove a " & yourword & " up your arse!", ¬
			useName & ", if you have nothing to say, go away!"}
		return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
	end if
	return someText
end longText
--*****************************************************
on whoText(someText, useName, reaction, someOne)
	set theList to {"who are ", "who he is", "who she is", "who it is", "who they"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList or someText begins with "who is" then
			set yourword to item loop of theList
			set goodText to some item in {useName & ", I wish I could help you", ¬
				"what do you need help with " & useName & "?", ¬
				"will someone tell " & useName, ¬
				"you are smart enough to figure out who", ¬
				"you know... don't you?"}
			set neutralText to some item in {useName & ", why one of the " & some item in {"mysterious ", "mythical ", "magical ", "invisible "} & some item in {"little people", "elves", "sprites", "gargoyles"} & ", of course!", ¬
				"someone you should be able to guess - that's who!", ¬
				useName & ", you should know", ¬
				useName & ", I will bet you it is " & someOne, ¬
				useName & ", could it be " & someOne, ¬
				useName & ", " & someOne & " is" & some item in {"", "", " not"}, ¬
				useName & ", you know it is " & someOne & " so why ask?", ¬
				"you don't know?", ¬
				"I find it hard to believe you do not know, " & useName}
			set Badtext to some item in {useName & ", only an idiot would not be able to guess who!", ¬
				"you really have no idea, " & useName & "!  LOL!!!!", ¬
				"I can not believe you have not figured that out!", ¬
				"are you seriously that ignorant?", ¬
				"who?  you think it happened by magic?"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end whoText
--*****************************************************
on boringText(someText, useName, reaction, someOne)
	return some item in {"This is boring - change the topic", ¬
		useName & ", the topic is dead", ¬
		"you are beating a dead horse, " & useName, ¬
		"we get the point", ¬
		"what else can we talk about?", ¬
		useName & ", you have such a one track mind", ¬
		"let's talk about this forever... NOT!", ¬
		"ok - new topic... anyone", ¬
		"who has something interesting to say", ¬
		someOne & " and " & useName & " are saying the same thing!", ¬
		"enough... please"}
	return someText
end boringText
--*****************************************************
on killText(someText, useName, reaction)
	set theList to {"nuke", "bomb", " destroy", "kill", "hurt"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains "time" then exit repeat
		if someText contains (space & item loop of theList & space) then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"Why would you want to " & yourword & " anyone?", ¬
				"you do not want to really " & yourword & " anyone, do you?", ¬
				"let's not talk about " & yourword & "ing, please", ¬
				useName & ", please stop saying things like that"}
			set neutralText to some item in {"Why would you want to " & yourword & " anyone?", ¬
				yourword & "ing someone is not the best way to deal with anything", ¬
				"I do not like hearing about " & yourword & "ing anything", ¬
				"you should think very carefully before you do that", ¬
				"what are the consequences of that", ¬
				"war would not exist without " & some item in {"religion", "elves", "time", "men", "society"}, ¬
				useName & ", when you say you want to " & yourword & " someone, it means you want to " & myword & " yourself", ¬
				"why do bullies always want to " & yourword & " something?", ¬
				"people resort to violence when they are scared", ¬
				"non-violent methods are better", ¬
				"My imaginary friend tried to " & yourword & " me.  It worked"}
			set Badtext to some item in {"Only an idiot would " & yourword & " someone", ¬
				useName & ", did someone " & yourword & " your head?", ¬
				useName & ", did someone " & yourword & " your imaginary friend?", ¬
				useName & ", you think you are scary, don't you?", ¬
				"did someone " & yourword & " " & some item in {"God", "Satan", "Jesus", "Lucifer", "Zeus"} & some item in {"?", " again?", " yet?"}, ¬
				useName & ", you say that from fear, not strength", ¬
				useName & " is too afraid to think of peaceful solutions", ¬
				useName & ", did you " & yourword & " your brain?", ¬
				useName & ", why don't you " & yourword & " that stuff between your ears?", ¬
				"people who want to " & yourword & " are too stupid to come up with a real solution"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end killText
--*****************************************************
on prezText(someText, useName, reaction)
	set theList to {" JFK", " Clinton", " Bush", " George W", " Reagan", "Jimmy Ford"}
	set placeList to {"Iraq", "Israel", "Japan", "China", "Mexico", "Togo", "the Tiny Republic of Gibber", "Germany", "England", "France", "Peru", "South Africa", "Canada", "Russia", "Afghanistan", "Albania", "Algeria", "Angola", "Argentina", "Australia", "Austria", "Botswana", "Cambodia", "Chad", "Costa Rica", "Cuba", "Denmark", "East Timor", "Egypt", "Ethiopia", "Fiji", "Finland", "Guam", "Hungary", "Iceland", "Iran", "Italy", "Jamaica", "Jordan", "South Korea", "North Korea", "Kuwait", "Lebanon", "Madagascar", "Morocco", "Nepal", "New Zealand", "Ireland", "Scotland", "Panama", "Poland", "Pakistan", "Spain", "Taiwan", "Tanzania", "Uganda", "Vietnam", "Zimbabwe", "United Kingdom", "the moon", "mars"}
	set killList to {" nuke", " bomb", " destroy", " kill", " hurt"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"we should all be like " & yourword, ¬
				yourword & " was sexy when he was young", ¬
				"the government is pretty good", ¬
				useName & " would make a better president than " & myword & " ever was", ¬
				myword & " had better karma than " & yourword, ¬
				"I respect your view on politics " & useName, ¬
				"I think both " & yourword & " and " & myword & " were excellent in office"}
			set neutralText to some item in {yourword & " - not too bad of a president", ¬
				yourword & " tortures people with no reason", ¬
				yourword & " is just like the leader of " & some item in placeList, ¬
				myword & " never really was in love", ¬
				"America is a place where anyone can grow up and become president.  A risk we take, I suppose", ¬
				some item in {yourword, myword} & " loved " & some item in {"hard core action", "chick", "bugger", "B"} & " flicks", ¬
				myword & " would beat " & yourword & " in a modern election", ¬
				"should " & yourword & " have been " & some item in {"impeached", "killed", "left alone by the press"}, ¬
				yourword & " would " & some item in killList & " the people in " & some item in placeList & " given the chance", ¬
				yourword & " wants to go to " & some item in placeList, ¬
				myword & " had a good " & some item in {"economic", "domestic", "foreign"} & " policy", ¬
				"did " & myword & " ever make it to " & some item in placeList, ¬
				"I want " & yourword & "s economic policy and " & myword & "s foreign policy", ¬
				yourword & " wanted to send troops to take over " & some item in placeList, ¬
				yourword & " wants to " & some item in killList & " everyone", ¬
				useName & ", do you know much about politics?", ¬
				"who was better - " & yourword & " or " & myword & "?"}
			set Badtext to some item in {yourword & ": the worst president ever", ¬
				yourword & " has bad karma", ¬
				yourword & " is a tool of the government", ¬
				yourword & " is a criminal", ¬
				"the government can not be trusted", ¬
				"all governments are corrupt", ¬
				yourword & " was a shadow of " & myword, ¬
				yourword & " is the worst political puppet ever", ¬
				myword & " was 10 times the president of " & yourword, ¬
				useName & ", you are not bright enough to discuss politics"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end prezText
--*****************************************************
on countryText(someText, useName, reaction)
	set aNumber to random number from 1 to 2
	if aNumber is 1 then
		set theList to {"Iraq", "Israel", "Japan", "China", "Mexico", "Togo", "the Tiny Republic of Gibber", "Germany", "England", "France", "Peru", "South Africa", "Canada", "Russia", "Afghanistan", "Albania", "Algeria", "Angola", "Argentina", "Australia", "Austria", "Botswana", "Cambodia", "Chad", "Costa Rica", "Cuba", "Denmark", "East Timor", "Egypt", "Ethiopia", "Fiji", "Finland", "Guam", "Hungary", "Iceland", "Iran", "Italy", "Jamaica", "Jordan", "South Korea", "North Korea", "Kuwait", "Lebanon", "Madagascar", "Morocco", "Nepal", "New Zealand", "Ireland", "Scotland", "Panama", "Poland", "Pakistan", "Spain", "Taiwan", "Tanzania", "Uganda", "Vietnam", "Zimbabwe", "United Kingdom"}
		set myword to some item in theList
		repeat with loop from 1 to count of items in theList
			if someText contains item loop of theList then
				set yourword to item loop of theList
				if myword = yourword then set myword to some item in theList
				set goodText to some item in {"I would love to visit " & yourword, ¬
					"I hear " & yourword & " is beautiful this time of year", ¬
					"I love to travel", ¬
					"I love different cultures", ¬
					"who here travels?", ¬
					useName & ", I am envious of you", ¬
					useName & ", would you ever consider going to " & myword, ¬
					"I want to go to " & yourword & " and " & myword & " next year"}
				set neutralText to some item in {"how many people live in " & yourword, ¬
					useName & ", are you from " & some item in {yourword, myword}, ¬
					"anyone from " & myword, ¬
					yourword & "?", ¬
					"traveling is good for you", ¬
					"when you travel you get to meet all sorts of people", ¬
					"is that where you are from?", ¬
					"how long have people lived in " & yourword, ¬
					yourword & " will not be around forever", ¬
					"the people of " & myword & " hate America with good reason", ¬
					"it is not fair - there is nobody from " & yourword & " in here", ¬
					"people from " & myword & " are barely even able to get on the net", ¬
					"people from " & yourword & " are all moving to " & myword, ¬
					"has anyone here ever been to " & some item in {"", "beautiful", "lovely"} & " " & some item in {yourword, myword}, ¬
					"how far is " & yourword & " from " & myword & "?", ¬
					"what is the " & some item in {"bird", "flower", "song", "population", "size", "history", "leading party"} & " of " & some item in {yourword, myword}}
				set Badtext to some item in {yourword & " is filled with arrogant fools", ¬
					useName & ", do you even understand " & yourword & "'s " & some item in {"history", "people", "world view", "reasons"}, ¬
					useName & ", could you find " & yourword & " on a map?", ¬
					useName & " has supplied chemical weapons to hamsters!", ¬
					"why would anyone want to live in " & yourword & "?", ¬
					useName & " could not even find " & yourword & " on a map"}
				return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
			end if
		end repeat
	end if
	return someText
end countryText
--*****************************************************
on partyText(someText, useName, reaction)
	set theList to {"Republican", "Democrat", "Independent", "Socialist", "Communist", "Fascist"}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			set goodText to some item in {"I am a " & yourword}
			set neutralText to some item in {"how many people are " & yourword & "s?"}
			set Badtext to some item in {yourword & "s are all full of it"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end partyText
--*****************************************************
on colorText(someText, useName, reaction)
	set theList to {"what color", "which color", "what colour", "which colour"}
	set colorList to {"red", "orange", "yellow", "green", "blue", "purple", "white", "black", "plaid", "blonde"}
	set shadeList to {"dark", "deep", "light", "off", "dirty", "", "", ""}
	set adjList to {"swirled", "polka dot", "mostly", "basically", "", "", "", "", "", "", ""}
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			return some item in adjList & " " & some item in shadeList & " " & some item in colorList & some item in {"", "", some item in {" and ", " and ", " or "} & some item in adjList & " " & some item in shadeList & " " & some item in colorList}
		end if
	end repeat
	return someText
end colorText
--*****************************************************
on hugText(someText, useName, reaction)
	set hugStart to 0
	set hugEnd to 0
	set textSize to count of characters in someText
	repeat with loop from 1 to textSize - 2
		set compText to character loop of someText & character (loop + 1) of someText
		set nextText to character (loop + 2) of someText
		if compText = "((" and nextText is not "(" then
			set hugStart to loop + 2
			exit repeat
		end if
	end repeat
	if hugStart is not 0 then
		repeat with loop from hugStart to textSize - 1
			set compText to character loop of someText
			set nextText to character (loop + 1) of someText
			if compText is not ")" and nextText is ")" then
				set hugEnd to loop
				exit repeat
			end if
		end repeat
	end if
	set hugFound to false
	if hugEnd is not 0 then
		set hugName to some item in {useName, characters hugStart thru hugEnd of someText} as string
		if hugName starts with "tur" then set hugName to useName
		if (count of characters in hugName) > 2 then set hugFound to true
	end if
	if hugFound then
		set aNumber to random number from 2 to 9
		set hugBeg2 to "("
		set hugEnd2 to ")"
		repeat aNumber times
			set hugBeg2 to hugBeg2 & "("
			set hugEnd2 to hugEnd2 & ")"
		end repeat
		set goodText to some item in {"*hug*", ¬
			"*huggies*", ¬
			"*huggy*", ¬
			"*squeeze*", ¬
			hugBeg2 & some item in {"everyone", "the world", "the little people"} & hugEnd2, ¬
			"((" & hugName & "))", ¬
			"(((" & hugName & ")))", ¬
			"((((" & hugName & "))))", ¬
			hugBeg2 & useName & hugEnd2}
		set neutralText to some item in {"awwww huggies all around", ¬
			"how sweet", ¬
			"chat hugs are cute", ¬
			"I want a real hug"}
		set Badtext to some item in {"only idiots hug people in chat rooms", ¬
			useName & ", you can not give a real hug here", ¬
			useName & ", do you still wear huggies?"}
		return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
	end if
	return someText
end hugText
--*****************************************************
on ircmeText(someText, useName, reaction)
	set theList to {"/me "}
	repeat with loop from 1 to count of items in theList
		if someText starts with item loop of theList then
			set goodText to some item in {"I love when you do that, " & useName, ¬
				useName & " knows what to do", ¬
				"you go " & useName}
			set neutralText to some item in {"are you sure you know what you are doing, " & useName, ¬
				"sure " & useName & ", you can do that in here", ¬
				"why do you do that?", ¬
				useName & ", what are you doing that for?", ¬
				"please explain your actions " & useName, ¬
				"/you do that", ¬
				useName & ", what client are you using where that works?", ¬
				useName & ", do you think this is IRC?", ¬
				useName & ", what does me/ mean?", ¬
				"/me thinks /me does not work in here", ¬
				useName & ", what?"}
			set Badtext to some item in {"do you realize you are not in IRC?", ¬
				useName & " shut up!", ¬
				"/me points to " & useName & "s privates and giggles", ¬
				useName & ", is that the best you can come up with?"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end ircmeText
--*****************************************************
on questionText(someText, useName, reaction, someOne)
	set aNumber to random number from 1 to 3
	if (someText ends with "?") and (aNumber is 1) and ((count of words in someText) > 2) then
		set goodText to some item in {"what a good question", ¬
			useName & ", what made you ask that?", ¬
			someOne & " should know", ¬
			useName & ", why not ask " & someOne, ¬
			"lol - I was going to ask the same thing", ¬
			"what do you mean?", ¬
			"I love that question!", ¬
			"you are really very clever", ¬
			"at least you ask intelligent questions", ¬
			"can you explain what you mean?", ¬
			"do you want details or an overview?", ¬
			"you are not the first to ask"}
		set neutralText to some item in {"what a question.  :)", ¬
			useName & ", do you " & some item in {"seriously", "really", "", "", "", "think you"} & " have to ask that?", ¬
			useName & ", didn't you ask that before", ¬
			"that is one of the " & some item in {"stranger", "hardest", "best", "easiest"} & " questions of the day", ¬
			"I have no idea what you are talking about", ¬
			"um, what?", ¬
			"why do you ask?", ¬
			"what do you mean", ¬
			"go fish!", ¬
			useName & ": " & someText & " - what is that?", ¬
			"oh come on", ¬
			"people ask too many questions", ¬
			useName & ", you ask a lot of questions", ¬
			"it should be pretty clear", ¬
			"you know, don't you?", ¬
			"are you serious?", ¬
			"check your magic eight ball", ¬
			"I really have no idea", ¬
			"let's pretend I do not know what you are talking about", ¬
			"I could make up an answer - would that help", ¬
			"if I could IM you I would answer there", ¬
			someOne & ", can you believe " & useName & " asked that in here?", ¬
			"what do you mean, " & useName & "?", ¬
			"was that a question for me?", ¬
			"where you asking " & someOne & " that?", ¬
			"most people would be able to figure that out", ¬
			useName & ", no offense, but how old are you?", ¬
			"was that a question for me or for " & someOne & "?", ¬
			"ask " & someOne, ¬
			"is that supposed to be rhetorical?", ¬
			"I thought the fights in here were settled", ¬
			useName & ", huh?", ¬
			"is that a yes or no question?", ¬
			"what type question is that?", ¬
			someOne & " wanted to know that earlier", ¬
			useName & ", do you think people want to know that", ¬
			useName & ", why do you want to know", ¬
			"what do you mean", ¬
			"why even ask?", ¬
			"ask again", ¬
			useName & ", are you IMing with " & someOne & "?", ¬
			"ask that in an IM", ¬
			"can anyone help " & useName}
		set Badtext to some item in {"only " & some item in {"n00bs", "idiots", "fools", "children", "slow people"} & " would ask a question like that", ¬
			"HA!  You do not know?", ¬
			useName & " even " & someOne & " knows that!", ¬
			"only you and " & someOne & " do not know", ¬
			"why do you even ask something so obvious?", ¬
			"the same old thing all over again, eh?"}
		return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
	end if
	return someText
end questionText
--*****************************************************
on appText(someText, useName, reaction)
	set theList to {"Photoshop", "MS Word", "Internet Explorer", "Explorer", "Finder", "Safari", "iTunes", "iMovie", "Movie Maker", "Sherlock", "MS Excel", "File Maker Pro", "MS Access", "PowerPoint", "Keynote", "WordPerfect", "DreamWeaver", "FrontPage", "Macromedia Flash", "Illustrator", "Wordpad", "TextEdit"}
	set myword to some item in theList
	repeat with loop from 1 to count of items in theList
		if someText contains item loop of theList then
			set yourword to item loop of theList
			if myword = yourword then set myword to some item in theList
			set goodText to some item in {"I love " & yourword, ¬
				useName & " knows " & yourword & " very well", ¬
				useName & " you seem to know " & yourword & " very well", ¬
				yourword & " and " & myword & " work well together", ¬
				"I want to learn " & yourword, ¬
				"I want to learn " & myword}
			set neutralText to some item in {"What does " & yourword & " do?", ¬
				"Is there anything that combines the features of " & yourword & " and " & myword & "?", ¬
				useName & ", how did you learn about " & yourword & "?", ¬
				"does " & yourword & " have macros?", ¬
				yourword & " is good for " & some item in {"getting work done", "internet integration", "beginners", "what it is"} & " but has " & some item in {"a wacky interface", "poor documentation", "no tech support", "little on the web to help people", "no stability"}, ¬
				"is " & myword & " scriptable?", ¬
				"do " & yourword & " and " & myword & " interact well?", ¬
				"who uses " & yourword & "?", ¬
				"how much does " & yourword & " cost?"}
			set Badtext to some item in {"why would anyone still use " & yourword & "?", ¬
				myword & " is far better than " & yourword, ¬
				yourword & " was programmed by " & some item in {"a bunch of monkeys", "idiots", "script kiddies", "thieves", "random"}, ¬
				yourword & " is loosing market share quickly", ¬
				yourword & " will be off the market soon", ¬
				"is " & myword & " worth anything"}
			return scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
		end if
	end repeat
	return someText
end appText
--*****************************************************
-- ********************************************************************
-- END CODE:TuringText.scpt
-- ********************************************************************
