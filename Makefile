all : mplay mpause

mplay : mplay.rb
	echo Building mplay
	macrubyc mplay.rb -o mplay

mpause : mpause.rb
	echo Building mpause
	macrubyc mpause.rb -o mpause

clean :
	echo Removing build ouptut
	rm -f mplay mplay.o mpause mpause.o

