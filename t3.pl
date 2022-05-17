
% I just want to mention that I have spent 5 hours wondering why the tests are not passing
% just to realize that pickBox,deliverBox,etc. had to be typed in the exact same way as in
% the test cases... 


initMyData(N,(N,(0,0),false,(0,0))).


% perform(+State, +RoomContainsBox, -Action, -NewState)
%
perform((N,(X,Y),false,(X,Y)),true,pickBox,(N,(X,Y),true,(X,Y))) :- N>0.   

                % Pick Box Action

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the robot: hasBox

    % Action we are going to do: pickBox

    % After (pickBox) action, we will: Have N boxes in the room 
    %                                  Be at X,Y coords
    %                                  Have a box
    %                                  Last coords 

    % Conditions: Room has more than 0 boxes


perform((N,(0,0),true,LastPos),_,deliverBox,(N1,(0,0),false,LastPos)) :- N1 is N-1.

                % Drop Box Action

    % Currently we have: N boxes we still need  
    %                    Are at 0,0 coords 
    %                    Have box
    %                    Last Coords

    % Action we are going to do: deliverBox

    % After (deliverBox) action, we will: Have N-1 boxes in the room 
    %                                  Be at 0,0 coords
    %                                  Have no box
    %                                  Last coords 

    % Post Conditions: Room has 1 less box
        

perform((0,(0,0),false,LastPos),_,done,(0,(0,0),false,LastPos)) :- true.

                % Finalize

    % Currently we have: 0 boxes we still need  
    %                    Are at 0,0 coords 
    %                    Have no box
    %                    Last Coords

    % Currently the room: has no box

    % Action we are going to do: Finish.


perform((N,(X,Y),false,(X,Y)),false,move(north),(N,(X,Y1),false,(X,Y1))) :- X > 0,
                                                                           -X < Y,
                                                                            Y < X,
                                                                            Y1 is Y+1.

                % Move North Action (search for box)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the robot: has no box

    % Action we are going to do: move(north)

    % After (move(north)) action, we will: Have N boxes in the room 
    %                                      Be at X,Y+1 coords
    %                                      Have no box
    %                                      Last coords    
   
    % Conditions: X > 0 ; -X < Y < X

    % Post Conditions: Y increases by 1


perform((N,(X,Y),false,(X,Y)),false,move(west),(N,(X1,Y),false,(X1,Y))) :- Y > 0,
                                                                          -Y < X,
                                                                           X =< Y,
                                                                           X1 is X-1.

                % Move West Action (search for box)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the robot: has no box

    % Action we are going to do: move(west)

    % After (move(west)) action, we will: Have N boxes in the room 
    %                                     Be at X-1,Y coords
    %                                     Have no box
    %                                     Last coords 

    % Conditions: Y > 0 ; -Y < X <= Y

    % Post Conditions: X decreases by 1


perform((N,(X,Y),false,(X,Y)),false,move(south),(N,(X,Y1),false,(X,Y1))) :- X < 0,
                                                                           -X >= Y,
                                                                            Y > X,
                                                                            Y1 is Y-1.

                % Move South Action (search for box)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the robot: has no box

    % Action we are going to do: move(south)

    % After (move(south)) action, we will: Have N boxes in the room 
    %                                      Be at X,Y-1 coords
    %                                      Have no box
    %                                      Last coords 

    % Conditions: X < 0, -X >= Y > X

    % Post Conditions: Y decreases by 1


perform((N,(X,Y),false,(X,Y)),false,move(east),(N,(X1,Y),false,(X1,Y))) :- Y =< 0,
                                                                           Y =< X,
                                                                           X =< -Y,
                                                                           X1 is X+1.                              
                                                                           
                % Move East Action (search for box)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the robot: has no box

    % Action we are going to do: move(east)

    % After (move(east)) action, we will:  Have N boxes in the room 
    %                                      Be at X+1,Y coords
    %                                      Have no box
    %                                      Last coords 

    % Conditions: Y < 0, Y <= X <= -Y

    % Post Conditions: X increases by 1


perform((N,(X,Y),false,(OriginX,OriginY)),_,move(east), (N,(X1,Y),false,(OriginX,OriginY))) :- X < OriginX,
                                                                                                X1 is X+1.

                % Return to origin (Current X < Origin X)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Original coords

    % Action we are going to do: move(east)

    % After (move(east)) action, we will:  Have N boxes in the room 
    %                                      Be at X+1,Y coords
    %                                      Have no box
    %                                      Original coords 

    % Conditions: Current X < Original Position X

    % Post Conditions: X increases by 1


perform((N,(XL,Y),false,(OriginX,OriginY)),_,move(north),(N,(XL,Y1),false,(OriginX,OriginY))) :- Y < OriginY,
                                                                                                  Y1 is Y+1.

                % Return to origin (Current Y < Origin Y)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Original coords

    % Action we are going to do: move(north)

    % After (move(north)) action, we will:  Have N boxes in the room 
    %                                       Be at X,Y+1 coords
    %                                       Have no box
    %                                       Original coords 

    % Conditions: Current Y < Original Position Y

    % Post Conditions: Y increases by 1


perform((N,(X,Y),false,(OriginX,OriginY)),_,move(west), (N,(X1,Y),false,(OriginX,OriginY))) :- X > OriginX,
                                                                                                X1 is X-1.

                % Return to origin (Current X > Origin X)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Original coords

    % Action we are going to do: move(west)

    % After (move(west)) action, we will:  Have N boxes in the room 
    %                                      Be at X-1,Y coords
    %                                      Have no box
    %                                      Original coords 

    % Conditions: Current X > Original Position X

    % Post Conditions: X decreases by 1


perform((N,(XL,Y),false,(OriginX,OriginY)),_,move(south),(N,(XL,Y1),false,(OriginX,OriginY))) :- Y > OriginY,
                                                                                                  Y1 is Y-1.

                % Return to origin (Current Y > Origin Y)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Original coords

    % Action we are going to do: move(south)

    % After (move(south)) action, we will:  Have N boxes in the room 
    %                                       Be at X,Y-1 coords
    %                                       Have no box
    %                                       Original coords 

    % Conditions: Current Y > Original Position Y

    % Post Conditions: Y decreases by 1


perform((N,(X,Y),true,LastPos),_,moveWithBox(east),(N,(X1,Y),true,LastPos)) :- X < 0,
                                                                               X1 is X+1.

                % Move box to 0,0 (X < 0)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have box
    %                    Last Position

    % Action we are going to do: move(east)

    % After (move(east)) action, we will:  Have N boxes in the room 
    %                                      Be at X+1,Y coords
    %                                      Have box
    %                                      Last Position 

    % Conditions: Current X < 0

    % Post Conditions: X increases by 1
    

perform((N,(0,Y),true,LastPos),_,moveWithBox(north),(N,(0,Y1),true,LastPos)) :- Y < 0,
                                                                                Y1 is Y+1.

                % Move box to 0,0 (Y < 0)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have box
    %                    Last Position

    % Action we are going to do: move(north)

    % After (move(north)) action, we will:  Have N boxes in the room 
    %                                       Be at X,Y+1 coords
    %                                       Have box
    %                                       Last Position 

    % Conditions: Current Y < 0

    % Post Conditions: Y increases by 1
    
    
perform((N,(X,Y),true,LastPos),_,moveWithBox(west),(N,(X1,Y),true,LastPos)) :- X > 0,
                                                                               X1 is X-1.

                % Move box to 0,0 (X > 0)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have box
    %                    Last Position

    % Action we are going to do: move(west)

    % After (move(west)) action, we will:  Have N boxes in the room 
    %                                      Be at X-1,Y coords
    %                                      Have box
    %                                      Last Position 

    % Conditions: Current X > 0

    % Post Conditions: X decreases by 1
    

perform((N,(0,Y),true,LastPos),_,moveWithBox(south),(N,(0,Y1),true,LastPos)) :- Y > 0,
                                                                                Y1 is Y-1.

                % Move box to 0,0 (Y > 0)

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have box
    %                    Last Position

    % Action we are going to do: move(south)

    % After (move(south)) action, we will:  Have N boxes in the room 
    %                                       Be at X,Y-1 coords
    %                                       Have box
    %                                       Last Position 

    % Conditions: Current Y > 0

    % Post Conditions: Y decreases by 1
    



loop(Start,End,ProgramData) :-
    perform(ProgramData,false,_,UpdatedProgramData),
    Start =< End,
    write(ProgramData),
    nl,
    Start1 is Start+1,
    loop(Start1,End,UpdatedProgramData).
