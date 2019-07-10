/*Для установки обновил индекс пакетов apt командой
$ sudo apt update
Затем установил пакет:
$ sudo apt install mysql-server
Выполнил скрипт безопасности
$ sudo mysql_secure_installation

Для того, чтобы пользователь root в MySQL мог использовать пароль для входа в систему 
необходимо изменить метод аутентификации с auth_socket на mysql_native_password. 
Для этого вошел в оболочку MySQL следующей командой:
$ sudo mysql

проверил, какой метод аутентификации используется для каждого из пользователей 
mysql> SELECT user,authentication_string,plugin,host FROM mysql.user;

В моем примере пользователь root использует аутентификацию с помощью плагина auth_socket
Для изменения этой настройки на использование пароля использую следующую команду ALTER USER
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

Далее выполняю команду FLUSH PRIVILEGES, которая применит внесённые изменения:
mysql>FLUSH PRIVILEGES;

Чтобы при входе не приходилось каждый раз вводить пароль создаю фаил 
в домашней директории пользователя .my.cnf
$ nano .my.cnf
ввожу содержимое файла и сохраняю.
[client]
user=root
password=******/
