writeInfoLine: "Extracting formants..."

# Extract the names of the Praat objects
thisSound$ = selected$("Sound")
thisTextGrid$ = selected$("TextGrid")

# Extract the number of intervals in the phoneme tier
select TextGrid 'thisTextGrid$'
numberOfPhonemes = Get number of intervals: 1  
appendInfoLine: "There are ", numberOfPhonemes, " intervals."

# Create the Formant Object
select Sound 'thisSound$'
To Formant (burg)... 0 5 5000 0.025 50

# Create the output file and write the first line.
outputPath$ = "/Users/anshumansaikia/Documents/FSP/Formants/formants30.csv"
writeFileLine: "'outputPath$'", "time,phoneme,F1,F2,F3"

# Loop through each interval on the phoneme tier.
for thisInterval from 1 to numberOfPhonemes
    #appendInfoLine: thisInterval

    # Get the label of the interval
    select TextGrid 'thisTextGrid$'
    thisPhoneme$ = Get label of interval: 1, thisInterval
    #appendInfoLine: thisPhoneme$
    
    # Find the midpoint.
    thisPhonemeStartTime = Get start point: 1, thisInterval
    thisPhonemeEndTime   = Get end point:   1, thisInterval
    duration = thisPhonemeEndTime - thisPhonemeStartTime
    midpoint = thisPhonemeStartTime + duration/2
    
    # Extract formant measurements
    select Formant 'thisSound$'
    f1 = Get value at time... 1 midpoint Hertz Linear
    f2 = Get value at time... 2 midpoint Hertz Linear
    f3 = Get value at time... 3 midpoint Hertz Linear

    # Save to a spreadsheet
    appendFileLine: "'outputPath$'", 
                    ...midpoint, ",",
                    ...thisPhoneme$, ",",
                    ...f1, ",", 
                    ...f2, ",", 
                    ...f3

endfor

appendInfoLine: newline$, newline$, "Whoo-hoo! It didn't crash!"
