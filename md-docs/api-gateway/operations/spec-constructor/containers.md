[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Пошаговые инструкции](../index.md) > [Конструктор спецификаций](index.md) > Serverless Containers

# Добавить расширение x-yc-apigateway-integration:serverless_containers

{% list tabs %}

- Консоль управления

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. Перейдите в сервис **API Gateway**.
    1. Выберите API-шлюз или нажмите кнопку **Создать API-шлюз**, чтобы создать новый.
    1. В поле **Спецификация** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/serverless-containers.svg).
    1. Укажите в поле:

        * **Путь** — относительный путь к интеграции, который будет добавлен к URL-адресу API Gateway. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее в спецификации [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        * **HTTP-метод** — метод, который будет использоваться для взаимодействия с интеграцией.

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при обращении к контейнеру. Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **Идентификатор контейнера** — идентификатор контейнера. Чтобы узнать его, [получите информацию о контейнере](../../../serverless-containers/operations/container-info.md).
    1. (Опционально) Вставьте или загрузите контекст операции — произвольный объект в формате YAML или JSON.
    1. Нажмите кнопку **Добавить**.

{% endlist %}

В поле **Спецификация** отобразится OpenAPI-спецификация с указанными значениями параметров.

## Полезные ссылки {#see-also}

* [Расширение x-yc-apigateway-integration:serverless_containers](../../concepts/extensions/containers.md)