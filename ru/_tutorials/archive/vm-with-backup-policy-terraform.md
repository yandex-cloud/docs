# Автоматическая привязка политики резервного копирования {{ backup-full-name }} к ВМ с помощью {{ TF }}


Чтобы создать виртуальную машину с автоматической привязкой к политике резервного копирования {{ backup-name }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Активируйте сервис](#service-activate).
1. [Создайте инфраструктуру](#deploy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-with-backup-policy/paid-resources.md) %}

## Активируйте сервис {#service-activate}

{% include [service-activate](../_tutorials_includes/vm-with-backup-policy/service-activate.md) %}

## Создайте инфраструктуру {#deploy}

{% note info %}

Привязка политики резервного копирования {{ backup-full-name }} к ВМ доступна для [{{ TF }}-провайдера]({{ tf-provider-link }}/) `0.127.0` и более поздних версий.

{% endnote %}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-baas-backup-policy-auto-binding
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `backup-policy-auto-binding-config.tf` — конфигурация создаваемой инфраструктуры.
          * `cloud-init.yaml` — файл метаданных ВМ.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке:

          1. Конфигурационный файл `backup-policy-auto-binding-config.tf`:

            {% cut "backup-policy-auto-binding-config.tf" %}

            {% include [backup-policy-auto-binding-config](../../_includes/backup/backup-policy-auto-binding-config.md) %}

            {% endcut %}

          1. Файл метаданных ВМ `cloud-init.yaml`:

            {% cut "cloud-init.yaml" %}

            ```yaml
            #cloud-config
            datasource:
             Ec2:
              strict_id: false
            ssh_pwauth: no
            users:
            - name: <имя_пользователя>
              sudo: ALL=(ALL) NOPASSWD:ALL
              shell: /bin/bash
              ssh_authorized_keys:
              - <публичный_ssh_ключ>
            packages:
              - curl
              - perl
              - jq
            runcmd:
              - curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
            ```

            {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Назначение [роли](../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Сеть](../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсеть](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группа безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * Данные [образа ВМ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-datasources-link }}/compute_image).
    * Загрузочный [диск](../../compute/concepts/disk.md) виртуальной машины — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Политика резервного копирования](../../backup/concepts/policy.md) — [yandex_backup_policy]({{ tf-provider-resources-link }}/backup_policy). Вы можете создать новую или использовать одну из политик, автоматически созданных при активации сервиса.
    * Привязка политики резервного копирования к ВМ — [yandex_backup_policy_bindings]({{ tf-provider-resources-link }}/backup_policy_bindings). Чтобы привязать к ВМ одну из политик, автоматически созданных при активации сервиса, [получите](../../backup/operations/policy-vm/get-info.md) ее идентификатор.

1. В файле `cloud-init.yaml` задайте пользовательские параметры:

    * `name` — имя пользователя ВМ, например `vm-user`.
    * `ssh_authorized_keys` — содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [installation-note](../_tutorials_includes/vm-with-backup-policy/installation-note.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `backup-policy-auto-binding.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}