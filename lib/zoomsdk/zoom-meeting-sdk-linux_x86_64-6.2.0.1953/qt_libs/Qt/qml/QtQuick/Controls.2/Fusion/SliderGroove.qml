/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls 2 module of the Qt Toolkit.
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
****************************************************************************/

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Fusion 2.12
import QtQuick.Controls.Fusion.impl 2.12

Rectangle {
    id: groove

    property Item control
    property real offset
    property real progress
    property real visualProgress

    x: control.horizontal ? 0 : (control.availableWidth - width) / 2
    y: control.horizontal ? (control.availableHeight - height) / 2 : 0

    implicitWidth: control.horizontal ? 160 : 5
    implicitHeight: control.horizontal ? 5 : 160
    width: control.horizontal ? control.availableWidth : implicitWidth
    height: control.horizontal ? implicitHeight : control.availableHeight

    radius: 2
    border.color: Fusion.outline(control.palette)
    scale: control.horizontal && control.mirrored ? -1 : 1

    gradient: Gradient {
        GradientStop {
            position: 0
            color: Qt.darker(Fusion.grooveColor(groove.control.palette), 1.1)
        }
        GradientStop {
            position: 1
            color: Qt.lighter(Fusion.grooveColor(groove.control.palette), 1.1)
        }
    }

    Rectangle {
        x: groove.control.horizontal ? groove.offset * parent.width : 0
        y: groove.control.horizontal ? 0 : groove.visualProgress * parent.height
        width: groove.control.horizontal ? groove.progress * parent.width - groove.offset * parent.width : 5
        height: groove.control.horizontal ? 5 : groove.progress * parent.height - groove.offset * parent.height

        radius: 2
        border.color: Qt.darker(Fusion.highlightedOutline(groove.control.palette), 1.1)

        gradient: Gradient {
            GradientStop {
                position: 0
                color: Fusion.highlight(groove.control.palette)
            }
            GradientStop {
                position: 1
                color: Qt.lighter(Fusion.highlight(groove.control.palette), 1.2)
            }
        }
    }
}
