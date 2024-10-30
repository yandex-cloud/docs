---
title: Подключение к кластеру {{ OS }} в {{ mos-full-name }}
description: К хостам кластера {{ OS }} с ролью DATA можно подключиться через интернет, если вы настроили публичный доступ для нужного хоста, и с виртуальных машин {{ yandex-cloud }}, расположенных в той же виртуальной сети.
keywords:
  - подключение кластера OpenSearch
  - кластер OpenSearch
  - OpenSearch
---

# Подключение к кластеру {{ OS }}

К хостам кластера {{ mos-name }} с [ролью](../concepts/host-roles.md#data) `DATA` можно подключиться:

* Через интернет, если вы настроили публичный доступ для нужной группы хостов.


* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [виртуальной сети](../../vpc/concepts/network.md).


Вне зависимости от способа подключения, {{ mos-name }} поддерживает только соединения с [SSL-сертификатом](#ssl-certificate) к хостам кластера.


## Настройка групп безопасности {#security-groups}

{% include notitle [Configuring security groups](../../_includes/mdb/mos/configuring-security-groups.md) %}


## Получение SSL-сертификата {#ssl-certificate}

Чтобы использовать шифрованное соединение, получите SSL-сертификат:

{% include [install-certificate](../../_includes/mdb/mos/install-certificate.md) %}

## FQDN хоста {{ OS }} {#fqdn}

Для подключения к хосту потребуется его [FQDN](../concepts/network.md#hostname) — доменное имя. Его можно получить несколькими способами:

* [Запросите список хостов в кластере](host-groups.md#list-hosts).
* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит заполненный FQDN хоста. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Посмотрите FQDN в консоли управления:

   1. Перейдите на страницу кластера.
   1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

Для хостов с ролью `DASHBOARDS` также используется [особый FQDN](#special-fqdns).

## Особый FQDN {#special-fqdns}

Наравне с [обычными FQDN](#fqdn) {{ mos-name }} предоставляет особый FQDN, который также можно использовать при подключении к кластеру.

FQDN вида `c-<идентификатор_кластера>.rw.{{ dns-zone }}` всегда указывает на доступный хост {{ OS }} с ролью `DASHBOARDS` в кластере. Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

Сервис не предоставляет особые FQDN для хостов с ролью `DATA`.

## Подключение к {{ OS }} Dashboards {#dashboards}


Вы можете подключиться к {{ OS }} Dashboards:

* Через интернет, если для хоста с ролью `DASHBOARDS` включен публичный доступ.
* Через виртуальную машину в {{ yandex-cloud }}, если публичный доступ не включен ни для какого из хостов с ролью `DASHBOARDS`.

{% list tabs group=connection_method %}

- Через интернет {#internet}

    1. Установите [SSL-сертификат](#ssl-certificate) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
    1. На странице кластера в консоли управления нажмите кнопку **{{ ui-key.yacloud.opensearch.title_opensearch-dashboards-section }}** или перейдите в браузере по адресу `https://c-<идентификатор_кластера>.rw.{{ dns-zone }}>`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Введите имя пользователя `admin` и пароль, который был задан при [создании кластера](cluster-create.md).

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. [Создайте](../../compute/quickstart/quick-create-linux.md) виртуальную машину на основе Linux в той же [виртуальной сети](../../vpc/concepts/network.md), что и кластер.
    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
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

При использовании API {{ OS }} Dashboards:

* Для отправки запросов используйте порт `{{ port-https }}` вместо штатного `5601`.
* Добавьте путь к SSL-сертификату в конфигурацию вашего приложения для работы с [API](../../glossary/rest-api.md).

{% endnote %}

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mos-name }} из Docker-контейнера, добавьте в Dockerfile строки:

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
        wget "{{ crt-web-path }}" \
             --output-document ~/.opensearch/root.crt && \
        chmod 0600 ~/.opensearch/root.crt
    ```

{% endlist %}

## Примеры строк подключения {#code-examples}

Перед подключением [подготовьте сертификат](#ssl-cetificate).

Для подключения нужно использовать имя пользователя `admin` и пароль, который был задан при [создании кластера](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Code examples](../../_includes/mdb/mos/code-examples.md) %}
