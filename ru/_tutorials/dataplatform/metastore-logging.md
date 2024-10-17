# Передача логов кластера {{ metastore-full-name }} в {{ cloud-logging-full-name }}

Вы можете настроить регулярный сбор логов, в которых собрана информация о работе [кластера {{ metastore-full-name }}](../../metadata-hub/concepts/metastore.md). Логи будут поставляться в пользовательскую [лог-группу](../../logging/concepts/log-group.md) в сервисе {{ cloud-logging-full-name }}.

Чтобы настроить передачу логов кластера {{ metastore-name }} в {{ cloud-logging-name }}:

1. [Создайте лог-группу](#create-log-group).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Назначьте сервисному аккаунту роль на каталог](#assign-role).
1. [Создайте кластер {{ metastore-name }}](#create-metastore).
1. [Проверьте передачу логов кластера в лог-группу](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Создайте лог-группу {#create-log-group}

{% list tabs group=instructions %}

* Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать лог-группу.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. Укажите имя `metastore-log-group`.
    1. Задайте срок хранения записей в лог-группе.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать лог-группу, выполните команду:

    ```bash
    yc logging group create \
       --name metastore-log-group \
       --retention-period <срок_хранения_записей>
    ```

    В результате будет создана группа с именем `metastore-log-group`.

    {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

* {{ TF }} {#tf}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. Опишите в конфигурационном файле параметры лог-группы:

        ```hcl
        resource "yandex_logging_group" "metastore-log-group" {
          name             = "metastore-log-group"
          folder_id        = "<идентификатор_каталога>"
          retention_period = "<срок_хранения_записей>"
        }
        ```

        Идентификатор каталога можно получить со [списком каталогов](../../resource-manager/operations/folder/get-id.md).

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

        Более подробную информацию о параметрах ресурса `yandex_logging_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/logging_group).

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

            ```bash
            terraform plan
            ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

    1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

            ```bash
            terraform apply
            ```

        1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

            После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

            ```bash
            yc logging group list
            ```

* API {#api}

    Чтобы создать лог-группу, воспользуйтесь методом REST API [create](../../logging/api-ref/LogGroup/create.md) для ресурса [LogGroup](../../logging/api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Create](../../logging/api-ref/grpc/LogGroup/create.md) и передайте в теле запроса:

    * Идентификатор каталога в параметре `folderId`. Идентификатор можно получить со [списком каталогов](../../resource-manager/operations/folder/get-id.md).
    * Имя лог-группы `metastore-log-group` в параметре `name`.
    * Срок хранения записей в лог-группе в параметре `retentionPeriod`.

        Значение можно указать только в секундах в формате `<число>s`. Если указать пустое значение или `0s`, срок хранения будет не ограничен.

{% endlist %}

## Создайте сервисный аккаунт {#create-service-account}

Используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), чтобы от его имени поставлять логи в {{ cloud-logging-name }}.

{% list tabs group=instructions %}

* Консоль управления {#console}

    Чтобы создать сервисный аккаунт:

    1. В консоли управления выберите каталог, в котором вы создали лог-группу.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Укажите имя сервисного аккаунта `metastore-logging-sa`.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

* CLI {#cli}

    Чтобы создать сервисный аккаунт, выполните команду:

    ```bash
    yc iam service-account create --name metastore-logging-sa
    ```

    Требования к имени:

    {% include [name-format](../../_includes/name-format.md) %}

* {{ TF }} {#tf}

    Чтобы создать сервисный аккаунт:

    1. Опишите в конфигурационном файле параметры сервисного аккаунта:

        ```hcl
        resource "yandex_iam_service_account" "sa" {
          name        = "metastore-logging-sa"
          folder_id   = "<идентификатор_каталога>"
        }
        ```

        Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account).

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

            ```bash
            terraform plan
            ```

        Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

    1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

            ```bash
            terraform apply
            ```

        1. Подтвердите создание сервисного аккаунта: введите в терминал слово `yes` и нажмите **Enter**.

            После этого будет создан сервисный аккаунт. Проверить появление сервисного аккаунта можно в консоли управления или с помощью команды CLI:

            ```bash
            yc iam service-account list
            ```

* API {#api}

    Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) и передайте в теле запроса:

    * идентификатор каталога в параметре `folderId`;
    * имя сервисного аккаунта `metastore-logging-sa` в параметре `name`.

{% endlist %}

## Назначьте сервисному аккаунту роль на каталог {#assign-role}

Назначьте сервисному аккаунту `metastore-logging-sa` роль [{{ roles.metastore.integrationProvider }}](../../metadata-hub/security/metastore-roles.md#managed-metastore-integrationProvider) на каталог. Она позволяет кластеру {{ metastore-name }} взаимодействовать с различными ресурсами {{ yandex-cloud }}, в том числе отправлять логи в {{ cloud-logging-name }}.

{% list tabs group=instructions %}

* Консоль управления {#console}

    Чтобы назначить роль:

    1. В консоли управления выберите нужный каталог.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. В открывшемся окне введите имя сервисного аккаунта `metastore-logging-sa` и выберите его.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль `{{ roles.metastore.integrationProvider }}`.
    1. Нажмите кнопку **Сохранить**.

* CLI {#cli}

    Чтобы назначить роль, выполните команду:

    ```bash
    yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
       --role {{ roles.metastore.integrationProvider }} \
       --subject serviceAccount:<идентификатор_сервисного_аккаунта>
    ```

    Идентификатор сервисного аккаунта можно получить со [списком сервисных аккаунтов](../../iam/operations/sa/get-id.md).

* {{ TF }} {#tf}

    Чтобы назначить роль:

    1. Опишите в конфигурационном файле параметры роли для сервисного аккаунта:

        ```hcl
        resource "yandex_resourcemanager_folder_iam_member" "managed-metastore-integration-provider" {
          folder_id   = "<идентификатор_каталога>"
          role        = "{{ roles.metastore.integrationProvider }}"
          member      = "serviceAccount:<идентификатор_сервисного_аккаунта>"
        }
        ```

        Идентификатор сервисного аккаунта можно получить со [списком сервисных аккаунтов](../../iam/operations/sa/get-id.md).

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

            ```bash
            terraform plan
            ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

            ```bash
            terraform apply
            ```

        1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

            После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в консоли управления или с помощью команды CLI:

            ```bash
            yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
            ```

* API {#api}

    Чтобы назначить роль, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) и передайте в теле запроса:

    * Значение `ADD` в параметре `accessBindingDeltas.action`, чтобы добавить роль.
    * Роль `{{ roles.metastore.integrationProvider }}` в параметре `accessBindingDeltas.accessBinding.roleId`.
    * Идентификатор сервисного аккаунта в параметре `accessBindingDeltas.accessBinding.subject.id`. Идентификатор можно получить со [списком сервисных аккаунтов](../../iam/operations/sa/get-id.md).
    * Значение `serviceAccount` в параметре `accessBindingDeltas.accessBinding.subject.type`, чтобы указать, что роль назначают сервисному аккаунту.

    В URL запроса укажите идентификатор нужного каталога.

{% endlist %}

## Создайте кластер {{ metastore-name }} {#create-metastore}

1. В подсети, к которой будет подключен кластер, [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md). Это нужно, чтобы кластер мог взаимодействовать с сервисами {{ yandex-cloud }}.
1. [Настройте группы безопасности](../../metadata-hub/operations/metastore/cluster-create.md#set-up-security-groups).
1. Создайте кластер {{ metastore-name }}:

    {% list tabs group=instructions %}

    * Консоль управления {#console}

        1. В консоли управления выберите нужный каталог.
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
        1. На левой панели выберите страницу ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
        1. Укажите имя кластера `metastore-cluster`.
        1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите `metastore-logging-sa`.
        1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть и подсеть с настроенным NAT-шлюзом.
        1. В блоке **{{ ui-key.yacloud.logging.label_title }}**:

            1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
            1. Чтобы логи записывались в пользовательскую лог-группу, выберите значение **{{ ui-key.yacloud.logging.label_loggroup }}** в поле **{{ ui-key.yacloud.logging.label_destination }}**.
            1. Укажите лог-группу `metastore-log-group`.
            1. Выберите минимальный уровень логирования.

                В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

## Проверьте передачу логов кластера в лог-группу {#check-result}

{% list tabs group=instructions %}

* Консоль управления {#console}

    1. В консоли управления перейдите в нужный каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Нажмите на строку с лог-группой `metastore-log-group`.

    На открывшейся странице отобразятся записи.

* CLI {#cli}

    Чтобы посмотреть записи в формате JSON, выполните команду:

    ```bash
    yc logging read --group-name=metastore-log-group --format=json
    ```

    Результат:

    ```text
    [
      {
        "uid": "488ece3c-75b8-4d35-95ac-2b49********",
        "resource": {},
        "timestamp": "2024-08-22T02:10:40Z",
        "ingested_at": "2024-08-22T08:49:15.716Z",
        "saved_at": "2024-08-22T08:49:16.176097Z",
        "level": "INFO",
        "message": "My message",
        "json_payload": {
          "request_id": "1234"
        }
      }
    ]
    ```

* API {#api}

    Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

{% endlist %}

Подробнее см. в разделе [{#T}](../../logging/operations/read-logs.md).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

* Вручную {#manual}

    Удалите:

    1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
    1. [Группу безопасности](../../vpc/operations/security-group-delete.md).
    1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
    1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
    1. [Кластер {{ metastore-name }}](../../metadata-hub/operations/metastore/cluster-delete.md).

* {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационные файлы с инфраструктурой, созданной для передачи логов кластера {{ metastore-name }}.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в удаленных конфигурационных файлах, будут удалены.

{% endlist %}
