%Predicate that calculates the player's points through the received board
evaluateBoards(Board,Points):-user_is(Curr_user),
      if_then_else(Curr_user=='pcX',
      (saveElements(Board,'pieceX1',List),
      saveElements(Board,'pieceX2',List2),
      append(List,List2,FinalList),
      getNrowNcol(FinalList,0,Points,'playerX')),

      (saveElements(Board,'pieceY1',List),
      saveElements(Board,'pieceY2',List2),
      append(List,List2,FinalList),
      getNrowNcol(FinalList,0,Points,'playerY'))).

%Predicate that makes a list with the best plays, increasingly ordered by the number of points of each player
listOfBestMovements(FinalList,Board):-
          setof(Points-Nrow-Ncol,(
          if_then_else(areaX1(Nrow,Ncol),Area='areaX1',
                  (if_then_else(areaX2(Nrow,Ncol),Area='areaX2',
                  (if_then_else(areaY1(Nrow,Ncol),Area='areaY1',
                  (if_then_else(areaY2(Nrow,Ncol),Area='areaY2',Area='areaX1'))))))),
                            validateMovePC(Area,Ncol,Nrow,Col,Row,Board),getPiece(Board,Nrow,Ncol,Piece),
                            setPiece(Board,Col,Row,Piece,BoardOut2),setPiece(BoardOut2,Nrow,Ncol,'noPiece',BoardOut),
                            evaluateBoards(BoardOut,Points)),FinalList).
