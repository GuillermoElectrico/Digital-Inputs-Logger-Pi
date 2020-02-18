#!/bin/bash

## Servicio o script a monitorizar si se está ejecutando
SERVICE=read_input_raspberry.py

while :
do
	result=$(ps ax|grep -v grep|grep $SERVICE)
#	echo ${#result}
	if [ ${#result} != 0 ] 
	then
		# está todo OK
		# cada 10 segundos probamos si sigue bien
		sleep 10
	else
		# no está funcionando
		# cada 10 segundos probamos si ha vuelto
		sleep 10
		#iniciar script (en este caso un script de python)
		/home/pi/Digital-Inputs-Logger-Pi/$SERVICE > /var/log/read_input_raspberry.py &
		# esperamos a que cargue
		sleep 1
	fi
done