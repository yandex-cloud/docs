---
title: Добавить расширение {{ sw-full-name }}
description: Следуя данной инструкции, вы сможете добавить расширение {{ sw-full-name }} с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:http для интеграции с {{ sw-full-name }}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы [создать](../../operations/api-gw-create.md) новый.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/workflows.svg).
  1. Укажите в поле:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}** — сервисный аккаунт с ролью `serverless.workflows.executor` для [запуска рабочего процесса](../../../serverless-integrations/concepts/workflows/execution.md). Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
      * **Рабочий процесс** — имя [рабочего процесса](../../../serverless-integrations/concepts/workflows/workflow.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## Требования к структуре входящего запроса {#requirements}

Чтобы API-шлюз корректно обрабатывал входящие запросы, для них должно быть задано значение заголовка `Content-Type: application/json`.