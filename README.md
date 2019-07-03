# apache-mon
***autor:*** *av-vlasov*
## Variable ##
### Command ###
ECHO = echo -e 
TIME = YYYY-mm-dd_HH:MM:SS - дата и время 
DIR = `pwd` - текущая директория 
HOST = адрес для проверки 
## Function ##
### send_mail ###
 отправка почты всем из списка MAIL_LIST
### apache_start ###
 старт сервиса apache 
 после старта запускает функцию send_mail
### apache_stop ###
 остановка apache, через kill -9 на случай повисших процессов 
 после выполнения запускает функцию apache_start.
### check_apache ###
 проверка доступности $HOST, в случае отсутствия отклика 200 или 301 создает log файл с текущей датой;
 запускает функцию apache_stop
### while ###
 каждые 5 секунд запускает функцию check_apache 
