/*
 * Copyright 2021  Kevin Donnelly
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kirigami 2.4 as Kirigami

Item {
    id: appearanceConfig

    property alias cfg_compactPointSize: compactPointSize.value
    property alias cfg_propHeadPointSize: propHeadPointSize.value
    property alias cfg_propPointSize: propPointSize.value
    property alias cfg_tempPointSize: tempPointSize.value
    property alias cfg_tempAutoColor: tempAutoColor.checked

    Kirigami.FormLayout {
        anchors.fill: parent

        Kirigami.Heading {
            Layout.fillWidth: true
            level: 2
            text: i18n("Compact Representation")
        }

        ConfigFontFamily {
            id: compactFontFamily

            configKey: "compactFamily"

            Kirigami.FormData.label: i18n("Font")
        }

        SpinBox {
            id: compactPointSize

            editable: true

            Kirigami.FormData.label: i18n("Font size (0px=scale to widget)")
        }

        ConfigTextFormat {
            Kirigami.FormData.label: i18n("Font styles")
        }

        Kirigami.Separator {}

        Kirigami.Heading {
            Layout.fillWidth: true
            level: 2
            text: i18n("Full Representation")
        }

        SpinBox {
            id: propHeadPointSize

            editable: true

            Kirigami.FormData.label: i18n("Property header text size")
        }

        SpinBox {
            id: propPointSize

            editable: true

            Kirigami.FormData.label: i18n("Property text size")
        }

        SpinBox {
            id: tempPointSize

            editable: true

            Kirigami.FormData.label: i18n("Temperature text size")
        }

        CheckBox {
            id: tempAutoColor

            Kirigami.FormData.label: "Auto-color temperature:"
        }

    }
}