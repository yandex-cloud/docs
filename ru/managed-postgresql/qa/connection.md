# Подключение

#### Возможен ли доступ к кластеру изнутри {{ yandex-cloud }}? {#conn-from-yc}

К хостам кластера {{ mpg-short-name }} можно подключиться:
* Через интернет, если вы настроили публичный доступ для нужного хоста. К таким хостам подключиться можно только используя SSL-соединение.
* С виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети. Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.

Подробнее см. в [документации сервиса](../operations/connect.md).

#### Как получить SSL-сертификат для подключения к {{ mpg-name }} на Windows? {#get-ssl}

SSL-сертификат можно получить с помощью PowerShell:

```powershell
mkdir $HOME\AppData\Roaming\postgresql; `
curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt https://{{ s3-storage-host }}{{ pem-path }}
```

Сертификат будет доступен по пути `$HOME\AppData\Roaming\postgresql\root.crt`.

Подробнее о получении сертификата и подключении к базе данных см. в [документации сервиса](../operations/connect.md).

#### Как установить SSL-сертификат для подключения Power BI к {{ mpg-name }} через psql? {#power-bi}

1. Установите [Windows Subsystem for Linux](https://docs.microsoft.com/ru-ru/windows/wsl/) (WSL) и выполните в терминале команду:

   ```bash
   mkdir /mnt/c/temp && \
   curl "https://{{ s3-storage-host }}{{ pem-path }}" -o /mnt/c/temp/CA.pem && \
   openssl pkcs12 -export -out /mnt/c/temp/CA.pfx -nokeys -in /mnt/c/temp/CA.pem
   ```

   Сертификат будет доступен по пути `C:\temp\CA.pfx`.

2. [Разместите полученный сертификат в хранилище сертификатов Windows](https://docs.microsoft.com/en-us/skype-sdk/sdn/articles/installing-the-trusted-root-certificate).
