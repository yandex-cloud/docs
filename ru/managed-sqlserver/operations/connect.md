# Подключение к базе данных в кластере {{ MS }}

К хостам кластера {{ mms-short-name }} можно подключиться:
- Через интернет, если вы настроили публичный доступ для нужного хоста. К такому кластеру можно подключиться только используя [SSL-соединение](#get-ssl-cert).
- С виртуальных машин {{ yandex-cloud }}, расположенных в той же [виртуальной сети](../../vpc/concepts/network.md). Если к кластеру нет публичного доступа, для подключения с таких ВМ SSL-соединение использовать необязательно.

## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать шифрованное соединение, получите SSL-сертификат:

{% list tabs %}

- Ubuntu 20.04
  {% if audience != "internal" %}

  ```bash
  $ sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
  sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
  sudo update-ca-certificates
  ```

  {% else %}

  ```bash
  $ sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
  sudo wget "{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
  sudo update-ca-certificates
  ```

  {% endif %}

{% endlist %}

## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mms-conn-strings-env.md) %}

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mms-connection-strings](../../_includes/mdb/mms-conn-strings.md) %}
