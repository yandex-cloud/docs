[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for GitLab](../../index.md) > [Пошаговые инструкции](../index.md) > Получение информации об инстансах

# Получение информации об инстансах Yandex Managed Service for GitLab

Вы можете получить детальную информацию о каждом созданном [инстансе GitLab](../../concepts/index.md#instance) в Yandex Cloud.

## Получить список инстансов в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Перейдите в сервис **Managed Service for&nbsp;GitLab**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить список доступных инстансов GitLab в каталоге по умолчанию, выполните команду:

    ```bash
    yc managed-gitlab instance list
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
    * `GITLAB VERSION` — версия GitLab.
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

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится инстанс GitLab.
  1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить детальную информацию об инстансе GitLab, выполните команду:

    ```bash
    yc managed-gitlab instance get <имя_или_идентификатор_инстанса>
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
    * `gitlab_version` — версия GitLab

    Имя и идентификатор инстанса можно запросить со [списком инстансов в каталоге](instance-list.md#list).  

    Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/get.md).

- Terraform

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию об инстансе GitLab с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_gitlab_instance" "gitlab_instance_by_id" {
        id = "<идентификатор_инстанса>"
      }

      output "instance_domain" {
        value = data.yandex_gitlab_instance.gitlab_instance_by_id.domain
      }
      ```

      Где:

      * `data "yandex_gitlab_instance"` — описание инстанса GitLab в качестве источника данных:
         * `id` — идентификатор инстанса GitLab.
      * `output "instance_domain"` — выходная переменная, которая содержит информацию о домене:
         * `value` — возвращаемое значение.

     Вместо `domain` вы можете выбрать любой другой параметр для получения информации. Подробнее о параметрах источника данных `gitlab_instance` в [документации провайдера](../../../terraform/data-sources/gitlab_instance.md).

  1. Примените конфигурацию:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform применит конфигурацию и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      instance_domain = example.gitlab.yandexcloud.net
      ```

- API {#api}

  Воспользуйтесь методом REST API [Get](../../api-ref/Instance/get.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Get](../../api-ref/grpc/Instance/get.md).

{% endlist %}

## Посмотреть список операций в инстансе {#list-operations}

В списке операций отображаются операции с инстансами и связанными ресурсами.

Все действия с инстансами Managed Service for GitLab сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список операций для конкретного инстанса:

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Инстансы**.
  1. Выберите нужный инстанс.
  1. Перейдите на панель ![image](../../../_assets/console-icons/list-check.svg) **Операции** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным инстансом.

{% endlist %}

## Получить подробную информацию об операции {#get-operation-info}

1. [Получите список операций](#list-operations) для инстанса.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      Результат:

      ```text
      id: c17de7epmui********
      description: Create automatic GitLab backup
      created_at: "2025-07-24T22:01:24.352Z"
      created_by: yc.managed-gitlab.serviceAccount
      modified_at: "2025-07-25T03:07:17.092Z"
      done: true
      metadata:
        '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
      response:
        '@type': type.googleapis.com/yandex.cloud.gitlab.v1.Instance
      ...
      ```

    - API {#api}

      Воспользуйтесь методом REST API [Get](../../api-ref/Operation/get.md) для ресурса [Operation](../../api-ref/Operation/index.md) или вызовом gRPC API [OperationService/Get](../../api-ref/grpc/Operation/get.md).

    {% endlist %}

#### Полезные ссылки {#see-also}

* [Работа с операциями](../../../api-design-guide/concepts/about-async.md)