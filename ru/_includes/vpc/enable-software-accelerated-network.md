# Включить программно ускоренную сеть

Вы можете включить [программно ускоренную сеть](../../vpc/concepts/software-accelerated-network.md) при создании или изменении [виртуальной машины](../../glossary/vm.md).

{% include [functional-agreement-required](../functional-agreement-required.md) %}

Чтобы включить программно ускоренную сеть на существующей ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и выберите нужную ВМ.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/stop.svg) **{{ ui-key.yacloud.common.stop }}** и подтвердите остановку ВМ.
  1. Подождите, пока ВМ перейдет в статус `Stopped`, и на панели сверху нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите опцию **{{ ui-key.yacloud.component.compute.resources.field_sw-accelerated-net }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.common.start }}** и подтвердите запуск.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

      ```bash
      yc compute instance update --help
      ```

  1. Получите список ВМ в каталоге по умолчанию:

      {% include [compute-instance-list](../../compute/_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ и остановите ее. Например, чтобы остановить ВМ с именем `first-instance`, выполните команду:

      ```bash
      yc compute instance stop first-instance
      ```

  1. Включите программно ускоренную сеть:

      1. Выполните команду:

          ```bash
          yc compute instance update first-instance \
            --network-settings type=software-accelerated
          ```

          Где `--network-settings` — параметр, который переключает тип сети.

          Результат:

          ```text
          id: fhm0b28lgfp4********
          folder_id: b1gbnv36zqf5********
          created_at: "2023-05-24T09:28:11Z"
          name: first-instance
          zone_id: {{ region-id }}-a
          platform_id: standard-v3
          resources:
            memory: "2147483648"
            cores: "2"
            core_fraction: "100"
          status: STOPPED
          ...
          network_settings:
            type: SOFTWARE_ACCELERATED
          placement_policy: {}
          ```

      1. Запустите ВМ:

          ```bash
          yc compute instance start first-instance
          ```

  Чтобы выключить программно ускоренную сеть, остановите ВМ и выполните команду:

    ```bash
    yc compute instance update first-instance \
      --network-settings type=standard
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  Чтобы включить программно ускоренную сеть для ВМ:

  1. В конфигурационном файле в описании ресурса `yandex_compute_instance` добавьте параметр `network_acceleration_type`:

     ```hcl
     resource "yandex_compute_instance" "example" {
       ...
       network_acceleration_type = "software_accelerated"
       ...
     }
     ```

     Где `network_acceleration_type` — тип ускорения сети. Возможные значения:
     * `software_accelerated` — программно ускоренная сеть;
     * `standard` — обычная сеть. Укажите это значение, чтобы выключить программно ускоренную сеть.

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Воспользуйтесь методом REST API [update](../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../compute/api-ref/grpc/Instance/update.md).

    Для включения программно ускоренной сети передайте в теле запроса параметр `networkSettings.type` со значением `SOFTWARE_ACCELERATED`, для выключения — со значением `STANDARD`.

{% endlist %}
