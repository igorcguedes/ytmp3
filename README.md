Simple shell script that download a song with youtube-dl/yt-dlp, rename, add artist and album name with id3tool.

Example:

    ytmp3 -o "Devil Trigger" -r "Casey Edwards" -a "DMC" "https://www.youtube.com/watch?v=-WpnPSChVRQ"

use ytmp3 -h to get the flag list:

The most efficient way to run the script:
                
    ytmp3 -c -o "Name of the song"

I recommend place the script in a desired folder, ~/scripts for example, and exporting to .zsrch or bash.

    export PATH=$HOME/scripts/:$PATH
