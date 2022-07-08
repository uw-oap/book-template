# PANDOC_OPTIONS=--toc --top-level-division=chapter
VERSION_STRING := $(shell bin/get-version.sh)
DATE_STRING := $(shell date +"%B, %Y")
PANDOC_OPTIONS=--metadata-file=src/metadata.txt -M subtitle="Version ${VERSION_STRING}" -M date="${DATE_STRING}"
FILES_TO_COMPILE=src/*.org
BOOK_NAME=FIXME

.PHONY: pdf epub clean pushup

pdf: out/${BOOK_NAME}.pdf

epub: out/${BOOK_NAME}.epub

out/uw-it-managers.pdf: src/*
	pandoc ${PANDOC_OPTIONS} -o $@ -H style/header.tex ${FILES_TO_COMPILE}

out/uw-it-managers.epub: src/*
	pandoc ${PANDOC_OPTIONS} -o $@ ${FILES_TO_COMPILE}

clean:
	rm -f out/*

pushup:
	git push
	git push --tags
	git checkout develop
	git merge main
	git push
