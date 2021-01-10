#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "sortfiltermodel.h"

//class Model : public QAbstractListModel
//{
//    def __init__(self, parent=None):
//        super(Model, self).__init__(parent)
//        self.items = [
//            {"name": "Item1"},
//            {"name": "Item2"},
//            {"name": "Item3"},
//            {"name": "Item4"},
//            {"name": "Item5"},
//            {"name": "Item6"},
//            {"name": "Item12"},
//            {"name": "Item13"},
//            {"name": "Item14"},
//        ]
//        self.roles = {
//            QtCore.Qt.UserRole + 1: "name"
//        }

//    def rowCount(self, parent=QtCore.QModelIndex()):
//        return len(self.items)

//    def data(self, index, role=QtCore.Qt.DisplayRole):
//        try:
//            item = self.items[index.row()]
//        except IndexError:
//            return QtCore.QVariant()

//        if role in self.roles:
//            return item.get(self.roles[role], QtCore.QVariant())

//        return QtCore.QVariant()

//    def roleNames(self):
//        return self.roles
//}

//class Model: public QSortFilterProxyModel
//{
//public:
//   explicit Model(QObject *parent = nullptr);

//};

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    //    app = QtGui.QGuiApplication(sys.argv)

    //    view = QtQuick.QQuickView()

    //    model = Model()
    //    proxy = QtCore.QSortFilterProxyModel()
    //    proxy.setSourceModel(model)
    //    proxy.setFilterRole(model.roles.keys()[0])
    //    proxy.setFilterCaseSensitivity(QtCore.Qt.CaseInsensitive)

    //    engine = view.engine()
    //    context = engine.rootContext()
    //    context.setContextProperty("qmodel", proxy)

    //    view.setSource(QtCore.QUrl("filtering.qml"))
    //    view.setResizeMode(view.SizeRootObjectToView)
    //    view.show()

    //    app.exec_()

    //    auto model = new Model();
    //    auto listmodel = new QStringListModel();
    //    QStringList list = {"item1","item2","item3","item4","item5","item6","item7","item8","item9","item10",};
    //    listmodel->setStringList(list);
    //    model->setSourceModel(listmodel);

    auto proxyModel = new sortFilterModel();

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("colorProxyModel", proxyModel);
    engine.rootContext()->setContextProperty("listModel", proxyModel->getListModel());

    engine.load(url);

    return app.exec();
}
