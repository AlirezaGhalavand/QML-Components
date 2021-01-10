#ifndef SORTFILTERMODEL_H
#define SORTFILTERMODEL_H

#include <QObject>
#include <QtCore>
#include <QtGui>
#include <QtQuick>

class sortFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT

    Q_PROPERTY(int cb_currentIndex READ cb_currentIndex WRITE setCb_currentIndex NOTIFY cb_currentIndexChanged)

    int m_cb_currentIndex = 0;
    QStringList _listModel;

public:
    explicit sortFilterModel(QObject *parent = nullptr);

    int cb_currentIndex() const;

signals:

    void cb_currentIndexChanged(int cb_currentIndex);

public slots:
    void setFilterFixedString(QString str);
    void setCb_currentIndex(int cb_currentIndex);
    QStringList getListModel();
};

#endif // SORTFILTERMODEL_H
