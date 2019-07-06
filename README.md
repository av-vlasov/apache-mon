# apache-mon
***autor:*** *av-vlasov*
### Configarion ###
rename file users.var in users.var.cfg \
HOST= имя хоста для мониторинга; \
MAIL_LIST - список e-mail для отправки отчета, через пробел.
## Variable ##
### Command ###
ECHO = echo -e 
TIME = YYYY-mm-dd_HH:MM:SS - дата и время \
DIR = `pwd` - текущая директория 
## Function ##
### send_mail ###
 отправка почты всем из списка MAIL_LIST \
 удаление файлов логов старше 2х дней
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
