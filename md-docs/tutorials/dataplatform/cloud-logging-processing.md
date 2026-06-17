# Обработка логов Yandex Cloud Logging

[Yandex Cloud Logging](../../logging/index.md) — это сервис, который позволяет читать и записывать логи сервисов Yandex Cloud и пользовательских приложений.

Логи можно отправить в [поток](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams и далее обработать в реальном времени с помощью Yandex Query. Обработанные данные можно:

* отправить в Yandex Monitoring для построения графиков и алертинга;
* записать в поток Data Streams и далее отправить на обработку в Yandex Cloud Functions;
* записать в поток Data Streams и далее передать в Yandex Data Transfer [для отправки в различные системы хранения](../../data-streams/tutorials/data-ingestion.md).

![cloud-logging-to-yq](../../_assets/query/cloud-logging.png)

В этом сценарии вы отправите логи Cloud Logging в поток Data Streams, а затем выполните к ним запрос с помощью Query. В результате выполнения запроса вы получите количество сообщений по каждому хосту, сгруппированное по интервалам продолжительностью 10 секунд.

Для выполнения сценария:

1. [Создайте поток данных Data Streams](#create-yds-stream).
1. [Создайте лог-группу Cloud Logging](#create-log-group).
1. [Запустите отправку данных в лог-группу](#send-to-loggroup).
1. [Подключите Query к потоку данных](#connect-query).
1. [Выполните запрос к данным](#query).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Установите [интерфейс командной строки](../../cli/quickstart.md#install) Yandex Cloud.

## Создайте поток данных Data Streams {#create-yds-stream}

[Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream) c именем `cloud-logging-stream`.

## Создайте лог-группу Cloud Logging {#create-log-group}

[Создайте лог-группу](../../logging/operations/create-group.md) c именем `cloud-logging-group`. При задании параметров лог-группы укажите созданный на предыдущем шаге поток данных `cloud-logging-stream`.

## Запустите отправку данных в лог-группу {#send-to-loggroup}

Чтобы запустить отправку данных в лог-группу, выполните следующую команду:

```bash
while true; do yc logging write \
  --group-name=cloud-logging-group \
  --message="test_message" \
  --timestamp="1s ago" \
  --level=INFO \
  --json-payload='{"request_id": "1234", "host":"test_host"}' \
  --folder-id b1kmrhakmf8a********; \
  sleep 1; \
done
```

* `--group-name` — название лог-группы, в которую отправляются сообщения;
* `--message` — текст сообщения;
* `--json_payload` — дополнительные данные сообщения в формате JSON;
* `--folder-id` — идентификатор каталога, в котором создана лог-группа.

{% note info %}

   Параметры `--group-name`, `--message`, `--json-payload` можно опустить и указать только значения параметров. Например: `cloud-logging-group "test_message" '{"request_id": "1234", "host":"test_host"}'`.

   {% endnote %}

## Подключите Query к потоку данных {#connect-query}

1. [Создайте соединение](../../query/operations/connection.md#create) с именем `cloud-logging-connection` и типом `Data Streams`.
1. На странице создания привязки:
    * Выберите **Автоматически заполнить настройки для Cloud Logging**.
    * Введите имя привязки `cloud-logging-binding`.
    * Укажите поток данных `cloud-logging-stream`.
    * Задайте формат `json-list`.
1. Нажмите кнопку **Создать**.

## Выполните запрос к данным {#query}

В редакторе запросов в интерфейсе Query выполните следующий запрос:

```sql
$cloud_logging_data = 
SELECT 
    CAST(JSON_VALUE(data, "$.timestamp") AS Timestamp) AS `timestamp`,
    JSON_VALUE(data, "$.jsonPayload.host") AS host
FROM bindings.`cloud-logging-binding`;

SELECT 
    host, 
    COUNT(*) AS message_count, 
    HOP_END() AS `timestamp`
FROM $cloud_logging_data
GROUP BY 
    HOP(`timestamp`, "PT10S", "PT10S", "PT10S"), 
    host
LIMIT 2;
```

Результат:

| # | host | message_count | timestamp |
| :--- | :--- | ---: | :--- |
| 1 | "test_host" | 3 | 2023-05-09T10:34:00.000000Z |
| 2 | "test_host" | 4 | 2023-05-09T10:34:10.000000Z |

{% note info %}

Данные из потокового источника передаются в виде бесконечного потока. Чтобы остановить обработку и получить результат в консоли, данные в примере ограничены с помощь оператора `LIMIT`, который задает количество строк результата.

{% endnote %}

## Полезные ссылки {#see-also}

* [Чтение данных из Data Streams с помощью соединений в Query](../../query/sources-and-sinks/data-streams.md).