%Description:
%this program simulate a small chat, this uses nodes of erlang.
%Developed by Leticia Hernàndez Villanueva <leticia.hvillanueva@gmail.com>

-module(my_node).
-export([conectar/1,enviar/1,run/0,loop/0]).
-include("../include/cortar.hrl").

run()->
	pid(),
	my_gen ! init.

conectar(H)->
	pong=net_adm:ping(H).

enviar(Msg)->
	[{my_gen,Node}!Msg||Node<-nodes()].

pid()->
	Pid=spawn(fun()->loop() end),
	register(my_gen,Pid).

loop()->
	receive
		mostrarlista->
			hacer:mostrar({ets:first(users), ets:lookup(users,ets:first(users))}),
			loop();
		init->
			ok=net_kernel:monitor_nodes(true),
			ets:new(users,[ordered_set,protected,named_table]),
			loop(); 
		{msg,Msg}->
			io:format("received msg: ~p~n",[Msg]),
			loop();
		{msgpriv,Msg,Node}->
			io:format("~p dice: ~p~n",[list_to_atom(Node),Msg]),
			loop();
		{nodeup,Node}->
			[Namenode|_Other]=?Cortar(Node),
			true=ets:insert(users,{list_to_atom(Namenode),Node}),
			io:format("Se ha conectado: ~p~n",[Namenode]),
			loop();
		{nodedown,Node}->
			[Namenode|_Other]=?Cortar(Node),
			true=ets:delete(users,list_to_atom(Namenode)),
			io:format("Se ha desconectado: ~p~n",[Namenode]),
			loop();
		{Key,Msg}->
			[Namenode|_Other]=?Cortar(node()),
			hacer:mensaje_privado({Namenode,ets:lookup(users,Key),Msg}),
			loop();
		_Unknown->
			io:format("receive msg unknown: ~p~n",[unknown]),
			loop()
	end.
