# Отправить запрос в ноду

Отправьте тестовый запрос в ноду из интерфейса {{ ml-platform-name }}:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **Ресурсы** выберите **Нода**.
1. Выберите ноду, к которой нужно отправить запрос.
1. Перейдите на вкладку **Запрос**.
1. В блоке **Создать тестовый запрос** в поле **Input** введите входные переменные запроса в формате `{"a":2,"b":3}` и нажмите кнопку **Выполнить**.
1. Посмотрите результат обработки запроса в блоке **Ответ**.

{% note info %}

В блоке **Запросы командной строки** приведены примеры запросов в ноду для утилит cURL и gRPCurl.

В блоке **Ответ сервера** приведены коды и описание ответов ноды.

{% endnote %}

Для отправки запросов в ноды необходимо иметь роль {{ roles-datasphere-user }} или {{ roles-datasphere-admin }} на каталог, в котором созданы проект и нода.

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