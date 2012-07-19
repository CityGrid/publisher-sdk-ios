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

BUILD_DIR=build
IOS_BUILD_DIR=${BUILD_DIR}/Release-iphoneos
I386_BUILD_DIR=${BUILD_DIR}/Release-iphonesimulator
UNIVERSAL_BUILD_DIR=${BUILD_DIR}/Release-universal
LIB_NAME=libCityGrid.a
FRAMEWORK_BUILD_DIR=${BUILD_DIR}/Release-framework
FRAMEWORK_NAME=CityGrid
FRAMEWORK_DIR=${FRAMEWORK_BUILD_DIR}/${FRAMEWORK_NAME}.framework
FRAMEWORK_VERSION=2
FRAMEWORK_SHORT_VERSION=2.4
IMAGE_DIR=${BUILD_DIR}/image

trap errored TERM
trap interrupted INT

rm -fr ${BUILD_DIR}

SECTION="Cleaning ${BUILD_DIR}"
echo "${SECTION}"
rm -fr ${BUILD_DIR}

SECTION="Testing API for iOS Simulator"
echo "${SECTION}"
xcodebuild -project CityGrid.xcodeproj -sdk iphonesimulator4.3 -configuration Debug -target CityGrid
xcodebuild -project CityGrid.xcodeproj -sdk iphonesimulator4.3 -configuration Debug -target CityGridTests

SECTION="Cleaning Test ${BUILD_DIR}"
echo "${SECTION}"
rm -fr ${BUILD_DIR}

SECTION="Building for iOS Simulator"
echo "${SECTION}"
xcodebuild -project CityGrid.xcodeproj -sdk iphonesimulator4.3 -configuration Release -target CityGrid

SECTION="Building for iOS Device"
echo "${SECTION}"
xcodebuild -project CityGrid.xcodeproj -sdk iphoneos4.3 -configuration Release -target CityGrid

SECTION="Building a Universal"
echo "${SECTION}"
mkdir -p ${UNIVERSAL_BUILD_DIR}
lipo -create ${IOS_BUILD_DIR}/${LIB_NAME} -arch i386 ${I386_BUILD_DIR}/${LIB_NAME} -o ${UNIVERSAL_BUILD_DIR}/${LIB_NAME}

SECTION="Building a Framework"
echo "${SECTION}"
mkdir -p ${FRAMEWORK_DIR}/Versions/1/Resources
mkdir -p ${FRAMEWORK_DIR}/Versions/1/Headers
mkdir -p ${FRAMEWORK_DIR}/Versions/1/Documentation
cp ${UNIVERSAL_BUILD_DIR}/${LIB_NAME} ${FRAMEWORK_DIR}/Versions/1/${FRAMEWORK_NAME}
cat > ${FRAMEWORK_DIR}/Versions/1/Resources/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>English</string>
	<key>CFBundleExecutable</key>
	<string>CityGrid</string>
	<key>CFBundleName</key>
	<string>CityGrid SDK</string>
	<key>CFBundleIdentifier</key>
	<string>com.citygrid.CityGrid</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundlePackageType</key>
	<string>FMWK</string>
	<key>CFBundleSignature</key>
	<string>CGFW</string>
	<key>CFBundleVersion</key>
	<string>${FRAMEWORK_VERSION}</string>
	<key>CFBundleShortVersionString</key>
	<string>${FRAMEWORK_SHORT_VERSION}</string>
	<key>NSHumanReadableCopyright</key>
	<string>Copyright 2011 CityGrid Media, LLC</string>
	<key>CFBundleGetInfoString</key>
	<string>Welcome to the CityGrid SDK for iOS. Using the CityGrid SDK, you can access and display local *content* and *advertising* on your iOS application. This CityGrid SDK and Documentation uses and mirrors the publicly available REST APIs available at docs.citygridmedia.com</string>
</dict>
</plist>
EOF

rsync -al -exclude-cvs --exclude ".svn/*" --exclude ".svn" ${IOS_BUILD_DIR}/Headers/ ${FRAMEWORK_DIR}/Versions/1/Headers
rsync -al -exclude-cvs --exclude ".svn/*" --exclude ".svn" Library/Simulation ${FRAMEWORK_DIR}/Versions/1/Resources
headerdoc2html -o ${FRAMEWORK_DIR}/Versions/1/Documentation ${FRAMEWORK_DIR}/Versions/1/Headers
gatherheaderdoc ${FRAMEWORK_DIR}/Versions/1/Documentation index.html

ln -s 1 ${FRAMEWORK_DIR}/Versions/Current
ln -s Versions/Current/Headers ${FRAMEWORK_DIR}/Headers
ln -s Versions/Current/Resources ${FRAMEWORK_DIR}/Resources
ln -s Versions/Current/Documentation ${FRAMEWORK_DIR}/Documentation
ln -s Versions/Current/${FRAMEWORK_NAME} ${FRAMEWORK_DIR}/${FRAMEWORK_NAME}

trap - INT TERM

echo "Success!"
exit 0
