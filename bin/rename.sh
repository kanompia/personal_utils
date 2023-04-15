#!/bin/sh
ARG_SOURCE_DIR=$1
ARG_TARGET_DIR=$2
ARG_PREFIX=$3
ARG_DEBUG=1
PWD=$(pwd)

if [ "$ARG_DEBUG" = "1" ]; then
	echo "Working in Dir: $ARG_SOURCE_DIR"
	echo "Prefix: $ARG_PREFIX"
	echo "Current Dir: $PWD"
fi

usage()
{
	echo "Usage:"
	echo "  \$ ./rename.sh [SOURCE_DIR] [TARGET_DIR] [PREFIX]"
	echo ""
	echo "Example:"
	echo "  \$ ./rename.sh \"Source Folder Chapter 01\" \"Target_Folder\" 01"
	echo "  \$ ./rename.sh \"Source Folder Chapter 02\" \"Target_Folder\" 02"
	echo "  ..."
	echo "  \$ ./rename.sh \"Source Folder Chapter NN\" \"Target_Folder\" NN"
	echo ""
}

if [ "$ARG_SOURCE_DIR" = "" ] || [ "$ARG_TARGET_DIR" = "" ]; then
	usage
	exit
fi


# Check source directory and target directory
if [ ! -d "$ARG_SOURCE_DIR" ]; then
	echo "The specified directory \"$ARG_SOURCE_DIR\" doesn't exist"
fi
if [ ! -d "$ARG_TARGET_DIR" ]; then
	echo "Directory \"$ARG_TARGET_DIR\" doesn't exist"
	while true; do
		read -p "Do you wish to create it now? (Y/N) " yn
		case $yn in
			[Yy]* ) mkdir -p "$ARG_TARGET_DIR"; break;;
			[Nn]* ) exit;;
			* ) echo "Please answer Y/N";;
		esac
	done
fi
if [ ! -d "$ARG_TARGET_DIR" ]; then
	echo "Your desired target directory is not exist or unable to create"
	exit
fi

# Change Dir
cd "$ARG_SOURCE_DIR"
# List files in that DIR
for FILE in *.mp4; do
	echo "File: $FILE"
	SOURCE_FILE="${PWD}/${FILE}"
	TARGET_FILE="${ARG_TARGET_DIR}/${ARG_PREFIX}_${FILE}"
	if [ ! -f "${SOURCE_FILE}" ]; then
		echo "File ${FILE}  at ${SOURCE_FILE} doesn't exist"
		echo
	else
		echo "cp \"${SOURCE_FILE}\"  \"${TARGET_FILE}\""
		cp -Rf "${SOURCE_FILE}"  "${TARGET_FILE}"
		echo
	fi
done

