#-------------------------------------------------
#
# Project created by QtCreator 2011-05-17T12:50:25
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = StereoVideo
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app

INCLUDEPATH  = /usr/local/include/opencv
LIBS        += -lopencv_core -lopencv_highgui -lopencv_video -lopencv_calib3d -lopencv_features2d

SOURCES += main.cpp
