# Добавить расширение x-yc-apigateway-integration:serverless_containers

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/serverless-containers.svg).
    1. Укажите в поле:

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.path_name }}** — относительный путь к интеграции, который будет добавлен к URL-адресу {{ api-gw-name }}. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее см. спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_method_name }}** — метод, который будет использоваться для взаимодействия с интеграцией.

        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}** — сервисный аккаунт для авторизации при обращении к контейнеру. Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.serverless_containers_container_id_name }}** — идентификатор контейнера. Чтобы узнать его, [получите информацию о контейнере](../../../serverless-containers/operations/container-info.md).
    1. (Опционально) Вставьте или загрузите контекст операции — произвольный объект в формате YAML или JSON.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** отобразится OpenAPI-спецификация с указанными значениями параметров.

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:serverless_containers](../../concepts/extensions/containers.md)