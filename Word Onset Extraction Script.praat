# this is a modified praat script to get textgrid information and transform it into a csv after automatic transcription
# change the dirs as needed
home_dir$ = "/Volumes/Server/NEUROLING/PersonalFiles/Aline-Priscillia Messi/megmethods/"
savedir$ = home_dir$ + "annotations/"
wd$ = savedir$ + "audio/"
# only selecting the textgrid files from the working directory
wd_aud$ = wd$ + "*.TextGrid"
# Get list of files and number
audList = Create Strings as file list: "audList", wd_aud$
numFiles = Get number of strings
writeInfoLine: "Finished loading in files..."
# prompt for level of analysis
beginPause: "Choose the transcript"
	comment: "What level of transcription do you want to select?"
	choice: "Level",1
		option: "word"
		option: "story"
	endPause: "Submit",1
if level$ = "word"
	# csvfileName$ = replace$(txtFile$, ".TextGrid", ".csv") # change it so that I have the same filename for the textgrid I'm reading in
	csvfile$ = savedir$ + "story_wordonsets.csv" 
	deleteFile: csvfile$
	# create header
	fileappend "'csvfile$'" word,start,end,duration,confidence,file 'newline$'

	# create a for loop that reads in the files and then extracts what I want 
	for fileNum from 1 to numFiles
		# select the list	
		selectObject: audList
		# select the filename
		txtFile$ = Get string: fileNum
		appendInfoLine: txtFile$
		# read in the textgrid that I've selected
		textgrid = Read from file: wd$ + txtFile$
		# get the name of each audio file to append as a column
		object_info$ = Info
		filename$ = extractLine$(object_info$, "Object name:")
		wordIntervals = Get number of intervals... 3
		storyIntervals = Get number of intervals... 1

			for i from 1 to wordIntervals
				# get the label of the ith interval on level 3
				word$ = Get label of interval... 3 i
				starttime = Get start point... 3 i
				endtime = Get end point... 3 i
				duration = endtime - starttime
				confidence$ = Get label of interval... 4 i
				if word$ = ""
					# empty line to skip interation
					a = 1
				elsif word$ = " "
					b = 0
				else 
					fileappend "'csvfile$'" 'word$','starttime','endtime','duration','confidence$','filename$' 'newline$'
				endif
			endfor
	endfor
endif
appendInfoLine: "Finished processing!"



#for j from 1 to number
					#phon$ = Get label of interval... 3 j
					#start = Get start point... 3 j
					#end = Get end point... 3 j
					#if start = starttime
						#length = end - start
						#fileappend "'file2$'" 'phon$', 'start', 'end', 'length' 'newline$'
					#endif
				#endfor
