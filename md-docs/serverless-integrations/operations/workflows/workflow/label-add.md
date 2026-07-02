[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Управление рабочим процессом > Управлять метками > Добавить метку

# Добавить метку рабочему процессу

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором добавить метку [рабочему процессу](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Раскройте блок **Дополнительные параметры**:

      1. В поле **Метки** нажмите **Добавить метку**.
      1. Введите ключ и значение и нажмите **Enter**.

  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы добавить метку [рабочему процессу](../../../concepts/workflows/workflow.md), выполните команду:

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

  Чтобы добавить метку [рабочему процессу](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [Update](../../../workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../workflows/api-ref/grpc/Workflow/update.md).

{% endlist %}