import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    id:root
    visible: true
    width: 450
    height: 600

    title: "Color Picker Application"

    Text{
        text: "Color Picker Application"
        //    verticalAlignment: Qt.AlignVCenter
        //    horizontalAlignment: Qt.AlignHCenter
        //    anchors.top: root.top
        x:root.width/2 - width/2
        y:10
        font.bold: true
        font.pointSize: 13
        color: "grey"

    }

    flags: Qt.FramelessWindowHint

    x:Screen.width/2 - width/2
    y:Screen.height/2 - height/2

    property bool handleScrollVisibility : true//false

    property string selectedColor

    color: listModel[0]

    //ComboBox for Filter Regexp
    Rectangle {
        id:cbRect
        width: 200
        height: 25
        radius: 5
        color: "white"

        //        anchors.top: parent.top

        y:50
        anchors.left: parent.left

        anchors.margins: 10

        ComboBox {
            currentIndex: colorProxyModel.cb_currentIndex
            model: ListModel {
                id: cbItems
                ListElement { text: "Regular expression";   value: 0 }
                ListElement { text: "Wildcard";             value: 1 }
                ListElement { text: "Fixed string";         value: 2 }
            }
            width: 200
            onCurrentIndexChanged: {
                console.debug(cbItems.get(currentIndex).text + ", " + cbItems.get(currentIndex).value)
                colorProxyModel.setCb_currentIndex(currentIndex)
            }
        }
    }

    Button{
        x: 330
        y:50
        text: "close"
        onClicked: root.close()

        style: ButtonStyle{
            background: Rectangle {
                id:backBtn
                implicitWidth: 100
                implicitHeight: 25
                border.width: control.activeFocus ? 2 : 1
                border.color: "#888"
                radius: 4
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                    GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                }
                color: "white"

            }
            label: Text {
                id: name
                text: qsTr("Close")
                font.family: "Ubuntu"
                font.bold: true
                //                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }
        }

    }

    //TextField to Filter
    Rectangle {
        id:txtRect
        width: 200
        height: 25
        radius: 5
        color: "white"

        anchors.top: cbRect.bottom
        anchors.left: cbRect.left

        TextField {
            id: edit
            width: 200

            placeholderText: "Filter by name.."

            onTextChanged: {
                colorProxyModel.setFilterFixedString(text)
            }
        }
    }

    //ListView for Colors List
    Rectangle{
        id:listViewRect
        anchors.top: txtRect.bottom
        anchors.left: txtRect.left


        width: parent.width - 20
        height: root.height - 130

        border.color: "grey"
        border.width: 1
        radius: 10

//        MouseArea {
//            anchors.fill: parent
//            hoverEnabled: true
//            onPressed: mouse.accepts = false
//            onEntered: {
//                handleScrollVisibility = true
//                console.log("Mouse Entered.")
//            }
//            onExited: {
//                handleScrollVisibility = true
//                console.log("Mouse Exited.")
//            }
//        }

        ScrollView
        {
            id: myScrollView
            anchors.fill: parent
            focus: true

            anchors.margins: 5

            //            frameVisible: false

            verticalScrollBarPolicy: Qt.ScrollBarAsNeeded



            style: ScrollViewStyle
            {
                handle: Rectangle
                {
                    id:rectHandle
                    visible:handleScrollVisibility
                    implicitWidth: 10
                    implicitHeight: 100
                    radius: 10
                    anchors.left: parent.left
                    color: "darkgrey"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: rectHandle.color = "black"
                        onPressAndHold: rectHandle.color = "red"
                    }

                }

                scrollBarBackground: Rectangle
                {
                    visible:false

                    implicitWidth: 12
                    anchors.right: parent.right
                    color: "transparent"
                }
                incrementControl:Rectangle{
                    visible: false
                }
                decrementControl:Rectangle{
                    visible: false
                }
            }
            ListView {
                id: list
                y:5
                x:5
                width: parent.width - 10
                height: parent.height - 10
                model: colorProxyModel
                clip:true

                Keys.onDownPressed: {
                    list.incrementCurrentIndex()
                    root.color = root.selectedColor
                }
                Keys.onUpPressed: {
                    list.decrementCurrentIndex()
                    root.color = root.selectedColor
                }
                //                Keys.onReturnPressed: root.color = root.selectedColor

                header: Component{
                    Item {
                        id: header
                        height: 25

                        Column {
                            id:col1
                            x:10
                            width: 360
                            Row{
                                Text { text: "<b>Name<b/> " ; color: "grey"; textFormat: Text.RichText; }
                            }
                        }
                        Column {
                            id:col2
                            width: 60
                            x:col1.width

                            Row{
                                Text { text: "<b>Color<b/> " ; color: "grey"; textFormat: Text.RichText}
                            }
                        }
                    }
                }
                delegate: Component {
                    Item {
                        id:listItem

                        width: parent.width
                        height: 40
                        visible: true


                        Rectangle {
                            id:col1
                            x:10
                            width: 370
                            Rectangle{
                                height: 20
                                anchors.topMargin: 5
                                anchors.left: parent.left
                                Text {
                                    text: display;font.bold:true; horizontalAlignment: Qt.AlignHCenter
                                    onTextChanged: {
                                        root.selectedColor=text;
                                        console.log(index)
                                        console.log(text)

                                        listModel[index] = text
                                        console.log("listModel[index]="+listModel[index])
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: 60
                            id:col2
                            x:col1.width
                            Rectangle{
                                height: 20
                                anchors.topMargin: 5
                                anchors.left: parent.left
                                Rectangle{color: display; width: 20; height: 20; }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked:
                            {
                                list.currentIndex = index
                                selectedColor = listModel[index]
                                root.color = selectedColor

                                myScrollView.focus = true
                            }
                        }
                    }
                }
                highlight: Rectangle {
                    color: 'lightgrey'
                    radius: 5
                    Text {
                        anchors.centerIn: parent
                    }
                }
                onCurrentIndexChanged: {
                    console.log(listModel[currentIndex])
                    selectedColor = listModel[currentIndex]
                }
                focus: true
            }
        }
    }
}
