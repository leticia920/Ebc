-module(hacer).
-export([mostrar/1,mensaje_privado/1]).

mostrar({_Key,[]})->[];
mostrar({Key,_Valor})->
	io:format("~p~n",[Key]),
	mostrar({ets:next(users,Key),ets:lookup(users,ets:next(users,Key))}).

mensaje_privado({Node,[{_H,Value}],Msg})->
	{my_gen,Value} ! {msgpriv,Msg,Node}.
