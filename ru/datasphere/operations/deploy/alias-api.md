---
title: "Как отправить запрос в алиас в {{ ml-platform-full-name }}"
description: "Следуя данной инструкции, вы сможете отправить запрос в алиас."
---

# Отправить запрос в алиас

Тип запроса в [алиас](../../concepts/deploy/index.md#alias) зависит от вашей [ноды](../../concepts/deploy/index.md#node). Вы можете отправить тестовый запрос в интерфейсе, если в ответе ожидаете получить простые данные, например числа или строковые переменные.

Отправьте тестовый запрос в алиас из интерфейса {{ ml-platform-name }}:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Выберите алиас, к которому нужно отправить запрос.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}**:
   * В поле **Method** выберите тип запроса.
   * В поле **{{ ui-key.yc-ui-datasphere.common.input }}** введите входные переменные запроса в формате `{"a":2,"b":3}` и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.execute }}**.
1. Посмотрите результат обработки запроса в блоке **{{ ui-key.yc-ui-datasphere.common.response }}**.

{% note info %}

В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.curl }}** приведены примеры запросов в алиас для утилит cURL и gRPCurl.

{% endnote %}

Для отправки запросов в алиасы необходимо иметь роль `{{ roles-datasphere-user }}` или `{{ roles-datasphere-admin }}` на каталог, в котором созданы проект и алиас.

## Пример вызова gRPC API {#grpc-call-example}

Для отправки вызовов gRPC можно воспользоваться утилитой [gRPCurl](https://github.com/fullstorydev/grpcurl).

```bash
grpcurl \
  -H "Authorization: Bearer <IAM-токен>" \
  -d '{
  "folder_id": "<идентификатор_каталога>",
  "alias_name": "<имя_алиаса>",
  "input": { <входные_переменные> } \
  }' \
  datasphere.{{ api-host }}:443
yandex.cloud.datasphere.v1.NodeService/ExecuteAlias
```

Где:

* `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для аутентификации.
* `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и алиас.
* `<имя_алиаса>` — имя алиаса.
* `<входные_переменные>` — объект в формате `{"a":2,"b":3}`, в котором ключи соответствуют входным переменным.

В успешном ответе будет возвращен объект:

```json
{
   "output": {
      <выходные_переменные>
   }
}
```

## Пример запроса REST API {#rest-query-example}

Для отправки REST-запросов можно воспользоваться утилитой [cURL](https://curl.se).

```bash
curl \
   --header "x-node-alias: datasphere.user.<имя_алиаса>" \
   --header "Authorization: Bearer <IAM-токен>" \
   --header "x-folder-id: <идентификатор_каталога>" \
   --request <тип_запроса> \
   --data '<входные_переменные>' \
   https://node-api.datasphere.yandexcloud.net/
```

Где:

* `<имя_алиаса>` — имя алиаса.
* `<IAM-токен>` — IAM-токен для аутентификации.
* `<идентификатор_каталога>` — идентификатор каталога, в котором созданы проект и алиас.
* `<тип_запроса>` — тип запроса в алиас.
* `<входные_переменные>` — объект в формате `{"a":2,"b":3}`, в котором ключи соответствуют входным переменным.

В ответ возвращается JSON-объект с выходными переменными.
