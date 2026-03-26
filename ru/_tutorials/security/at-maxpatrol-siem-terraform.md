# Загрузка аудитных логов в MaxPatrol SIEM с помощью {{ TF }}


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) позволяет читать [аудитные логи](../../audit-trails/concepts/events.md) {{ yandex-cloud }} из потока данных [{{ yds-full-name }}](../../data-streams/index.yaml). Для полного прохождения руководства у вас должен быть доступ к экземпляру MaxPatrol SIEM.

Чтобы настроить экспорт аудитных логов с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните инфраструктуру, необходимую для загрузки аудитных логов в MaxPatrol SIEM](#deploy).
1. [Настройте в MaxPatrol SIEM задачу по сбору данных из потока {{ yds-name }}](#configure-maxpatrol).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/at-maxpatrol-siem/paid-resources.md) %}

## Разверните инфраструктуру, необходимую для загрузки аудитных логов в MaxPatrol SIEM {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-export-audit-logs-maxpatrol
         ```

      1. Перейдите в папку с репозиторием. В ней должны появиться следующие файлы:
          * `audit-trails-maxpatrol-export.tf` — файл конфигурации создаваемой инфраструктуры.
          * `audit-trails-maxpatrol-export.auto.tfvars` — файл со значениями пользовательских переменных.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов и в этой папке:

          1. Создайте конфигурационный файл `audit-trails-maxpatrol-export.tf`:

              {% cut "**audit-trails-maxpatrol-export.tf**" %}

              {% include [audit-trails-maxpatrol-export-config](../_tutorials_includes/at-maxpatrol-siem/audit-trails-maxpatrol-export-config.md) %}

              {% endcut %}

          1. Создайте файл с пользовательскими данными `audit-trails-maxpatrol-export.auto.tfvars`:

              **audit-trails-maxpatrol-export.auto.tfvars**

              ```hcl
              folder_id       = "<идентификатор_каталога>"
              organization_id = "<идентификатор_организации>"
              ```

    {% endlist %}

    Более подробную информацию о параметрах используемых в {{ TF }} ресурсов см. в документации провайдера:

    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Роль](../../iam/concepts/access-control/roles.md), назначенная сервисному аккаунту на каталог — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * Роль, назначенная сервисному аккаунту на организацию — [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding).
    * [Статический ключ доступа](../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Бессерверная база данных YDB](../../ydb/concepts/serverless-and-dedicated.md#serverless) — [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless).
    * [Поток данных {{ yds-full-name }}](../../data-streams/concepts/glossary.md#stream-concepts) — [yandex_ydb_topic]({{ tf-provider-resources-link }}/ydb_topic).
    * [Трейл](../../audit-trails/concepts/trail.md) — [yandex_audit_trails_trail]({{ tf-provider-resources-link }}/audit_trails_trail).

1. В файле `audit-trails-maxpatrol-export.auto.tfvars` задайте значения пользовательских переменных:
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `organization_id` — [идентификатор организации](../../organization/operations/organization-get-id.md), в которой создается трейл и где будут собираться аудитные логи.

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

    В результате в выбранном каталоге будет создана и настроена вся необходимая инфраструктура.

1. Получите идентификатор и секретный ключ статического ключа доступа, а также идентификатор созданной базы данных — они понадобятся позднее при настройке MaxPatrol SIEM. Для этого выполните команды:

    ```bash
    echo "Static access key: $(terraform output static-access-key)"
    echo "Secret key: $(terraform output static-secret-key)"
    echo "YDB database ID: $(terraform output database-id)"
    ```

    Результат:

    ```text
    Static access key: "YCAJEnmnfsV8GpAMk********"
    Secret key: "YCMVxx-n0t8Y6s48zJDdKw9lWMB1iGU-********"
    YDB database ID: "etnvs692elpn********"
    ```

## Настройте MaxPatrol SIEM {#configure-maxpatrol}

{% include [the-maxpatrol-part](../_tutorials_includes/at-maxpatrol-siem/the-maxpatrol-part.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `audit-trails-maxpatrol-export.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}