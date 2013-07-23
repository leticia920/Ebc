Ebc (Erlang basic Chat)
=======================

This program runs over LAN.

configuring hosts file
=======================
You need two or more different computers.

I'm going to explain this example using two computers, their names are: pc1 and pc2.

Step 1: We need to know which are ours ip address in pc1 and pc2.
For example: 

    pc1 has got: 192.168.1.1
    pc2 has got: 192.168.1.2
		
Step 2: We need to edit ours /etc/hosts files.
For example in pc1:

    pc1@user#vi /etc/hosts

And then,  We need to type:

    192.168.1.2 pc2

And save changes.
	
In pc2:

    pc2@user#vi /etc/hosts
	
And then, We need to type:

    192.168.1.1 pc1

Step 3: To verify that  there is an connection; You need that your firewall is off.
In pc1 type:

    pc1@user#ping pc2
	
And, It should be successful.
	
In pc2 type:

		pc2@user#ping pc1
        
And, It should be successful, too.

Downloading and using
=====================
In each computer, You need to:

Download Ebc from the git repo

    $git clone https://github.com/leticia920/Ebc
     
Let's into Ebc directory

    $cd Ebc
    
You can type three different commands
  
    $make compile (this command compiles all .erl files located in src/ directory)
    $make clear   (this command erases all .beam file located in beam/ directory)
    $make start   (this command starts an erlang runtime system withthe following arguments: erl -sname example -setcookie test -pa ebin/)

But you just type the following commands: 
  
    $make compile
    $make start

Then, In pc1 You need to type the following command:

	$erl -sname pc1 -setcookie test -pa ebin/

In pc2, You need to type:

	$erl -sname pc2 -setcookie test -pa ebin/
	
	
In this moment, your Prompt line:

	in pc1 It'll be like: (pc1@hostname)
	in pc2 It'll be like: (pc2@hostname)

Now, in pc1 and pc2 type:

	$my_node:run().
	
Then, in pc1 type:

	$my_node:conectar('pc2@hostname').
	
After that command, pc1 will  do  replicate this message over all nodes:
 
	pc1 has been connected.
	

Now, If You want to send a message to all nodes, type the following command:	

	$my_node:enviar({msg,"Hola"}).
	
In pc1 if You want to send a private message, You need to list the connected users, type:

	$my_gen ! mostrarlista.
	
And You'll see all connected nodes. Then, selected someone (pc2) and type:

	$my_gen ! {enrique,"Hola"}.
	
And only pc2 receives the message.

Author
====

    Leticia Hernàndez Villanueva <leticia.hvillanueva@gmail.com>.

License
====

    THIS SOFTWARE IS LICENSED UNDER BSD LICENSE. see LICENSE.txt for more info.
