{% include [connect-sa-to-vm-intro](../../connect-sa-to-vm-intro.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите сервисный аккаунт с ролью `backup.editor`.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. Посмотрите описание команды для изменения ВМ:

      ```bash
      yc compute instance update --help
      ```

  1. Привяжите к ВМ сервисный аккаунт, выполнив команду:

      ```bash
      yc compute instance update <имя_или_идентификатор_ВМ> \
        --service-account-name <имя_сервисного_аккаунта>
      ```

      Где `--service-account-name` — имя сервисного аккаунта с ролью `backup.editor`.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      created_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      service_account_id: ajelprpohp7r********
      ...
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. В конфигурационном файле {{ TF }} в блоке с описанием ресурса `yandex_compute_instance` добавьте параметр `service_account_id` и укажите идентификатор сервисного аккаунта с ролью `backup.editor`:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        ...
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Воспользуйтесь методом REST API [update](../../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../../compute/api-ref/grpc/Instance/update.md). В запросе укажите идентификатор сервисного аккаунта с ролью `backup.editor`.

{% endlist %}

Подробности см. в разделе [{#T}](../../../compute/operations/vm-control/vm-update.md).