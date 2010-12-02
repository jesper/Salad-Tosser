# Add more folders to ship with the application, here
folder_01.source = qml/Pusku
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

QT += opengl
MOBILITY = multimedia
# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# Avoid auto screen rotation
DEFINES += ORIENTATIONLOCK

# Needs to be defined for Symbian
#DEFINES += NETWORKACCESS

symbian:TARGET.UID3 = 0xE6003429

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
CONFIG += mobility
MOBILITY += sensors

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    loadscreen.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES +=

HEADERS += \
    accelerometer.h \
    audio.h \
    loadscreen.h

RESOURCES += \
    resources.qrc

FORMS += \
    loadscreen.ui
