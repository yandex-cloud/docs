{% note info %}

К виртуальной машине можно привязать только один сервисный аккаунт.

{% endnote %}

Чтобы привязать сервисный аккаунт к ВМ, необходимо иметь разрешение на использование этого аккаунта. Это разрешение входит в роли [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../iam/roles-reference.md#editor) и выше.

### К существующей ВМ {#link-with-exist-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите один из существующих сервисных аккаунтов или создайте новый.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Обновите параметры ВМ, указав сервисный аккаунт с помощью опции `--service-account-name` или `--service-account-id`:

  ```bash
  yc compute instance update my-instance --service-account-name test
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }}, в котором описана ВМ, к которой вы хотите подключить сервисный аккаунт. См. [пример конфигурационного файла ВМ](../../compute/operations/vm-create/create-linux-vm.md#tf_1).
  1. В блок с описанием ресурса `yandex_compute_instance` добавьте параметр `service_account_id` и укажите идентификатор сервисного аккаунта:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        ...
      }
      ```

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} измениn все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Воспользуйтесь методом REST API [update](../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../compute/api-ref/grpc/Instance/update.md). В запросе укажите идентификатор сервисного аккаунта.

{% endlist %}

### К создаваемой ВМ {#link-with-new-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В консоли управления вы можете привязать к виртуальной машине сервисный аккаунт, расположенный в том же [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается ВМ. Если сервисный аккаунт расположен в другом каталоге, воспользуйтесь CLI или API.

  Чтобы привязать сервисный аккаунт к ВМ, выберите его в блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**  в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** при [создании ВМ](../../compute/operations/index.md#vm-create). Вы можете выбрать один из существующих сервисных аккаунтов или создать новый.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Создайте ВМ, указав сервисный аккаунт с помощью опции `--service-account-name` или `--service-account-id`:

  ```bash
  yc compute instance create \
    --name my-instance \
    --network-interface subnet-name=default,nat-ip-version=ipv4 \
    --ssh-key ~/.ssh/id_ed25519.pub \
    --service-account-name my-robot
  ```

- {{ TF }} {#tf}

  1. Откройте конфигурационный файл {{ TF }}, в котором описана ВМ, к которой вы хотите подключить сервисный аккаунт. См. [пример конфигурационного файла ВМ](../../compute/operations/vm-create/create-linux-vm.md#tf_1).
  1. В блок с описанием ресурса `yandex_compute_instance` добавьте параметр `service_account_id` и укажите идентификатор сервисного аккаунта:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        ...
      }
      ```

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md). В запросе укажите идентификатор сервисного аккаунта.

{% endlist %}