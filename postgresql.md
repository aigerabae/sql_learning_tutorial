sudo apt install postgresql
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4
sudo /usr/pgadmin4/bin/setup-web.sh

sudo su - postgres
psql
CREATE ROLE aygera LOGIN SUPERUSER PASSWORD 'password';
CREATE DATABASE aygera OWNER aygera;
\q
exit

psql -U aygera -d aygera

Log in via with 'aigerabae' and 'password' http://localhost/pgadmin4

I had to register server with:
Host name/address: localhost
Port: 5432
Maintenance database: aygera 
Username: aygera
Password: password

in VS code:
python -m venv venv
source venv/bin/activate
# i created file requirements.txt in my current directory with fastapi uvicorn SQLAlchemy psycopg2-binary pydantic
pip3 install -r requirements.txt

in ipython (command line):
import db,models
db.create_table()
