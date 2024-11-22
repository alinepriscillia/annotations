# Set directories
home_dir$ = "/Volumes/Server/NEUROLING/PersonalFiles/Aline-Priscillia Messi/megmethods/"
savedir$ = home_dir$ + "annotations/"
wd$ = savedir$ + "audio/"
wd_aud$ = wd$ + "*.TextGrid"

# Get list of TextGrid files
audList = Create Strings as file list: "audList", wd_aud$
numFiles = Get number of strings
writeInfoLine: "Finished loading files..."

# Prompt for transcription level
beginPause: "Choose the transcript level"
    comment: "What level of transcription do you want to select?"
    choice: "Level", 1
        option: "word"
        option: "story"
endPause: "Submit", 1

# Use tab as the separator
sep$ = tab$  

if level$ = "word"
    csvfile$ = savedir$ + "story_wordonsets.tsv" 
    deleteFile: csvfile$
    # Write CSV header
    fileappend "'csvfile$'" word 'sep$' start 'sep$' end 'sep$' duration 'sep$' confidence 'sep$' file 'newline$'

    # Loop through TextGrid files
    for fileNum from 1 to numFiles
        selectObject: audList
        txtFile$ = Get string: fileNum
        appendInfoLine: "Processing file: " + txtFile$
        textgrid = Read from file: wd$ + txtFile$
        object_info$ = Info
        filename$ = extractLine$(object_info$, "Object name:")
        wordIntervals = Get number of intervals... 3

        for i from 1 to wordIntervals
            word$ = Get label of interval... 3 i
            starttime = Get start point... 3 i
            endtime = Get end point... 3 i
            duration = endtime - starttime
            confidence$ = Get label of interval... 4 i

            if word$ != "" and word$ != " "
                fileappend "'csvfile$'" 'word$' 'sep$' 'starttime' 'sep$' 'endtime' 'sep$' 'duration' 'sep$' 'confidence$' 'sep$' 'filename$' 'newline$'
            endif
        endfor
    endfor

elif level$ = "story"
    csvfile$ = savedir$ + "story_segmentsandwordonsets.tsv"
    deleteFile: csvfile$
    # Write CSV header
    fileappend "'csvfile$'" segment# 'sep$' segment 'sep$' word 'sep$' word_start 'sep$' word_end 'sep$' word_duration 'sep$' word_confidence 'sep$' file 'newline$'

    for fileNum from 1 to numFiles
        selectObject: audList
        txtFile$ = Get string: fileNum
        appendInfoLine: "Processing file: " + txtFile$
        textgrid = Read from file: wd$ + txtFile$
        object_info$ = Info
        filename$ = extractLine$(object_info$, "Object name:")
        storyIntervals = Get number of intervals... 1

        for segmentNum from 1 to storyIntervals
            segment$ = Get label of interval... 1 segmentNum
            segmentStart = Get start point... 1 segmentNum
            segmentEnd = Get end point... 1 segmentNum

            if segment$ != "" and segment$ != " "
                # Loop through words in the segment
                wordIntervals = Get number of intervals... 3

                for i from 1 to wordIntervals
                    wordStart = Get start point... 3 i
                    wordEnd = Get end point... 3 i

                    # Ensure words fall within the segment
                    if wordStart >= segmentStart and wordEnd <= segmentEnd
                        word$ = Get label of interval... 3 i
                        duration = wordEnd - wordStart
                        confidence$ = Get label of interval... 4 i

                        if word$ != "" and word$ != " "
                            fileappend "'csvfile$'" 'segmentNum' 'sep$' 'segment$' 'sep$' 'word$' 'sep$' 'wordStart' 'sep$' 'wordEnd' 'sep$' 'duration' 'sep$' 'confidence$' 'sep$' 'filename$' 'newline$'
                        endif
                    endif
                endfor
            endif
        endfor
    endfor
endif

appendInfoLine: "Finished processing!"
