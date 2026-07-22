[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Пошаговые инструкции](../index.md) > [Конструктор спецификаций](index.md) > Cloud Functions

# Добавить расширение x-yc-apigateway-integration:cloud_functions

{% list tabs %}

- Консоль управления

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. [Перейдите](https://console.yandex.cloud/link/api-gateway) в сервис **API Gateway**.
    1. Выберите API-шлюз или нажмите кнопку **Создать API-шлюз**, чтобы создать новый.
    1. Нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
    1. В поле **Спецификация** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-functions.svg).
    1. Укажите в поле:

        * **Путь** — относительный путь к интеграции, который будет добавлен к URL-адресу API Gateway. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее в спецификации [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        * **HTTP-метод** — метод, который будет использоваться для взаимодействия с интеграцией.

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при обращении к [функции](../../../functions/concepts/function.md). Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * (Опционально) **Версия формата запроса** — версию формата запроса к функции. Возможные значения — 0.1, 1.0 и 2.0. Версия по умолчанию — 0.1.
        * **Функция** — имя функции и [тег версии](../../../functions/concepts/function.md#tag) функции.
    1. (Опционально) Вставьте или загрузите контекст операции — произвольный объект в формате YAML или JSON. Контекст передается в функцию внутри запроса в поле `requestContext.apiGateway.operationContext`. В контексте операции осуществляется подстановка параметров.
    1. Нажмите кнопку **Добавить**.

{% endlist %}

В поле **Спецификация** отобразится OpenAPI-спецификация с указанными значениями параметров.

#### Полезные ссылки {#see-also}

[Расширение x-yc-apigateway-integration:cloud_functions](../../concepts/extensions/cloud-functions.md)