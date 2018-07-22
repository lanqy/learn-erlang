% try ... catch 语法

% try Expression of
%     SuccessfulPattern1 [Guards] ->
%         Expression1;
%     SuccessfulPattern2 [Guards] ->
%         Expression2;
% catch
%     TypeError:ExceptionPattern1 ->
%         Expression3;
%     TypeError:ExceptionPattern2 ->
%         Expression4;
% after
%     Expression5 
% end

-module(exceptions).
-compile(export_all).
throws(F) ->
    try F() of
        _ -> ok
            
    catch
        Throw -> {throw, caught, Throw}
            
    end.

% c(exceptions).
% exceptions:throws(fun() -> throw(thrown) end).
%  输出：{throw, caught, thrown}
% exceptions:throws(fun() -> erlang:error(pang) end). 


errors(F) ->
    try F() of
        _ -> ok
 
    catch
        error:Error -> {error, caught, Error}
            
    end.

exits(F) ->
    try F() of
        _ -> ok
            
    catch
        exit:Exit -> {exit, caught, Exit}
            
    end.

% c(exceptions).
% exceptions:errors(fun() -> erlang:error("Die!") end).
% 输出：{error,caught,"Die!"}
% exceptions:exits(fun() -> exit(goodbye) end).
% 输出：{exit,caught,goodbye}


sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) when is_function(Attack, 0) ->
    try Attack() of
        _ -> "None shall pass."
            
    catch
        throw:slice -> "It is but a scratch.";
        error:cut_arm -> "I've had worse.";
        exit:cut_leg -> "Come on you pansy!";
        _:_ -> "Just a flesh wound."    
    end.

talk() ->
    "blah blah".

% exceptions:talk().
% exceptions:black_knight(fun exceptions:talk/0).
% exceptions:black_knight(fun() -> exceptions:sword(1) end).
% exceptions:black_knight(fun() -> exceptions:sword(2) end).
% exceptions:black_knight(fun() -> exceptions:sword(3) end).
% exceptions:black_knight(fun() -> exceptions:sword(4) end).
% exceptions:black_knight(fun() -> exceptions:sword(5) end).

whoa() ->
    try 
        talk(),
        _Knight = "None shall pass!",
        _Doubles = [N * 2 || N <- lists:seq(1, 100)],
        throw(up),
        _WillReturnThis = tequila
    of
        tequila -> "Hey, this worked!"
            
    catch
        Exception:Reason -> {caught, Exception, Reason}
            
    end.

im_impressed() ->
    try 
        talk(),
        _Knight = "None shall pass!",
        _Doubles = [N * 2 || N <- lists:seq(1, 100)],
        throw(up),
        _WillReturnThis = tequila
            
    catch
        Exception:Reason -> {caught, Exception, Reason}
            
    end.

% 也可以通过 catch 来处理异常

% catch throw(whoa).
% catch exit(die).
% catch 1/0.
% catch 2+2.
% catch doesnt:exist(a, 4).


catcher(X, Y) ->
    case catch X/Y of
        {'EXIT', {badarith, _}} -> "uh oh";
        N -> N
end.

% exceptions:catcher(3, 3).
% exceptions:catcher(6, 3).
% exceptions:catcher(6, 0).

%% 在树中查找给定值'Val'
has_value(_, {node, 'nil'}) ->
    false;
has_value(Val, {node, {_, Val, _, _}}) ->
    true;
has_value(Val, {node, {_, _, Left, Right}}) ->
    case has_value(Val, Left) of
        true -> true;
            false -> has_value(Val, Right)
    end.


has_value(Val, Tree) ->
    try has_value1(Val, Tree) of
        false -> false
            
    catch
        true -> true
            
    end.
    
has_value1(_, {node, 'nil'}) ->
    false;
has_value1(Val, {node, {_, Val, _, _}}) ->
    throw(true);
has_value1(Val, {node, {_, _, Left, Right}}) ->
    has_value1(Val, Left),
    has_value1(Val, Right).