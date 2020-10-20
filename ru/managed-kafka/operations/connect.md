# Подключение к топикам в кластере Apache Kafka®

К хостам кластера {{ mkf-name }} можно подключиться:
- Через интернет, если вы настроили публичный доступ для кластера [при его создании](cluster-create.md). К такому кластеру можно подключиться только используя [SSL-соединение](#get-ssl-cert).
- С виртуальных машин {{ yandex-cloud }}, расположенных в той же [виртуальной сети](../../vpc/concepts/network.md). Если к кластеру нет публичного доступа, для подключения с таких ВМ SSL-соединение использовать необязательно.

{% if audience != "internal" %}

К кластеру {{ KF }} можно подключиться как с использованием шифрования (`SASL_SSL`) - порт 9091, так и без него (`SASL_PLAINTEXT`) - порт 9092.

{% else %}

К кластеру {{ KF }} можно подключиться только с использованием шифрования (`SASL_SSL`) - порт 9091.

{% endif %}

Чтобы подключиться к кластеру {{ KF }}:

1. [Создайте учетные записи](cluster-accounts.md#create-account) для клиентов (производителей и потребителей) с доступами в нужные топики.
1. Подключите клиентов к кластеру:
   * производителей с помощью [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi);
   * потребителей с помощью [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

Для большинства популярных языков программирования существуют готовые реализации API {{ KF }}. Примеры кода для подключения к кластеру приведены в разделе [{#T}](#connection-string).

## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать шифрованное SSL-соединение, необходимо получить SSL-сертификат:

{% if audience != "internal" %}

```bash
sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
```

{% else %}

```bash
sudo wget "{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
chmod 655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
```

{% endif %}

## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mkf-conn-strings-env.md) %}

Перед подключением к хостам кластера с использованием SSL-соединения, [подготовьте сертификат](#get-ssl-cert). В этих примерах предполагается, что сертификат `YandexCA.crt` расположен в директории `/usr/local/share/ca-certificates/Yandex/`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mkf-connection-strings](../../_includes/mdb/mkf-conn-strings.md) %}

После запуска приложения-производителя в топик {{ KF }} будет отправлено одно или несколько сообщений `test message`. Затем их можно будет считать, запустив приложение-потребитель.