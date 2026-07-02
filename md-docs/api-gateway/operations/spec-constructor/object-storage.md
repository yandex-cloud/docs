[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Пошаговые инструкции](../index.md) > [Конструктор спецификаций](index.md) > Object Storage

# Добавить расширение x-yc-apigateway-integration:object_storage

{% list tabs %}

- Консоль управления

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. Перейдите в сервис **API Gateway**.
    1. Выберите API-шлюз или нажмите кнопку **Создать API-шлюз**, чтобы создать новый.
    1. В поле **Спецификация** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/object-storage.svg).
    1. Укажите в поле:

        * **Путь** — относительный путь к интеграции, который будет добавлен к URL-адресу API Gateway. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее в спецификации [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        * **HTTP-метод** — метод, который будет использоваться для взаимодействия с интеграцией.

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при обращении к Object Storage.
        * **Бакет** — имя [бакета](../../../storage/concepts/bucket.md).
        * **Имя объекта** — имя [объекта](../../../storage/concepts/object.md).
        * (Опционально) **Объект ошибки** — имя объекта, который будет возвращаться, если вместо указанного имени объекта получена ошибка с HTTP-кодом 4xx.
    1. Нажмите кнопку **Добавить**.

{% endlist %}

В поле **Спецификация** отобразится OpenAPI-спецификация с указанными значениями параметров.

## Полезные ссылки {#see-also}

* [Расширение x-yc-apigateway-integration:object_storage](../../concepts/extensions/object-storage.md)