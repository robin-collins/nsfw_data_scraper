#!/bin/bash

scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source_urls_dirname="source_urls"

if [[ "$1" == "test" ]]
then
	echo "Running in test mode" 
	source_urls_dirname="source_urls_test"
fi

base_dir="$(dirname "$scripts_dir")"
raw_data_dir="$base_dir/raw_data"

declare -a class_names=(
	"Couples"
"Gonewild"
"Stockings_Socks"
"Cum"
"Ginger"
"Japanese"
"drawings"
"Incest"
"Curvy_Thick_THICC"
"Yoga pants"
"Redditors"
"Positions"
"Body Type"
"Pussy"
"Meet People"
"Face"
"High Quality"
"Public"
"Petite"
"Athlete"
"requirements"
"OnlyFans"
"Legs_feet"
"Cam"
"Fit"
"Cum inside"
"Body Parts"
"Selfies"
"Titfuck"
"BDSM"
"Mound"
"Celebrity_Athlete"
"Outfits"
"Masturbation_Orgasm"
"Lesbian"
"Professional_Cam"
"Amateur"
"Hair"
"Asshole"
"neutral"
"Men"
"Anal"
"Blowjobs"
"Curves"
"Costumes"
"Hardcore"
"Feet"
"teens"
"Other NSFW"
"Waist_Tummy"
"Animated"
"Ebony"
"Comics"
"Misogyny"
"sexy"
"Dresses_Skirts"
"Asian"
"Underwear"
"Cuck"
"Ass"
"Nipples"
"Thighs"
"Celebrity"
"Hentai"
"Dildos"
"General"
"Groups"
"Looking for"
"Wives"
"Trash"
"White"
"Thongs"
"Boobs_Nipples"
"Large Penis"
"Ethnicity"
"Occupation"
"Age"
"porn"
"Emotion"
"Indian"
"Latina"
"Snapchat"
"Small"
"Professional_Sites_Porn"
"Teen"
"TikTok"
"Bikinis"
"Gore"
"Video Games"
"Individuals"
"Busty"
"MILF"
"Gifs"
"Cum Location"
"Social Media"
"Video"
"Wet women"
"Trans"
"Skin"
"Korean"
"Pants_Shorts"
	)

#download ripme.jar
wget https://github.com/RipMeApp/ripme/releases/download/1.7.95/ripme.jar -O $scripts_dir/ripme.jar

for cname in "${class_names[@]}"
do
	echo "--- Getting images for class: $cname"
	
	while read url
	do
		echo "------ url: $url"
		if [[ ! "$url" =~ ^"#" ]]
		then
			echo "$url"
			java -jar "$scripts_dir/ripme.jar" --skip404 --no-prop-file --ripsdirectory "$raw_data_dir/$cname" --url "$url"
		fi
	done < "$scripts_dir/$source_urls_dirname/$cname.txt"
done

for cname in "${class_names[@]}"
do
	urls_file="$raw_data_dir/$cname/urls_$cname.txt"
	tmpfile=$(mktemp)
	find "$raw_data_dir/$cname" -type f -name "urls.txt" -exec cat {} + >> "$tmpfile"
	grep -e ".jpeg" -e ".jpg" "$tmpfile" > "$urls_file"
	sort -u -o "$urls_file" "$urls_file"
	rm "$tmpfile"
done