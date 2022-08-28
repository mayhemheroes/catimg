FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev libjpeg-dev
RUN git clone https://github.com/posva/catimg.git
WORKDIR /catimg
RUN cmake -DCMAKE_C_COMPILER=afl-clang -DCMAKE_CXX_COMPILER=afl-clang .
RUN make
RUN make install
RUN mkdir /catimgCorpus
RUN cp ./test-images/*.png /catimgCorpus
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/mozilla/012-dispose-none.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/arc.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/arc.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/gray10.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/crosshatch30.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/gray100.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/hexagons.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/hs_cross.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/left30.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/left45.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal2.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal3.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/objects.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/red-ball.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/t-shirt.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/vertical.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/wizard.png
RUN mv *.png /catimgCorpus

ENTRYPOINT ["afl-fuzz", "-i", "/catimgCorpus", "-o", "/catimgOut"]
CMD ["/catimg/bin/catimg", "@@"]
