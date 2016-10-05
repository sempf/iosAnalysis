#!/bin/bash

# ipa.info.sh
# Perfoms the initial information gathering for aniOS APK file
# usage ipa.info.sh <path_to_ipa_file> <appname>
# Bill Sempf (bill@pointweb.net)

# Get the parameters
ipafile=$1
appname=$2


# If the file exists
if [ -f $ipafile ]
	then
		# Unzip it
		unzip $ipafile

		# Get the path to the app
		apppath="./Payload/$appname.app/$appname"
		echo "Working on app at $apppath"

		# Archtecture with otool -f <appname>
		otool -f $apppath > "architecture.txt"

		# DLLs with nm <appname>
		nm $apppath > "dynamiclibraries.txt"

		# Dynamic dependancies with otool -L <appname>
		otool -l $apppath > "dynamicdependancies.txt"

		# Runtime info with class-dump-z <appname>
		class-dump-z $apppath > "runtime.txt"

		# Dump the keychain with dump_keychain
		dump_keychain $apppath > "keychain.txt"

		# Locate the PIE with otool -hv <appname>
		otool -hv $apppath > "pie.txt"

		# Stack smashing protection with otool -lv
		otool -lv $apppath > "stack.txt"
	else
		echo "File $ipapath doesn\'t exist."
# That's it.
fi
