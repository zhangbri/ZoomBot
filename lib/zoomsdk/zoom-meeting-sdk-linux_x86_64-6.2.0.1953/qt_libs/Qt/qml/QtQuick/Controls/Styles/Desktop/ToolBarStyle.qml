/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
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
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

/*!
    \qmltype StatusBarStyle
    \internal
    \inqmlmodule QtQuick.Controls.Styles
*/
Style {

    padding.left: 6
    padding.right: 6
    padding.top: 1
    padding.bottom: style.style === "mac" ? 1 : style.style === "fusion" ? 3 : 2

    StyleItem { id: style ; visible: false}

    property Component panel: StyleItem {
        id: toolbar
        anchors.fill: parent
        elementType: "toolbar"
        textureWidth: 64
        border {left: 16 ; right: 16}
    }
}
