[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Управление правами доступа к рабочему процессу > Посмотреть роли, назначенные на рабочий процесс

# Посмотреть роли, назначенные на рабочий процесс

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

{% note info %}

Роли, назначенные на каталог, облако или организацию, автоматически [наследуются](../../../../iam/concepts/access-control/index.md#inheritance) рабочими процессами Workflows. При этом они не отображаются в списке ролей, назначенных на них. Подробнее о [просмотре ролей](../../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы посмотреть роли, назначенные на [рабочий процесс](../../../concepts/workflows/workflow.md), выполните команду:

  ```bash
  yc serverless workflow list-access-bindings <имя_или_идентификатор_рабочего_процесса>
  ```

  Результат:

  ```text
  +---------------------------------+----------------+----------------------+
  |             ROLE ID             |  SUBJECT TYPE  |      SUBJECT ID      |
  +---------------------------------+----------------+----------------------+
  | serverless.workflows.admin      | serviceAccount | ajef2lm8ahpc******** |
  | serverless.workflows.viewer     | serviceAccount | rrbilgiqaptv******** |
  | serverless.workflows.executor   | userAccount    | aje9o8d241nl******** |
  +---------------------------------+----------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessBindings](../../../workflows/api-ref/Workflow/listAccessBindings.md) для ресурса [Workflow](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowService/ListAccessBindings](../../../workflows/api-ref/grpc/Workflow/listAccessBindings.md).

{% endlist %}