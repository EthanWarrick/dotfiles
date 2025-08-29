FROM python:3.7

ENV DIRPATH=/usr/src/app
WORKDIR $DIRPATH

# Clone Hack & Alt-Hack
RUN git clone --depth 1 --branch dev https://github.com/source-foundry/Hack.git $DIRPATH
RUN git clone --depth 1 https://github.com/source-foundry/alt-hack.git $DIRPATH/alt-hack/

# Edit the Alt-Hack script 'patch-hack.sh'
RUN sed -i 's/HACK_PATH=""/HACK_PATH="$DIRPATH"/' $DIRPATH/alt-hack/patch-hack.sh
RUN sed -i '/^declare -a alternates=(/,/^)/c\declare -a alternates=(\n    "u0030-forwardslash"\n    "u0069-slab"\n    "u00EC-slab"\n    "u00ED-slab"\n    "u00EE-slab"\n    "u00EF-slab"\n    "u0129-slab"\n    "u012B-slab"\n    "u012D-slab"\n    "u012F-slab"\n    "u0131-slab"\n    "u0456-slab"\n    "u0457-slab"\n)' $DIRPATH/alt-hack/patch-hack.sh

# Run the script
WORKDIR $DIRPATH/alt-hack
RUN $DIRPATH/alt-hack/patch-hack.sh 
WORKDIR $DIRPATH

# Change the type hinting thing.
RUN head -n -4 postbuild_processing/tt-hinting/Hack-Regular-TA.txt > /tmp/tmp.txt && mv /tmp/tmp.txt postbuild_processing/tt-hinting/Hack-Regular-TA.txt

# Compile font
RUN python -m pip install pipenv
RUN make compile-local-dep
RUN make ttf
RUN mkdir -p /output && cp $DIRPATH/build/ttf/*.ttf /output/

CMD [ "bash" ]
