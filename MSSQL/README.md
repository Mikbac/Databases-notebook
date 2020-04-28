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



