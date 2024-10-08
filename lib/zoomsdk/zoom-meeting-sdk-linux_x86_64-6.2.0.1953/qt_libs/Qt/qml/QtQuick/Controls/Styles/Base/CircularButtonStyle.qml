/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Extras module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:COMM$
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** $QT_END_LICENSE$
**
**
**
**
**
**
**
**
**
**
**
**
**
**
**
**
**
**
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras.Private 1.0

ButtonStyle {
    id: buttonStyle

    label: Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font.pixelSize: TextSingleton.font.pixelSize * 1.25
        color: control.pressed || control.checked ? __buttonHelper.textColorDown : __buttonHelper.textColorUp
        styleColor: control.pressed || control.checked ? __buttonHelper.textRaisedColorDown : __buttonHelper.textRaisedColorUp
        style: Text.Raised
        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
    }

    /*! \internal */
    property alias __buttonHelper: buttonHelper

    CircularButtonStyleHelper {
        id: buttonHelper
        control: buttonStyle.control
    }

    background: Item {
        implicitWidth: __buttonHelper.implicitWidth
        implicitHeight: __buttonHelper.implicitHeight

        Canvas {
            id: backgroundCanvas
            anchors.fill: parent

            Connections {
                target: control
                function onPressedChanged() { backgroundCanvas.requestPaint() }
            }

            onPaint: {
                var ctx = getContext("2d");
                __buttonHelper.paintBackground(ctx);
            }
        }
    }
}
