% initMyData(+NBoxesToPick, -ProgramDataInitial).
% Here you should choose and initialize a structure for ProgramData
% Intuition:
%   ProgramData represents the internal state of the robot.
%   Here, the robot could store:
%     - his current position (X,Y)
%     - if he carries a box or not
%     - the position of the last room visited by him (Xlast,Ylast)
%     - how many boxes he (still) has to deliver




% Let's decide what should be the state of the robot
%

initMyData(N,(N,(0,0),noBox,(0,0))).
initMyData(10,InitData) :- % 10 is the amt of boxes to pick
	InitData = (10,(0,0),noBox,(0,0)).


            % initMyData(9, ProgramData),
            % perform(ProgramData,noBox,X,UpdatedProgramData).

            %                   or

            % initMyData(9, ProgramData),
            % loop(0,20,ProgramData).



% perform(+State, +RoomContainsBox, -Action, -NewState)
%
perform((N,(X,Y),noBox,(X,Y)),hasBox,pickBox,(N,(X,Y),hasBox,(X,Y))) :- N>0.   

                % Pick Box Action

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the room: hasBox

    % Action we are going to do: pickBox

    % After (pickBox) action, we will: Have N boxes in the room 
    %                                  Be at X,Y coords
    %                                  Have a box
    %                                  Last coords 

    % Conditions: Room has more than 0 boxes


perform((N,(0,0),hasBox,LastPos),_,dropBox,(N1,(0,0),noBox,LastPos)) :- N1 is N-1.

                % Drop Box Action

    % Currently we have: N boxes we still need  
    %                    Are at 0,0 coords 
    %                    Have box
    %                    Last Coords

    % Currently the room: don't care

    % Action we are going to do: dropBox

    % After (dropBox) action, we will: Have N-1 boxes in the room 
    %                                  Be at 0,0 coords
    %                                  Have no box
    %                                  Last coords 

    % Post Conditions: Room has 1 less box


perform((N,(X,Y),noBox,(X,Y)),noBox,move(north),(N,(X,Y1),noBox,(X,Y1))) :- X > 0,
                                                                           -X < Y,
                                                                            Y < X,
                                                                            Y1 is Y+1.

                % Move North Action

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the room: noBox

    % Action we are going to do: move(north)

    % After (move(north)) action, we will: Have N boxes in the room 
    %                                      Be at X,Y+1 coords
    %                                      Have no box
    %                                      Last coords    
   
    % Conditions: X > 0 ; -X < Y < X

    % Post Conditions: Y increases by 1


perform((N,(X,Y),noBox,(X,Y)),noBox,move(west),(N,(X1,Y),noBox,(X1,Y))) :- Y > 0,
                                                                          -Y < X,
                                                                           X =< Y,
                                                                           X1 is X-1.

                % Move West Action

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the room: noBox

    % Action we are going to do: move(west)

    % After (move(west)) action, we will: Have N boxes in the room 
    %                                     Be at X-1,Y coords
    %                                     Have no box
    %                                     Last coords 

    % Conditions: Y > 0 ; -Y < X <= Y

    % Post Conditions: X decreases by 1


perform((N,(X,Y),noBox,(X,Y)),noBox,move(south),(N,(X,Y1),noBox,(X,Y1))) :- X < 0,
                                                                           -X >= Y,
                                                                            Y > X,
                                                                            Y1 is Y-1.

                % Move South Action

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the room: noBox

    % Action we are going to do: move(south)

    % After (move(south)) action, we will: Have N boxes in the room 
    %                                      Be at X,Y-1 coords
    %                                      Have no box
    %                                      Last coords 

    % Conditions: X < 0, -X >= Y > X

    % Post Conditions: Y decreases by 1


perform((N,(X,Y),noBox,(X,Y)),noBox,move(east),(N,(X1,Y),noBox,(X1,Y))) :- Y =< 0,
                                                                           Y =< X,
                                                                           X =< -Y,
                                                                           X1 is X+1.                              
                                                                           
                % Move East Action

    % Currently we have: N boxes we still need  
    %                    Are at X,Y coords 
    %                    Have no box
    %                    Last Coords

    % Currently the room: noBox

    % Action we are going to do: move(east)

    % After (move(east)) action, we will:  Have N boxes in the room 
    %                                      Be at X+1,Y coords
    %                                      Have no box
    %                                      Last coords 

    % Conditions: Y < 0, Y <= X <= -Y

    % Post Conditions: X increases by 1

loop(Start,End,ProgramData) :-
    perform(ProgramData,noBox,_,UpdatedProgramData),
    Start =< End,
    write(ProgramData),
    nl,
    Start1 is Start+1,
    loop(Start1,End,UpdatedProgramData).