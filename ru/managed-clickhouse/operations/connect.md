# Подключение к базе данных в кластере {{ CH }}

К хостам кластера {{ mch-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

К кластеру можно подключиться как с использованием шифрования — через порты `9440` для [clickhouse-client](https://clickhouse.tech/docs/ru/interfaces/cli/) и `8443` для [HTTP-интерфейса](https://clickhouse.tech/docs/ru/interfaces/http/), так и без него — через порты `9000` и `8123` соответственно.

## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать шифрованное соединение, необходимо подготовить SSL-сертификат, например, так:

{% if audience != "internal" %}

```bash
sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

{% else %}

```bash
wget "{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

{% endif %}


## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

Вы можете подключаться к хостам кластера {{ CH }} в публичном доступе только с использованием SSL-сертификата. Перед подключением [подготовьте сертификат](#get-ssl-cert).

В этих примерах предполагается, что сертификат `YandexInternalRootCA.crt` расположен в директории `/usr/local/share/ca-certificates/Yandex/`.

Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mch-connection-strings](../../_includes/mdb/mch-conn-strings.md) %}

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ CH }}.

## Автоматический выбор доступного хоста {#auto}

Чтобы вручную не подключаться к другому хосту, если текущий станет недоступен, можно использовать адрес вида:

* `c-<идентификатор кластера>.rw.mdb.yandexcloud.net` для подключения к мастеру кластера.

* `<имя шарда>.c-<идентификатор кластера>.rw.mdb.yandexcloud.net` для подключения к мастеру [шарда](../concepts/sharding.md).

Если хост, на который указывает этот адрес, станет недоступен, может быть небольшая задержка, прежде чем адрес начнет указывать на другой доступный хост.
