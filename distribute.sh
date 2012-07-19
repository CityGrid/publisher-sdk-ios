#!/bin/sh
# This follows creating a framework for the iPhone outlined in
# http://accu.org/index.php/journals/1594
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

LIBRARY_DIR=library
FRAMEWORK_SRC_DIR=${LIBRARY_DIR}/build/Release-framework/CityGrid.framework

EXAMPLE1_DIR=example_1
EXAMPLE2_DIR=example_2

BUILD_DIR=build
BUILD_IMAGE_DIR=${BUILD_DIR}/image
VOLUME_NAME=CityGrid
DMG_NAME=CityGrid-2.4.dmg

trap errored TERM
trap interrupted INT

SECTION="Cleaning ${BUILD_DIR}"
rm -fr ${BUILD_DIR}

SECTION="Building ${LIBRARY_DIR}"
cd ${LIBRARY_DIR}
./distribute.sh
cd ..

SECTION="Updating ${EXAMPLE1_DIR}"
cd ${EXAMPLE1_DIR}
./update.sh
cd ..

SECTION="Updating ${EXAMPLE2_DIR}"
cd ${EXAMPLE2_DIR}
./update.sh
cd ..

SECTION="Building a disk image of the Framework and Example project"
echo "${SECTION}"

rm -fr ${BUILD_DIR}
mkdir -p ${BUILD_IMAGE_DIR}
rsync -al -exclude-cvs --exclude ".svn/*" --exclude ".svn" --exclude "build" ${FRAMEWORK_SRC_DIR} ${BUILD_IMAGE_DIR}
rsync -al -exclude-cvs --exclude ".svn/*" --exclude ".svn" --exclude "build" --exclude "update.sh" ${EXAMPLE1_DIR} ${BUILD_IMAGE_DIR}
rsync -al -exclude-cvs --exclude ".svn/*" --exclude ".svn" --exclude "build" --exclude "update.sh" ${EXAMPLE2_DIR} ${BUILD_IMAGE_DIR}

hdiutil create ${BUILD_DIR}/${DMG_NAME} -format UDZO -srcfolder ${BUILD_IMAGE_DIR} -volname ${VOLUME_NAME} -ov

trap - INT TERM

echo "Success!"
exit 0
