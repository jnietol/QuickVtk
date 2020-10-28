import QtQuick 2.12
import QtQuick.Window 2.2

import UI 1.0 as UI
//import Code 1.0 as Code
import TypeInfo 1.0 as TypeInfo

Window {
    id: root;

    color: "#21252B"

    FocusScope {
      id: defaultFocus;
    }

    MouseArea {
      anchors.fill: parent;
      onClicked: defaultFocus.forceActiveFocus();
    }

    Preview {
      controls: details.controls;

      anchors.top: header.bottom;
      anchors.left: parent.left;
      anchors.right: hSplit.right;
      anchors.bottom: vSplit.top;
    }

    Item {
      id: hSplit;

      anchors.bottom: parent.bottom;
      anchors.top: header.bottom;
      anchors.right: parent.right;
      anchors.rightMargin: App.details.collapsed ? 0 : 400;

      width: 8;
      // TODO: use mouse drag instead of constant width
    }

    Item {
      id: vSplit;

      height: 30;

      anchors.left: parent.left;
      anchors.right: hSplit.right;
      anchors.bottom: parent.bottom;
      anchors.bottomMargin: App.console.collapsed ? 0 : 200;

      Rectangle {
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.top: parent.top;
        height: 1;
        color: "#181A1F"
      }

      MouseArea {
        anchors.fill: parent;

        onDoubleClicked: App.console.toggle();
      }

      Row {
        anchors.left: parent.left;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.leftMargin: 8;
        spacing: 8;

        UI.Button {
          id: vLabel;
          frameless: true
          anchors.verticalCenter: parent.verticalCenter;
          icon: App.console.collapsed ? icons.fa_caret_up : icons.fa_caret_down;
          label.text: "Console";
          onClicked: App.console.toggle();
        }

        UI.Icon {
          anchors.verticalCenter: parent.verticalCenter;

          color: "#6E7582"
          icon: icons.fa_info_circle;
        }

        UI.Badge {
          anchors.verticalCenter: parent.verticalCenter;
          label.text: App.console.items.length;
        }

        UI.Icon {
          anchors.verticalCenter: parent.verticalCenter;

          icon: icons.fa_exclamation_triangle;
          color: App.console.warningCount > 0 ? "#D4B05E" : "#6E7582"
        }

        UI.Badge {
          anchors.verticalCenter: parent.verticalCenter;
          label.text: App.console.warningCount;
        }

        UI.Icon {
          anchors.verticalCenter: parent.verticalCenter;

          icon: icons.fa_exclamation_circle;
          color: App.console.errorCount > 0 ? "#C54632" : "#6E7582"
        }

        UI.Badge {
          anchors.verticalCenter: parent.verticalCenter;
          label.text: App.console.errorCount;
        }
      }

      Row {
        anchors.right: parent.right;
        anchors.rightMargin: 8;
        anchors.top: parent.top;
        anchors.bottom: parent.bottom;

        spacing: 8;

        UI.Label {
          anchors.top: parent.top;
          anchors.bottom: parent.bottom;

          text: "Code"
          color: _codeMa.containsMouse || App.document.showSource ? "#fff" : "#9DA5B4";
          font.bold: true;

          MouseArea {
              id: _codeMa;

              anchors.fill: parent;
              hoverEnabled: true;
              onClicked: App.document.showSource = true;
          }
        }

        UI.Button {
          anchors.top: parent.top;
          anchors.bottom: parent.bottom;

          frameless: true;
          icon: icons.fa_exchange;
          onClicked: App.document.showSource = !App.document.showSource;
        }

        UI.Label {
          anchors.top: parent.top;
          anchors.bottom: parent.bottom;

          text: "Preview"
          color: _previewMa.containsMouse || !App.document.showSource ? "#fff" : "#9DA5B4";
          font.bold: true;

          MouseArea {
              id: _previewMa;

              anchors.fill: parent
              onClicked: App.document.showSource = false;
              hoverEnabled: true;
          }
        }
      }
    }

    Details {
      id: details;

      anchors.left: hSplit.right;
      anchors.right: parent.right;
      anchors.top: header.bottom;
      anchors.bottom: parent.bottom;
    }

    Console {
      anchors.top: vSplit.bottom;
      anchors.left: parent.left;
      anchors.right: hSplit.right;
      anchors.bottom: parent.bottom;
    }

    Header {
      id: header

      anchors.left: parent.left
      anchors.right: parent.right
      anchors.top: parent.top
    }
}
