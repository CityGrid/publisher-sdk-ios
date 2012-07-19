#!/bin/sh
set -u
set -e

function errored() {
	echo "FAILED: ${SECTION}"
	exit 1
}

function interrupted() {
	echo "FAILED: Interrupted at ${SECTION}"
	exit 1
}

FRAMEWORK_SRC_DIR=../library/build/Release-framework/CityGrid.framework

if [ ! -d "${FRAMEWORK_SRC_DIR}" ]; then
	echo "FAILED: Missing ${FRAMEWORK_SRC_DIR} Please build the framework first"
	exit 1
fi

trap errored TERM
trap interrupted INT

SECTION="Syncing the CityGrid.framework"
rsync -ac -exclude-cvs --exclude ".svn/*" --exclude ".svn" ${FRAMEWORK_SRC_DIR} .

trap - INT TERM

echo "Framework Update Success!"
exit 0
