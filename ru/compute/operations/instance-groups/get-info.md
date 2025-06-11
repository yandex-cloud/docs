# Получить информацию о группе виртуальных машин

После создания [группы ВМ](../../concepts/instance-groups/index.md) вы можете получить основную информацию о группе.

Пользовательские [метаданные](../../concepts/vm-metadata.md), которые были переданы при создании или изменении группы ВМ, можно получить только с помощью [CLI](../../../cli/) или API.

Чтобы получить информацию о группе ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Нажмите на имя нужной группы ВМ.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о группе ВМ:

     ```bash
     {{ yc-compute-ig }} get --help
     ```

  1. Получите список групп ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы ВМ, например `first-instance-group`.
  1. Получите информацию о группе ВМ:

     ```bash
     {{ yc-compute-ig }} get --name first-instance-group
     ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о группе ВМ с помощью {{ TF }}:
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

     ```hcl
     data "yandex_compute_instance_group" "my_group" {
       instance_group_id = "<идентификатор_группы_ВМ>"
     }

     output "instancegroupvm_external_ip" {
       value = "${data.yandex_compute_instance_group.my_group.instances.*.network_interface.0.nat_ip_address}"
     }
     ```

     Где:
     * `data "yandex_compute_instance_group"` — описание источника данных для получения информации о группе ВМ:
       * `instance_group_id` — идентификатор группы ВМ.
     * `output "instancegroupvm_external_ip"` — список всех [публичных IP-адресов](../../../vpc/concepts/address.md#public-addresses) ВМ из группы, который будет выводиться в результате:
       * `value` — возвращаемое значение.

     Более подробную информацию о параметрах источника данных `yandex_compute_instance_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance_group).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output instancegroupvm_external_ip
     ```

     Результат:

     ```text
     instancegroupvm_external_ip = tolist([
       "158.160.112.7",
       "158.160.2.119",
     ])
     ```

- API {#api}

  Воспользуйтесь методом REST API [get](../../instancegroup/api-ref/InstanceGroup/get.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Get](../../instancegroup/api-ref/grpc/InstanceGroup/get.md).

  Список доступных групп ВМ запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}