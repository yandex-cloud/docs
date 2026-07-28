---
title: Как изменить диапазоны адресов подсети в {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете добавить диапазон адресов в подсеть или удалить его.
---

# Изменить диапазоны адресов подсети

У [подсети](../concepts/network.md#subnet) может быть несколько диапазонов адресов. Диапазоны задаются при [создании подсети](subnet-create.md), а затем их можно добавлять и удалять отдельными операциями, не пересоздавая подсеть.

Так делают, когда адресов в подсети перестает хватать: вместо создания новой подсети в ту же добавляют еще один диапазон.

Требования к диапазонам:

* Используются только частные IPv4-адреса из диапазонов, определенных в [RFC 1918](https://tools.ietf.org/html/rfc1918).
* Максимальный размер диапазона — `/16`, минимальный — `/28`.
* Диапазоны подсетей в пределах одной облачной сети не должны пересекаться.

Подробнее читайте в разделе [{#T}](../concepts/network.md#subnet).

{% note info %}

Перед удалением диапазона убедитесь, что из него не занят ни один адрес: иначе ресурсы, которым назначены адреса из этого диапазона, потеряют связность. Посмотреть занятые адреса можно по инструкции [{#T}](subnet-used-addresses.md).

{% endnote %}

## Добавить диапазон {#add}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления диапазона:

     ```bash
     yc vpc subnet add-range --help
     ```

  1. Получите список подсетей в каталоге по умолчанию:

     ```bash
     yc vpc subnet list
     ```

  1. Добавьте диапазон, указав имя или идентификатор подсети:

     ```bash
     yc vpc subnet add-range <имя_подсети> \
       --range <диапазон_адресов>
     ```

     Где `--range` — добавляемый диапазон в нотации CIDR, например `192.168.1.0/24`. Чтобы добавить несколько диапазонов, перечислите их через запятую.

     Результат:

     ```text
     id: e2l2prrbkbim********
     folder_id: b1g6ci08ma55********
     created_at: "2018-10-24T13:54:10Z"
     name: test-subnet-1
     network_id: enplom7a98s1********
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 192.168.0.0/24
     - 192.168.1.0/24
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте новый диапазон в параметр `v4_cidr_blocks` ресурса `yandex_vpc_subnet`:

     ```hcl
     resource "yandex_vpc_subnet" "lab-subnet-a" {
       name           = "<имя_подсети>"
       zone           = "{{ region-id }}-a"
       network_id     = yandex_vpc_network.lab-net.id
       v4_cidr_blocks = ["192.168.0.0/24", "192.168.1.0/24"]
     }
     ```

     Подробнее о параметрах ресурса `yandex_vpc_subnet` читайте в [документации провайдера]({{ tf-provider-resources-link }}/vpc_subnet).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить результат можно в [консоли управления]({{ link-console-main }}) или командой CLI:

     ```bash
     yc vpc subnet get <имя_подсети>
     ```

- API {#api}

  Воспользуйтесь методом REST API [addCidrBlocks](../api-ref/Subnet/addCidrBlocks.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/AddCidrBlocks](../api-ref/grpc/Subnet/addCidrBlocks.md) и передайте в запросе:

  * идентификатор подсети в параметре `subnetId`;

    {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

  * добавляемые диапазоны в параметре `v4CidrBlocks`.

  Метод запускает асинхронную операцию: результат приходит не сразу, а состояние операции можно отслеживать по ее идентификатору.

{% endlist %}

## Удалить диапазон {#remove}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления диапазона:

     ```bash
     yc vpc subnet remove-range --help
     ```

  1. Убедитесь, что из удаляемого диапазона не занят ни один адрес:

     ```bash
     yc vpc subnet list-used-addresses --name <имя_подсети>
     ```

  1. Удалите диапазон:

     ```bash
     yc vpc subnet remove-range <имя_подсети> \
       --range <диапазон_адресов>
     ```

     Где `--range` — удаляемый диапазон в нотации CIDR. Чтобы удалить несколько диапазонов, перечислите их через запятую.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите ненужный диапазон из параметра `v4_cidr_blocks` ресурса `yandex_vpc_subnet`.
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

  Воспользуйтесь методом REST API [removeCidrBlocks](../api-ref/Subnet/removeCidrBlocks.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/RemoveCidrBlocks](../api-ref/grpc/Subnet/removeCidrBlocks.md) и передайте в запросе:

  * идентификатор подсети в параметре `subnetId`;

    {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

  * удаляемые диапазоны в параметре `v4CidrBlocks`.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](subnet-create.md)
* [{#T}](subnet-update.md)
* [{#T}](subnet-used-addresses.md)
* [{#T}](../concepts/network.md)
