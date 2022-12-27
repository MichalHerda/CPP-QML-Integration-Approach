#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QDebug>
#include <QVector>
#include <QtQml>
#include <QtQml/qqmlregistration.h>

//gameboard size:
#define BOARD 9

class BackEnd : public QObject
{
    Q_OBJECT

 // QML => C++ integation macros
 // enable variables visibility
 // in QML file:

    Q_PROPERTY(bool turn                READ turnRead          WRITE turnWrite          NOTIFY turnChanged         )
    Q_PROPERTY(bool game_over           READ game_overRead     WRITE game_overWrite     NOTIFY game_overChanged    )
    Q_PROPERTY(QVector<int>tile         READ tileRead          WRITE tileWrite          NOTIFY tileChanged         )
    Q_PROPERTY(int magic_number         READ magic_numberRead  WRITE magic_numberWrite  NOTIFY magic_numberChanged )

    QML_ELEMENT

public:
//variables :
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    QVector<int> tile  = QVector<int> (BOARD,0) ;                       // gameboard representation
                                                                        // with initialization inside class (9 elements with 0 value):
                                                                        // 0 - null
                                                                        // 1 - x
                                                                        // 2 - o
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    bool turn           = true;                                         // turn:  true: x   false: o
    bool game_over      = true;                                         // true: move not available
                                                                        // false: move available
    int magic_number = 0;                                               // to select kind of line, drawing depending on situation on board, if player wins
//line coordinates (properties to draw line in case of win):
    QVector<int> coordinates = QVector<int> (4,0) ;

//functions existing to enable communication between QML and C++ :

   bool turnRead()const;

       bool game_overRead()const;
       void game_overWrite(bool game_over);
           QVector<int> tileRead()const;
           void tileWrite(QVector<int>tile);
                int magic_numberRead()const;
                void magic_numberWrite(int magic_number);

//constructor:
public:
    explicit BackEnd(QObject *parent = nullptr);

//signals and slots:
signals:
    void turnChanged(bool turn);
    void game_overChanged(bool game_over);
    void tileChanged(QVector<int>tile);
    void magic_numberChanged(int magic_number);

public slots:
//funtions descriptions in .cpp file
    void clear_board(QVector<int> tile);
    bool check_for_win(bool turn, QVector<int>tile);
    bool check_is_move_possible(QVector<int>tile);
    void change_tile_value(int index, bool turn);
    void turnWrite(bool turn);

};

#endif // BACKEND_H
