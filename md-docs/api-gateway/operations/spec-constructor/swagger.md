# Добавить расширение x-yc-apigateway-integration:swagger

{% list tabs %}

- Консоль управления

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. Перейдите в сервис **API Gateway**.
    1. Выберите API-шлюз или нажмите кнопку **Создать API-шлюз**, чтобы создать новый.
    1. В поле **Спецификация** нажмите значок ![swagger](../../../_assets/api-gateway/spec-constructor/swagger.svg) и в открывшемся окне:

        1. В поле **Путь** укажите относительный путь к интеграции, который будет добавлен к URL-адресу API Gateway. Переменные указывайте в фигурных скобках, например `/docs/{document_id}`. Подробнее см. спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        1. Нажмите кнопку **Добавить**.

{% endlist %}

В поле **Спецификация** отобразится OpenAPI-спецификация с указанными значениями параметров.

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:swagger](../../concepts/extensions/swagger.md)