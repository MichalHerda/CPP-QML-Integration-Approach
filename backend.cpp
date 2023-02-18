#include "backend.h"
////////////////////////////////////////////////////////////////////////////////////////////////
BackEnd::BackEnd(QObject *parent)
    : QObject{parent}
{
}
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::game_overRead()const
{
    return game_over;
}
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::turnRead()const
{
    return turn;
}
////////////////////////////////////////////////////////////////////////////////////////////////
QVector<int> BackEnd::tileRead()const
{
    return tile;
}
////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::tileWrite(QVector<int>tile)
{
    emit tileChanged(tile);
}
////////////////////////////////////////////////////////////////////////////////////////////////
int BackEnd::magic_numberRead() const
{
    return magic_number;
}

void BackEnd::magic_numberWrite(int magic_number)
{
    emit magic_numberChanged(magic_number);
}
////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::game_overWrite(bool game_over)
{
    game_over == true ? this -> game_over = false : this -> game_over = true;
    if (game_over == true ) qInfo() << "GAME OVER!";
    emit game_overChanged(game_over);
}
////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::turnWrite(bool turn)
{   
    turn == true ? this -> turn = false : this -> turn = true  ;
    qInfo() << "Player Change" << "Now player = " << turn;
    emit turnChanged(turn);
}
/////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::clear_board(QVector<int> tile)
{
 // Filling gameboard with "empty" values and also reset game variables below:
    this -> magic_number = 0;
    this -> turn = true;
    for(int i = 0; i < BOARD; i++) {
              this -> tile [i] = 0;
              qInfo() << "Empty tile no. " << i << ". Its value = " << tile [i];
            }
}
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::check_for_win(bool turn, QVector<int> tile)
{
// Checking for winner: true - win, false - not win,
// the function takes as argument bool type, than is converting into int, which means player value ( 'x' or 'o' )
// I have choose manual method of winner checking since this game has only
// 8 possible combinations for win
// checking draw case is solved as combination current function and
// function check_is_move_posiible()
// for draw, both of them must return false
    int player;
    turn == true ? player = 1 : player = 2;
//
    qInfo() << "Check For Win:";
    for(int i = 0; i < BOARD; i++) {
    qInfo() << "Tile " << i << " : " << tile[i];
    }
//
    if      ( (tile[0] == player) && (tile[1] == player) && (tile[2] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 1; return true; }
    else if ( (tile[3] == player) && (tile[4] == player) && (tile[5] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 2; return true; }
    else if ( (tile[6] == player) && (tile[7] == player) && (tile[8] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 3; return true; }
    else if ( (tile[0] == player) && (tile[3] == player) && (tile[6] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 4; return true; }
    else if ( (tile[1] == player) && (tile[4] == player) && (tile[7] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 5;  return true; }
    else if ( (tile[2] == player) && (tile[5] == player) && (tile[8] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 6;  return true; }
    else if ( (tile[0] == player) && (tile[4] == player) && (tile[8] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 7; return true; }
    else if ( (tile[2] == player) && (tile[4] == player) && (tile[6] == player) )
    { qInfo() << "Player " << player << "wins!"; game_overWrite(game_over); this -> magic_number = 8;  return true; }
    else
        {
         qInfo() << "Nobody wins ";
         return false;
        }
}
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::check_is_move_possible(QVector<int> tile)
{
// Check is there space for next move (true/false)
// If this function returns false and function check_for_win() also returns false - it means draw result
    int empty_tiles = 0;
    for(int i = 0; i < BOARD; i++)
                {
                  tile[i] == 0 ? empty_tiles += 1 : empty_tiles += 0;
                }
    qInfo() << "Number Of Empty Tiles = " << empty_tiles;
    return (empty_tiles != 0) ? true : false ;
}

void BackEnd::change_tile_value(int index, bool turn)
{
     int player;
     turn == true ? player = 1 : player = 2;
     this -> tile [index] = player;
     qInfo() << "Now, Tile no " << index << " value, is " << player;
}
