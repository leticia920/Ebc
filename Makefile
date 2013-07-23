compile:
	rm -rf src/*.erl~
	for ARCHIVO in `ls src/ | grep .erl`;\
                do\
                erlc -I include/ -o ebin/ src/$$ARCHIVO;\
        done
clean:
	rm -rf ebin/*.beam
	
start:
	erl -sname example -setcookie test -pa ebin/
	
