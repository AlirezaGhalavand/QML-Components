#include "sortfiltermodel.h"

sortFilterModel::sortFilterModel(QObject *parent) : QSortFilterProxyModel(parent)
{    
    auto sourceModel = new QStringListModel();
    _listModel = QColor::colorNames(); //get all color names
    sourceModel->setStringList(_listModel);

    this->setSourceModel(sourceModel);
    this->setFilterKeyColumn(0);
}



//QVariant sortFilterModel::data(const QModelIndex &index, int role) const {

//    if(!index.isValid())
//        return QVariant();

//    if(index.row() >= m_data.size())
//        return QVariant();

//    switch (role) {
//        case Id:
//            return m_data.at(index.row()).id;
//        case RoomId:
//            return m_data.at(index.row()).roomId;
//        case PersonId:
//            return m_data.at(index.row()).personId;
//        case PersonEmail:
//            return m_data.at(index.row()).personEmail;
//        case Text:
//            return m_data.at(index.row()).text;
//        case Created:
//            return m_data.at(index.row()).created.toString(Qt::ISODateWithMs);
//    }

//    return QVariant();
//}


int sortFilterModel::cb_currentIndex() const
{
    return m_cb_currentIndex;
}

void sortFilterModel::setFilterFixedString(QString str)
{
    QRegExp::PatternSyntax syntax = QRegExp::PatternSyntax(cb_currentIndex());
    QRegExp regExp(str, Qt::CaseInsensitive, syntax);
    this->setFilterRegExp(regExp);
//    for(auto i=0; i<this->rowCount(); i++)
//    {
        _listModel.clear();
////        _listModel.append(this->data);
//    }
}

void sortFilterModel::setCb_currentIndex(int cb_currentIndex)
{
    if (m_cb_currentIndex == cb_currentIndex)
        return;

    m_cb_currentIndex = cb_currentIndex;
    emit cb_currentIndexChanged(m_cb_currentIndex);
}

QStringList sortFilterModel::getListModel()
{
    return _listModel;
}
