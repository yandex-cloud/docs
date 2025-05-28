# Создать реестр

Использовать созданный [реестр](../../concepts/registry.md) могут все пользователи и [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md), у которых есть права на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder). 

Вы можете создать безопасный реестр с автоматическим сканированием с помощью [сканера уязвимостей](../../concepts/vulnerability-scanner.md).

{% note info %}

Сканирование Docker-образов на наличие уязвимостей [тарифицируется](../../pricing.md#scanner).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-registry-console](../../../_includes/container-registry/create-registry-console.md) %}

- CLI {#cli}

  {% include [create-registry-cli](../../../_includes/container-registry/create-registry-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  1. Добавьте в конфигурационный файл параметры реестра, который необходимо создать. Например, файл с названием `example.tf` в директории `~/cloud-terraform`:

     ```hcl
     resource "yandex_container_registry" "my-reg" {
       name = "my-registry"
       folder_id = "<идентификатор_каталога>"
       labels = {
         my-label = "my-label-value"
       }
     }
     ```

     Где:
     * `name` — имя реестра.
     * `folder_id` — идентификатор каталога.
     * `labels` — набор [меток](../../../resource-manager/concepts/labels.md).

     Более подробную информацию о ресурсах, которые можно создать с помощью {{ TF }}, смотрите в [документации провайдера]({{ tf-provider-link }}/).
  1. Проверьте корректность конфигурационного файла.
     1. В командной строке перейдите в директорию, где вы сохранили конфигурационный файл:

        ```bash
        cd /Users/<имя_пользователя>/cloud-terraform
        ```

     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Результат:

        ```text
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Создайте реестр.
     1. Выполните команду:

        ```bash
        terraform apply
        ```

        Результат:

        ```text
        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
          + create
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Подтвердите создание реестра. Для этого введите значение `yes` и нажмите **Enter**:

        ```bash
        Enter a value: yes
        ```

        Результат:

        ```text
        yandex_container_registry.default: Creating...
        yandex_container_registry.default: Creation complete after 4s [id=crpuljdfqoj3********]

        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
        ```

        В каталоге будет создан реестр с именем `my-registry`.
     1. Проверьте ресурсы и их настройки в [консоли управления]({{ link-console-main }}).

- API {#api}

  {% include [create-registry-api](../../../_includes/container-registry/create-registry-api.md) %}

{% endlist %}
