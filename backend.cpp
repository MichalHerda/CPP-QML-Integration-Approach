#include "backend.h"
#include <QDebug>
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::game_over_read()
{
 return game_over;
}
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::whose_move_read()
{
 return whose_move;
}
////////////////////////////////////////////////////////////////////////////////////////////////
/*int BackEnd::tile_read(QVector<int*>tile, int board_tile_index)
{
 int x = &tile[board_tile_index];
 return x;
}*/
////////////////////////////////////////////////////////////////////////////////////////////////
BackEnd::BackEnd(QObject *parent)
    : QObject{parent}
{

}
////////////////////////////////////////////////////////////////////////////////////////////////
// gameboard tiles are int type
// Each tile can have following values:
//       0 - empty tile
//       1 - cross
//       2 - nought
////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::clear_board(QVector<int> tile)
{
 // Filling gameboard with "empty" values

    for(int i = 0; i < 9; i++)
            {
              tile [i] = 0;
              qInfo() << "Empty tile no. " << i << ". Its value = " << tile [i];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::change_tile_value(int board_tile_index, char player, QVector<int> tile)
{
// Changing tile value, depending on arguments: board tile index,
// whose_move variable == true  - player x
//                     == false - player o

    if ( whose_move == true )
        {
        tile[board_tile_index] = 1;
        qDebug() << "Tile index no " << board_tile_index << " = " << tile [board_tile_index];
        }
    else
        {
        tile[board_tile_index] = 2;
        qDebug() << "Tile index no " << board_tile_index << " = " << tile [board_tile_index];
        }
}
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::check_for_win(char player, QVector <int> tile)
{
// Checking for winner: true - win, false - not win,
// the function takes as argument char type, which means player value ( 'x' or 'o' )
// I have choose manual method of winner checking since this game has only
// 8 possible combinations for win
// checking draw case is solved as combination current function and
// function check_is_move_posiible()
// for draw, both of them must return false
    qDebug() << "Check For Win";
    qDebug() << "Tile 0 : " << tile[0];
    qDebug() << "Tile 1 : " << tile[1];
    qDebug() << "Tile 2 : " << tile[2];
    qDebug() << "Tile 3 : " << tile[3];
    qDebug() << "Tile 4 : " << tile[4];
    qDebug() << "Tile 5 : " << tile[5];
    qDebug() << "Tile 6 : " << tile[6];
    qDebug() << "Tile 7 : " << tile[7];
    qDebug() << "Tile 8 : " << tile[8];
    if      ( (tile[0] == player) && (tile[1] == player) && (tile[2] == player) ) return true;
    else if ( (tile[3] == player) && (tile[4] == player) && (tile[5] == player) ) return true;
    else if ( (tile[6] == player) && (tile[7] == player) && (tile[8] == player) ) return true;
    else if ( (tile[0] == player) && (tile[3] == player) && (tile[6] == player) ) return true;
    else if ( (tile[1] == player) && (tile[4] == player) && (tile[7] == player) ) return true;
    else if ( (tile[2] == player) && (tile[5] == player) && (tile[8] == player) ) return true;
    else if ( (tile[0] == player) && (tile[4] == player) && (tile[8] == player) ) return true;
    else if ( (tile[2] == player) && (tile[4] == player) && (tile[8] == player) ) return true;
    else return false;
}
////////////////////////////////////////////////////////////////////////////////////////////////
bool BackEnd::check_is_move_possible(QVector <int> tile)
{
// Check is there space for next move (true/false)
// If this function returns false and function check_for_win() also returns false - it means draw result
    int empty_tiles = 0;
    for(int i = 0; i < 9; i++)
                {
                 if( tile[i] == 0) empty_tiles += 1;
                    else
                      empty_tiles = empty_tiles;
                }
    qInfo() << "Number Of Empty Tiles = " << empty_tiles;
    if ( empty_tiles == 0 )
            return false;
        else
            return true;
}
////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::whose_move_change(bool whose_move)
{
//whose_move variable meaning:
//          'true' - PLAYER X (crosses)
//         'false' - PLAYER O (noughts)
//
//Function below changes variable value:

if ( whose_move == true )
       {
        whose_move = false;
        qInfo() << "Now it is Noughts (O) move";
       }
if ( whose_move == false )
       {
        whose_move = true;
        qInfo() << "Now it is Crosses (X) move";
       }
}
////////////////////////////////////////////////////////////////////////////////////////////////
void BackEnd::game_over_status(QVector <int> tile)
{
// change game_over status depending on situation on gameboard
//check_is_move_possible(QVector<int>tile);
if ( check_is_move_possible(tile) == true)
            {
             game_over = false;
             qInfo() << "Game over mode = " << game_over;
            }
            else
            {
             game_over = true;
             qInfo() << "Game over mode = " << game_over;
            }


//emit game_over_status();  //signal emiting
}
////////////////////////////////////////////////////////////////////////////////////////////////

void BackEnd::actions_after_clicking(int board_tile_index, bool whose_move, QVector <int> tile )
{
// This Function is existing to gather all actions after player's move
// In the correct order
//
// All possibilities of the game are taken into account here:
    qInfo() << "Whose Move = " << whose_move;
    qInfo() << "Tile index no " << board_tile_index << "is clicked";
    char player;
    if(whose_move == true)
         {
          char player = 'x';
          change_tile_value (board_tile_index, player, tile );
//        qInfo() << "Now it is PLAYER X move, so char tile[] " << board_tile_index << "value = " << tile [board_tile_index];
         }
    else
         {
          char player = 'o';
          change_tile_value (board_tile_index, player, tile);
//        qInfo() << "Now it is PLAYER O move, so char tile[] " << board_tile_index << "value = " << tile [board_tile_index];
         }
//   change_tile_value (board_tile_index, player);


    check_for_win (player, tile);
    if ( check_for_win (player, tile) == true )
         {
           qInfo() << "Player " << player << "Wins !";
           game_over_status(tile);
           return;
         }
    else
         {
           check_is_move_possible (tile);
           if ( check_is_move_possible(tile) == false)
                {
                 qInfo() << "Draw ! ";
                 game_over_status(tile);
                 return;
                }
            else
                whose_move_change (&whose_move);
         }
}


