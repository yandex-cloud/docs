# Подключение к кластеру OpenSearch из приложений

В этом разделе представлены настройки для подключения к хостам кластера Managed Service for OpenSearch с помощью [инструментов командной строки](#command-line-tools), [OpenSearch Dashboards](#dashboards) и из [Docker-контейнера](#connection-docker). Примеры подключения из приложения — в разделе [Примеры кода](code-examples.md).

## Инструменты командной строки {#command-line-tools}

Примеры кода с заполненным FQDN хоста доступны в [консоли управления](https://console.yandex.cloud) по нажатию кнопки **Подключиться** на странице кластера.

### Linux (Bash) {#bash}

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

    ```bash
    curl \
        --user admin:<пароль> \
        --cacert ~/.opensearch/root.crt \
        --request GET 'https://<FQDN_хоста_OpenSearch_с_публичным_доступом>:9200/'
    ```

{% endlist %}

О том, как получить FQDN хоста, в [инструкции](fqdn.md).

### Windows (PowerShell) {#powershell}

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

   ```powershell
   curl `
     -Certificate <абсолютный_путь_к_файлу_сертификата> `
     -Uri https://<FQDN_хоста_OpenSearch_с_ролью_DATA>:9200 `
     -Credential admin
   ```

{% endlist %}

О том, как получить FQDN хоста, в [инструкции](fqdn.md).

## Подключение к OpenSearch Dashboards {#dashboards}


Вы можете подключиться к OpenSearch Dashboards:

* Через интернет, если для хоста с ролью `DASHBOARDS` включен публичный доступ.
* Через виртуальную машину в Yandex Cloud, если публичный доступ не включен ни для какого из хостов с ролью `DASHBOARDS`.

{% list tabs group=connection_method %}

- Через интернет {#internet}

    1. Установите [SSL-сертификат](index.md#ssl-certificate) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
    1. На странице кластера в консоли управления нажмите кнопку **OpenSearch Dashboards** или перейдите в браузере по адресу `https://c-<идентификатор_кластера>.rw.mdb.yandexcloud.net`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Введите имя пользователя `admin` и пароль, который был задан при [создании кластера](../cluster-create.md).

- С ВМ в Yandex Cloud {#cloud}

    1. [Создайте](../../../compute/quickstart/quick-create-linux.md) виртуальную машину на основе Linux в той же [виртуальной сети](../../../vpc/concepts/network.md), что и кластер.
    1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
    1. Установите зависимости:
    
       ```bash
       sudo apt update && \
       sudo apt install --yes nginx ssl-cert
       ```

    1. Скопируйте загруженный SSL-сертификат в директорию `/etc/nginx/`:

       ```bash
       sudo cp ~/.opensearch/root.crt /etc/nginx/root.crt
       ```

    1. Измените файл конфигурации по умолчанию для NGINX, например, так:

       `/etc/nginx/sites-available/default`

       ```nginx
       upstream os-dashboards-nodes {
          server <FQDN_хоста_1_с_ролью_DASHBOARDS>:443;
          ...
          server <FQDN_хоста_N_с_ролью_DASHBOARDS>:443;
       }

       server {
          listen 443 ssl;

          ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
          ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;

          server_name _;

          location / {

              proxy_pass https://os-dashboards-nodes;

              proxy_ssl_trusted_certificate /etc/nginx/root.crt;
              proxy_ssl_session_reuse on;
          }
       }
       ```

       {% note warning %}

       В этом примере конфигурационного файла используется самоподписанный сертификат `snakeoil` из пакета `ssl-cert`. Использовать этот сертификат в реальном кластере небезопасно. Вместо самоподписанного сертификата укажите путь к вашим публичным и приватным ключам SSL-сертификата в директивах `ssl_certificate` и `ssl_certificate_key`.

       {% endnote %}

    1. Перезапустите NGINX:

       ```bash
       sudo systemctl restart nginx
       ```

    1. Добавьте сертификат, указанный в директиве `ssl_certificate`, в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).

    1. Перейдите в браузере по адресу `https://<публичный_IP-адрес_ВМ>`.

    1. Введите имя пользователя `admin` и пароль.

{% endlist %}


{% note info %}

При использовании API OpenSearch Dashboards:

* Для отправки запросов используйте порт `443` вместо штатного `5601`.
* Добавьте путь к SSL-сертификату в конфигурацию вашего приложения для работы с [API](../../../glossary/rest-api.md).

{% endnote %}

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру Managed Service for OpenSearch из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install curl --yes
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget curl --yes && \
        mkdir --parents ~/.opensearch && \
        wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
             --output-document ~/.opensearch/root.crt && \
        chmod 0600 ~/.opensearch/root.crt
    ```

{% endlist %}