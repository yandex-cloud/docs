# Запросы в ноды, созданные из ячейки с кодом на Python

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Для отправки запросов в ноды необходимо иметь роль {{ roles-datasphere-user }} или {{ roles-datasphere-admin }} на каталог, в котором созданы проект и нода.

{% include [datasphere-api-auth](../../_includes/datasphere/datasphere-api-auth.md) %}

## Пример запросов gRPC API

```bash
grpcurl -H "Authorization: Bearer <iam_token>" \
  -d '{
  "folder_id": "<folder_id>",
  "node_id": "<node_id>",
  "input": { <input_variables> } \
  }' \
  datasphere.{{ api-host }}:443
yandex.cloud.datasphere.v1.NodeService/Execute
```

* `<iam_token>` — IAM-токен для аутентификации;
* `<folder_id>` — идентификатор каталога, в котором созданы проект и нода;
* `<node_id>` — идентификатор ноды;
* `<input_variables>` — объект, в котором ключи соответствуют входным переменным.

В успешном ответе будет возвращен объект:

```
{
   "output": {
      <output_variables>
   }
}
```

* `output_variables` — объект, в котором ключи соответствуют выходным переменным.

## Пример запросов REST API

Для отправки REST-запросов можно воспользоваться утилитой [cURL](https://curl.se).

```bash
curl https://datasphere.{{ api-host }}/datasphere/v1/nodes/<node_id>:execute \
   -X POST \
   -H "Authorization: Bearer <iam_token>"
   -d '{
      "folder_id": "<folder_id>",
      "node_id": "<node_id>",
      "input": { <input_variables> }
   }'
```

* `<iam_token>` — IAM-токен для аутентификации;
* `<folder_id>` — идентификатор каталога, в котором созданы проект и нода;
* `<node_id>` — идентификатор ноды;
* `<input_variables>` — объект, в котором ключи соответствуют входным переменным.

В ответ возвращается JSON-объект с выходными переменными.