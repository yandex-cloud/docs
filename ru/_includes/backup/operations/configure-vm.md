{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. Добавьте группу безопасности в [сетевой интерфейс](../../../compute/concepts/network.md) ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**:

     * В правом верхнем углу блока нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
     * В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** добавьте созданную ранее группу безопасности.
     * Нажмите **{{ ui-key.yacloud.common.save }}**.

  1. Если у ВМ нет [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), то в секции **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. В открывшемся окне:

      * В поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** выберите `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, чтобы автоматически получить IP-адрес, или `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, чтобы выбрать зарезервированный адрес из списка.
      * (Опционально) Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, включите опцию **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. Подробнее см. в разделе [{#T}](../../../vpc/ddos-protection/index.md).
      * Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, выберите IP-адрес, который хотите привязать к ВМ. IP-адрес и ВМ должны находиться в одной зоне доступности.
      * Нажмите **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. Посмотрите описание команды для изменения [сетевого интерфейса](../../../compute/concepts/network.md) ВМ:

      ```bash
      yc compute instance update-network-interface --help
      ```

  1. Добавьте созданную ранее группу безопасности в сетевой интерфейс ВМ:

      ```bash
      yc compute instance update-network-interface \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса> \
        --security-group-id <идентификатор_группы_безопасности>
      ```

      Где:

      * `--id` — идентификатор ВМ.
      * `--network-interface-index` — номер сетевого интерфейса, например `0`.
      * `--security-group-id` — идентификатор группы безопасности.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

  1. Посмотрите описание команды для привязки публичного IP-адреса к ВМ:

      ```bash
      yc compute instance add-one-to-one-nat --help
      ```

  1. Если у ВМ нет [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), то привяжите его:

      ```bash
      yc compute instance add-one-to-one-nat \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса>
      ```

      Где:

      * `--id` — идентификатор ВМ.
      * `--network-interface-index` — номер сетевого интерфейса, например `0`.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. Откройте конфигурационный файл и в блоке с описанием ресурса `yandex_compute_instance` измените параметры [сетевого интерфейса](../../../compute/concepts/network.md) ВМ:

      ```hcl
      resource "yandex_compute_instance" "my-vm" {
      ...
        network_interface {
          ...
          security_group_ids = "<идентификатор_группы_безопасности>"
          nat                = true
          ...
        }
      ...
      }
      ```

      Где:

      * `yandex_compute_instance` — описание ВМ.
      * `network_interface` — настройки сетевого интерфейса ВМ.
      * `security_group_ids` — список идентификаторов групп безопасности.
      * `nat` — параметр, задающий привязку публичного IP-адреса к ВМ.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Чтобы добавить группу безопасности в [сетевой интерфейс](../../../compute/concepts/network.md) ВМ, воспользуйтесь методом REST API [updateNetworkInterface](../../../compute/api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateNetworkInterface](../../../compute/api-ref/grpc/Instance/updateNetworkInterface.md).

  Чтобы привязать [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) к ВМ, воспользуйтесь методом REST API [addOneToOneNat](../../../compute/api-ref/Instance/addOneToOneNat.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AddOneToOneNat](../../../compute/api-ref/grpc/Instance/addOneToOneNat.md).

{% endlist %}

Подробности см. в разделах [{#T}](../../../compute/operations/vm-control/vm-change-security-groups-set.md) и [{#T}](../../../compute/operations/vm-control/vm-attach-public-ip.md).