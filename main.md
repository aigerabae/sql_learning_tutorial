Installation on ubuntu:
```bash
sudo apt install mysql-server
sudo snap install mysql-workbench-community     # one of the editors, can choose any other
sudo systemctl start mysql.service              #Starting a session
sudo mysql                                      #starts mysql prompt
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';    # sets assword as password
# then you can close command line and open MySQL workbench app; in the app you edit connection to have password password (manually entering it) and then run it.
```

SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS tutorialdb #the part after if will allow you to avoid error code if you are trying to create a database rthat already exists
