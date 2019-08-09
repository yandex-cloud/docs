# Подключение к базе данных в кластере {{ CH }}

{% if audience != "internal" %}

Внутри Яндекс.Облака подключиться к кластеру БД можно только с виртуальной машины с адресом в той же подсети Облака.

{% endif %}

К кластеру {{ CH }} можно подключиться как с помощью [клиента командной строки](https://clickhouse.yandex/docs/ru/interfaces/cli/) (порт 9440), так и по [HTTP-интерфейсу](https://clickhouse.yandex/docs/ru/interfaces/http_interface/) (порт 8443). Все соединения с кластерами БД шифруются.

## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать шифрованное соединение, необходимо получить SSL-сертификат:

{% if audience != "internal" %}

```bash
wget "https://{{ s3-storage-host }}{{ pem-path }}"
```

{% else %}

```bash
wget "{{ pem-path }}"
```

{% endif %}


## Подключение с помощью {{ CH }} CLI {#cli}

Чтобы подключиться к кластеру с помощью клиента командной строки, укажите путь к SSL-сертификату в [конфигурационном файле](https://clickhouse.yandex/docs/ru/interfaces/cli/#interfaces_cli_configuration), в элементе `<caConfig>`:

```xml
<config>
  <openSSL>
    <client>
      <loadDefaultCAFile>true</loadDefaultCAFile>
      <caConfig>[путь к SSL-сертификату]</caConfig>
      <cacheSessions>true</cacheSessions>
      <disableProtocols>sslv2,sslv3</disableProtocols>
      <preferServerCiphers>true</preferServerCiphers>
      <invalidCertificateHandler>
        <name>RejectCertificateHandler</name>
      </invalidCertificateHandler>
    </client>
  </openSSL>
</config>
```

Затем запустите ClickHouse CLI со следующими параметрами:

```bash
clickhouse-client --host <адрес хоста> \
                  -s \
                  --user <имя пользователя БД> \
                  --password <пароль пользователя БД> \
                  -q "<запрос к БД>"
                  --port 9440
```

## Подключение по HTTP {#http}

Отправьте запрос, указав путь к полученному SSL-сертификату, атрибуты базы данных и текст запроса в формате urlencoded:

```bash
curl --cacert <путь к SSL-сертификату> \
     -H "X-ClickHouse-User: <имя пользователя БД>" \
     -H "X-ClickHouse-Key: <пароль пользователя БД>" \
     'https://<адрес хоста>:8443/?database=<имя БД>&query=SELECT%20now()'
```

При подключении с помощью HTTP-метода GET возможны только операции чтения. GET-запрос операции записи всегда вызовет ошибку, как при использовании параметра соединения `readonly=1`.
Для операций записи всегда используйте метод POST:

```bash
curl -X POST \
     --cacert <путь к SSL-сертификату> \
     -H "X-ClickHouse-User: <имя пользователя БД>" \
     -H "X-ClickHouse-Key: <пароль пользователя БД>" \
     'https://<адрес хоста>:8443/?database=<имя БД>&query=INSERT%20INTO%20Customers%20%28CustomerName%2C%20Address%29%20VALUES%20%28%27Example%20Exampleson%27%2C%20%27Moscow%2C%20Lva%20Tolstogo%2C%2016%27%29%3B'
```

