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
git pull

IFS=","
BEATS_ARRAY=($BEATS)

for BEAT in "${BEATS_ARRAY[@]}"
do
    # build
    cd $BEAT
    go build

    # list files for debugging in case beats are not available
    ls

    SUFFIX=""

    if [[ -z "${GOOS}" ]]; then
	  echo "No GOOS set. This might be ok, when using linux/arm e. g."
      else
	  if [ "${GOOS}" = "windows" ]; then
		  SUFFIX=".exe"
	  fi
    fi

    #+make
    cp "$BEAT$SUFFIX" /build || true
    cd ..

done
