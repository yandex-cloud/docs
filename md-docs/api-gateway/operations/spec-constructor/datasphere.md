# Добавить расширение x-yc-apigateway-integration:cloud_datasphere

{% list tabs %}

- Консоль управления

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **API Gateway**.
    1. Выберите API-шлюз или нажмите кнопку **Создать API-шлюз**, чтобы создать новый.
    1. В поле **Спецификация** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-datasphere.svg).
    1. Укажите в поле:

        * **Путь** — относительный путь к интеграции, который будет добавлен к URL-адресу API Gateway. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее см. спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        * **HTTP-метод** — метод, который будет использоваться для взаимодействия с интеграцией.

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при вызове [ноды](../../../datasphere/concepts/deploy/index.md#node) DataSphere. Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **Каталог** — каталог, в котором создан [проект](../../../datasphere/concepts/project.md) DataSphere и развернута нода.
        * **Идентификатор ноды** — идентификатор ноды DataSphere.
    1. Нажмите кнопку **Добавить**.

{% endlist %}

В поле **Спецификация** отобразится OpenAPI-спецификация с указанными значениями параметров.

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:cloud_datasphere](../../concepts/extensions/datasphere.md)