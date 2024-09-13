---
title: "Как отправить запрос в ноду в {{ ml-platform-full-name }}"
description: "Следуя данной инструкции, вы сможете отправить запрос в ноду."
---

# Отправить запрос в ноду

Отправьте тестовый запрос в [ноду](../../concepts/deploy/index.md#node) из интерфейса {{ ml-platform-name }}:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Выберите ноду, к которой нужно отправить запрос.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}** в поле **{{ ui-key.yc-ui-datasphere.common.input }}** введите входные переменные запроса в формате `{"a":2,"b":3}` и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.execute }}**.
1. Посмотрите результат обработки запроса в блоке **{{ ui-key.yc-ui-datasphere.common.response }}**.

{% note info %}

В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.curl }}** приведены примеры запросов в ноду для утилит cURL и gRPCurl.

В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.server-response }}** приведены коды и описание ответов ноды.

{% endnote %}

Для отправки запросов в ноды необходимо иметь [роль](../../security/index.md) `{{ roles-datasphere-user }}` или `{{ roles-datasphere-admin }}` на каталог, в котором созданы проект и нода.

## Пример вызова gRPC API {#grpc-call-example}

```bash
grpcurl -H "Authorization: Bearer <IAM-токен>" \
  -d '{
  "folder_id": "<идентификатор_каталога>",
  "node_id": "<идентификатор_ноды>",
  "input": { <входные_переменные> } \
  }' \
  datasphere.{{ api-host }}:443
yandex.cloud.datasphere.v1.NodeService/Execute
```

Где:

* `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для аутентификации.
* `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и нода.
* `<идентификатор_ноды` — идентификатор ноды.
* `<входные_переменные>` — объект, в котором ключи соответствуют входным переменным.

В успешном ответе будет возвращен объект:

```json
{
   "output": {
      <выходные_переменные>
   }
}
```

Где `<выходные_переменные>` — объект, в котором ключи соответствуют выходным переменным.

## Пример запроса REST API {#rest-query-example}

Для отправки REST-запросов можно воспользоваться утилитой [cURL](https://curl.se).

```bash
curl https://datasphere.{{ api-host }}/datasphere/v1/nodes/<идентификатор_ноды>:execute \
   -X POST \
   -H "Authorization: Bearer <IAM-токен>"
   -d '{
      "folder_id": "<идентификатор_каталога>",
      "node_id": "<идентификатор_ноды>",
      "input": { <входные_переменные> }
   }'
```

Где:

* `<IAM-токен>` — IAM-токен для аутентификации.
* `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и нода.
* `<идентификатор_ноды>` — идентификатор ноды.
* `<входные_переменные>` — объект, в котором ключи соответствуют входным переменным.

В ответ возвращается JSON-объект с выходными переменными.
