Simples shell script que faz o download de uma musica com o youtube-dl/yt-dlp, renomeia, adiciona o artista e o album nome com o id3tool.

#### Exemplo:

    ytmp3 -o "Devil Trigger" -r "Casey Edwards" -a "DMC" "https://www.youtube.com/watch?v=-WpnPSChVRQ"

use ytmp3 -h para ter a lista de flags:

#### A forma mais eficiente de executar o script:

    ytmp3 -c -o "Name of the song"

Recomendo colocar o script numa pasta desejada, ~/scripts por exemplo, e exportar pro .zsrch ou bash.

export PATH=$HOME/scripts/:$PATH
