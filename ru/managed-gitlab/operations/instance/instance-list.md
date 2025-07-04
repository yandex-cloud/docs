# Получение информации об инстансах

Вы можете получить детальную информацию о каждом созданном [инстансе {{ GL }}](../../concepts/index.md#instance) в {{ yandex-cloud }}.

## Получить список инстансов в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы получить список доступных инстансов {{ GL }} в каталоге по умолчанию, выполните команду:

    ```bash
    {{ yc-gl }} instance list
    ```

    Результат:

    ```bash
    +----------------------+-------+-------------------------------+---------------------+---------------------+----------------+---------+
    |          ID          | NAME  |            DOMAIN             |     CREATED AT      |     UPDATED AT      | GITLAB VERSION | STATUS  |
    +----------------------+-------+-------------------------------+---------------------+---------------------+----------------+---------+
    | c17gehgsk7gq******** | my-gl | domain.gitlab.yandexcloud.net | 2025-06-10 12:10:55 | 2025-06-10 12:10:55 | 17.11.2        | RUNNING |
    +----------------------+-------+-------------------------------+---------------------+---------------------+----------------+---------+
    ```

    Где:

    * `ID` — идентификатор инстанса.
    * `NAME` — имя инстанса.
    * `DOMAIN` — адрес инстанса в интернете.
    * `CREATED AT` — дата и время, когда инстанс был создан.
    * `UPDATED AT` — дата и время, когда инстанс был изменен.
    * `GITLAB VERSION` — версия {{ GL }}.
    * `STATUS` — статус инстанса. [Подробнее о возможных статусах](monitoring.md#statuses).

    Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/list.md).

- API {#api}

  Воспользуйтесь методом REST API [List](../../api-ref/Instance/list.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/List](../../api-ref/grpc/Instance/list.md).

{% endlist %}

## Получить детальную информацию об инстансе {#get}

Детальная информация об инстансе:
* Домен.
* Статус.
* Ресурсы — RAM, vCPU, размер диска.
* Логин и электронная почта администратора.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится инстанс {{ GL }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию об инстансе {{ GL }}, выполните команду:

    ```bash
    {{ yc-gl }} instance get <имя_или_идентификатор_инстанса>
    ```
    
    Результат:

    ```bash
    id: c17gehgsk7gq********
    folder_id: b1gutjgdvq50********
    created_at: "2025-06-10T12:10:55.902Z"
    updated_at: "2025-06-10T12:10:55.902Z"
    name: my-gl
    resource_preset_id: s2.micro
    disk_size: "32212254720"
    status: RUNNING
    admin_login: my-login
    admin_email: admin@mail.ru
    domain: domain.gitlab.yandexcloud.net
    subnet_id: e9bk8uu1lv1sg********
    backup_retain_period_days: "7"
    maintenance_delete_untagged: true
    deletion_protection: true
    approval_rules_id: NONE
    gitlab_version: 17.11.2
    ```

    Где:

    * `id` — идентификатор инстанса.
    * `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится инстанс.
    * `created_at` — дата и время, когда инстанс был создан.
    * `updated_at` — дата и время, когда инстанс был изменен.
    * `name` — имя инстанса.
    * `resource_preset_id` — идентификатор [типа инстанса](../../concepts/index.md#config).
    * `disk_size` — размер диска.
    * `status` — статус инстанса. [Подробнее о возможных статусах](monitoring.md#statuses).
    * `admin_login` — логин администратора.
    * `admin_email` — электронная почта администратора.
    * `domain` — адрес инстанса в интернете.
    * `subnet_id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet).
    * `backup_retain_period_days` — количество дней хранения резервных копий.
    * `maintenance_delete_untagged` — опция для удаления образов без тегов во время обслуживания. Возможные значения: `true` или `false`.
    * `deletion_protection` — защита инстанса от непреднамеренного удаления пользователем. Возможные значения: `true` или `false`.
    * `approval_rules_id` — правила ревью кода. [Подробнее о доступных конфигурациях правил](../../concepts/approval-rules.md#packages).
    * `gitlab_version` — версия {{ GL }}

    Имя и идентификатор инстанса можно запросить со [списком инстансов в каталоге](instance-list.md#list).  

    Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/get.md).

- API {#api}

  Воспользуйтесь методом REST API [Get](../../api-ref/Instance/get.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Get](../../api-ref/grpc/Instance/get.md).

{% endlist %}

## Посмотреть список операций в инстансе {#list-operations}

В списке операций отображаются операции с инстансами и связанными ресурсами.

Все действия с инстансами {{ mgl-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список операций для конкретного инстанса:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.gitlab.switch_instances }}**.
  1. Выберите нужный инстанс.
  1. Перейдите на панель ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным инстансом.

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../../api-design-guide/concepts/about-async.md)
