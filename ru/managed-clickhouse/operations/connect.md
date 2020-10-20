# Подключение к базе данных в кластере {{ CH }}

{% if audience != "internal" %}

Внутри {{ yandex-cloud }} подключиться к кластеру БД можно только с виртуальной машины, подключенной к той же подсети, что и кластер.

{% endif %}

К кластеру {{ CH }} можно подключиться как с помощью [клиента командной строки](https://clickhouse.yandex/docs/ru/interfaces/cli/) (порт 9440), так и по [HTTP-интерфейсу](https://clickhouse.yandex/docs/ru/interfaces/http_interface/) (порт 8443). Все соединения с кластерами БД шифруются.

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

Вы можете подключаться к кластеру {{ CH }} только с использованием SSL-сертификата. Перед подключением [подготовьте сертификат](#get-ssl-cert). 

В этих примерах предполагается, что сертификат `YandexInternalRootCA.crt` расположен в директории `/usr/local/share/ca-certificates/Yandex/`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mch-connection-strings](../../_includes/mdb/mch-conn-strings.md) %}

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ CH }}.

