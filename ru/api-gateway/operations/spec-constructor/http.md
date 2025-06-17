---
title: Добавить расширение Обращение по HTTP
description: Следуя данной инструкции, вы сможете добавить расширение Обращение по HTTP с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:http

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/http.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_url_name }}** — URL, по которому необходимо перенаправить вызов. Должен быть доступен из интернета.
        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_http_method_for_extension_name }}** — HTTP-метод, который будет использоваться для вызова. Если параметр не задан, используется метод, указанный в поле **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_method_name }}**.
        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_headers_name }}** — HTTP-заголовки, которые будут передаваться в запросе.

            Включите опцию **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_send_original_headers_name }}**. По умолчанию HTTP-заголовки исходного запроса не передаются.

        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_query_name }}** — query-параметры, которые будут передаваться в запросе.

            Включите опцию **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_send_original_query_params_name }}**. По умолчанию query-параметры исходного запроса не передаются.

        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_read_timeout_name }}** — таймаут чтения для выполнения вызова, в секундах.
        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_connect_timeout_name }}** — таймаут соединения для выполнения вызова, в секундах.
    1. (Опционально) Включите опцию **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_omit_empty_headers_name }}**. По умолчанию пустые заголовки передаются.
    1. (Опционально) Включите опцию **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_omit_empty_query_parameters_name }}**. По умолчанию пустые query-параметры передаются.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:http](../../concepts/extensions/http.md)
