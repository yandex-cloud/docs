# Добавить расширение x-yc-apigateway-integration:cloud_datastreams

{% list tabs %}

- Консоль управления

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **API Gateway**.
    1. Выберите API-шлюз или нажмите кнопку **Создать API-шлюз**, чтобы создать новый.
    1. В поле **Спецификация** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-datastreams.svg).
    1. Укажите в поле:

        * **Путь** — относительный путь к интеграции, который будет добавлен к URL-адресу API Gateway. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее см. спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        * **HTTP-метод** — метод, который будет использоваться для взаимодействия с интеграцией.

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при выполнении операции с [потоком](../../../data-streams/concepts/glossary.md#stream-concepts) Data Streams. Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **Операция** — выполняемую операцию.
        * **Имя потока Data Streams** — имя потока данных Data Streams.
        * (Опционально) **Тип содержимого записи** — тип содержимого записи. Если значение — `body`, в поток записывается только тело запроса, если `request` — весь запрос в формате JSON. Значение по умолчанию — `body`.
        * (Опционально) **Ключ сегмента** — [ключ сегмента](../../../data-streams/concepts/partition-keys.md). Если не указан, запись выполняется в случайный сегмент.
    1. Нажмите кнопку **Добавить**.

{% endlist %}

В поле **Спецификация** отобразится OpenAPI-спецификация с указанными значениями параметров.

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:cloud_datastreams](../../concepts/extensions/datastreams.md)