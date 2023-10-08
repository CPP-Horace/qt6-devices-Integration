// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0

import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Window
import QtQuick.Layouts

Rectangle {
    id: master
    width: 1366
    height: 705
    visible: true
    //title: "德图福思"
    color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
    property string formulaName: "无"
    property string formulaSpeed: "0"
    property string textCountAll: ""  //进料数量
    property string textCountPass: ""
    property string textCountInspection: "" //检测数量
    property string textCountEliminate: "" //总剔除数量
    property string textCountLogisticscode: "" //物流码剔除数量
    property string textCountWaste: ""
    property string textCountLocateWaste: ""
    property string textCountCodeWaste: ""
    property string textCountPauseWaste: ""
    property string textEquipmentSteps: "未启动"
    property string textProduceState: "1"
    property int autoPointMode: 2
    property int openFlag: 0
    property bool handMoveState: false // false-->自动    true-->手动

    TabBar {
        id: bar
        width: master.width / 8
        x: 10
        y: 30
        background: Rectangle {
            color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
        }
        TabButton {
            id: cameraBtn
            text: qsTr("         相        机")
            height: 91
            width: master.width / 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            font.pointSize: 14
            contentItem: IconLabel {
                spacing: cameraBtn.spacing
                mirrored: cameraBtn.mirrored
                display: cameraBtn.display

                icon: cameraBtn.icon
                text: cameraBtn.text
                font: cameraBtn.font
                color: cameraBtn.palette.windowText
            }
            Image {
                source: "file:///" + appdir + "/ico/xiangji.png"
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit //保持宽高比
                mipmap: true
                x: 20
                anchors.verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                id: cameraBackRec
                radius: 10
                border.width: 2
                border.color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
                color: bar.currentIndex === 0 ? "lightblue" : Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.currentIndex = 0;
                }
                onEntered: {
                    cameraBackRec.border.color = "lightblue";
                }
                onExited: {
                    cameraBackRec.border.color = Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1);
                }
            }
        }
        TabButton {
            id: produceDataBtn
            text: qsTr("         生产数据")
            height: 91
            font.pointSize: 14
            width: master.width / 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cameraBtn.bottom
            contentItem: IconLabel {
                spacing: produceDataBtn.spacing
                mirrored: produceDataBtn.mirrored
                display: produceDataBtn.display

                icon: produceDataBtn.icon
                text: produceDataBtn.text
                font: produceDataBtn.font
                color: produceDataBtn.palette.windowText
            }
            Image {
                source: "file:///" + appdir + "/ico/shuju.png"
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit //保持宽高比
                mipmap: true
                x: 20
                anchors.verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                id: produceDataBackRec
                radius: 10
                border.width: 2
                border.color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
                color: bar.currentIndex === 1 ? "lightblue" : Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.currentIndex = 1;
                }
                onEntered: {
                    produceDataBackRec.border.color = "lightblue";
                }
                onExited: {
                    produceDataBackRec.border.color = Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1);
                }
            }
        }
        TabButton {
            id: alarmBtn
            text: qsTr("         报警显示")
            height: 91
            font.pointSize: 14
            width: master.width / 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: produceDataBtn.bottom
            contentItem: IconLabel {
                spacing: alarmBtn.spacing
                mirrored: alarmBtn.mirrored
                display: alarmBtn.display

                icon: alarmBtn.icon
                text: alarmBtn.text
                font: alarmBtn.font
                color: alarmBtn.palette.windowText
            }
            Image {
                source: "file:///" + appdir + "/ico/alarm.png"
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit //保持宽高比
                mipmap: true
                x: 20
                anchors.verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                id: alarmRec
                radius: 10
                border.width: 2
                border.color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
                color: bar.currentIndex === 2 ? "lightblue" : Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.currentIndex = 2;
                    var json = {
                        "pageSize": 12,
                        "pageNumber": 1
                    };
                    alarmItem.alarmList.clear();
                    var strSend = JSON.stringify(json);
                    var jsRet = appMetaFlash.qmlCallExpected(MainWindow.ExpectedFunction.SelectAlert, strSend);
                    var result = JSON.parse(jsRet);
                    if (result.ok === true) {
                        alarmItem.itemCount = result.details.num;
                    } else {
                        console.log("require alarm faile");
                    }
                }
                onEntered: {
                    alarmRec.border.color = "lightblue";
                }
                onExited: {
                    alarmRec.border.color = Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1);
                }
            }
        }

        TabButton {
            id: valveBtn
            text: qsTr("         阀        门")
            height: 91
            font.pointSize: 14
            width: master.width / 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: alarmBtn.bottom
            contentItem: IconLabel {
                spacing: valveBtn.spacing
                mirrored: valveBtn.mirrored
                display: valveBtn.display

                icon: valveBtn.icon
                text: valveBtn.text
                font: valveBtn.font
                color: valveBtn.palette.windowText
            }
            Image {
                source: "file:///" + appdir + "/ico/famen.png"
                width: 46
                height: 46
                fillMode: Image.PreserveAspectFit //保持宽高比
                mipmap: true
                x: 19
                anchors.verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                id: valveRec
                radius: 10
                border.width: 2
                border.color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
                color: bar.currentIndex === 3 ? "lightblue" : Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.currentIndex = 3;
                    if (volveItem.openFlag) {
                        volveItem.curPage = 1;
                        volveItem.curPage = 0;
                        volveItem.initValve();
                        volveItem.openFlag = false;
                    }
                    volveItem.requireValveState();
                }
                onEntered: {
                    valveRec.border.color = "lightblue";
                }
                onExited: {
                    valveRec.border.color = Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1);
                }
            }
        }
        TabButton {
            id: powerBtn
            text: qsTr("         电        机")
            height: 91
            font.pointSize: 14
            width: master.width / 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: valveBtn.bottom
            contentItem: IconLabel {
                spacing: powerBtn.spacing
                mirrored: powerBtn.mirrored
                display: powerBtn.display

                icon: powerBtn.icon
                text: powerBtn.text
                font: powerBtn.font
                color: powerBtn.palette.windowText
            }
            Image {
                source: "file:///" + appdir + "/ico/dianji.png"
                width: 37
                height: 37
                fillMode: Image.PreserveAspectFit //保持宽高比
                mipmap: true
                x: 26
                anchors.verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                id: powerRec
                radius: 10
                border.width: 2
                border.color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
                color: bar.currentIndex === 4 ? "lightblue" : Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.currentIndex = 4;
                    if (powerItem.initFlag) {
                        powerItem.curPage = 1;
                        powerItem.curPage = 0;
                        powerItem.initPower();
                        powerItem.initFlag = false;
                    }
                    powerItem.requirePowerState();
                }
                onEntered: {
                    powerRec.border.color = "lightblue";
                }
                onExited: {
                    powerRec.border.color = Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1);
                }
            }
        }
        TabButton {
            id: manageBtn
            text: qsTr("         用户管理")
            height: 91
            font.pointSize: 14
            width: master.width / 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: powerBtn.bottom
            contentItem: IconLabel {
                spacing: manageBtn.spacing
                mirrored: manageBtn.mirrored
                display: manageBtn.display

                icon: manageBtn.icon
                text: manageBtn.text
                font: manageBtn.font
                color: manageBtn.palette.windowText
            }
            Image {
                source: "file:///" + appdir + "/ico/yonghuguanli.png"
                width: 37
                height: 37
                fillMode: Image.PreserveAspectFit //保持宽高比
                mipmap: true
                x: 22
                anchors.verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                id: manageRec
                radius: 10
                border.width: 2
                border.color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
                color: bar.currentIndex === 5 ? "lightblue" : Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.currentIndex = 5;
                }
                onEntered: {
                    manageRec.border.color = "lightblue";
                }
                onExited: {
                    manageRec.border.color = Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1);
                }
            }
        }
        TabButton {
            id: operateBtn
            text: qsTr("         操作日志")
            height: 91
            font.pointSize: 14
            width: master.width / 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: manageBtn.bottom
            contentItem: IconLabel {
                spacing: operateBtn.spacing
                mirrored: operateBtn.mirrored
                display: operateBtn.display

                icon: operateBtn.icon
                text: operateBtn.text
                font: operateBtn.font
                color: operateBtn.palette.windowText
            }
            Image {
                source: "file:///" + appdir + "/ico/caozuorizhi.png"
                width: 36
                height: 36
                fillMode: Image.PreserveAspectFit //保持宽高比
                mipmap: true
                x: 20
                anchors.verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                id: operateRec
                radius: 10
                border.width: 2
                border.color: Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
                color: bar.currentIndex === 6 ? "lightblue" : Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.currentIndex = 6;
                }
                onEntered: {
                    operateRec.border.color = "lightblue";
                }
                onExited: {
                    operateRec.border.color = Qt.rgba(245 / 255, 248 / 255, 245 / 255, 1);
                }
            }
        }
        onCurrentIndexChanged: {
            if (currentIndex === 0) {
                cameraItem.timeTask.start();
                produceItem.timeTask.stop();
            } else if (currentIndex === 1) {
                cameraItem.timeTask.stop();
                produceItem.timeTask.start();
            } else {
                cameraItem.timeTask.stop();
                produceItem.timeTask.stop();
            }
        }
    }

    StackLayout {
        id: view
        width: parent.width
        currentIndex: bar.currentIndex
        // 相机
        Item {
            id: cameraTab
            StrightCamera {
                id: cameraItem
                x: 190
                y: 30
            }
        }
        // 生产数据
        Item {
            id: produceDataTab
            StrightProduceData {
                id: produceItem
                x: 190
                y: 30
            }
        }

        // 报警显示
        Item {
            id: alarmTab
            Alarm {
                id: alarmItem
                x: 190
                y: 30
            }
        }
        // 阀门
        Item {
            id: valvePageTab
            StrightValvePage {
                id: volveItem
                x: 190
                y: 30
            }
        }
        // 电机
        Item {
            id: powerPageTab
            StrightPowerPage {
                id: powerItem
                x: 190
                y: 30
            }
        }

        // 用户管理
        Item {
            id: userPageTab
            UserPage {
                x: 190
                y: 30
            }
        }
        // 操作日志
        Item {
            id: nonepage
            // PlcTest {
            //     x: 190
            //     y: 30
            // }
        }
    }
    onVisibleChanged: {
        root.visible = true;
    }
}
