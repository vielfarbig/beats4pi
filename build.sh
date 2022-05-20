#!/bin/bash
echo Target version: $BEATS_VERSION

BRANCH=$(echo $BEATS_VERSION | awk -F \. {'print $1 "." $2'})
echo Target branch: $BRANCH

if [ ! -d "$GOPATH/src/github.com/elastic/beats" ]; then
	mkdir -p ${GOPATH}/src/github.com/elastic
	git clone https://github.com/elastic/beats ${GOPATH}/src/github.com/elastic/beats
fi

cd ${GOPATH}/src/github.com/elastic/beats
git checkout $BRANCH

IFS=","
BEATS_ARRAY=($BEATS)

for BEAT in "${BEATS_ARRAY[@]}"
do
    # build
    cd $BEAT
    go build

    #+make
    cp $BEAT /build
    cd ..

done
