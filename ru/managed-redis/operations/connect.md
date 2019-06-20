# Подключение к базе данных в кластере {{ RD }}

Хостам кластера Redis нельзя назначать публичные IP-адреса. Подключиться к хосту Redis можно только с виртуальной машины, находящейся в той же подсети, что и хост.

1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) с публичным IP-адресом в той же подсети, где находится хост Redis.

1. Подключитесь к созданной ВМ [через SSH](../../compute/operations/vm-connect/ssh.md).

   ```
   $ ssh <логин>@<публичный IP-адрес ВМ>
   ```

1. Установите инструменты Redis на ВМ с помощью пакетного менеджера:

   {% list tabs %}

   - Ubuntu
  
     ```
     $ sudo apt update
     $ sudo apt-get install redis
     ```
  
   - CentOS
  
     ```
     $ sudo yum update
     $ sudo yum install redis
     ```
  
   {% endlist %}

1. Установите сертификат для доступа к базе данных:

   ```
   $ mkdir -p /usr/local/share/ca-certificates/Yandex
   $ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```

1. Создайте переменную, содержащую адрес и порт хоста, а также имя мастера БД.

   ```
   $ host=$(redis-cli -h <адрес хоста> -p 26379 sentinel get-master-addr-by-name <имя кластера> | head -n 1)
   ```

1. Проверьте соединение с хостом:

   ```
   $ redis-cli -h $host -a <пароль БД> ping
   ```

   Если вернется ответ `PONG`, то соединение устанавливается успешно.

