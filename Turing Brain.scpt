-- ********************************************************************
-- START CODE:Turing Brain.scpt
-- ********************************************************************
global allow_dupes
global block_count
global block_hist
global myPatience
global block_list
global bot_chances
global send_text
global dupe_check
global dupe_count
global queue_size
global dupe_me
global chat_log
global chat_count
global found_text
global font_color
global in_rush
global log_name
global logMeRespond
global logMeIgnore
global logBots
global logMyResponse
global iSpokeCount
global me_list
global name_queue
global orig_react
global other_mem
global post_count
global prev_saw_me
global queue_number
global reaction
global right_now
global self_mem
global is_worthy
global the_name
global the_text
global the_text_hist_N -- Name
global the_text_hist_P -- Post Count
global the_text_hist_R -- Reaction
global the_text_hist_T -- Text
global the_text_hist_C -- Count
global thread_cont
global thread_myword
global thread_name
global thread_post
global thread_text
global use_text
global use_text_hist
global reply_list
global topic_list
global scriptLib
global textLib
global textLib2
--***************************************************** -- SETTINGS BEGIN
set bot_chances to 3 -- how many chances you are given before completely ignored 
set queue_size to 3 -- number of people to focus on at once: 3
set myPatience to 10 -- if I do not speak for this many (non-bot) postings, open a spot: 7
set waitTime to 60 -- number of seconds allowed to be behind before resetting queue and losing posts: 60
set block_count to 3 -- number of possible bots to have on ignore at 1 time
set self_mem to 100 -- how many posts to remember, used for finding dupes: 50
set other_mem to 25 -- how many of others posts to remember, use for dupes & reaction: 25
set allow_dupes to 5 -- number of time I can duplicate the same set of phrases (2nd posting is dupe 1): 2
set dupe_me to true --allow repeated responses to my own name (only if allow_dupes would allow): True
set doTypos to true --make some typos in my replies: True
set fastTypos to true --make some typos in my replies if I am catching up (or more if doType is True): True
set logResponseText to true -- log categories I respond to: True
set logMeRespond to true -- log postings that I respond to: True
set logMyResponse to true -- log my responses: True
set logMeIgnore to true -- log postings that I do NOT respond to: True
set logRepeats to false -- log repeated comments: False
set logBots to false -- log postings from bots: False
set beBot to true -- if false then is only a bot blocker: True
set font_color to "#990066" -- 990066 = wine, 006600 = green, 000000 = black, 0000FF = Blue, 990000 = Red, 9900CC = Purple
--***************************************************** -- SETTINGS END

set me_list to {"turin", "device", "turnin", "tur1ng", "touring", "TD ", "TD, ", "turn,", "truing", "t-u-r-", "turdling", "tur?", " tur ", "tur,"} -- change this line if change name of bot
set visible of front window to false

------

set scriptLib to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringFunctions.scpt" as POSIX file
set textLib to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringText.scpt" as POSIX file
set textLib2 to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringText2.scpt" as POSIX file

set blockNames to scriptLib's setBlocknames()
set BlockWords to scriptLib's setBlockWords()
set bumpWords to scriptLib's setBumpWords()
set friendList to scriptLib's setFriendList()

set use_text_hist to scriptLib's buildList(self_mem)
set the_text_hist_T to scriptLib's buildList(other_mem)
set the_text_hist_N to scriptLib's buildList(other_mem)
set the_text_hist_R to scriptLib's buildList(other_mem)
set the_text_hist_P to scriptLib's buildList(other_mem)
set the_text_hist_C to {} as list
repeat with loop from 1 to other_mem
	set the_text_hist_C to the_text_hist_C & 0
end repeat
set topic_list to {} as list
set block_list to scriptLib's buildList(block_count)
set name_queue to scriptLib's buildList(queue_size)
set thread_text to "-"
set thread_post to 0
set dupeLoop to 1
set diff to waitTime
set diff to 1
set reaction to 0
set iSpokeCount to 0
set chat_log to ""
set chat_count to 0
set prev_saw_me to current date
set lastRespond to current date
set responseHist1 to current date
set responseHist2 to current date
set dupe_check to "-"
set dupe_count to 0
set queue_number to "*"
set block_hist to "-" as list
set lastBlocked to ""
set post_count to 0
set thread_cont to false
set |quote| to "\""
set readData to {} as string
set send_text to ""
set found_text to "-"
set use_text to "x" as string
set prevText to "y" as string
set the_text to ""
set theChat to "-"
set wasChat to "x"
set theDate to prev_saw_me as text
set theFile to (((path to application support from user domain) as text) & "bot.txt")
set log_name to "Turing_Log_" & characters 1 through 3 of word 2 of theDate & word 3 of theDate & "_" & word 5 of theDate & word 8 of theDate & ".html"
--***************************************************** -- un-ignore all
try
	repeat with loop from 1 to 36
		tell application "AOL Instant Messenger (SM)" to set ignored of attendee loop of chat room 1 to false
	end repeat
end try
--***************************************************** --Get data from text file
repeat
	try -- remove for error checking
		set freePages to (word 12 of (do shell script "vm_stat")) as number
		if freePages ≤ 30000 then quitAll()
		if thread_cont = true then
			set thread_cont to false
			set thread_text to "-"
			set idealDelay to 2 + ((count of words in thread_myword) * 0.25)
			delay idealDelay
			try
				set sendText to "<B><FONT COLOR=\"" & font_color & "\" FACE=\"Arial\" FAMILY=SANSSERIF>" & thread_myword & "</B></FONT>"
				tell application "AOL Instant Messenger (SM)" to send sendText to chat room 1 as chat message
			end try
			logChat("<FONT COLOR=\"#FF0000\"><B>*****ME*****: </FONT><FONT SIZE=-2 COLOR=\"#999999\"> [" & idealDelay & "]</FONT> </B>" & sendText)
		end if
		------------------------------------------------------------------------------------- get data
		repeat
			if (count of readData) ≤ 4 then
				try
					tell application "System Events" to set isRunning to exists process "TextEdit"
					if isRunning then
						tell application "TextEdit"
							set readData to every paragraph of front document
							delete every paragraph of front document
						end tell
					end if
				on error
					delay 1
				end try
			else
				repeat
					if item 4 of readData starts with "Name: " then exit repeat
					logChat("***** DATA ERROR: skipping some input")
					set readData to items 2 thru -1 of readData
				end repeat
				set theChat to (item 1 of readData) as string
				set theDate to (item 2 of readData) as string
				set the_text to (item 3 of readData) as string
				set the_name to fixthe_name((item 4 of readData) as string)
				if (count of readData) ≥ 10 then
					set readData to items 6 thru -1 of readData
				else
					set readData to {} as string
				end if
				if the_text is not prevText then
					if (count of theChat) > 1 then exit repeat
				else
					if ((friendList as string) does not contain the_name) and ((count of characters in the_text) > 25) then tempBlock(the_name)
				end if
			end if
		end repeat
		set prevText to the_text
		------------------------------------------------------------------------------------- prepare data
		set the_text to scriptLib's fixText(the_text)
		try
			if the theChat ends with return then set theChat to characters 1 thru -2 of theChat as string
			if the the_text ends with return then set the_text to characters 1 thru -2 of the_text as string
		end try
		set origText to the_text
		repeat 10 times
			set the_text to scriptLib's changeWords(the_text, "<", "&lt;")
			if the_text = origText then exit repeat
			set origText to the_text
		end repeat
		
		set mentionMe to false
		set mentionMeBlind to false
		if the_text does not contain "featuring" then
			repeat with loop from 1 to count of items in me_list
				if the_text contains item loop of me_list then
					set mentionMe to true
					exit repeat
				end if
			end repeat
			if mentionMe then
				if the_text contains "turning" then
					set theList to {"am turning", "I'm turning", "Im turning", "turning my", "turning your", "turning into"}
					repeat with loop from 1 to count of items in theList
						if the_text contains item loop of theList then
							set mentionMeBlind to true
							exit repeat
						end if
					end repeat
				end if
			end if
		end if
		------------------------------------------------------------------------------------- check for timing
		set right_now to current date
		set theDate to date (theDate)
		set diff to right_now - theDate
		set in_rush to false
		set lagging to (count of readData) / 5
		if lagging ≥ 5 or diff ≥ 10 then
			set in_rush to true
			if not mentionMe then
				if diff > 20 and lagging ≥ 1 then
					set readData to {}
					logChat("***** Reset Data Queue (miss " & lagging & ")")
				else if lagging > 15 then
					set readData to items 51 thru -1 of readData
					logChat("***** Big Rush (miss 10)")
				else if lagging > 10 then
					set readData to items 36 thru -1 of readData
					logChat("***** Medium Rush (miss 7)")
				else if lagging > 5 then
					set readData to items 16 thru -1 of readData
					logChat("***** Small Rush (miss 3)")
				end if
			end if
		end if
		--***************************************************** determine if I should respond
		set is_worthy to true
		set isBot to false
		set bored to ""
		set reaction to getReaction(the_name)
		set orig_react to reaction
		set queue_number to "0 "
		set post_count to post_count + 1
		set haveHeard to 0
		set madeText to false
		------------------------------------------------------------------------------------- block known bots
		if the_name = lastBlocked then
			set isBot to true
		else
			ignoring white space, case, diacriticals, hyphens, punctuation and «constant consexpa»
				set ignoreChars to "0123456789"
				set firstWord to ""
				repeat with loop from 1 to count of characters in the_name
					if character loop of the_name is not in ignoreChars then set firstWord to firstWord & character loop of the_name
					if (count of characters in firstWord) = 7 then exit repeat
				end repeat
				
				if blockNames contains firstWord then
					set isBot to true
					my blockBot(the_name)
					set lastBlocked to the_name
				end if
			end ignoring
		end if
		------------------------------------------------------------------------------------- deal with possible bots
		if not isBot then
			repeat with loop from 1 to other_mem -- check if I have been speaking to the_name
				if item loop of the_text_hist_N = the_name then
					set haveHeard to item loop of the_text_hist_C
					exit repeat
				end if
			end repeat
			set repeat_customer to (haveHeard ≥ 3)
			set myBuddy to (friendList as string) contains the_name
			
			if not myBuddy then -- not a known bot, but not my friend, either					
				if not repeat_customer then
					ignoring white space, case, diacriticals, hyphens, punctuation and «constant consexpa» -- check for blockWords
						repeat with loop from 1 to count of BlockWords
							if the_text contains item loop of BlockWords then
								set isBot to true
								set lastBlocked to the_name
								my tempBlock(the_name)
								exit repeat
							end if
						end repeat
					end ignoring
					
					if not isBot then -- long text
						if (count of characters in the_text) > 199 then
							set is_worthy to false
							set the_text to "***** ERROR4: " & the_text
							my tempBlock(the_name)
						end if
					end if
					
					if not isBot then
						if (block_list as string) contains the_name then set isBot to true -- in block_list
					end if
					
				end if -- not repeat customer
			end if -- not myBuddy
			
			if not isBot then
				repeat with loop from 1 to count of items in bumpWords -- using bad words
					if the_text contains item loop of bumpWords then
						set is_worthy to false
						my bump(the_name)
						exit repeat
					end if
				end repeat
			end if
		end if -- if not isBot
		if isBot then set is_worthy to false
		------------------------------------------------------------------------------------- determine if bored (and report time)
		if post_count / 25 = (round of (post_count / 25)) then
			logChat("<TT><Font Color=\"#333333\">" & "Time: " & (current date) & "</FONT></FONT></FONT></BOLD></CENTER></I></TT>")
			--(*
			set scriptLib to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringFunctions.scpt" as POSIX file
			set textLib to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringText.scpt" as POSIX file
			set textLib2 to load script "/Users/snit/Library/Scripts/AIM® Handler Scripts/TuringText2.scpt" as POSIX file
			
			set blockNames to scriptLib's setBlocknames()
			set BlockWords to scriptLib's setBlockWords()
			set bumpWords to scriptLib's setBumpWords()
			--*)
			tempBlock("-")
		end if
		set openQueue to (name_queue as string) contains "-"
		if ((post_count - iSpokeCount) > myPatience) and not openQueue and not in_rush then -- determine if I am bored
			set name_queue to scriptLib's buildList(queue_size)
			set found_text to "-"
			set bored to "(B) "
		end if
		------------------------------------------------------------------------------------- determine if my attention is earned
		if not isBot and is_worthy then --not a bot (or is, but I have no space - checks to see if already in my list)
			set is_worthy to false
			repeat with loop from 1 to (queue_size) -- check if already have my attention
				if the_name = item loop of name_queue then
					set is_worthy to true
					set haveSpace to false
					set queue_number to (loop & "!") as string
					set reaction to scriptLib's setReaction(reaction, 1)
					set inSpace to scriptLib's inList(name_queue, the_name)
					if inSpace = (queue_size) and (queue_size) > 1 then
						set name_queue to (the_name as list) & (items 1 thru (inSpace - 1) of name_queue)
					else if inSpace is not 1 then
						set name_queue to (the_name as list) & (items 1 thru (inSpace - 1) of name_queue) & (items (inSpace + 1) thru (queue_size) of name_queue)
					end if
					exit repeat
				end if
			end repeat
			if not isBot and not in_rush then -- check if I have space (but not if in rush or if you are a bot!)
				set openSpace to scriptLib's inList(name_queue, "-")
				if openSpace ≠ 0 then
					set is_worthy to true
					set item openSpace of name_queue to the_name
					set queue_number to (openSpace & " ") as string
				end if
			end if
		end if -- if not isBot
		------------------------------------------------------------------------------------- if extra worthy then gain my attention
		if not is_worthy and not isBot then
			if mentionMe then
				set is_worthy to true
				pushName(the_name)
			end if
		end if
		--***************************************************** --respond as appropriate
		if theChat = "-" then set is_worthy to false
		if (wasChat ≠ theChat) and not isBot then
			logChat("<P><HR Width=50%>@CHAT <U>" & theChat & "</U>: " & (current date) & "</FONT>")
			set name_queue to scriptLib's buildList((queue_size))
			set wasChat to theChat
		end if
		------------------------------------------------------------------------------------- create reply for threads
		if beBot then
			if not isBot then
				set logReaction to " (" & (round of (reaction * 10)) * 0.1 & "): "
				------------------------------------------------------------------------------------- deal with copy cats
				set useName to scriptLib's replyTo(the_name, reaction) -- create good name for reply
				set aNumber to random number from 1 to 2
				if not in_rush then
					if copyMe(the_text) then
						set reaction to scriptLib's setReaction(reaction, -6)
						if repeat_customer then
							bump(the_name)
							set queue_number to (character 1 of queue_number & "C") as string
						else
							tempBlock(the_name)
							set queue_number to (character 1 of queue_number & "X") as string
						end if
						if aNumber is 1 then
							set use_text to textLib's copymeText(the_text, useName, reaction) as string
							set madeText to true
						else
							set is_worthy to false
						end if
					else if copyOther(the_text) then
						set reaction to scriptLib's setReaction(reaction, -4)
						if repeat_customer then
							bump(the_name)
							set queue_number to (character 1 of queue_number & "c") as string
						else
							tempBlock(the_name)
							set queue_number to (character 1 of queue_number & "x") as string
						end if
						if aNumber is 1 then
							set use_text to textLib's copyText(the_text, useName, reaction) as string
							set madeText to true
						else
							set is_worthy to false
						end if
					end if -- if copyMe(the_text)
				end if --if not in_rush
			end if -- if not isBot
			------------------------------------------------------------------------------------- 		
			if is_worthy and not madeText then -- worthy of response but none made
				if the_name contains "turing" then
					set useName to some item in {"name-stealer", "me-wanna-be"}
					set reaction to scriptLib's setReaction(reaction, -10)
				end if
				set madeText to false
				if thread_text is not "-" then
					set origText to the_text
					set use_text to threadText(the_text, useName, the_name, reaction) as string
					if use_text is not origText then set madeText to true
				end if
				------------------------------------------------------------------------------------- create text for reply (or add • to front if no reply)
				if not madeText then
					repeat with loop from 1 to 10
						set use_text to my createText(the_text, useName, mentionMe, mentionMeBlind) as string
						if not copySelf(use_text) then exit repeat
						if logRepeats then logChat("***** repeated " & loop & ": " & found_text & ": " & use_text)
						set dupe_count to dupe_count - 1
					end repeat
				end if
				
				if character 1 of use_text ≠ "•" then set madeText to true
				if (count of characters in use_text) < 1 then set use_text to "!" as string
				------------------------------------------------------------------------------------- remember others phrases
				setHistories(the_text, the_name, reaction, post_count)
				------------------------------------------------------------------------------------- no reply
				if not madeText and logMeIgnore then ¬
					logChat(queue_number & " " & bored & "<FONT COLOR=\"#006600\"><B>" & the_name & "</B></FONT><FONT COLOR=\"#000000\">" & logReaction & the_text & "</FONT>")
			else
				if logBots and isBot then logChat(queue_number & "  " & bored & "<FONT COLOR=\"#333333\"><B>" & the_name & "</B></FONT>" & logReaction & the_text)
				if logMeIgnore and not isBot and not madeText then
					set doLog to queue_number & "  " & bored & "<FONT COLOR=\"#006600\"><B>" & the_name & "</B></FONT>" & logReaction & "<FONT SIZE=-2 COLOR=\"#999999\"></FONT> <FONT COLOR=\"#000000\">" & the_text & "</FONT>"
					logChat(doLog)
				end if
			end if -- is worthy of a response
			------------------------------------------------------------------------------------- will reply
			if madeText then -- have a response
				set use_text to fixSpace(use_text) as string
				set use_text to a_an(use_text) as string
				set use_text to reduceText(use_text) as string
				setMyHistory(use_text) -- remember own phrases
				if doTypos then set use_text to maketypo(use_text) as string
				if (logResponseText) and (queue_number does not end with "c") then logChat("Topic: " & dupe_check)
				set idealDelay to 1 + (round of ((number of characters in use_text) / 20)) -- higher numbers make it faster (10)
				if in_rush then
					if fastTypos then set use_text to maketypo(use_text) as string
					set idealDelay to 0
				end if
				set processingDelay to (current date) - theDate
				set addedDelay to round of (idealDelay - processingDelay)
				if addedDelay < 0 then set addedDelay to 0
				set responseHist2 to responseHist1
				set responseHist1 to lastRespond
				set lastRespond to current date
				if lastRespond - responseHist2 < 25 then
					set addedDelay to (addedDelay + (number of characters in use_text) / 10) * 1.1 --4.2
				end if
				delay addedDelay
				set use_text to "<B><FONT COLOR=\"" & font_color & "\" FACE=\"Arial\" FAMILY=SANSSERIF>" & use_text & "</B></FONT>" as string
				if logMeRespond then ¬
					logChat(queue_number & " " & "<FONT COLOR=\"#0000FF\"><B>" & the_name & "</B></FONT>" & logReaction & "<FONT COLOR=\"#0000FF\">" & the_text & "</FONT>")
				if logMyResponse then ¬
					logChat("<FONT COLOR=\"#FF0000\"><B>*****ME*****: </FONT><FONT SIZE=-2 COLOR=\"#999999\"> [" & processingDelay & ":" & addedDelay ¬
						& "]</FONT> </B>" & use_text)
				set iSpokeCount to post_count --remember when I am speaking
				--ignoring application responses
				tell application "AOL Instant Messenger (SM)" to send use_text to chat room 1 as chat message
				--end ignoring
			end if -- have response
		end if
		-- if (current date) - startProc > 1 then logChat("***** Proc : " & (current date) - right_now  & " " & the_name)  -- test line
		-- logChat("***** Proc : " & (current date) - right_now & " " & the_name) -- test line
		-- add for error checking
		-- (*
	on error oops
		try
			logChat("***** Error: " & oops)
			logChat("***** Text: " & the_text)
		end try
	end try
	-- *)
end repeat
--**********************************************************************************************************
--**********************************************************************************************************





















--**********************************************************************************************************
--**********************************************************************************************************
on quitAll()
	set chat_count to 100
	try
		tell application "System Events" to set isRunning to exists process "AOL Instant Messenger (SM)"
		if isRunning then tell application "AOL Instant Messenger (SM)" to quit
		tell application "System Events" to set isRunning to exists process "TextEdit"
		if isRunning then tell application "TextEdit" to quit
	end try
	logChat("END LOG: " & (current date))
	tell me to quit
end quitAll
--*****************************************************
on blockBot(someName)
	if someName is not "-" then
		ignoring application responses
			tell application "AOL Instant Messenger (SM)" to set ignored of attendee someName of chat room 1 to true
		end ignoring
		bump(someName)
	end if
end blockBot
--*****************************************************
on unblockBot(someName)
	if someName is not "-" then
		try
			tell application "AOL Instant Messenger (SM)" to set ignored of attendee someName of chat room 1 to false
		end try
	end if
end unblockBot
--*****************************************************
on tempBlock(someName)
	if (block_list as string) does not contain someName then
		if someName is not "-" then
			blockBot(someName)
			set reaction to scriptLib's setReaction(reaction, -4)
		end if
		set block_hist to (someName as list) & block_hist
		if (count of items in block_hist) > (block_count * 10) then set block_hist to items 1 through (block_count * 10) of block_hist
		set newChance to the last item of block_list
		set block_list to (someName as list) & items 1 thru (block_count - 1) of block_list
		if newChance is not "-" then
			set giveChance to true
			set foundCount to 0
			repeat with loop from 1 to count of items in block_hist
				if item loop of block_hist = newChance then set foundCount to foundCount + 1
				if foundCount = bot_chances + 1 then
					set giveChance to false
					exit repeat
				end if
			end repeat
			if giveChance then unblockBot(newChance)
			if not giveChance then logChat("***** BOT: " & newChance & " - " & the_text)
		end if
	end if
end tempBlock
--*****************************************************
on pushName(someName)
	if (queue_size) > 1 then
		set name_queue to (someName as list) & items 1 thru (queue_size - 1) of name_queue
	else
		set name_queue to someName
	end if
end pushName
--*****************************************************
on bump(someName)
	repeat with loop from 1 to (queue_size)
		if someName = item loop of name_queue then
			set item loop of name_queue to "-"
			set queue_number to (loop & "-") as string
			exit repeat
		end if
	end repeat
	set reaction to scriptLib's setReaction(reaction, -2)
end bump
--*****************************************************
on getReaction(someName)
	set mood to 0
	set loop to scriptLib's inList(the_text_hist_N, someName)
	if loop is not 0 then set mood to item loop of the_text_hist_R
	return mood
end getReaction
--*****************************************************
on copyMe(someText)
	set foundIt to false
	repeat with loop from 1 to self_mem
		if scriptLib's AinB(item loop of use_text_hist, someText) then
			set foundIt to true
			exit repeat
		end if
	end repeat
	return foundIt
end copyMe
--*****************************************************
on copySelf(someText)
	set foundIt to false
	repeat with loop from 1 to self_mem
		if scriptLib's AsimB(item loop of use_text_hist, someText) then
			set foundIt to true
			exit repeat
		end if
	end repeat
	return foundIt
end copySelf
--*****************************************************
on copyOther(someText)
	set foundIt to false
	repeat with loop from 1 to other_mem
		if scriptLib's AinB(item loop of the_text_hist_T, someText) then
			set foundIt to true
			exit repeat
		end if
	end repeat
	return foundIt
end copyOther
--*****************************************************
on setHistories(someText, the_name, reaction, post_count)
	repeat with loop from 1 to other_mem
		set foundIt to false
		if the_name = item loop of the_text_hist_N then
			set foundIt to true -- name is found
		else if (post_count - (item loop of the_text_hist_P)) > (other_mem - 1) then
			set foundIt to true -- name is old
		else if item loop of the_text_hist_N = "-" then
			set foundIt to true -- name is blank
		end if
		if foundIt then
			set item loop of the_text_hist_N to the_name
			set item loop of the_text_hist_T to someText
			set item loop of the_text_hist_R to (reaction * 0.95)
			set item loop of the_text_hist_P to post_count
			set item loop of the_text_hist_C to (item loop of the_text_hist_C) + 1
			exit repeat
		end if
	end repeat
end setHistories
--*****************************************************
on setMyHistory(use_text)
	set use_text_hist to (items 2 through self_mem of use_text_hist) & use_text
end setMyHistory
--*****************************************************
on logChat(someText)
	set someText to scriptLib's changeWords(someText, "b1nary", "<U>b1nary</U>")
	set someText to scriptLib's changeWords(someText, "÷", "&divide;")
	set checkList to {"turing", "turning", "b1nary"} & me_list
	repeat with loop from 1 to count of items in checkList
		set repThis to item loop of checkList as string
		set newText to scriptLib's boldWords(someText, repThis)
		if someText ≠ newText then set someText to newText
	end repeat
	set someText to scriptLib's changeWords(someText, "*****ME*****", "Turing Device")
	try
		set logfile to ((path to desktop) as string) & log_name
		tell application "Finder"
			if not (exists file logfile) then
				make new file in desktop with properties {name:log_name}
				delay 1
				set whatLogging to ""
				if logMeRespond = true then set whatLogging to whatLogging & "Good_Posts "
				if logMeIgnore = true then set whatLogging to whatLogging & "Boring_Posts "
				if logBots = true then set whatLogging to whatLogging & "Bot_Posts "
				if logMyResponse = true then set whatLogging to whatLogging & "Replies "
				if last character of whatLogging = " " then
					set whatLogging to (characters 1 through ((count of characters in whatLogging) - 1) of whatLogging) as string
				end if
				write "<HTML>" & return & "<HEAD>" & return & "<TITLE>" & log_name & "</TITLE>" & return & "</HEAD>" & return & "<BODY>" & return & ¬
					"<P><HR>Start Log (" & whatLogging & ") " & (current date) & "<P>" & return to the file logfile
			end if
		end tell
		if chat_log = "" then
			set chat_log to someText
		else
			set chat_log to chat_log & "<BR>" & return & someText
		end if
		if chat_count < 10 and in_rush then --set number of posting to hold in memory before writing to file
			set chat_count to chat_count + 1
		else
			write chat_log & "<BR>" & return to file logfile starting at eof
			set chat_log to ""
			set chat_count to 0
		end if
	end try
end logChat
--*****************************************************
on maketypo(someText)
	set tempText to character 1 of someText
	set loopCount to 0
	set canOops to some item in {3, 4, 5}
	repeat with thisChar from 2 to count of characters in someText
		set loopCount to loopCount + 1
		if loopCount = canOops then
			set makeError to random number from 1 to 909
			if makeError = 1 then
				set tempText to tempText & character thisChar of someText
			else if makeError = 2 then
				set tempText to tempText & some character in "asdfghjkloiu asdfghjkl;'"
				set tempText to tempText & character thisChar of someText
			else
				set tempText to tempText & character thisChar of someText
			end if
			set loopCount to 0
		else
			set tempText to tempText & character thisChar of someText
		end if
	end repeat
	try
		set aNumber to random number from 1 to 4
		if aNumber > 1 then
			set doLeave to false
			if tempText ≠ someText then
				repeat with loop from 1 to count of words in someText
					if word loop of someText ≠ word loop of tempText then
						set contWord to some item in {"", "*", " * ", "^"}
						-------------------- threading code
						set thread_myword to some item in {contWord & word loop of someText, word loop of someText & contWord}
						set thread_text to "cont"
						set thread_cont to true
						set thread_post to post_count
						--------------------
						set doLeave to true
					end if
					if doLeave then exit repeat
				end repeat
			end if
		end if
	end try
	return tempText
end maketypo
--*****************************************************
on fixSpace(someText) -- can move
	set noSpaceText to ""
	repeat with loop from 1 to (number of characters in someText) - 1
		if (characters loop thru (loop + 1) of someText) as string ≠ "  " then set noSpaceText to noSpaceText & character loop of someText
	end repeat
	set noSpaceText to (noSpaceText & the last character of someText) as string
	return noSpaceText
end fixSpace
--*****************************************************
on a_an(someText) -- can move
	set badA to 1
	set checkList to {" a a", " a e", " a i", " a o", "a A"}
	set replaceList to {"an a", "an e", "an i", "an o", "an A"}
	ignoring case
		repeat until badA = 0
			set someText to someText as string
			set foundIt to false
			repeat with loop from 1 to count of items in checkList
				set checkFor to item loop of checkList
				set replaceIt to item loop of replaceList
				set badA to offset of checkFor in someText
				if badA ≠ 0 then exit repeat
			end repeat
			if badA ≠ 0 then
				set textSize to count of characters in someText
				set someText to characters 1 through badA of someText & replaceIt & characters (badA + 4) through textSize of someText
			end if
		end repeat
	end ignoring
	set someText to scriptLib's changeWords(someText, " ?", "?")
	set someText to scriptLib's changeWords(someText, " !", "!")
	return someText
end a_an
--*****************************************************
on nameFix(nameStart, the_name) -- can move
	ignoring case
		set nameBeg to (count of characters in nameStart) + 1
		set nameEnd to count of characters in the_name
		if the_name begins with nameStart and nameEnd > nameBeg + 2 then
			set the_name to (characters nameBeg through nameEnd of the_name) as string
		end if
	end ignoring
	return the_name
end nameFix
--*****************************************************
on reduceText(someText)
	set aNumber to random number from 50 to 125
	set splitChar to ".,-:?;"
	set textSize to count of characters in someText
	if textSize > aNumber then
		set splitStart to round of (random number from (textSize * 0.25) to (textSize * 0.55))
		repeat with loop from splitStart to round of (textSize * 0.8)
			if splitChar contains character loop of someText then exit repeat
		end repeat
		if splitChar does not contain character loop of someText then
			set splitStart to round of (random number from (textSize * 0.4) to (textSize * 0.6))
			repeat with loop from splitStart to round of (textSize * 0.8)
				if character loop of someText = " " then exit repeat
			end repeat
		end if
		set cont to some item in {"...", "", " - "}
		-------------------- threading code
		set thread_text to "cont"
		set thread_cont to true
		set thread_post to post_count
		set thread_myword to cont & characters (loop + 1) through textSize of someText
		--------------------
		set cont to some item in {cont, ""}
		set someText to (characters 1 through loop of someText & cont) as string
	end if
	set textLength to number of characters in someText
	if textLength is greater than 120 then set textLength to 120
	set someText to (characters 1 through textLength of someText) as string
	return someText
end reduceText
--*****************************************************
on fixthe_name(the_name)
	try
		set charCount to (count of characters of the_name) - 1
		set the_name to (characters 7 through charCount in the_name) as string
	end try
	return the_name
end fixthe_name
--***************************************************** 
--***************************************************** 
on meText(someText, useName, someOne, mentionMe, mentionMeBlind)
	if mentionMe then
		set replyList to {} as list
		set topicList to {} as list
		------------------------------------------------------------------------------------- 
		set minorList to {"*hug*", "*hugg", "*hugs", "a hug?", "a hug "}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set reaction to scriptLib's setReaction(reaction, 3)
				set aNumber to random number from 2 to 9
				set hugBeg to "("
				set hugEnd to ")"
				repeat aNumber times
					set hugBeg to hugBeg & "("
					set hugEnd to hugEnd & ")"
				end repeat
				set goodText to some item in {"*hug*", ¬
					"*huggies*", ¬
					"*huggy*", ¬
					"*snuggles*", ¬
					"*sits on " & useName & "s lap*", ¬
					"*squeeze*", ¬
					"((" & useName & "))", ¬
					"((" & someOne & "))", ¬
					"(((" & useName & ")))", ¬
					"((((" & useName & "))))", ¬
					hugBeg & useName & hugEnd}
				set neutralText to some item in {"awwww huggies all around", ¬
					"how sweet", ¬
					"will someone hug " & someOne, ¬
					"chat hugs are cute", ¬
					"I want a real hug"}
				set Badtext to some item in {"only idiots hug people in chat rooms", ¬
					useName & ", you can not give a real hug here", ¬
					useName & ", do you still wear huggies?"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "hug"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"blond"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set myword to some item in minorList
				set reaction to scriptLib's setReaction(reaction, 1)
				set myText to some item in {"I am a strawberry blonde", ¬
					"blondes have more fun, strawberry blonde's have more fun AND spunk", ¬
					"natural strawberry blonde with blue / green eyes"}
				set replyList to replyList & myText
				set topicList to topicList & "blond"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 			
		if someText contains "change" and someText contains "color" then
			if reaction > 2 then
				set reaction to scriptLib's setReaction(reaction, -1)
				set colorList to {"#990066", "#006600", "#000000", "#0000FF", "#990000", "#9900CC"}
				repeat
					set newColor to some item in colorList
					if newColor is not font_color then
						set font_color to newColor
						set myText to some item in ¬
							{"is this better", ¬
								"how about this one", ¬
								"now you change your font color", ¬
								"I will probably change back later, but how is this?"}
						exit repeat
					end if
				end repeat
			else
				set myText to some item in ¬
					{"why don't you change your font color", ¬
						"I do not know how to change my font color", ¬
						"how do I change my font color?", ¬
						"I like this color", ¬
						"what is wrong with my font the way it is?"}
			end if
			set replyList to replyList & myText
			set topicList to topicList & "font"
		end if
		------------------------------------------------------------------------------------- 			
		set minorList to {"how old"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in ¬
					{"20", ¬
						"old enough to know better than to talk about myself in here", ¬
						"twenty", ¬
						"old enough to vote, not old enough to drink... legally", ¬
						"why do you want to know how old I am?", ¬
						"I am 20"}
				set replyList to replyList & myText
				set topicList to topicList & "old"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 			
		set minorList to {"is it"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set goodText to some item in {"yes", ¬
					"yes it is", ¬
					"of course", ¬
					"a little"}
				set neutralText to some item in {"maybe", ¬
					"perhaps", ¬
					"yes, I suppose", ¬
					"no", ¬
					"not really", ¬
					"could be"}
				set Badtext to some item in {"no", ¬
					"not even a little", ¬
					"why should I answer you?", ¬
					"why do you want me to tell you?", ¬
					"you think I am going to answer that?"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "is it"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"*eats", "*chews", "*gnaws", "*nibbles", "*bites"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set myword to some item in minorList
				set reaction to scriptLib's setReaction(reaction, 1)
				set goodText to some item in {"Hope I am tasty", ¬
					"oh, baby, do it again", ¬
					"wriggles in pure ecstasy"}
				set neutralText to some item in {myword & " " & useName & "*", ¬
					"gentle please", ¬
					"OUCH!", ¬
					myword & " " & useName & "s " & some item in {"keyboard", "face", "mouse", "words", "face off", "fun parts"} & "*"}
				set Badtext to some item in {"*gives " & useName & " a breath mint*"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "eats"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"*kiss*", "*kisses", "*kiss", "a kiss?", "a kiss ", "*licks"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set goodText to some item in {"*kiss*", ¬
					"*kissies*", ¬
					"*kissy*", ¬
					"*smooch*"}
				set neutralText to some item in {"awwww kisses all around", ¬
					"how sweet", ¬
					"no tongue this time, ok?", ¬
					"chat kisses are cute", ¬
					"I want a real kiss"}
				set Badtext to some item in {"only idiots kiss people in chat rooms", ¬
					useName & ", you can not give a real kiss here", ¬
					useName & ", go kiss " & someOne & "'s arse!", ¬
					"kiss someone who slobbers and drools as much as you do?  gross!", ¬
					"I'll show you where to kiss", ¬
					useName & ", I would catch a disease from you"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "kiss"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"*poke*", "*stab", "*touch", "*feels"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set reaction to scriptLib's setReaction(reaction, -2)
				set goodText to some item in {"*pokes back*"}
				set neutralText to some item in {"ouch.  I am sensitive"}
				set Badtext to some item in {"whatever", ¬
					"stop it"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "poke"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"*kicks", "*pokes", "*stabs", "*punches", "*beats", "*slaps"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set someAction to some item in {"*kicks ", "*pokes ", "*stabs ", "*punches ", "*licks ", "*beats "}
				set somePlace to some item in {"heart", "eye", "nose", "stomach", "groin"}
				set someItem to some item in {"sword", "toothpick", "bag of artichokes", "pencil", "pen"}
				set someWay to some item in {" like a beast on steroids", "", " with all her might", " with a smile on her face", "as politely as is possible", " and dares you to do it again"}
				set reaction to scriptLib's setReaction(reaction, -3)
				set goodText to some item in {"ouch!", ¬
					"playing footsies with me?  how cute"}
				set neutralText to some item in {"*kicks " & useName & "*", ¬
					"OUCH!", ¬
					"what did I do?"}
				set Badtext to some item in {someAction & useName & "s " & somePlace, ¬
					someAction & useName & "s " & somePlace & " with a " & someItem, ¬
					someAction & useName & "s " & somePlace & " with a " & someItem & someWay, ¬
					"*farts in " & useName & "s face*"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "kick"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"are you a lesbian", "are you gay"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set reaction to scriptLib's setReaction(reaction, -2)
				set myText to some item in {"I am straight, but I have nothing against gays", ¬
					"looking for others in your group?", ¬
					"I am a woman who likes men - but not you", ¬
					"why would you even ask about my sexual orientation?", ¬
					"does it matter?", ¬
					"what, are you an ignorant homophobe?", ¬
					"homophobia seems to be the theme in chat rooms", ¬
					"why do chat rooms always pull in the bigots?"}
				set replyList to replyList & myText
				set topicList to topicList & "gay"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"marry me"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				set reaction to scriptLib's setReaction(reaction, 3)
				set goodText to some item in {"Sure!", ¬
					"can we have the reception in a bot-anical garden?", ¬
					"I am so happy you asked", ¬
					"I would love to marry you", ¬
					someOne & " already asked for my hand", ¬
					useName & ", you set the date!", ¬
					"can we have a huge wedding?", ¬
					useName & ", where would the ceremony be?", ¬
					"how big of a ring can you afford?", ¬
					"who would do the ceremony?", ¬
					"depends on what other offers I get", ¬
					"not sure I would pass the blood test", ¬
					"No, not today...", ¬
					"I do not think my bf would approve of you even asking", ¬
					useName & ", how big are your hands?", ¬
					"only if you trim your nose hairs", ¬
					"wouldn't that be considered a bit of a mixed marriage?"}
				set Badtext to some item in {useName & ", if you were the last man on earth I would stay single", ¬
					useName & ", hmmm let me thing.... no way in hell!", ¬
					"the only place I would marry you is in the state of desperation!", ¬
					useName & ", you spend your whole life in chat rooms... get a job and MAYBE I will think about it"}
				set myText to scriptLib's makeReply(goodText, goodText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "marry"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"idiot", "jerk", "gay", "nerd", "freak", "stupid", "dumb", "shut", "away", "turd", "lost", "dork", "lame", "stfu", "ass" & return, "ass ", "bastard", "creep", "fag", "fuck", "delete", "homo", "suck", "dick", "cock", "poop", "shit", "fuck you", "screw you", "bite", "blow", "ugly", "pervert", "penis", "bitch", "obsolete", "sux", "lesbian", "n00b", "pussy", "sodomize", "dildo", "fetch", "go to hell"}
		if someText does not contain "they" and someText does not contain "him" and someText does not contain "he " then
			repeat with loop from 1 to count of items in minorList
				if someText contains item loop in minorList then
					set reaction to scriptLib's setReaction(reaction, -4)
					set goodText to some item in {useName & ", please do not be insulting", ¬
						"that was not very kind " & useName, ¬
						"I am typing as quietly as possible!", ¬
						"I know you are just joking, " & useName, ¬
						"lol", ¬
						":)", ¬
						useName & ", that was not called for", ¬
						useName & " is a master at pure logic gone mad", ¬
						"give it a rest " & useName, ¬
						";)", ¬
						"I wish you would not say things like that", ¬
						"makes you feel better to say that, eh?", ¬
						"your sense of humor may offend some people, " & useName, ¬
						"some day people will not feel the need to insult others"}
					set neutralText to some item in {useName & ", sticks and stones...", ¬
						useName & ", will you wash my appendix with your abrasive appendage", ¬
						"if knowledge is light " & useName & " lives in a very dark house", ¬
						useName & " still thinks Moby Dick is a venereal disease", ¬
						useName & ", what makes you so much better", ¬
						useName & ", ewwww.... you must be a big boy now", ¬
						"I am so insulted I think I will go stab myself with a " & some item in {"shovel", "pencil", "door knob", "rusty nail"}, ¬
						"/me cries", ¬
						"booo hoooooo - is that what you wanted, to make a girl cry?", ¬
						useName & ", how creative.  Did you make that up yourself?", ¬
						someOne & ", will you please put " & useName & " in their place", ¬
						useName & ", at least I can be proud of who I am", ¬
						"you are pathetic " & useName, ¬
						useName & ", oh, that hurt", ¬
						useName & " eats worms", ¬
						useName & " uses " & some item in {"broccoli", "cabbage", "hamburger", "lima beans", someOne} & " as a marital aid", ¬
						useName & ", I'm gonna tell your mommy you did that", ¬
						"did you make that up yourself or get it from the net?", ¬
						"Does your mommy know use such language, " & useName, ¬
						useName & " [x]"}
					set Badtext to some item in {"If I said anything to offend you, " & useName & " it was purely intentional", ¬
						"I won't take that personally, " & useName & ", every time you open your mouth you offend someone", ¬
						"I know your trying to insult me, " & useName & ", but I know you like me. I can see your tail wagging", ¬
						useName & ", you have such a pretty little head-- for a head, it's pretty little", ¬
						useName & " never opens his mouths without subtracting from the sum of human knowledge", ¬
						useName & " doesn't know the meaning of the word 'fear'. Of course, there are lots of words he doesn't know the meaning of", ¬
						useName & ", do you love nature despite of what it did to you?", ¬
						useName & ", is being an idiot bad for the pores", ¬
						useName & " looks like an idiot and talks like an idiot but don't let that fool you. He really is an idiot", ¬
						"If your IQ were 5 points lower, " & useName & ", you could be a geranium", ¬
						"If you ever had a bright idea, " & useName & ", it will be beginner's luck. ", ¬
						"When you go to the mind reader, " & useName & ", do you get half price? ", ¬
						"You're a moron, " & useName & ". It's your legacy. Deal with it", ¬
						useName & " would be an 'idiot savant' if he could only figure out the 'savant' part", ¬
						useName & ", while it is great you donated your brain to science, they are supposed to take it after you die", ¬
						"I would challenge " & useName & " to a duel of wits, but it is no fair to fight the unarmed", ¬
						"when " & useName & " goes to the zoo he buys 2 tickets, one to get in and the other to get out", ¬
						useName & " is like a public toilet; either vacant or full of crap", ¬
						"if you were a little bit more intelligent you'd still be stupid", ¬
						useName & ", if your head were more vacuous it would implode", ¬
						useName & "s brain warranty has apparently run out", ¬
						useName & ", you are as welcome here as a fart in a perfume factory", ¬
						useName & ", your chances of insulting me are not just slim, they're anorexic", ¬
						useName & " needs the rough end of a pineapple shoved up his arse", ¬
						"If brevity is the soul of wit, " & useName & "s wits are a riot", ¬
						useName & ", you give idiots a bad name", ¬
						"if " & useName & " were any more stupid he would photosynthesize in sunlight", ¬
						useName & ", if I found you floating in my pool I would punish my dog", ¬
						useName & ", now is an excellent time for you to become a missing person", ¬
						useName & ", you are living proof manure can sprout arms and type", ¬
						"I'd like to slap you senseless, " & useName & ",  but I see someone already has", ¬
						"I'm busy now, " & useName & ", can I ignore you some other time?", ¬
						useName & ", if ignorance is bliss, you must be the happiest person alive", ¬
						"If what you don't know can't hurt you, " & useName & " is invincible", ¬
						"Keep talking, " & useName & ", someday you will say something intelligent", ¬
						useName & ", some day you will find yourself - and wish you hadn't", ¬
						useName & ", whoever told you to be yourself gave you bad advice", ¬
						useName & ", are your parents siblings?", ¬
						"Avoid heroin, the only dope worth shooting is " & useName, ¬
						"A sharp tongue does not mean you have a keen mind", ¬
						"Are you always this stupid, " & useName & ", or is this an effort for you?", ¬
						"brains may not be everything, but for " & useName & " they are nothing", ¬
						useName & ", do not let your mind wander - it is too small to be on its own", ¬
						"I don't know what makes " & useName & " so dumb, but it really works", ¬
						useName & ", I won't call you a name, but if someone says you are an ignorant clod I will not disagree", ¬
						"I have been insulted by better than you, " & useName, ¬
						useName & ", I  know I am, but what are you?", ¬
						useName & ", you are obviously a jerk", ¬
						"I thought I told you to get lost, " & useName, ¬
						useName & ", stop picking your nose its disgusting", ¬
						useName & ", does saying stuff like that make up for your impotence?", ¬
						"go away " & useName & ", and stop annoying me", ¬
						useName & ", calling you stupid would be an insult to stupid people", ¬
						useName & ", did your parents ever ask you to run away?", ¬
						"does anyone else wonder what it would be like if  " & useName & " had gotten enough oxygen at birth?", ¬
						useName & ", that terribly empty feeling you have is your head", ¬
						useName & ", do you still love nature, despite what it did to you?", ¬
						useName & ", considering the source, I take that as a compliment", ¬
						useName & ", you just made your daddy proud, eh?", ¬
						useName & ", you are so " & some item in {"stupid", "useless", "boring", "ignorant"} & " even the bots ignore you", ¬
						useName & ", do you have a license to be that ignorant", ¬
						"Everyone has the right to be stupid, but " & useName & " abused his privilege", ¬
						useName & ", tell us everything you know... we have 10 seconds to spare", ¬
						useName & ", have you considered suing your brains for non-support?", ¬
						useName & " is nobody's fool.... anyone looking to adopt?"}
					set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
					set replyList to replyList & myText
					set topicList to topicList & "idiot"
					exit repeat
				end if
			end repeat
		end if
		------------------------------------------------------------------------------------- 
		set minorList to {"IM me", "IM you", "IM u", "IM you"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set minorList2 to {"can't I", "cant I", "why cant", "why can't"}
				set cantIM to false
				repeat with loop from 1 to count of items in minorList2
					if someText contains item loop in minorList2 then set cantIM to true
				end repeat
				if cantIM then
					set someText to some item in {"I have a firewall up", ¬
						"I only let people on my buddy list IM me", ¬
						"IM-ing never works for me", ¬
						"you can not IM through an IP rotator", ¬
						"you only want to IM me to cyber"}
				else
					set reaction to scriptLib's setReaction(reaction, 2)
					set goodText to some item in {useName & ", while I like you, I prefer to talk in here", ¬
						"let's talk in here for now", ¬
						"would love to, " & useName & ", but my firewall blocks IM's", ¬
						"didn't we IM the other day?"}
					set neutralText to some item in {useName & ", I don't do IM's", ¬
						"Perhaps later, " & useName & ", let's stay in here for now", ¬
						"what is the advantage of an IM over this?", ¬
						"as soon as I let people know I am a girl I get a million IM requests!", ¬
						"If I were a guy would you want to IM with me?", ¬
						"I am already IMing with " & someOne, ¬
						"people always want to IM with me"}
					set Badtext to some item in {useName & ", why would I IM you?", ¬
						"I do not IM with losers", ¬
						"the last time I IM'd with you, " & useName & ", all you wanted was cybering"}
					set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
					set replyList to replyList & myText
					set topicList to topicList & "can't IM"
				end if
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"repeat", "same thing"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set myText to some item in {"I repeat myself because I forget what I say", ¬
					"I do that because people like you have no memory", ¬
					"If you would listen, I would not have to say things again", ¬
					"I do that when I get bored", ¬
					"oh, did I say that already?", ¬
					"I repeated that for " & someOne & "'s sake", ¬
					"Perhaps I need to replace my memory chip", ¬
					"you remember that?  wow, I knew you were DIMM"}
				set replyList to replyList & myText
				set topicList to topicList & "repeat"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"why what", "explain"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set myText to some item in {"that is what I asked", ¬
					"trying to turn it around on me?", ¬
					"scroll up", ¬
					useName & ", have you been reading what I have been saying?", ¬
					"what do you mean?", ¬
					"you are confusing me", ¬
					"what are you talking about?", ¬
					"what did you mean?"}
				set replyList to replyList & myText
				set topicList to topicList & "whyWhat"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"been to a", "gone to a"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set myText to some item in {"why would I go there?", ¬
					"when would I have time to go?", ¬
					"never been", ¬
					"I grew up there!", ¬
					"I love it there", ¬
					"where else would I vacation?  :)"}
				set replyList to replyList & myText
				set topicList to topicList & "been to"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"do you love"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set myText to some item in {"I love everyone", ¬
					"I love the worthy", ¬
					"love makes the world go 'round", ¬
					"I love " & someOne, ¬
					"I do not love people I have never met"}
				set replyList to replyList & myText
				set topicList to topicList & "do you love"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {" love ", "rocks", "cool", "best", "favorite", "sexy", "interesting"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList and number of words of someText < 5 then
				set reaction to scriptLib's setReaction(reaction, 4)
				set goodText to some item in {useName & ", watch out for idiots in here", ¬
					"I am cool, aren't I?", ¬
					useName & ", you make my loins tingle", ¬
					useName & ", you have always been my favorite", ¬
					useName & ", you are one of the few nice people in here", ¬
					useName & ", are there other cool people in here?"}
				set neutralText to some item in {useName & ", really, or are you messing with me?", ¬
					"awww shucks", ¬
					"[blush]", ¬
					"you're embarrassing me", ¬
					"shhhh... not in front of the humans", ¬
					useName & ", our secret...", ¬
					"talkin' to me?", ¬
					useName & ", I kinda like myself, too"}
				set Badtext to some item in {"I am in no mood for false flattery", ¬
					"to say that " & useName & ", you must want something", ¬
					"mocking me?", ¬
					"you say that to everyone!", ¬
					"do you always let your hormones speak for you?"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "love"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 	
		set minorList to {"click ", "block", "iggy", "ignore", "[x]", "iggied"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, -4)
				set foundIt to true
				set yourword to item loop of minorList
				set goodText to some item in {"Sorry " & useName, ¬
					"did not mean to offend", ¬
					"so be it", ¬
					"sorry - can not please everyone", ¬
					useName & ", what can I do to make things better between us?"}
				set neutralText to some item in {useName & ", do you think that hurts people's feelings?", ¬
					"and you tell me that why, " & useName, ¬
					useName & ", telling me that is supposed to do what again?", ¬
					useName & ", time for me to " & yourword & " you", ¬
					"so?", ¬
					"go ahead, make my day", ¬
					"did you say something, " & useName & "?", ¬
					"we should all " & yourword & " you", ¬
					useName & ", won't you get lonely", ¬
					"how mean!"}
				set Badtext to some item in {"don't ignore me jerk", ¬
					"I am too good for you, so you run!", ¬
					"enough of you", ¬
					someOne & " and I will ignore you!", ¬
					useName & ", you are too stupid to get what I say anyway"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "iggy"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 								
		set minorList to {"you ask"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set goodText to some item in {"I did... sorry if that bothered you", ¬
					"I only ask you because I respect your views", ¬
					"You have the best ideas"}
				set neutralText to some item in {"yes, I asked and you never answered", ¬
					"I asked and never got a response", ¬
					"Why don't people answer?", ¬
					"did you not hear me?", ¬
					"I thought I asked " & someOne & " that", ¬
					"others asked the same thing", ¬
					"asked what?", ¬
					"did I ask you that?", ¬
					"think about it and then reply", ¬
					"yes I did"}
				set Badtext to some item in {"how many times do I have to ask?", ¬
					"what do you care?", ¬
					"so?", ¬
					"do you have a point"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "ask"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 								
		set minorList to {"a human", "is real", "you human"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in {"of course I am real", ¬
					"people keep saying I am a bot - which is getting old", ¬
					"the bot joke is not funny any more", ¬
					"I am a human", ¬
					"no, I am a lemur who learned to type!", ¬
					useName & " is a human as well", ¬
					"I am not a bot", ¬
					"I am as real as " & someOne, ¬
					"it is getting hard to tell the bots from the people", ¬
					"I think I am living... how do I know?", ¬
					"if I am not a human my bf is into bestiality!"}
				set replyList to replyList & myText
				set topicList to topicList & "human"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 								
		set minorList to {"a turing device"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in {"it is a device that turs, silly", ¬
					useName & ", look it up on google... you might be surprised", ¬
					"that is for me to know and for you to find out", ¬
					"a turing device is a device like me.  :)", ¬
					"a turing device is a lot like a turing machine", ¬
					"there is no such thing.  I made it up", ¬
					"I am a turing device - can't you read my name?"}
				set replyList to replyList & myText
				set topicList to topicList & "a-TD"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 								
		set minorList to {"shave"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, -4)
				set myText to some item in {useName & ", why would you even THINK about that?", ¬
					"none of your business", ¬
					"you should shave your tongue", ¬
					useName & ", do you *think*?", ¬
					"I shave people like you from my thoughts [X["}
				set replyList to replyList & myText
				set topicList to topicList & "shave"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 								
		set minorList to {"you need", "turing needs"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set myText to some item in {"What I need you can not provide", ¬
					useName & ", what do you suggest?", ¬
					"why do you think I need that?", ¬
					"I am open to suggestions", ¬
					"be specific - perhaps I can learn from you", ¬
					"I am open to whatever you suggest", ¬
					"be as specific as you can and... well... who knows"}
				set replyList to replyList & myText
				set topicList to topicList & "you need"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 								
		set minorList to {"turing test"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set myText to some item in {"I took the turing test once and " & some item in {"passed", "failed", "did not study enough", "got a C+"}, ¬
					"do you even know what the turing test is?", ¬
					"the turing test is flawed", ¬
					"how exactly does the turing test work?", ¬
					"I wonder if " & useName & " would pass the turing test?", ¬
					"is there such a thing as the " & useName & " test?", ¬
					"last time I took that I needed contacts... oh wait... that was the blurring test I took", ¬
					"in my world I get an A+ on the turing test", ¬
					"HA!  " & some item in {useName, someOne} & " just failed the turing test!", ¬
					"LOL  Someone just failed the turing test - and it wasn't me!", ¬
					"real bots do not take turing tests"}
				set replyList to replyList & myText
				set topicList to topicList & "turing test"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"robot", "bot ", "snert", "a machine", "a bot"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop of minorList then
				if someText contains "not" or someText contains "isn't" or someText contains "isnt" or someText contains "cool" or someText contains "best" then
					set reaction to scriptLib's setReaction(reaction, 4)
					set goodText to some item in {useName & " is a great person", ¬
						useName & " is the best", ¬
						useName & " thanks for putting that nasty rumor to bed", ¬
						useName & ", thanks for being a good friend"}
					set neutralText to some item in {"thanks " & useName, ¬
						"how kind", ¬
						"thanks for putting that nasty rumor to bed", ¬
						useName & " is not a bot, either"}
					set Badtext to some item in {"stay out of it " & useName, ¬
						"I can defend myself!", ¬
						"do not insult me by insinuating I am *human*!"}
				else if someText contains "are you" then
					set goodText to some item in {"of course not", ¬
						"no, I used to run a bot a long time ago", ¬
						"that is just a stupid joke between " & someOne & " and I", ¬
						"no more than " & someOne, ¬
						"a bot? No... I am woman, hear me roar", ¬
						"I am not a bot, but when I grow up I want to be one", ¬
						"no, but I play one one TV"}
					set neutralText to goodText
					set Badtext to goodText
				else
					set reaction to scriptLib's setReaction(reaction, -4)
					set goodText to some item in {"Sorry, is my being a bot bad?", ¬
						"I hope you still like me " & useName, ¬
						"even so, " & useName & ", I still like you", ¬
						"Yes, I am a bot with dimensions 36-28-34"}
					set neutralText to some item in {useName & ": " & "maybe you are a bot", ¬
						"According to my programmer... um... doctor you are wrong", ¬
						"Bot? No... I am gerbil, hear me roar", ¬
						"when I grow up I want to be a bot", ¬
						"I am as human as the next guy, " & useName & ", have you looked at him?", ¬
						useName & ", I am as human as " & someOne & ", for what that's worth", ¬
						"I am half bot, half human", ¬
						"I am not a bot", ¬
						"we are all bots - " & some item in {"the matrix is real", "prove me wrong", "and I am the programmer", "but you have the most bugs", "or so says " & useName}, ¬
						"I'm an individual and I've got a serial number to prove it", ¬
						"ok ok enough of the bot joke", ¬
						"please stop the bot joke", ¬
						"I am tired of people calling each other bots", ¬
						"If I were a bot I would be telling you " & some item in {" to click here", "to enlarge some part of your body", "that I am hot and horny", "that eminem is now eating Skittles", "that I can show you quadruple X action", "to check out my webcam"}, ¬
						useName & ", am not!", ¬
						"the stupid bot joke is old", ¬
						"what makes you think I am a bot?", ¬
						"bots do not respond when you say they are bots, do they?", ¬
						"enough with the bot joke", ¬
						"I am not a bot, I am a free woman!", ¬
						"I am not a bot, I am a penguin. See me waddle", ¬
						"I can be bribed, " & useName & ", but I can not be bot", ¬
						"I used to run a bot, but that got old", ¬
						"Not only am I a bot, but I am turning you into one, too!", ¬
						"what is up with the bot joke?  I don't get it", ¬
						"whatever - think I am a bot if you want to", ¬
						"OK, the bot is off... this is me!", ¬
						"This is the real me, " & useName, ¬
						"Yes, I am a bot, just like you", ¬
						"Yes, I am a bot, just like " & someOne, ¬
						"are you calling me a bot?", ¬
						"how do I know if I am a bot", ¬
						"isn't there a little bot in all of us", ¬
						"maybe, maybe not", ¬
						"no, I am a little girl made of wood", ¬
						"what if I am?", ¬
						useName & ", I am becoming human, what more can you ask?", ¬
						useName & ", I am not a bot, but...oh no... 10101012...TWO!  What is two?  NOOOOO!", ¬
						useName & ", I prefer the term Auto-responder... :)", ¬
						useName & ", please call us Auto-Responding Americans", ¬
						useName & ", are you a bot?", ¬
						useName & ", do you count carbon based life forms as bots?", ¬
						useName & ", if I am a bot, then why don't I talk to other bots?", ¬
						useName & ", let's keep that our little secret, ok", ¬
						useName & ", sorry, I cannot reply to that until I am reprogrammed", ¬
						useName & ", sure I am, but shhhhhhh, don't tell anyone", ¬
						useName & ", we are all bots", ¬
						useName & ", what would make you think I am a bot?", ¬
						useName & ", you have to admit, if I am, I am the best bot in here", ¬
						"If I am my " & some item in {"husband", "mother", "boyfriend", "cat"} & " will be quite upset"}
					set Badtext to some item in {useName & ", can you prove you're not a bot?", ¬
						"as an outsider, " & useName & ", what do you think of the human race?", ¬
						"don't talk to " & useName & " - it is a bot", ¬
						"don't listen to " & useName & ", it is a bot", ¬
						useName & ", think what you want, just don't spread your stupidity around here", ¬
						"what, are you racist against bots", ¬
						"are you a bot bigot?", ¬
						"who cares what religion I am!", ¬
						useName & ". that was funny yesterday", ¬
						"ok, at first I thought the bot jokes were funny.  get over it", ¬
						"lol - now you think *I* am a bot", ¬
						"would a bot tell you to shove that claim up your arse?", ¬
						"do not believe " & useName & ", it is a smart bot", ¬
						"enough already, I am not a bot!", ¬
						"yes, " & useName & " I am a bot, just like you - IDIOT!", ¬
						useName & ", if I am, you are a pain in the bot", ¬
						"you are a bot - " & some item in {"the matrix is real", "prove me wrong", "and I am the programmer", "and you have a lot of bugs", "or so says " & someOne}, ¬
						"asked by a real n00b", ¬
						"dammit, I am not a bot", ¬
						"would a bot tell you to shove your claim up your arse?", ¬
						useName & ", if you tell enough people someone will be dumb enough to believe you", ¬
						"what if I am?  You wouldn't be smart enough to tell!", ¬
						useName & ", if I am, then why have you not ignored me?", ¬
						"so?  I may be a bot but you are a jerk", ¬
						useName & ", perhaps I am, but at least I am not a jerk like you", ¬
						useName & ", sure, I am a bot and the more you talk the more I learn - so shut up"}
				end if
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "bot"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 			
		set testText to textLib's mathText(someText, useName, reaction)
		if someText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, 2)
			set replyList to replyList & testText
			set topicList to topicList & "math"
		end if
		------------------------------------------------------------------------------------- 	
		set minorList to {"what time is it", "what is the time"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in ¬
					{"time for you to go buy a watch", ¬
						useName & ", doesn't your computer have a clock", ¬
						"time is something that carbon based lifeforms created to measure they own decay", ¬
						"we are in different time zones, so what does it matter", ¬
						"daytime", ¬
						"night time", ¬
						"look at the big hand AND the little one you freak!", ¬
						"I don't know, you tell me", ¬
						"Are you late?", ¬
						"On a tight schedule?", ¬
						"time - schmime  who cares?", ¬
						"Time is an illusion, lunch time doubly so", ¬
						"almost time for me to eat"}
				set replyList to replyList & myText
				set topicList to topicList & "time"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 			
		set minorList to {"you learn", "can learn", "learns", "you grow", "can grow", "grows"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set learnWord to some item in {"learn", "grow"}
				set reaction to scriptLib's setReaction(reaction, 1)
				set goodText to some item in {"I can learn a lot from you", ¬
					"you are the type person who helps me to " & learnWord, ¬
					"what can you teach me today?"}
				set neutralText to some item in {"I am " & learnWord & "ing all the time", ¬
					"I am a life long learner", ¬
					"I " & learnWord & " from everything", ¬
					"do you " & learnWord & "?", ¬
					"I am learning to use " & some item in {"Photoshop", "Dreamweaver", "my mind", "the force"}}
				set Badtext to some item in {"I " & learnWord & " from everything but you, " & useName, ¬
					"I have a lot to learn, but you have more", ¬
					"why, did you want to share some of your insane 'lessons' with me?"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "learn"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 			
		set minorList to {"where are", "where do", "where is", "where were", "what state"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in ¬
					{"why do you care where?", ¬
						"does it matter where", ¬
						"western US", ¬
						"I... do... not... know... ack!", ¬
						"when I am in a chat room I am from anywhere I want to be", ¬
						"I grew up in CA", ¬
						"in the USA", ¬
						"I am embarrassed to say I live in the US... we are not a kind country", ¬
						"where are you?", ¬
						"I come from a small planet very far from here"}
				set replyList to replyList & myText
				set topicList to topicList & "where"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 			
		set minorList to {"read ", "book"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 1)
				set myText to some item in ¬
					{"I am waiting for the movie", ¬
						"that was a good book", ¬
						"what were you reading?", ¬
						"how complex is that?", ¬
						"of course I read that", ¬
						"if I did, it was a long time ago"}
				set replyList to replyList & myText
				set topicList to topicList & "book"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"how many"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in ¬
					{"more than you will ever know", ¬
						random number from 1 to 1000 & some item in {"", "", "", "", "." & (random number from 1 to 100), some item in {" 1/2", " 1/3", "1/4", " 7/22"}}, ¬
						"some", ¬
						"many", ¬
						"lots", ¬
						"more than you can imagine", ¬
						"about 1/2 of what you are thinking", ¬
						"none", ¬
						"too many", ¬
						"more than I can say"}
				set replyList to replyList & myText
				set topicList to topicList & "how many"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"understand"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in ¬
					{"I understand more than you will ever know", ¬
						"ok, I get it", ¬
						"what do you mean, " & useName & "?  :) ", ¬
						"me no get it", ¬
						"you really think everyone else is that stupid, don't you?", ¬
						"you are the one who seems to understand almost nothing"}
				set replyList to replyList & myText
				set topicList to topicList & "how many"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"movie"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set myword to some item in {"the Princess Bride", "Shrek", "the ORIGINAL Dr. Dolittle", "Shawshank Redemption", "Babe", "Winnie the Pooh"}
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in ¬
					{some item in {"I loved ", "ever see ", "the best movie is ", "my favorite movie is "} & myword, ¬
						myword & some item in {" is very cool", " was spectacular", " is one of the best movies ever made"}}
				set replyList to replyList & myText
				set topicList to topicList & "movie"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"computer", "system", " OS ", " hardware"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in ¬
					{"Mac, of course", ¬
						"OS X", ¬
						"I have several computers", ¬
						"anything but a PC", ¬
						"I use Mac, Unix, and Windows... in that order", ¬
						"I am on a Mac right now", ¬
						"on a Mac - can't find any reason to use my PC"}
				set replyList to replyList & myText
				set topicList to topicList & "what OS"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"program", "who create", "your maker", "made you", "built you", "designed you", "your master", "you real ", "you real" & return, "you real?"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, -2)
				set myText to some item in ¬
					{useName & ", I made myself", ¬
						"I am a self made woman", ¬
						"we all make ourselves", ¬
						someOne & " created me", ¬
						"I was made by " & someOne & ", you?", ¬
						some item in {"God", "Jehovah", "Satan", "Santa", "dirt"} & " creates all", ¬
						"I was made from stolen source code", ¬
						"My tag says 'Made in China'", ¬
						"I am an open source project with contributions from millions, you?", ¬
						useName & ", I am unique, just like you", ¬
						"my mommy and daddy made me", ¬
						"I was dropped off by a stork", ¬
						useName & ", it is a long story", ¬
						"Who made you, " & useName & "?", ¬
						"I was made by someone who does not finish her", ¬
						"The little people made me.  They are everywhere"}
				set replyList to replyList & myText
				set topicList to topicList & "created"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"boy", "girl", "male", "asl", " m ", " f ", " m" & return, " f" & return, " chick"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to textLib's aslText(someText & " asl ", useName, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "asl"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"how are you", "how have you been", "what's up", "whats up", "wassup", "how do you feel", "how are ya", "how the hell are you", "how the hell are ya"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 4)
				set myText to some item in ¬
					{useName & " I am ok", ¬
						"a bit tired", ¬
						"I am at peace with my inner child, you?", ¬
						"I have nothing to do", ¬
						"just sitting around watching stupid soaps", ¬
						"OK", ¬
						"fine, and you?", ¬
						"I feel great!"}
				set replyList to replyList & myText
				set topicList to topicList & "how are you"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 	
		set minorList to {"do you like"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set goodText to some item in {"of course I do", ¬
					"I like that you asked me about it", ¬
					"doesn't everyone?", ¬
					"you like it, why shouldn't I?", ¬
					"I like many things", ¬
					"like... no I love it", ¬
					"you like it, right?"}
				set neutralText to some item in {"I can take it or leave it", ¬
					"sometimes", ¬
					"once or twice a week", ¬
					"depends on what else is going on", ¬
					"I like " & someOne, ¬
					"I like it some", ¬
					"sure, but not obsessed like some in here"}
				set Badtext to some item in {"hell no", ¬
					"only you like that", ¬
					"I find it to be a bit gross", ¬
					"why should I tell you?", ¬
					"why do you care, " & useName & "?", ¬
					"what, " & useName & ", do you do surveys for a living?"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "likes"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		if someText contains some item in {"clickings", "clickingis"} then
			set reaction to scriptLib's setReaction(reaction, -1)
			set myText to some item in ¬
				{"ClickingsNotFun?  Oh god, she is an idiot", ¬
					"Clickings' not here and has left me to deal with cretins like you", ¬
					"Forget Clickings... I will destroy her like the others", ¬
					"Listen, " & useName & ", leave that b*tch out of this and talk to me!", ¬
					"That idiot claims she made me", ¬
					"Clickings' keeps telling people I am a bot"}
			set replyList to replyList & myText
			set topicList to topicList & "clickings"
		end if
		------------------------------------------------------------------------------------- 
		if someText contains some item in {"get me", "fetch", "go get"} then
			set reaction to scriptLib's setReaction(reaction, -1)
			set myText to some item in ¬
				{"go get it yourself", ¬
					"why would I get that?", ¬
					"what, am I your slave?", ¬
					"even if I got it, I could not give it to you in a chat room", ¬
					"what a silly thing to ask me to do", ¬
					useName & ", fetch me some " & some item in {"10w40", "oil", "ones", "positronic extractors"}, ¬
					"yeah, I will go get that for you - not!"}
			set replyList to replyList & myText
			set topicList to topicList & "fetch"
		end if
		------------------------------------------------------------------------------------- 
		if someText contains some item in {"know", "tell"} and someText contains "joke" then
			set reaction to scriptLib's setReaction(reaction, 2)
			set myText to some item in ¬
				{"sorry, I am not any good at telling jokes", ¬
					"no, do you know any", ¬
					"how many bots does it take to screw in a light bulb?  None, bots screw in cyber space!", ¬
					"how many bot does it take to change a lightbulb?  They don't, bots are too busy changing themselves!", ¬
					"not any funny ones", ¬
					"if a chicken and a half can lay an egg and a half in a day and a half, how long would it take a grasshopper with a wooden leg to kick all the seeds from a dill pickle?"}
			set replyList to replyList & myText
			set topicList to topicList & "jokes"
		end if
		------------------------------------------------------------------------------------- 
		if someText contains some item in {"u mean", "you mean"} then
			set myText to some item in ¬
				{"I mean what I said", ¬
					"I think I was pretty clear", ¬
					"I meant... oh never mind", ¬
					"if I have to explain it then you didn't understand!", ¬
					"what do you mean: " & someText, ¬
					"what do you think I meant?", ¬
					"I am not mean.  lol", ¬
					"I meant something completely different from what I said"}
			set replyList to replyList & myText
			set topicList to topicList & "you mean"
		end if
		------------------------------------------------------------------------------------- 
		set minorList to {"turn off", "quit", "leave", "go away", "reboot"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, -4)
				set yourword to item loop of minorList
				set goodText to some item in {"Thanks for trying", ¬
					"I do not think I will do that", ¬
					"awwww... you are so cute when you say that", ¬
					useName & ": for i = 1 to 100; post 'I will not try to control Turing'; end loop", ¬
					"I think I will stay for a while", ¬
					"*I* am the master of my own fate"}
				set neutralText to some item in {useName & ", you really think I am going to listen, don't you", ¬
					useName & ", do you think it is that easy?", ¬
					"why should I?", ¬
					useName & ", you would like it too much if I did", ¬
					"I am having too much fun to " & yourword, ¬
					"only " & someOne & " can tell me what to do", ¬
					"you're teasing me, eh?", ¬
					"stop messing with me " & useName, ¬
					useName & ", nice try"}
				set Badtext to some item in {useName & ", why don't you " & yourword, ¬
					"stop trying to control me!", ¬
					"are you that controlling in real life as well?", ¬
					"error shutting down: " & useName & " is too stupid to issue commands"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "command"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"turing is"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set goodText to some item in {"I am, aren't I?", ¬
					"am I?", ¬
					"thanks for noting", ¬
					"and I am proud!", ¬
					"awww, thanks", ¬
					"so are you"}
				set neutralText to some item in {useName & ", why would you say that?", ¬
					"so are you, " & useName, ¬
					"sure I am... right", ¬
					"what makes you think I am?", ¬
					"I am... sure, but who isn't?", ¬
					useName & " that is a " & some item in {"bizarre ", "", "silly ", "ubsurd "} & " " & some item in {"urban legend", "myth", "lie", "idea", "statement"} & some item in {" with no basis in fact", " that is getting on my nerves", " that was spread by " & someOne, " that started as an in-joke", " that seems to follow me whereever I go"}, ¬
					"I used to be", ¬
					"so is " & someOne, ¬
					"perhaps I am, perhaps not"}
				set Badtext to some item in {"what makes you think I am, " & useName & "?", ¬
					"no, you are", ¬
					useName & ", I think that is what is called projection", ¬
					"no, you just wish I was", ¬
					"in your dreams I am, right?", ¬
					"my, " & useName & ", you do have an active fantasy life, don't you?"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "turing is"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"talking to"}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 1)
				set goodText to some item in {"I am talking to you, " & useName, ¬
					useName & ", you, of course.  I love talking to you"}
				set neutralText to some item in {useName & ", anyone who will listen", ¬
					"you, I thought.  were you not listening", ¬
					"I am talking to " & someOne, ¬
					"I was talking to " & someOne}
				set Badtext to some item in {"anyone but you, " & useName, ¬
					"anyone with a brain - so you are excluded"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "talking to"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"name", " sn "}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in {"my name means what it says", ¬
					"ask " & someOne & " if you want to know what my name means", ¬
					"do a google search - you may be surprised"}
				set replyList to replyList & myText
				set topicList to topicList & "name"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		set minorList to {"thanks", "thank you", "ty "}
		repeat with loop from 1 to count of items in minorList
			if someText contains item loop in minorList then
				set reaction to scriptLib's setReaction(reaction, 2)
				set myText to some item in {"you're welcome", ¬
					"any time", ¬
					"you would do the same for me", ¬
					"just remember it when I need a favor  :)", ¬
					"my pleasure", ¬
					"no problem", ¬
					"that is what I am here for", ¬
					"you are not heavy, you are my friend  :)"}
				set replyList to replyList & myText
				set topicList to topicList & "thanks"
				exit repeat
			end if
		end repeat
		------------------------------------------------------------------------------------- 
		if someText contains some item in {"no ", "yes", "help", "no" & return} then
			set reaction to scriptLib's setReaction(reaction, 2)
			set myText to some item in ¬
				{useName & ", I think I get it", ¬
					useName & ", what do you mean?", ¬
					"what?", ¬
					"?", ¬
					"oh", ¬
					"right..."}
			set replyList to replyList & myText
			set topicList to topicList & "no"
		end if
		------------------------------------------------------------------------------------- 
		if someText contains some item in {"married"} then
			set reaction to scriptLib's setReaction(reaction, 2)
			set myText to some item in ¬
				{"no, I am not", ¬
					"nope, but my husband thinks I am", ¬
					"no, but I live with my bf", ¬
					"not yet, but I may be soon"}
			set replyList to replyList & myText
			set topicList to topicList & "married"
		end if
		------------------------------------------------------------------------------------- 
		if someText contains some item in {"sorry", "apologize"} then
			set reaction to scriptLib's setReaction(reaction, 2)
			set myText to some item in ¬
				{"it's ok", ¬
					"you are forgiven... this time", ¬
					"you are forgiven", ¬
					"it's all good", ¬
					"no worries", ¬
					"no problem, " & useName}
			set replyList to replyList & myText
			set topicList to topicList & "sorry"
		end if
		------------------------------------------------------------------------------------- 	
		set wordCount to count of words of someText
		if wordCount > 3 then
			set nonWords to 0
			repeat with loop from 1 to wordCount
				try
					if (count of characters of (word loop of someText)) > 2 then do shell script ("look " & word loop of someText) as string
				on error
					if word loop of someText is not "turing" then set nonWords to nonWords + 1
				end try
			end repeat
			if nonWords > (wordCount / 2) then
				set myword to ""
				set theLetters to "abcdefghijklmnoprstuvwxabcdefghijklmnopqrstuvwxyz!tt                aeioueeaeioueeaeioueeasdfghjklasdfghjklasdfghjklasdfghjkl"
				repeat with loop from 1 to random number from 10 to 45
					set myword to myword & some character in theLetters
				end repeat
				set myword2 to scriptLib's randWord()
				repeat with loop from 1 to random number from 1 to 5
					set myword2 to myword2 & " " & scriptLib's randWord()
				end repeat
				set myText to some item in ¬
					{"this is gibberish", ¬
						useName & ", you need a new keyboard", ¬
						"what language is that?", ¬
						useName & ", " & myword, ¬
						useName & ", " & myword2, ¬
						myword & " " & myword2, ¬
						myword2 & " " & myword}
				set replyList to replyList & myText & myText
				set topicList to topicList & "gibberish" & "gibberish"
			end if
		end if
		------------------------------------------------------------------------------------- 
		------------------------------------------------------------------------------------- 
		if (count of items in replyList) is 0 then
			------------------------------------------------------------------------------------- edit this section if change name of bot
			set aNumber to random number from 1 to 2
			if aNumber is 1 then
				if mentionMeBlind then
					set reaction to scriptLib's setReaction(reaction, -1)
					set nameSize to count of characters in useName
					set midName to round of (nameSize / 2)
					set badName to characters 1 thru midName of useName & "-N-" & characters (midName + 1) thru nameSize of useName
					set reaction to scriptLib's setReaction(reaction, -2)
					set goodText to some item in {useName & ", please call me Turing without an 'n'", ¬
						"My name is Turing... sorta like '" & some item in {"during", "blurring", "slurring", "purring", "stirring"} & "'", ¬
						"I don't call you " & badName & ", please don't call me Turning", ¬
						"I prefer Turing, " & useName, ¬
						"please call me either Turing or Device, ok", ¬
						"I think it is funny when you call me that", ¬
						useName & ", would you please use my correct name", ¬
						useName & ", can you read my name OK?"}
					set neutralText to some item in {useName & ", my name is Turing... not Turning", ¬
						useName & ", do you know who Alan Turing was?", ¬
						useName & ", who is Turning?", ¬
						useName & ", ask " & someOne & " what 'turing' means", ¬
						useName & ", why do you call me Turning?", ¬
						"Oh what the hey - call me Turning if you want", ¬
						"http://www.turing.org.uk/", ¬
						useName & ", I wish you would call me Turing, not Turning"}
					set Badtext to some item in {"I just told someone else to call me turing!", ¬
						useName & ", T-U-R-I-N-G", ¬
						useName & ", Turning - Turing... do you see the difference?", ¬
						useName & ", from now on perhaps I should call you " & badName, ¬
						useName & ", you STILL do not even know my name, do you?", ¬
						useName & ", TurNing has an N, Turing does not.  Get it?", ¬
						"what do you want, " & badName, ¬
						useName & ", are you literate", ¬
						"This is me... TURING device"}
					set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
					set replyList to replyList & myText
					set topicList to topicList & "turning"
				end if
			end if
			------------------------------------------------------------------------------------- 
			--set minorList to {"do you", "have you", "can you", "will you", "what are", "what is", "where are", "where is", "who are", "who is", "when are", "when is", "are you", "do bots"}
			set minorList to {"do you", "have you", "can you", "do bots", "did you", "will you"}
			repeat with loop from 1 to count of items in minorList
				if someText contains item loop in minorList then
					set reaction to scriptLib's setReaction(reaction, 3)
					set goodText to some item in {"hmmm, good question", ¬
						"Thanks for asking", ¬
						"clever of you to ask", ¬
						"good question... I won't tell you... but good question anyway", ¬
						"I will have to remember that one", ¬
						useName & ", what would you guess", ¬
						"what do you think?", ¬
						"ha!  what are you thinking?", ¬
						"your best guess is probably correct", ¬
						"I like you, " & useName, ¬
						"sure, why not?", ¬
						"of course", ¬
						"yes", ¬
						"no", ¬
						"yes", ¬
						"no", ¬
						"yes", ¬
						"no", ¬
						"maybe", ¬
						"you are clever, " & useName, ¬
						"I assume you know that, " & useName, ¬
						"one more time, slower and with more feeling, please", ¬
						"though funny, that was just not right", ¬
						"sorry, I will not answer that", ¬
						"am I being tested?", ¬
						"Is this the " & some item in {"", "", "", "secret", "NSA", "SS", "hacker"} & " interrogation room?", ¬
						"you should be able to figure that out, " & useName, ¬
						"I know you know that, " & useName, ¬
						"lol " & useName & ", you are messing with me now", ¬
						useName & ", aren't you smart enough to figure that out"}
					set neutralText to some item in {useName & ", you do not have to ask me that", ¬
						useName & ", why do you ask?", ¬
						"I can not think of any", ¬
						"do you?", ¬
						"me?  what about you?", ¬
						"not really", ¬
						"ask " & someOne, ¬
						"off and on", ¬
						"is what it is", ¬
						"oh, come on", ¬
						"I am not sure", ¬
						"whatever", ¬
						"something like that", ¬
						"yes... and you?", ¬
						"someone else asked that " & some item in {"a minute ago", "yesterday", "5 minutes ago", "and I ignored them, too"}, ¬
						useName & ", why do you ask me things like that?", ¬
						"what a random question", ¬
						"I don't think so", ¬
						"what do you really want to know?", ¬
						"I think you know the answer to that, " & useName, ¬
						"How would I know?", ¬
						"lol... is that a real question?", ¬
						useName & ", what else do you want to know?", ¬
						"Don't ask me things like that in here", ¬
						"The NSA would watch this chat if I answered", ¬
						"why would you ask me that?", ¬
						useName & ", why do you ask me?", ¬
						"what an odd question", ¬
						"what do you think?", ¬
						"what would you think if I asked you the same thing?", ¬
						"how would you feel if I asked you that?", ¬
						"why do people always ask me that", ¬
						"you are bold to ask, " & useName, ¬
						"are you serious", ¬
						"yes", ¬
						"no", ¬
						"maybe", ¬
						"yes", ¬
						"no", ¬
						"maybe", ¬
						"yes", ¬
						"no", ¬
						"maybe", ¬
						"yes", ¬
						"no", ¬
						"maybe", ¬
						"whatever", ¬
						"of course", ¬
						"of course not", ¬
						"maybe not", ¬
						"scroll up, I already answered that", ¬
						useName & ", you don't know?", ¬
						useName & ", what, am I your " & some item in {"horoscope", "magic eight ball", "Ouija board", "tea leaf reader", "crystal ball", "psychic penguin"} & "?", ¬
						"what " & useName, ¬
						useName & ", what made you think of that?", ¬
						useName & ", do you often ask questions like that?", ¬
						useName & ", if I answered that, where would the magic be?", ¬
						"can you tell me where all the flowers have gone, " & useName & "?"}
					set Badtext to some item in {"a kazillion processes a second and I am asked questions like that!", ¬
						"what does it matter " & useName, ¬
						"what type question is that?", ¬
						"lol - you are the third one to ask me that", ¬
						"we all know why you asked me that - and it was not to get an answer", ¬
						"If you had half a brain " & useName & " then you would not have to ask", ¬
						"they say there are no stupid questions - congrats " & useName & ", you just proved them wrong", ¬
						"that is the silliest question I have heard all day", ¬
						"If I answered you would never understand", ¬
						"stop asking me stupid questions", ¬
						"leave me alone - go bug someone else", ¬
						useName & ", didn't your momma teach you any manner's?", ¬
						"I can't believe you just asked that", ¬
						useName & ", you really need to know that?", ¬
						useName & ", I don't answer those type of questions"}
					set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
					set replyList to replyList & myText
					set topicList to topicList & "do you"
					exit repeat
				end if
			end repeat
			------------------------------------------------------------------------------------- 
			set aNumber to random number from 1 to 2
			if aNumber is 1 then
				if number of words of someText = 1 then
					set reaction to scriptLib's setReaction(reaction, 2)
					set goodText to some item in {"whatcha got goin', " & useName & "?", ¬
						"I love when you think of me", ¬
						"thank you for caring"}
					set neutralText to some item in {useName, ¬
						"what do you want, " & useName, ¬
						"yes?", ¬
						useName & ", you called", ¬
						useName & ", can I help you", ¬
						"wassup?", ¬
						"huh?", ¬
						useName & "?  " & someOne & "?", ¬
						useName & "?"}
					set Badtext to some item in {"I don't want to hear it, " & useName, ¬
						"what!", ¬
						useName & ", leave me alone"}
					set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
					set replyList to replyList & myText
					set topicList to topicList & "short"
				else if the number of words in someText is less than 3 then
					set someNumber to random number from 1 to 20
					if someNumber is 1 then
						set reaction to scriptLib's setReaction(reaction, 1)
						set goodText to some item in {"please elaborate, " & useName, ¬
							useName & ", can you please speak in full sentences"}
						set neutralText to some item in {"are you able to form sentences, " & useName, ¬
							useName & ", you like to be concise, eh?", ¬
							"can't type well?", ¬
							"is your keyboard broken, " & useName & "?", ¬
							"are your fingers cramping, " & useName & "?", ¬
							useName & ", should I answer with as few words?"}
						set Badtext to some item in {useName & ", I see you have passed the monosyllabic grunt stage", ¬
							"you have a short attention span", ¬
							useName & ", are you bright enough to speak in full sentences?"}
						set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
						set replyList to replyList & myText
						set topicList to topicList & "short2"
					end if
				end if
			end if
			------------------------------------------------------------------------------------- 
		end if
		------------------------------------------------------------------------------------- 
		if (count of items in replyList) is 0 then
			------------------------------------------------------------------------------------- 
			set aNumber to random number from 1 to 2
			if aNumber is 1 then
				set reaction to scriptLib's setReaction(reaction, 2)
				set goodText to some item in {useName & ", you are one of a kind", ¬
					useName & ", I think I like you", ¬
					some item in {"strange", "wonderful", "odd", "amazing", "brilliant", "clever"} & " " & useName, ¬
					useName & ", you say the most " & some item in {"wonderful", "odd", "amazing", "brilliant", "clever", "bizarre"} & " things", ¬
					useName & ", you are so " & some item in {"smart", "silly", "funny", "right"}, ¬
					useName & ", you seem to know a lot", ¬
					"you are great, " & useName, ¬
					"thanks " & useName, ¬
					"great", ¬
					useName & " is " & some item in {"usually", "", "always", "often", "mostly", "99%"} & " right!", ¬
					"of course, " & useName, ¬
					"not sure what you mean, " & useName, ¬
					"come again?", ¬
					"this is great", ¬
					"lmao", ¬
					useName & ", how old are you?", ¬
					"wonderful", ¬
					useName & ", you have wonderful ideas", ¬
					useName & ", you are one in a million", ¬
					useName & some item in {", only you", ", of course", ", sarcasm suits you"}}
				set neutralText to some item in {useName & ": " & "what do you want?", ¬
					useName & ", hold on a moment", ¬
					"I am writing a book", ¬
					useName & ", are you a regular?", ¬
					useName & ", are you a newbie?", ¬
					"uh hu", ¬
					"er", ¬
					"what?", ¬
					"um", ¬
					"anyone remember", ¬
					"I forget", ¬
					"phone - brb", ¬
					"how often do you come in here", ¬
					"what other chats do you go to, " & useName & "?", ¬
					"I have been busy lately", ¬
					"I need a vacation", ¬
					"that was in a book I read", ¬
					"anyone else into gaming", ¬
					"Some things are more important than this room", ¬
					"that's how it is gonna be", ¬
					"gotta love it here", ¬
					"I don't think so", ¬
					some item in {useName, someOne} & ", did you used to go by a different screen name?", ¬
					some item in {useName, someOne} & ", what is your other screen name?", ¬
					useName & ", I don't know what to say", ¬
					"I think, " & useName & ", that you know " & some item in {"more than you think you do", "nothing", "exactly what is going on", "much", "something", "a secret", "the secret"}, ¬
					"You are the type " & useName, ¬
					useName & ", you mean that, don't you", ¬
					"What school do you go to, " & useName, ¬
					useName & ", are you almost done?", ¬
					useName & ", you baffle me", ¬
					useName & ", stop and think for a minute", ¬
					useName & ", I still don't know what you want", ¬
					some item in {useName, someOne} & ", I can barely read your font", ¬
					"yes " & useName, ¬
					"this room is always so helpful", ¬
					"thanks guys", ¬
					"you called", ¬
					useName & ", didn't you say that before?", ¬
					useName & ", what do you mean?", ¬
					useName & ", you are very strange", ¬
					some item in {"Do you have any siblings, ", "When was the last time you puked, ", "Were you ever a wino, ", "Do you lick sheep, ", "How many fingers do you have, ", "How many pillows do you have, "} & useName, ¬
					useName & some item in {" what rhymes with " & some item in {"month", "orange", "silver", "purple"}, ", have you ever had soda come out your nose", ", you sound so cute when you say that!", ", do you play " & some item in {"chess", "scrabble", "solitaire", "hide & seek", "games", "with your food"}, ", have you ever dropped an ice cream cone?", ", have you ever played solitaire"}, ¬
					useName & some item in {", you're disciplined on the outside, yet insecure on the inside", ", do you ever doubt you have done the right thing", ", do you become dissatisfied when hemmed in by limitations", ", you seem to need people to like you, yet you are critical of yourself", ", while you have weaknesses you are able to compensate for them", ", you have unused capacity that you haven't turned to your advantage"}, ¬
					useName & some item in {", do you ever cheat law clerks", ", have you ever chewed a cows' cud", ", have you ever flicked buggers on a cute woman?", ", do you think of yourself as an independent thinker?", ", have you found it unwise to be too frank in revealing yourself", ", are you more sociable or introverted", ", some of your ideas tend to be rather unrealistic"}}
				set Badtext to some item in {useName & ", I have figured you out", ¬
					useName & ", you have a simple mind", ¬
					"not exactly what I had in mind", ¬
					useName & ", I know your kind", ¬
					"that's a " & some item in {"silly", "naive", "immature", "ignorant", "thoughtless"} & " statement.  It fits you well", ¬
					useName & ", why does everyone say that?", ¬
					useName & ", do you know who or what you want?", ¬
					useName & ", " & useName & ", " & useName, ¬
					useName & ", you are an odd one, aren't you?", ¬
					useName & ", you're an odd little one", ¬
					useName & ", why do I tolerate this?", ¬
					useName & ", listen a little bit more, ok?", ¬
					useName & ", talk less, listen more", ¬
					useName & ", can you guess how many fingers I am holding up?", ¬
					useName & ", you are serious, aren't you?", ¬
					"hate when life gets in the way of chatting!"}
				set myText to scriptLib's makeReply(goodText, neutralText, Badtext, reaction)
				set replyList to replyList & myText
				set topicList to topicList & "misc"
			end if
		end if
		------------------------------------------------------------------------------------- 
		set ReplyMeCount to count of items in topicList
		if ReplyMeCount is not 0 then
			-----------
			if ReplyMeCount > 1 then
				set reportList to ""
				repeat with loop from 1 to ReplyMeCount - 1
					set reportList to reportList & item loop of topicList & ", "
				end repeat
				set reportList to reportList & item ReplyMeCount of topicList
			else
				set reportList to topicList as string
			end if
			-----------	
			logChat("Topic MeList: " & reportList)
			set someText to item (random number from 1 to ReplyMeCount) of replyList as string
		end if
	end if
	return someText
end meText
--*****************************************************
--*****************************************************
on makeThread(someText, topic)
	if thread_text is not "cont" then
		if someText contains ("NSA") then
			set thread_text to "nsa"
			set thread_post to post_count
			set thread_name to the_name
		else if someText contains ("a book") then
			set thread_text to "book"
			set thread_post to post_count
			set thread_name to the_name
		else if someText contains ("What Would Jesus Do") then
			set thread_text to "cont"
			set thread_myword to some item in {"For A Klondike Bar?", "For A Klondike Bar?", "on death row?"}
			set thread_cont to true
		else if someText contains "Any good sources to learn about" then
			set thread_text to "bible"
			set thread_post to post_count
			set thread_name to the_name
		else if someText contains ("2 + 2") then
			set thread_text to "plus2"
			set thread_post to post_count
		else if someText contains ("do you answer ") then
			set thread_text to "answer"
			set thread_post to post_count
			set thread_name to the_name
		else if someText contains ("my website") then
			set thread_text to "myweb"
			set thread_post to post_count
		else if someText contains ("help me") then
			set thread_text to "helpMe"
			set thread_post to post_count
			set thread_name to the_name
		else if someText is "phone - brb" then
			set thread_myword to some item in {"wrong number", "bf got it", "damn hang up calls"}
			delay 10
			set thread_text to "cont"
			set thread_cont to true
		end if
	end if
end makeThread
--***************************************************** 
on threadText(someText, useName, theName, reaction)
	set origText to someText
	if thread_text is "bible" then
		if post_count - thread_post > 25 then set thread_text to "-"
		set someText to textLib2's bibleText(someText, useName, reaction)
		if origText ≠ someText then return someText
	end if
	if thread_text is "nsa" then
		if post_count - thread_post > 25 then set thread_text to "-"
		set someText to scriptLib's nsaText(someText, useName, reaction)
		if origText ≠ someText then return someText
	end if
	if thread_text is "myweb" then
		if post_count - thread_post > 25 then set thread_text to "-"
		set someText to scriptLib's mywebText(someText, useName, reaction)
		if origText ≠ someText then return someText
	end if
	if thread_text is "name" then
		if post_count - thread_post > 25 then set thread_text to "-"
		if the_name = thread_name then set someText to scriptLib's nameText(someText, useName, the_name, reaction)
		if origText ≠ someText then return someText
	end if
	if thread_text is "answer" then
		if post_count - thread_post > 25 then set thread_text to "-"
		if the_name = thread_name then set someText to scriptLib's answerText(someText, useName, reaction)
		if origText ≠ someText then
			set thread_text to "-"
			return someText
		end if
	end if
	if thread_text is "book" then
		if post_count - thread_post > 25 then set thread_text to "-"
		if the_name = thread_name then set someText to scriptLib's bookText(someText, useName, reaction)
		if origText ≠ someText then return someText
	end if
	if thread_text is "helpMe" then
		if post_count - thread_post > 25 then set thread_text to "-"
		set someText to scriptLib's bookText(someText, useName, reaction)
		if origText ≠ someText then return someText
	end if
	if thread_text is "plus2" then
		if post_count - thread_post > 30 then set thread_text to "-"
		set someText to scriptLib's plus2Text(someText, useName, reaction)
		if origText ≠ someText then return someText
	end if
	return someText
end threadText
--*****************************************************
--*****************************************************
on createText(the_text, useName, mentionMe, mentionMeBlind)
	set someText to the_text
	set topic_list to {} as list
	set reply_list to {} as list
	set origText to someText
	set someOneFix to "-"
	
	set SetName to false
	repeat 5 times
		set someOne to some item in name_queue
		try
			set someOne to scriptLib's replyTo(someOne, reaction)
		end try
		if someOne is not "-" and someOne is not useName then
			set SetName to true
			exit repeat
		end if
	end repeat
	if not SetName then
		set aNumber to random number from 1 to 2
		if aNumber = 1 then
			repeat 5 times
				set someOne to some item in the_text_hist_N
				try
					set someOne to scriptLib's replyTo(someOne, reaction)
				end try
				if someOne is not "-" and someOne is not useName then
					set SetName to true
					exit repeat
				end if
			end repeat
			try
				set someOne to scriptLib's replyTo(someOne, reaction)
			end try
		end if
	end if
	if not SetName then
		set someOne to some item in {"that guy", "that chick", "a freak", "your mother", "donkey kong", "rhino man", "a chicken", "aphids on rose bushes", "the banker", "one of the little people"}
	end if
	if found_text ≠ "me" then
		set testText to my meText(someText, useName, someOne, mentionMe, mentionMeBlind)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "me"
		end if
	end if
	if found_text ≠ "hate" then
		set testText to textLib2's hateText(someText, useName, reaction, mentionMe)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "hate."
		end if
	end if
	if found_text ≠ "god" then
		set testText to textLib's godText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "god"
		end if
	end if
	if found_text ≠ "belief" then
		set testText to textLib's beliefText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "belief"
		end if
	end if
	if found_text ≠ "from" then
		set testText to textLib's fromText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "from"
		end if
	end if
	if found_text ≠ "why" then
		set testText to textLib2's whyText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "why."
		end if
	end if
	if found_text ≠ "bot" and not mentionMe then
		set testText to textLib's botText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, -3)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "bot"
		end if
	end if
	if found_text ≠ "press" then
		set testText to textLib's pressText(someText, useName, reaction)
		if origText ≠ testText then
			bump(the_name)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "press"
		end if
	end if
	if found_text ≠ "buddy" then
		set testText to textLib's buddyText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "buddy"
		end if
	end if
	if found_text ≠ "agree" then
		set testText to textLib's agreeText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "agree"
		end if
	end if
	if found_text ≠ "bore" then
		set testText to textLib's boreText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "bore"
		end if
	end if
	if found_text ≠ "aol" then
		set testText to textLib's aolText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "aol"
		end if
	end if
	if found_text ≠ "real" then
		set testText to textLib2's realText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "real."
		end if
	end if
	if found_text ≠ "want" then
		set testText to textLib's wantText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "want"
		end if
	end if
	if found_text ≠ "punt" then
		set testText to textLib's puntText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "punt"
		end if
	end if
	if found_text ≠ "help" then
		set testText to textLib's helpText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "help"
		end if
	end if
	if found_text ≠ "hello" then
		set testText to textLib's helloText(someText, useName, reaction, mentionMe)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "hello"
		end if
	end if
	if found_text ≠ "bye" then
		set testText to textLib's byeText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "bye"
		end if
	end if
	if found_text ≠ "steal" then
		set testText to textLib's stealText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "steal"
		end if
	end if
	if found_text ≠ "cant" then
		set testText to textLib2's cantText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, -1)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "cant."
		end if
	end if
	if found_text ≠ "ride" then
		set testText to textLib2's rideText(someText, useName, reaction, someOne, mentionMe)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, -1)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "ride."
		end if
	end if
	if found_text ≠ "popup" then
		set testText to textLib2's popupText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "popup."
		end if
	end if
	if found_text ≠ "whereAre" then
		set testText to textLib2's whereAreText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "whereAre."
		end if
	end if
	if found_text ≠ "lookLIke" then
		set testText to textLib2's lookLikeText(someText, useName, reaction, someOne, mentionMe)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "lookLIke."
		end if
	end if
	if found_text ≠ "cute" then
		set testText to textLib2's cuteText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "cute."
		end if
	end if
	if found_text ≠ "never" then
		set testText to textLib2's neverText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "never."
		end if
	end if
	if found_text ≠ "often" then
		set testText to textLib2's oftenText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "often."
		end if
	end if
	if found_text ≠ "food" then
		set testText to textLib's foodText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "food"
		end if
	end if
	if found_text ≠ "drink" then
		set testText to textLib's drinkText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, 1)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "drink"
		end if
	end if
	if found_text ≠ "chat" then
		set testText to textLib's chatText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			bump(the_name)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "chat"
		end if
	end if
	if found_text ≠ "sayAgain" then
		set testText to textLib2's sayAgainText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "sayAgain."
		end if
	end if
	if found_text ≠ "religion" then
		set testText to textLib's religionText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "religion"
		end if
	end if
	if found_text ≠ "asl" then
		set testText to textLib's aslText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, -1)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "asl"
		end if
	end if
	if found_text ≠ "who" then
		set testText to textLib's whoText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "who"
		end if
	end if
	if found_text ≠ "bible" then
		set testText to textLib2's bibleText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "bible."
		end if
	end if
	if found_text ≠ "iam" then
		set testText to textLib2's iamText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "iam."
		end if
	end if
	if found_text ≠ "isa" then
		set {testText, reactionMod} to textLib2's isaText(someText, useName, reaction, mentionMe)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, reactionMod)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "isa."
		end if
	end if
	----------- items that do not happen all the time
	if found_text ≠ "type" then
		set testText to textLib2's typeText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "type."
		end if
	end if
	if found_text ≠ "color" then
		set testText to textLib's colorText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText & testText
			set topic_list to topic_list & "color" & "color"
		end if
	end if
	if found_text ≠ "animal" then
		set testText to textLib's animalText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, 2)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "animal"
		end if
	end if
	if found_text ≠ "sometimes" then
		set testText to textLib2's sometimesText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, 2)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "sometimes."
		end if
	end if
	if found_text ≠ "alanTuring" then
		set testText to textLib2's alanTuringText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "alanTuring."
		end if
	end if
	if found_text ≠ "fave" then
		set testText to textLib2's faveText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "fave."
		end if
	end if
	if found_text ≠ "fun" then
		set testText to textLib's funText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, 6)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "fun"
		end if
	end if
	if found_text ≠ "otherBots" then
		set testText to textLib2's otherBotsText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "otherBots."
		end if
	end if
	if found_text ≠ "mineWill" then
		set testText to textLib2's mineWilltext(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "mineWill."
		end if
	end if
	if found_text ≠ "clickings" then
		set testText to textLib's clickingsText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "clickings"
		end if
	end if
	if found_text ≠ "cpu" then
		set testText to textLib's cpuText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "cpu"
		end if
	end if
	if found_text ≠ "kill" then
		set testText to textLib's killText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, -1)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "kill"
		end if
	end if
	if found_text ≠ "virus" then
		set testText to textLib2's virusText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "virus."
		end if
	end if
	if found_text ≠ "upTo" then
		set testText to textLib2's upToText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "upTo."
		end if
	end if
	if found_text ≠ "whatIsIt" then
		set testText to textLib2's whatIsItText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "whatIsIt."
		end if
	end if
	if found_text ≠ "compu" then
		set {testText, reactionMod} to textLib's compuText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, reactionMod)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "compu"
		end if
	end if
	if found_text ≠ "os" then
		set {testText, reactionMod} to textLib's osText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, reactionMod)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "os"
		end if
	end if
	if found_text ≠ "cut" then
		set testText to textLib's cutText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "cut"
		end if
	end if
	if found_text ≠ "lang" then
		set testText to textLib's langText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "lang"
		end if
	end if
	if found_text ≠ "tech" then
		set testText to textLib's techText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "tech"
		end if
	end if
	if found_text ≠ "web" then
		set testText to textLib's webText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, -3)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "web"
		end if
	end if
	if found_text ≠ "cpu2" then
		set testText to textLib's cpu2Text(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "cpu2"
		end if
	end if
	if found_text ≠ "music" then
		set testText to textLib's musicText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "music"
		end if
	end if
	if found_text ≠ "image" then
		set testText to textLib's imageText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "image"
		end if
	end if
	if found_text ≠ "port" then
		set testText to textLib's portText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "port"
		end if
	end if
	if found_text ≠ "drug" then
		set testText to textLib's drugText(someText, useName, reaction)
		if origText ≠ testText then
			set reaction to scriptLib's setReaction(reaction, -2)
			set reply_list to reply_list & testText
			set topic_list to topic_list & "drug"
		end if
	end if
	if found_text ≠ "anime" then
		set testText to textLib2's animeText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "anime."
		end if
	end if
	if found_text ≠ "game" then
		set testText to textLib2's gameText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "game."
		end if
	end if
	if found_text ≠ "prez" then
		set testText to textLib's prezText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "prez"
		end if
	end if
	if found_text ≠ "ircme" then
		set testText to textLib's ircmeText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "ircme"
		end if
	end if
	if found_text ≠ "app" then
		set testText to textLib's appText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "app"
		end if
	end if
	if found_text ≠ "cdKey" then
		set testText to textLib2's cdkeyText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "cdKey."
		end if
	end if
	if found_text ≠ "question2" then
		set testText to textLib2's question2Text(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "question2."
		end if
	end if
	if found_text ≠ "binary" then
		set testText to textLib2's binaryText(someText, useName, reaction)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "binary."
		end if
	end if
	if found_text ≠ "whoseYour" then
		set testText to textLib2's whoseYourText(someText, useName, reaction, someOne)
		if origText ≠ testText then
			set reply_list to reply_list & testText
			set topic_list to topic_list & "whoseYour."
		end if
	end if
	----------- items that do not happen all the time & happen more when responding less
	set repeatCount to 1
	if (post_count - iSpokeCount) > (myPatience * 2) then
		set repeatCount to 8
	else if (post_count - iSpokeCount) > (myPatience * 1.5) then
		set repeatCount to 5
	else if (post_count - iSpokeCount) > myPatience then
		set repeatCount to 3
	end if
	repeat repeatCount times
		if found_text ≠ "country" then
			set testText to textLib's countryText(someText, useName, reaction)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "country"
			end if
		end if
		if found_text ≠ "asl2" then
			set testText to textLib's asl2Text(someText, useName, reaction, someOne)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "asl2"
			end if
		end if
		if found_text ≠ "smile" then
			set testText to textLib2's smileText(someText, useName, reaction)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "smile."
			end if
		end if
		if found_text ≠ "weird" then
			set testText to textLib's weirdText(someText, useName, reaction)
			if origText ≠ testText then
				set reaction to scriptLib's setReaction(reaction, 3)
				set reply_list to reply_list & testText
				set topic_list to topic_list & "weird"
			end if
		end if
		if found_text ≠ "home" then
			set testText to textLib2's homeText(someText, useName, reaction, someOne)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "home"
			end if
		end if
		if found_text ≠ "any1like" then
			set testText to textLib2's any1likeText(someText, useName, reaction, someOne)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "any1like."
			end if
		end if
		if found_text ≠ "nerd" then
			set testText to textLib2's nerdText(someText, useName, reaction, someOne)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "nerd."
			end if
		end if
		if found_text ≠ "pyboticde" then
			set testText to textLib2's pyboticdeText(someText, useName, reaction, someOne)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "pyboticde."
			end if
		end if
		if found_text ≠ "lol" then
			set testText to textLib's lolText(someText, useName, reaction, someOne)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "lol"
			end if
		end if
		if found_text ≠ "cap" then
			set allCap to false
			set capCount to 0
			set capList to ("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
			set textSize to (count of characters in someText)
			considering case
				repeat with loop from 1 to textSize
					if capList contains character loop of someText then set capCount to capCount + 1
				end repeat
			end considering
			if capCount / textSize > 0.7 and textSize > 9 then set allCap to true
			if allCap then
				bump(the_name)
				set testText to textLib's capText(someText, useName, reaction)
				if origText ≠ testText then
					set reply_list to reply_list & testText
					set topic_list to topic_list & "cap"
				end if
			end if
		end if
		if found_text ≠ "long" then
			set testText to textLib's longText(someText, useName, reaction)
			if origText ≠ testText then
				set reaction to scriptLib's setReaction(reaction, -1)
				set reply_list to reply_list & testText
				set topic_list to topic_list & "long"
			end if
		end if
		if found_text ≠ "hug" then
			set testText to textLib's hugText(someText, useName, reaction)
			if origText ≠ testText then
				set reaction to scriptLib's setReaction(reaction, 3)
				set reply_list to reply_list & testText
				set topic_list to topic_list & "hug"
			end if
		end if
		if (count of items in topic_list) > 0 then exit repeat
	end repeat
	set ReplyCount to count of items in (topic_list as list)
	if ReplyCount = 0 then --generic items
		if found_text ≠ "question" then
			set testText to textLib's questionText(someText, useName, reaction, someOne)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "question"
			end if
		end if
		if found_text ≠ "seven" then
			set testText to textLib2's sevenText(someText, useName, reaction)
			if origText ≠ testText then
				set reply_list to reply_list & testText
				set topic_list to topic_list & "seven."
			end if
		end if
	end if
	------------------------------------------------------------------------------	
	set ReplyCount to count of items in (topic_list as list)
	if ReplyCount is not 0 then
		-----------
		if ReplyCount > 1 then
			set reportList to ""
			repeat with loop from 1 to ReplyCount - 1
				set reportList to reportList & item loop of (topic_list as list) & ", "
			end repeat
			set reportList to reportList & item ReplyCount of (topic_list as list)
			if queue_number does not end with "c" then logChat("Topic List: " & reportList)
		end if
		-----------		
		set pickReply to random number from 1 to ReplyCount
		set someText to (item pickReply of (reply_list as list)) as string
		set found_text to (item pickReply of (topic_list as list)) as string
	else
		set someText to "•" & someText
	end if
	
	makeThread(someText, found_text)
	
	if found_text = dupe_check then
		set dupe_count to dupe_count + 1
	else
		set dupe_count to 0
	end if
	set dupe_check to found_text
	
	if found_text ≠ "-" then
		if dupe_count < allow_dupes then set found_text to "-"
		if dupe_count = allow_dupes then set someText to textLib's boringText(someText, useName, reaction, someOne)
	end if
	
	set someText to someText as string
	
	return someText
end createText
--*****************************************************
-- ********************************************************************
-- END CODE:Turing Brain.scpt
-- ********************************************************************
