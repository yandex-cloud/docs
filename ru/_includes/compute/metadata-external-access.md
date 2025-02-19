{% include [external-access-directories](./metadata/external-access-directories.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**, на странице **{{ ui-key.yacloud.compute.instances.label_title }}**, приводится список ВМ в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) с краткой информацией о них.

  Для получения подробной информации о ВМ нажмите на строку с ее именем.

  На вкладке:
  * **{{ ui-key.yacloud.common.overview }}** приводится общая информация о ВМ, в том числе [IP-адреса](../../vpc/concepts/address.md), присвоенные ВМ.
  * **{{ ui-key.yacloud.compute.instance.switch_disks }}** приводится информация о [дисках](../../compute/concepts/disk.md), подключенных к ВМ.
  * **{{ ui-key.yacloud.compute.instance.switch_file-storages }}** приводится информация о подключенных [файловых хранилищах](../../compute/concepts/filesystem.md).
  * **{{ ui-key.yacloud.common.operations-key-value }}** приводится список операций с ВМ и подключенными к ней ресурсами, например дисками.
  * **{{ ui-key.yacloud.common.monitoring }}** приводится информация о потреблении ресурсов на ВМ. Эту информацию можно получить только в консоли управления или изнутри ВМ.
  * **{{ ui-key.yacloud.compute.instance.switch_console }}** предоставлен доступ к [серийной консоли](../../compute/operations/serial-console/index.md), если при [создании](../../compute/operations/index.md#vm-create) ВМ вы разрешили к ней доступ.
  * **{{ ui-key.yacloud.compute.instance.switch_service-console }}** приводится информация, которую ВМ выводит в последовательный порт. Чтобы получить эту информацию через API или CLI, воспользуйтесь инструкцией [{#T}](../../compute/operations/vm-info/get-serial-port-output.md).

- CLI {#cli}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды для получения [вывода последовательного порта](../../compute/operations/vm-info/get-serial-port-output.md):

     ```bash
     yc compute instance get --help
     ```

  1. Выберите ВМ, например `first-instance`:

     {% include [compute-instance-list](../../compute/_includes_service/compute-instance-list.md) %}

  1. Получите основную информацию о ВМ:

     ```bash
     yc compute instance get first-instance
     ```

     Чтобы получить информацию о ВМ вместе с метаданными, используйте флаг `--full`:

     ```bash
     yc compute instance get --full first-instance
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

     ```hcl
     data "yandex_compute_instance" "my_instance" {
       instance_id = "<идентификатор_ВМ>"
     }

     output "instance_external_ip" {
       value = "${data.yandex_compute_instance.my_instance.network_interface.0.nat_ip_address}"
     }
     ```

     Где:
     * `data "yandex_compute_instance"` — описание источника данных для получения информации о ВМ:
       * `instance_id` — идентификатор ВМ.
     * `output "instance_external_ip"` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ, который будет выводиться в результате:
       * `value` — возвращаемое значение.

     Более подробную информацию о параметрах источника данных `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output instance_external_ip
     ```

     Результат:

     ```text
     instance_external_ip = "158.160.50.228"
     ```

- API {#api}

  Чтобы получить основную информацию о ВМ, воспользуйтесь методом REST API [get](../../compute/api-ref/Instance/get.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Get](../../compute/api-ref/grpc/Instance/get.md).

  Основная информация не включает пользовательские метаданные, которые были переданы при создании или [изменении](../../compute/operations/vm-control/vm-update.md) ВМ. Чтобы получить информацию вместе с метаданными, укажите в параметрах `view=FULL`.

{% endlist %}