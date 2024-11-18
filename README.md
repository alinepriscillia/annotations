# How to extract word timing info from the story segments

## Import necessary libraries

-   Install transcription wrapper around whisperai: <https://github.com/JJWRoeloffs/transcribe_align_textgrid>

`pip install transcribe_align_textgrid`

Or install in specific environment if using a specific environment.

-   Install whisper-timestamped: <https://github.com/linto-ai/whisper-timestamped>

`pip3 install whisper-timestamped`

## Run the command line prompt to extract Praat textgrids

This is easier than using it as a library.

`python -m transcribe_align_textgrid [path]`

**[path]** here is the path to the folder with the audio files. If a whole folder is given, the script will return the text grids for all of the files.

## Clean the textgrids and transcript for each story segment if needed.

I didn’t do any cleaning but you can if you want to!

## Extract the word onset information and segment onset information from Praat

The Praat files return: Segment- segment confidence- Word- word confidence textgrids.

Use *Word Onset Extraction Script.praat* to create a .csv file with word onset and offset information as well as confidence of the transcription. The script skips pauses and breaks or empty textgrids. The script will loop through all of the audio files and textgrids in the audio folder and return a csv file with information for all of the files. The .csv file contains the word, start, end, duration, confidence and the audiofile the information was extracted from.
