-- ********************************************************************
-- START CODE:Turing Save Text.scpt
-- ********************************************************************
using terms from application "AOL Instant Messenger (SM)"
	
	on handle event of type inEventType ¬
		with screen name inScreenName ¬
		with message inMsg ¬
		with chat room name inChatRm
		
		set cleanText to trim html inMsg
		set theText to the first paragraph of cleanText
		
		-- with timeout of 1 seconds
		repeat 10 times
			
			display dialog "3"
			
			try
				set oops to false
				if theText does not contain "turing" then
					
					tell application "TextEdit"
						set the text of the front document to "" & text of the front document & ¬
							inChatRm & return & ¬
							(current date) & return & ¬
							theText & return & ¬
							"Name: " & inScreenName & return & return
					end tell
					
				else
					
					tell application "TextEdit"
						set the text of the front document to "" & inChatRm & return & ¬
							(current date) & return & ¬
							theText & return & ¬
							"Name: " & inScreenName & return & return & ¬
							text of the front document
					end tell
					
				end if
			on error
				set oops to true
			end try
			if not oops then exit repeat
		end repeat
		-- end timeout
	end handle event
	
end using terms from
-- ********************************************************************
-- END CODE:Turing Save Text.scpt
-- ********************************************************************
