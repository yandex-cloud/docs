---
title: Как изменить группы безопасности сетевого интерфейса виртуальной машины в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете изменить перечень групп безопасности, применяемых к сетевому интерфейсу виртуальной машины.
---

# Изменить группы безопасности сетевого интерфейса виртуальной машины

[Сетевому интерфейсу](../../concepts/network.md) ВМ можно назначить одновременно несколько [групп безопасности](../../../vpc/operations/security-group-create.md).

Перечень групп безопасности задается для каждого сетевого интерфейса отдельно. Если у ВМ несколько интерфейсов, изменения нужно вносить в каждый из них.

Как изменить имя, описание и метки ВМ читайте в разделе [{#T}](vm-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить перечень применяемых к виртуальной машине групп безопасности:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. Измените группы безопасности сетевого интерфейса ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**:
     * В правом верхнем углу блока нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
     * В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** добавьте или удалите применяемые к сетевому интерфейсу ВМ группы безопасности.
     * Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для обновления сетевого интерфейса ВМ:

     ```bash
     yc compute instance update-network-interface --help
     ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) нужной ВМ.

  1. Получите список сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

     ```bash
     yc compute instance get <идентификатор_ВМ>
     ```

     Результат:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:24:**:**:**
         subnet_id: e2lpp96bvvgp********
         primary_v4_address:
           address: 192.168.2.23
         security_group_ids:
           - enpe3m3fa8b1********
     ...
     ```

     Сохраните значение поля `index` — номер сетевого интерфейса, группы безопасности которого требуется изменить.

  1. Получите список групп безопасности в каталоге по умолчанию:

     ```bash
     yc vpc security-group list
     ```

     Результат:

     ```text
     +----------------------+----------------------+----------------------+-------------+
     |          ID          |         NAME         |      NETWORK-ID      | DESCRIPTION |
     +----------------------+----------------------+----------------------+-------------+
     | enpe3m3fa8b1******** | default-sg           | enpabce123hs******** |             |
     | enp1o8gm2n7t******** | web-sg               | enpabce123hs******** |             |
     +----------------------+----------------------+----------------------+-------------+
     ```

  1. Задайте новый перечень групп безопасности для выбранного сетевого интерфейса ВМ:

     ```bash
     yc compute instance update-network-interface \
       --id <идентификатор_ВМ> \
       --network-interface-index <номер_сетевого_интерфейса> \
       --security-group-id <идентификатор_группы_безопасности_1>,<идентификатор_группы_безопасности_2>
     ```

     Где:
     * `--id` — идентификатор виртуальной машины.
     * `--network-interface-index` — сохраненный ранее номер сетевого интерфейса ВМ.
     * `--security-group-id` — идентификаторы групп безопасности через запятую. Команда заменяет прежний перечень групп безопасности целиком, поэтому перечислите все группы, которые должны применяться к интерфейсу после изменения.

     Чтобы открепить от сетевого интерфейса все группы безопасности, выполните команду с параметром `--clear-security-groups`:

     ```bash
     yc compute instance update-network-interface \
       --id <идентификатор_ВМ> \
       --network-interface-index <номер_сетевого_интерфейса> \
       --clear-security-groups
     ```

     {% note alert %}

     Если к сетевому интерфейсу не привязана ни одна группа безопасности, трафик к ВМ и от нее не ограничивается.

     {% endnote %}

  1. Убедитесь, что перечень групп безопасности изменился:

     ```bash
     yc compute instance get <идентификатор_ВМ>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Чтобы изменить перечень групп безопасности сетевого интерфейса ВМ, задайте параметр `security_group_ids` в блоке `network_interface` нужного сетевого интерфейса в конфигурации ресурса `yandex_compute_instance`:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {
       ...
       network_interface {
         ...
         security_group_ids = [
           yandex_vpc_security_group.web-sg.id,
           "<идентификатор_группы_безопасности>"
         ]
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc compute instance get <идентификатор_ВМ>
     ```

- API {#api}

  Чтобы изменить перечень групп безопасности сетевого интерфейса ВМ, воспользуйтесь методом REST API [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateNetworkInterface](../../api-ref/grpc/Instance/updateNetworkInterface.md).

  В параметре `updateMask` укажите `securityGroupIds`, а в параметре `securityGroupIds` — полный перечень групп безопасности, которые должны применяться к интерфейсу после изменения.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../../vpc/concepts/security-groups.md)
* [{#T}](../../../vpc/operations/security-group-update.md)
* [{#T}](attach-network-interface.md)
