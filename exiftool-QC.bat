@ECHO OFF
REM The following is referred to in appending the datetime at the end of CSV and log files to ensure descriptive, unique filenames each time the batch file is run.
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a
set Yr=%DateTime:~0,4%
set Mon=%DateTime:~4,2%
set Day=%DateTime:~6,2%
set Hr=%DateTime:~8,2%
set Min=%DateTime:~10,2%
set Sec=%DateTime:~12,2%

REM This ensures the command prompt is working from the directory the script is located in.
cd /D "%~dp0"

@ECHO Please wait. This window will close once the process has finished and any errors will be recorded in the log file.

REM This is the exiftool command listing the required tags to be exported from all files in the specified location in CSV format. The current target DIR assumes the script is running inside a tag level folder within a BagIt bag, where the CSV and log is exported to the same directory as the batch file.
exiftool -csv -r -DateTimeOriginal -LayerCount -ImageSourceData -Compression -HistoryParameters -BitsPerSample -XResolution -YResolution -ColorMode -ColorSpace -ColorSpaceData -ICCProfileName -ProfileDescription "..\data" > "exiftool-report_%Yr%%Mon%%Day%_%Hr%%Min%%Sec%.csv" 2>exiftool-QC_%Yr%%Mon%%Day%_%Hr%%Min%%Sec%.log
