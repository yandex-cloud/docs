# Создать рабочий процесс с помощью YaWL-спецификации

## Подготовить YaWL-спецификацию {#prepare-spec}

Сохраните [YaWL-спецификацию](../../../concepts/workflows/yawl/index.md) рабочего процесса в YAML-файле, например `yawl-spec.yaml`.

Пример спецификации:

```yaml
yawl: "0.1"
start: collect_info
steps:
  collect_info:
    parallel:
      branches:
        collect_users:
          start: fetch_users
          steps:
            fetch_users:
              httpCall:
                url: https://jsonplaceholder.typicode.com/users
                output: '\({users: .})'
        collect_posts:
          start: fetch_posts
          steps:
            fetch_posts:
              httpCall:
                url: https://jsonplaceholder.typicode.com/posts
                output: '\({posts: .})'
```


## Создать рабочий процесс {#create-workflow}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. В правом верхнем углу нажмите **Создать рабочий процесс**.
  1. Выберите способ `YaML-спецификация`.
  1. В редакторе кода опишите [YaWL-спецификацию](../../../concepts/workflows/yawl/index.md) рабочего процесса.
  1. Раскройте блок **Дополнительные параметры**:
     
     1. Введите имя и описание рабочего процесса. Требования к имени:
     
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
     
     1. (Опционально) [Добавьте](label-add.md) метки.
     1. (Опционально) [Укажите](network-add.md) облачную сеть.
     1. Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) или [создайте](../../../../iam/operations/sa/create.md) новый.
     
         Сервисному аккаунту должны быть назначены роли для доступа к закрытым ресурсам, которые используются в шагах рабочего процесса.
     
     1. (Опционально) [Настройте](logs-write.md) запись логов.
  1. Нажмите **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow create --help
      ```

  1. Создайте рабочий процесс:

      ```bash
      yc serverless workflow create \
        --yaml-spec <файл_спецификации> \
        --name <имя_рабочего_процесса> \
        --description "<описание_процесса>" \
        --labels <список_меток> \
        --network-id <идентификатор_сети> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--yaml-spec` — путь к файлу с [YaWL-спецификацией](../../../concepts/workflows/yawl/index.md) рабочего процесса. Например: `./yawl-spec.yaml`.
      * `--name` — имя рабочего процесса.
      * `--description` — описание рабочего процесса. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

      * `--network-id` — идентификатор облачной сети, в которой будет выполняться рабочий процесс. Необязательный параметр.
      * `--service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md).

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

  Чтобы создать [рабочий процесс](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [Create](../../../workflows/api-ref/Workflow/create.md) для ресурса [Workflows](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowService/Create](../../../workflows/api-ref/grpc/Workflow/create.md).

{% endlist %}