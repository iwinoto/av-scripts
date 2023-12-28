#!/bin/bash
#Import MTS and CPI from Canon HFS11
#Camera will be mounted at /media/canonHFS11
# CPI files will be at /media/CANON/AVCHD/BDMV/CLIPINF
# MTS files will be at /media/CANON/AVCHD/BDMV/STREAM.
# JPG thumbnail files for the videos are in /media/CANON/AVCHD/CANONTHM
# CPI and MTS file names correspond except for the extension, which is CPI and MTS respectively.
#
# Starting with CLIPINF folder (although it doesn't matter) get the ls of files.
# for each file
#	get the last modified time stamp of the file
#	if a dir with the date does not exist in destination
#		create the dir with the date
#	endif
#	set $destFileName to $destRoot/$fileDate/$fileDateTime
#	copy the CPI file to $destFileName.CPI
#	copy the MTS file to $destFileName.MTS
#	copy the thumbnail to $destFileName.JPG
# endfor
#
# CHANGE LOG
# 2013 04 11	iwinoto		Timestamps don't seem to match file name.
# 2013 04 15	iwinoto		CPI and JPG files seem to be pretty useless, so not copying these any longer
# 2013 04 28	iwinoto		Since we aren't copying CPI and JPG, simplified directory structure to just one layer
# 2019 06 09    iwinoto         Transposed to Mac
#

sourceRoot='/Volumes/CANON/AVCHD'
sourceCPI=$sourceRoot/'BDMV/CLIPINF'
sourceMTS=$sourceRoot/'BDMV/STREAM'
sourceTHM=$sourceRoot/'CANONTHM'

temp='videoImport'

destRoot='/Users/iwinoto/Movies/camera/stage'

if [ ! -d "$temp" ]; then
	echo 'Working directory '"$temp/" 'does not exist'
	echo 'Creating working directory '"$temp/"
	mkdir -p "$temp"
fi

echo 'sourceMTS = '$sourceMTS
echo 'destRoot = '$destRoot

for file in $sourceMTS/*; do
	# get the file without path
	filename=$(basename "$file")
	fileNameNoExt=${filename%\.*}

	echo 'copying file '"$sourceMTS/$fileNameNoExt.MTS"' to '"$temp/"
#       -p  Cause cp to preserve the following attributes of each source file in the copy: modifica-
#           tion time, access time, file flags, file mode, user ID, and group ID, as allowed by per-
#           missions.  Access Control Lists (ACLs) and Extended Attributes (EAs), including resource
#           forks, will also be preserved.
	cp -p "$sourceMTS/$fileNameNoExt.MTS" "$temp/"
	
	# get the last modified time stamp of the file
	# use stat to get the epoch time of the file modification
	# use date -r to convert the epoch time to calendar time with a provided format.
        timestamp=`date -r $(stat -f "%m" "$temp/$fileNameNoExt.MTS") '+%Y%m%d%H%M%S'`

	# destinaiton dir is the date as YYYYMMDD, or first 8 characters of $timeStamp
	destDir=${timestamp:0:8}
	#testing
	echo 'file = '"$file"
	echo 'timestamp = '$timestamp
	echo 'fileNameNoExt = '$fileNameNoExt
	echo 'destDir = '$destDir
	echo '$destRoot/$destDir = '"$destRoot/$destDir"
	if [ ! -d "$destRoot/$destDir" ]; then
		echo "$destRoot/$destDir" 'does not exist'
		echo 'creating directory '"$destRoot/$destDir"
		mkdir -p "$destRoot/$destDir"
	fi

	echo 'moving file '"$temp/$fileNameNoExt.MTS"' to '"$destRoot/$destDir/$timestamp.MTS"
	mv "$temp/$fileNameNoExt.MTS" "$destRoot/$destDir/$timestamp.MTS"

done

# clean up
rm -rf "$temp/"

