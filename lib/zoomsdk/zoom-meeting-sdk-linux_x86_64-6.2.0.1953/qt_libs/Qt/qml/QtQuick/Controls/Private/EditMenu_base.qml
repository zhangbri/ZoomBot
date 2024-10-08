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

Item {
    id: editMenuBase
    anchors.fill: parent

    Component {
        id: undoAction
        Action {
            text: qsTr("&Undo")
            shortcut: StandardKey.Undo
            iconName: "edit-undo"
            enabled: input.canUndo
            onTriggered: input.undo()
        }
    }

    Component {
        id: redoAction
        Action {
            text: qsTr("&Redo")
            shortcut: StandardKey.Redo
            iconName: "edit-redo"
            enabled: input.canRedo
            onTriggered: input.redo()
        }
    }

    Component {
        id: cutAction
        Action {
            text: qsTr("Cu&t")
            shortcut: StandardKey.Cut
            iconName: "edit-cut"
            enabled: !input.readOnly && selectionStart !== selectionEnd
            onTriggered: {
                input.cut();
                input.select(input.cursorPosition, input.cursorPosition);
            }
        }
    }

    Component {
        id: copyAction
        Action {
            text: qsTr("&Copy")
            shortcut: StandardKey.Copy
            iconName: "edit-copy"
            enabled: input.selectionStart !== input.selectionEnd
            onTriggered: {
                input.copy();
                input.select(input.cursorPosition, input.cursorPosition);
            }
        }
    }

    Component {
        id: pasteAction
        Action {
            text: qsTr("&Paste")
            shortcut: StandardKey.Paste
            iconName: "edit-paste"
            enabled: input.canPaste
            onTriggered: input.paste()
        }
    }

    Component {
        id: deleteAction
        Action {
            text: qsTr("Delete")
            shortcut: StandardKey.Delete
            iconName: "edit-delete"
            enabled: !input.readOnly && input.selectionStart !== input.selectionEnd
            onTriggered: input.remove(input.selectionStart, input.selectionEnd)
        }
    }

    Component {
        id: clearAction
        Action {
            text: qsTr("Clear")
            shortcut: StandardKey.DeleteCompleteLine
            iconName: "edit-clear"
            enabled: !input.readOnly && input.length > 0
            onTriggered: input.remove(0, input.length)
        }
    }

    Component {
        id: selectAllAction
        Action {
            text: qsTr("Select All")
            shortcut: StandardKey.SelectAll
            enabled: !(input.selectionStart === 0 && input.selectionEnd === input.length)
            onTriggered: input.selectAll()
        }
    }

    property Component defaultMenu: Menu {
        MenuItem { action: undoAction.createObject(editMenuBase) }
        MenuItem { action: redoAction.createObject(editMenuBase) }
        MenuSeparator {}
        MenuItem { action: cutAction.createObject(editMenuBase) }
        MenuItem { action: copyAction.createObject(editMenuBase) }
        MenuItem { action: pasteAction.createObject(editMenuBase) }
        MenuItem { action: deleteAction.createObject(editMenuBase) }
        MenuItem { action: clearAction.createObject(editMenuBase) }
        MenuSeparator {}
        MenuItem { action: selectAllAction.createObject(editMenuBase) }
    }

    Connections {
        target: mouseArea

        function onClicked() {
            if (input.selectionStart === input.selectionEnd) {
                var cursorPos = input.positionAt(mouse.x, mouse.y)
                input.moveHandles(cursorPos, cursorPos)
            }

            input.activate()

            if (control.menu) {
                var menu = getMenuInstance();
                menu.__dismissAndDestroy();
                var menuPos = mapToItem(null, mouse.x, mouse.y)
                menu.__popup(Qt.rect(menuPos.x, menuPos.y, 0, 0), -1, MenuPrivate.EditMenu);
            }
        }
    }
}
