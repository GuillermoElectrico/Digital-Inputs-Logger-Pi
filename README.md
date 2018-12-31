# Digital-Inputs-Logger-Pi
Log inputs status on a Raspberry Pi and plot graphs of your data.
Its been verified to work with a raspberry pi with simple 13 inputs module (coming soon PCB). By changing the inputspins.yml file and making a corresponding GPIO inputs relation.

### Requirements

#### Hardware

* Raspberry Pi B+
* 13 inputs module (coming soon PCB) or other module DIY

#### Software

* Raspbian
* Python 3.4 and PIP3
* [RPi.GPIO](https://pypi.org/project/RPi.GPIO/)
* [InfluxDB](https://docs.influxdata.com/influxdb/v1.3/)
* [Grafana](http://docs.grafana.org/)

### Installation
#### Install InfluxDB*

##### Step-by-step instructions
* Add the InfluxData repository
    ```sh
    $ curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
    $ source /etc/os-release
    $ test $VERSION_ID = "9" && echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
    ```
* Download and install
    ```sh
    $ sudo apt-get update && sudo apt-get install influxdb
    ```
* Start the influxdb service
    ```sh
    $ sudo service influxdb start
    ```
* Create the database
    ```sh
    $ influx
    CREATE DATABASE db_inputs
    exit
    ```
[*source](https://docs.influxdata.com/influxdb/v1.3/introduction/installation/)

#### Install Grafana*

##### Step-by-step instructions
* Add APT Repository
    ```sh
    $ echo "deb https://dl.bintray.com/fg2it/deb-rpi-1b jessie main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    ```
* Add Bintray key
    ```sh
    $ curl https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
    ```
* Now install
    ```sh
    $ sudo apt-get update && sudo apt-get install grafana
    ```
* Start the service using systemd:
    ```sh
    $ sudo systemctl daemon-reload
    $ sudo systemctl start grafana-server
    $ systemctl status grafana-server
    ```
* Enable the systemd service so that Grafana starts at boot.
    ```sh
    $ sudo systemctl enable grafana-server.service
    ```
* Go to http://localhost:3000 and login using admin / admin (remember to change password)
[*source](http://docs.grafana.org/installation/debian/)

#### Install Digital-Inputs-Logger-Pi:
* Download and install from Github and install pip3
    ```sh
    $ git clone https://github.com/GuillermoElectrico/Digital-Inputs-Logger-Pi.git
	$ sudo apt-get install python3-pip
    ```
* Run setup script (must be executed as root (sudo) if the application needs to be started from rc.local, see below)
    ```sh
    $ cd Digital-Inputs-Logger-Pi
    $ sudo python3 setup.py install
    ```    
* Make script file executable
    ```sh
    $ chmod 777 read_input_raspberry.py
    ```
* Edit inputs.yml to match your configuration
* Test the configuration by running:
    ```sh
    ./read_input_raspberry.py
    ./read_input_raspberry.py --help # Shows you all available parameters
    ```

	If the error appears:
	```
	/usr/bin/env: ‘python3\r’: No such file or directory
	```
	Use dos2unix to fix it.
	```
	$ sudo apt install dos2unix
	$ dos2unix /PATH/TO/YOUR/FILE
	```

* To run the python script at system startup. Add to following lines to the end of /etc/rc.local but before exit:
    ```sh
    # Start Inputs Logger
    /home/pi/Digital-Inputs-Logger-Pi/read_input_raspberry.py > /var/log/inputs-logger.log &
    ```
	
    Log with potential errors are found in /var/log/inputs-logger.log
