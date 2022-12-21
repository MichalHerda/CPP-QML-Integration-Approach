#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QtQml>
#include <QtQml/qqmlregistration.h>
#include <QVector>
#include <QDebug>

class BackEnd : public QObject
{
    Q_OBJECT                                                                //
    Q_PROPERTY(bool whose_move READ whose_move_read WRITE whose_move_change)// QML -> C++ integation macros
    Q_PROPERTY(bool game_over READ game_over_read)                          // enable variables visibility in QML file
    Q_PROPERTY(QVector <int> tile)
    QML_ELEMENT                                                             //
public:
////////////////////////////////////////////////////////////////////////////////////////////////////////
    QVector <int> tile = {0, 0, 0, 0, 0, 0, 0, 0, 0};                       // gameboard representation
                                                                            // with initialization inside class:
                                                                            // 0 - null
                                                                            // 1 - x
                                                                            // 2 - o
//////////////////////////////////////////////////////////////////////////////////////////////////////
    bool whose_move = true;                                                 // whose_move:  true: x   false: o
    bool game_over = false;                                                 // true: move not available
                                                                            // false: move available

    //functions existing to enable communication between QML and C++ :
    bool game_over_read();
    bool whose_move_read();
//  int tile_read(QVector<int*>tile, int board_tile_index);                                                       //
    void game_over_off();                                                   //
//constructor:
public:
    explicit BackEnd(QObject *parent = nullptr);
//signals and slots:
signals:
    void new_game();
    void whose_move_changing(bool whose_move);
    void tile_clicked(int board_tile_index, bool whose_move, QVector <int> tile);
public slots:
//funtions descriptions in .cpp file
    void clear_board(QVector <int> tile);
    void change_tile_value(int board_tile_index, char player, QVector <int> tile);
    bool check_for_win(char player, QVector <int> tile);
    bool check_is_move_possible(QVector <int> tile);
    void whose_move_change(bool whose_move);
    void game_over_status(QVector <int> tile);

    void actions_after_clicking(int board_tile_index, bool whose_move, QVector <int>  tile);

};

#endif // BACKEND_H
