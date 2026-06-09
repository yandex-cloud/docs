# Изменить метку рабочего процесса

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить метку [рабочего процесса](../../../concepts/workflows/workflow.md), выполните команду:

  {% note warning %}
  
  Существующий набор меток (`labels`) полностью перезаписывается набором, переданным в запросе.
  
  {% endnote %}

  ```bash
  yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
    --yaml-spec <файл_спецификации> \
    --labels <список_меток>
  ```

  Где:

  * `--yaml-spec` — путь к файлу с [YaWL-спецификацией](../../../concepts/workflows/yawl/index.md) рабочего процесса. Например: `./yawl-spec.json`.
  * `--labels` — список меток. Вы можете указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

  Результат:

  ```text
  id: dfqjl5hh5p90********
  folder_id: b1g681qpemb4********
  specification:
    spec_yaml: "yawl: ..."
  created_at: "2025-03-11T09:27:51.691990Z"
  name: my-workflow
  description: created via cli
  labels:
    owner: "admin"
    version: "alpha"
  status: ACTIVE
  log_options: {}
  service_account_id: aje4tpd9coa********
  network_id: enpm8v48ehcl********
  ```

- API {#api}

  Чтобы изменить метку [рабочего процесса](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [Update](../../../workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../workflows/api-ref/grpc/Workflow/update.md).

{% endlist %}