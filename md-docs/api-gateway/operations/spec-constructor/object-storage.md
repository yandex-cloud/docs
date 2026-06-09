# Добавить расширение x-yc-apigateway-integration:object_storage

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/object-storage.svg).
    1. Укажите в поле:

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.path_name }}** — относительный путь к интеграции, который будет добавлен к URL-адресу {{ api-gw-name }}. Переменные указывайте в фигурных скобках, например `/static/{function_id}`. Подробнее см. спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_method_name }}** — метод, который будет использоваться для взаимодействия с интеграцией.

        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}** — сервисный аккаунт для авторизации при обращении к {{ objstorage-name }}.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.object_storage_bucket_name }}** — имя [бакета](../../../storage/concepts/bucket.md).
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.object_storage_filename_name }}** — имя [объекта](../../../storage/concepts/object.md).
        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.object_storage_error_object_filename_name }}** — имя объекта, который будет возвращаться, если вместо указанного имени объекта получена ошибка с HTTP-кодом 4xx.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** отобразится OpenAPI-спецификация с указанными значениями параметров.

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:object_storage](../../concepts/extensions/object-storage.md)