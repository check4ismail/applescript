set numberOfWords to display dialog "How many words will you be adding today?" default answer ""
set repeatLoopDigit to text returned of numberOfWords
set repeatLoopDigit to repeatLoopDigit * 3

--Command to start the Anki app and launch "add"
tell application "Anki"
	--During this delay, I must click on the window in Anki
	delay 6
	activate
	delay 2
	--Here, add window appears
	tell application "System Events" to tell process �
		"Anki" to keystroke "a"
	display dialog "Select?"
end tell

--Change to 3 All Purpose cards
tell application "System Events" to tell process "Anki"
	repeat 4 times
		key code 48 using {shift down}
	end repeat
	key code 49
	delay 0.5
	keystroke "3"
	key code 36
	delay 1
end tell

--Finder command to open Arabic Vocab text
tell application "Finder"
	open home
	open folder "Desktop" in window 1
	--Name of file is Arabic Words_3.txt
	open file "Arabic_Words_3.rtf" in window 1
	delay 1
end tell

set counter to 0
--Repeat based on the line number of Arabic_Words_3
repeat repeatLoopDigit times
	--When in textedit program, copy text/photo
	tell application "System Events" to tell process "TextEdit"
		--This part here will copy content
		key code 124 using {command down, shift down}
		key code 123 using {command down, shift down}
		keystroke "c" using {command down}
		--This part here will word from text edit, then move 
		--all words one line up
		key code 51
		key code 125
		key code 124 using {command down}
		key code 51
		--Switch to recent program which is Anki in this case
		key code 48 using {command down}
	end tell
	
	--Add content correctly to Anki
	tell application "System Events" to tell process "Anki"
		delay 1
		--If any word is present, remove its content
		keystroke "a" using {command down}
		--Delete
		key code 51
		--Now paste
		keystroke "v" using {command down}
		
		--First field (front with word blanked out)
		if counter is 0 then
			--Tab 3 times
			repeat 3 times
				delay 0.2
				key code 48
			end repeat
			set counter to counter + 1
			--Fifth field (full sentence)
		else if counter is 2 then
			--Tab 7 times, then press enter
			repeat 7 times
				key code 48
			end repeat
			--Press enter to enter next set of words
			key code 36
			set counter to counter - counter
		else
			--Tab once
			key code 48
			set counter to counter + 1
		end if
		
		delay 0.2
		--Return back to TextEdit file
		key code 48 using {command down}
	end tell
end repeat