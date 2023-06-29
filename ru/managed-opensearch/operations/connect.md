---
title: "Подключение к кластеру {{ OS }}"
description: "К хостам кластера {{ OS }} с ролью DATA можно подключиться через интернет, если вы настроили публичный доступ для нужного хоста, и с виртуальных машин {{ yandex-cloud }}, расположенных в той же виртуальной сети."
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

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

{% include notitle [Configuring security groups](../../_includes/mdb/mos/configuring-security-groups.md) %}


## Получение SSL-сертификата {#ssl-certificate}

Чтобы использовать шифрованное соединение, получите SSL-сертификат:

{% include [install-certificate](../../_includes/mdb/mos/install-certificate.md) %}

## Подключение к {{ OS }} Dashboards {#dashboards}


Вы можете подключиться к {{ OS }} Dashboards:

* Через интернет, если хосту с ролью `DASHBOARDS` назначен публичный IP-адрес.
* Через виртуальную машину в {{ yandex-cloud }}, если ни одному хосту с ролью `DASHBOARDS` публичный IP-адрес не назначен.

{% list tabs %}

- Через интернет

    1. Установите [SSL-сертификат](#ssl-certificate) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
    1. На странице кластера в консоли управления нажмите кнопку **OpenSearch Dashboards** или перейдите в браузере по адресу `https://c-<идентификатор кластера>.rw.{{ dns-zone }}>`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Введите имя пользователя `admin` и пароль, который был задан при [создании кластера](cluster-create.md).

- С ВМ в {{ yandex-cloud }}

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
          server <FQDN хоста 1 с ролью DASHBOARDS>:443;
          ...
          server <FQDN хоста N с ролью DASHBOARDS>:443;
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

    1. Перейдите в браузере по адресу `https://<публичный IP-адрес ВМ>`.

    1. Введите имя пользователя `admin` и пароль.

{% endlist %}


{% note info %}

При использовании API {{ OS }} Dashboards:

* Для отправки запросов используйте порт `{{ port-https }}` вместо штатного `5601`.
* Добавьте путь к SSL-сертификату в конфигурацию вашего приложения для работы с [API](../../glossary/rest-api.md).

{% endnote %}

## Примеры строк подключения {#code-examples}

Перед подключением [подготовьте сертификат](#ssl-cetificate).

Для подключения нужно использовать имя пользователя `admin` и пароль, который был задан при [создании кластера](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Code examples](../../_includes/mdb/mos/code-examples.md) %}

## Особые FQDN {#special-fqdns}

Наравне с обычными FQDN, которые можно запросить со [списком хостов в кластере](host-groups.md#list-hosts), {{ mos-name }} предоставляет особые FQDN, которые также можно использовать при подключении к кластеру.

### Доступный хост Dashboards {#fqdn-dashboards}

FQDN вида `c-<идентификатор кластера>.rw.{{ dns-zone }}` всегда указывает на доступный хост {{ OS }} с ролью `DASHBOARDS` в кластере. Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).
