# Загрузка аудитных логов {{ at-full-name }} в SIEM KUMA с помощью {{ TF }}

Чтобы настроить доставку файлов аудитных логов в [KUMA](https://www.kaspersky.ru/enterprise-security/unified-monitoring-and-analysis-platform):

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Смонтируйте бакет на сервере](#mount-bucket).
1. [Настройте коллектор KUMA](#setup-collector).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/audit-trails-events-to-kuma/paid-resources.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы создайть инфраструктуру с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Склонируйте репозиторий с конфигурационными файлами:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-audit-trails-kuma-integration
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `at-events-to-kuma.tf` — конфигурация создаваемой инфраструктуры.
          * `at-events-to-kuma.auto.tfvars` — пользовательские данные.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `at-events-to-kuma.tf`:

          {% cut "at-events-to-kuma.tf" %}

          {% include [at-events-to-kuma-tf-config](../../_includes/web/at-events-to-kuma-tf-config.md) %}

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `at-events-to-kuma.auto.tfvars`:

          {% cut "at-events-to-kuma.auto.tfvars" %}

          {% include [at-events-to-kuma-tf-variables](../../_includes/web/at-events-to-kuma-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
    * [Статический ключ доступа](../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key)
    * [Симметричный ключ шифрования](../../kms/concepts/key.md) — [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key)
    * [Роль](../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
    * [Бакет](../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket)
    * [Трейл](../../audit-trails/concepts/trail.md) — [yandex_audit_trails_trail]({{ tf-provider-resources-link }}/audit_trails_trail)
    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [Подсеть](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk)
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)

1. В файле `at-events-to-kuma.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя, который будет создан на ВМ, например `yc-user`.

        {% include [dont-use-root-name](../../_includes/dont-use-root-name.md) %}

    * `ssh_key_path` — путь к файлу с открытым SSH-ключом и его имя, например: `~/.ssh/id_ed25519.pub`. Пару SSH-ключей для подключения к ВМ по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
    * `bucket_name` —  [имя бакета](../../storage/concepts/bucket.md#naming), в который будут загружаться аудитные логи. Например `my-audit-logs-for-kuma`.

        {% include [bucket-name-note](../_tutorials_includes/audit-trails-events-to-kuma/bucket-name-note.md) %}

    * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет добавлен к именам объектов с аудитными логами в бакете. Например: `/`. Префикс участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога. 

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. Получите [идентификатор ключа](../../iam/concepts/authorization/access-key.md#key-id) и [секретный ключ](../../iam/concepts/authorization/access-key.md#private-key), которые понадобятся позднее при монтировании бакета на сервере:

    ```hcl
    terraform output access_key
    terraform output secret_key
    ```

    Результат:

    ```text
    "YCAJE0tO1Q4zO7bW4********"
    "YCNpH34y9fzL6xEap3wkuxYfkc1PTNvr********"
    ```

После создания инфраструктуры [cмонтируйте бакет на сервере](#mount-bucket) и [настройте коллектор KUMA](#setup-collector).


## Смонтируйте бакет на сервере {#mount-bucket}

{% include [about-server](../_tutorials_includes/audit-trails-events-to-kuma/about-server.md) %}

{% include [mount-bucket](../_tutorials_includes/audit-trails-events-to-kuma/mount-bucket.md) %}


## Настройте коллектор KUMA {#setup-collector}

{% include [setup-collector](../_tutorials_includes/audit-trails-events-to-kuma/setup-collector.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `at-events-to-kuma.tf` и удалите описание создаваемой инфраструктуры из файла.
1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты из созданного ранее бакета. Если этого не сделать, бакет и часть инфраструктуры не будут удалены, а команда `terraform apply` завершится ошибкой.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}