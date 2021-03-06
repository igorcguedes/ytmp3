#!/bin/sh
# REQUIREMENTS=('yt-dlp')

downloaddir=$HOME/Music

artist=none
album=none

useclipboard="false"

cd $downloaddir

if command -v yt-dlp &> /dev/null
then
  downloader=yt-dlp
else
  downloader=youtube-dl
fi

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "this is a script to download mp3 files from any place that youtube-dl/yt-dlp can"
      echo ""
      echo "Please put your flags before input link"
      echo "script will prefer yt-dlp over youtube-dl"
      echo "default download path is '~/Music', feel free to change it (downloaddir variable in the beginning of the script)"
      echo ""
      echo "Flags:"
      echo ""
      echo "-o Output file name"
      echo "-a Album name of the output file"
      echo "-r Artist name of the output file"
      echo "-c copy mp3 link from clipboard"
      echo "-rofi launches rofi to choose a name for next mp3, link will be taken from system clipboard"
      echo "-dmenu same as rofi, but for dmenu (doesn't work at the moment)"
      exit 0
      ;;
    -o)
      shift
      output=$1
      shift
      ;;
    -a)
      shift
			album=$1
      shift
      ;;
		-r)
      shift
			artist=$1
      shift
			;;
    -c)
      useclipboard="true"
      shift
      ;;
    -dmenu|--dmenu)
      menu="dmenu"
      shift
      ;;
    -rofi|--rofi)
      menu="rofi"
      shift
      ;;
    -n|--notify)
      notify="true"
      shift
      ;;
    *)
      break
      ;;
  esac
done

input=$1

if [ "$menu" = "rofi" ]; then
  output=$(rofi -dmenu)
  useclipboard="true"
fi

#if [ $menu = "dmenu" ]; then
#  output=$(dmenu)
#  useclipboard="true"
#fi

if [ "$useclipboard" = "true" ]; then
  input=$(xclip -o -sel c)
fi

[ -n "$notify" ] && notify-send "Downloading $input"

if [ -n "$output" ]; then
  $downloader -x --audio-format mp3 --prefer-ffmpeg $input -o "$output.mp3"
  file="$output.mp3"
else
  $downloader -x --audio-format mp3 --prefer-ffmpeg $input -o "%(title)s.mp3"
  file=$(yt-dlp -o "%(title)s.mp3" --get-filename $input)
fi

if command -v yt-dlp &> /dev/null
then
  id3tool -a "$album" -r "$artist" "$file"
fi

echo $file
[ -n "$notify" ] && notify-send "Your download is finished :)"
