# ref: https://trac.ffmpeg.org/wiki/CompilationGuide/MacOSX
#### Change log
# 7/05/2020 
# remove invalid options:
# --with-chromaprint

# brew install ffmpeg --with-fdk-aac --with-fontconfig --with-freetype --with-frei0r --with-game-music-emu --with-libass --with-libbluray --with-libbs2b --with-libcaca --with-libgsm --with-libmodplug --with-libsoxr --with-libssh --with-libvidstab --with-libvorbis --with-libvpx --with-opencore-amr --with-openh264 --with-openjpeg --with-openssl --with-opus --with-rtmpdump --with-rubberband --with-schroedinger --with-sdl2 --with-snappy --with-speex --with-tesseract --with-theora --with-tools --with-two-lame --with-wavpack --with-webp --with-x265 --with-xz --with-zeromq --with-zimg

brew install ffmpeg \
      --enable-shared \
      --enable-pthreads \
      --enable-version3 \
      --enable-avresample \
      --cc=#{ENV.cc} \
      --host-cflags=#{ENV.cflags} \
      --host-ldflags=#{ENV.ldflags} \
      --enable-ffplay \
      --enable-gnutls \
      --enable-gpl \
      --enable-libaom \
      --enable-libbluray \
      --enable-libmp3lame \
      --enable-libopus \
      --enable-librubberband \
      --enable-libsnappy \
      --enable-libsrt \
      --enable-libtesseract \
      --enable-libtheora \
      --enable-libvidstab \
      --enable-libvorbis \
      --enable-libvpx \
      --enable-libwebp \
      --enable-libx264 \
      --enable-libx265 \
      --enable-libxvid \
      --enable-lzma \
      --enable-libfontconfig \
      --enable-libfreetype \
      --enable-frei0r \
      --enable-libass \
      --enable-libopencore-amrnb \
      --enable-libopencore-amrwb \
      --enable-libopenjpeg \
      --enable-librtmp \
      --enable-libspeex \
      --enable-libsoxr \
      --enable-videotoolbox 
