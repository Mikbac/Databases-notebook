# MSSQL

## Table of Contents:
 * Basic
 * Creating databases and tables
 * Collocations
 * Select

## Installation
 * run script ```./install.sh``` 
 * Configuration before adding tools
    ```
    $ sudo /opt/mssql/bin/mssql-conf setup
    ```
 * run script ```./addTools.sh```
 
## Run server
```
$ sudo systemctl start mssql-server.service
```

## Close server
```
$ sudo systemctl stop mssql-server.service
```

## sqlcmd
```
sqlcmd -S localhost -U sa
```

## Ports
```
$ sudo netstat -tapn | grep sqlservr
```

## Status
```
$ sudo systemctl status mssql-server.service
```
```
$ sudo journalctl -u mssql-server.service --all
```

## mssql-cli

```
sudo apt-get update
wget http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3.1_amd64.deb
sudo dpkg -i libicu60_60.2-3ubuntu3.1_amd64.deb
sudo apt-get install -y mssql-cli
mssql-cli -S localhost -U sa
```

