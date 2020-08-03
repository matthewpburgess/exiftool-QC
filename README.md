# exiftool-QC
A simple Windows batch script that utilises ExifTool to read metadata from image files and generate a CSV export for quality control purposes. 

The current target directory assumes the script is running inside a tag level folder within a BagIt bag, where the CSV and log is exported to the same directory as the batch file.

## Requirements
1. A computer running a Windows operating system. This was created and tested on Windows 10
2. ExifTool by Phil Harvey, available from https://www.exiftool.org/. Follow the Windows install instructions for use on the command line

***Note:*** If you cannot move the ExifTool executable to C:\WINDOWS due to lack of admin/user rights, you can update the batch script to refer to the path of the executable in another location instead, eg. "C:\path\to\exiftool.exe"

## ExifTool command and tags
The following ExifTool command is used:

    exiftool -csv -r -DateTimeOriginal -LayerCount -ImageSourceData -Compression -HistoryParameters -BitsPerSample -XResolution -YResolution -ColorMode -ColorSpace -ColorSpaceData -ICCProfileName -ProfileDescription path\to\folder > exiftool-report.csv

The following tags are included in the CSV export and should be checked against preferred specifications and guidelines. Note that tags will not be included in the export if not present/no data.
Tag name | Description
------------ | -------------
DateTimeOriginal | Original datetime stamp from the camera. May be used for cataloguing if trustworthy. The datetime is often manually set on a camera and may not update automatically based on timezone. Check with the photographer whether this data is accurate.
LayerCount | Extracted from Photoshop layer information if present. Can be used to indicate whether a file contains layers.
ImageSourceData | Photoshop DocumentData. Should be blank if no layers are present.
Compression | 
HistoryParameters | Used to check the history of a file, specifically whether it has been converted to TIFF from JPEG.
BitsPerSample | 
XResolution | 
YResolution | 
ColorMode | 
ColorSpace | 
ColorSpaceData | 
ICCProfileName | 
ProfileDescription | 

***Note:*** The ExifTool command can be altered to include additional information about each file such as filename and MIMEType, but note that this may minimise error messages. For example, including those fields for extracting metadata on AppleDouble system files or a corrupt TIFF file where the other metadata tags cannot be read excludes error messages in the log such as "Error: File format error" and "Warning: Bad format (30908) for IFD0 entry 0".

## Customising the script
It may be more useful to run this script on digital material stored on an external devices such as a USB or hard drive before acquisition. Assuming that external devices are mapped to the same drive letter every time, you can change the target directory from "..\data" to the drive letter, H:\ for example. Note that the CSV and log exports to the same location as the batch script, so you might like to store the script on a local drive in a folder called exiftool-QC.
