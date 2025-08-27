{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список функций.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы получить список функций, выполните команду:

  ```bash
  yc serverless function list
  ```

  Результат:

  ```text
  +----------------------+--------------------+----------------------+--------+
  |          ID          |        NAME        |      FOLDER ID       | STATUS |
  +----------------------+--------------------+----------------------+--------+
  | b097d9ous3ge******** | my-beta-function   | aoek49ghmknn******** | ACTIVE |
  +----------------------+--------------------+----------------------+--------+
  ```

- API {#api}

  Чтобы получить список функций, воспользуйтесь методом REST API [list](../../functions/functions/api-ref/Function/list.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/List](../../functions/functions/api-ref/grpc/Function/list.md).


{% endlist %}
