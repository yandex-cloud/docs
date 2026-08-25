---
title: Как удалить подсеть
description: Следуя данной инструкции, вы сможете удалить подсеть.
---

# Удалить подсеть

{% note alert %}

Перед удалением [подсети](../concepts/network.md#subnet) необходимо отключить от нее все ресурсы.
После удаления подсеть невозможно восстановить.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить подсеть.
  1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной подсети и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления подсети:

      ```bash
      yc vpc subnet delete --help
      ```

  1. Получите список всех подсетей в каталоге по умолчанию:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```text
      +----------------------+-----------------------+------------------------+
      |          ID          |         NAME          | ... |       RANGE      |
      +----------------------+-----------------------+------------------------+
      ...
      | e2l0psbfoloe******** | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной подсети.
  1. Удалите подсеть из каталога по умолчанию:

      ```bash
      yc vpc subnet delete test-subnet-1
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы удалить подсеть, созданную с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием подсети.

     {% cut "Пример описания подсети в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_vpc_subnet" "lab-subnet-a" {
       name           = "subnet-1"
	     description    = "My first subnet"
       v4_cidr_blocks = ["10.2.0.0/16"]
       zone           = "{{ region-id }}-a"
       network_id     = yandex_vpc_network.lab-net.id
     }
     ...
     ```

     {% endcut %}

  1. Примените конфигурацию:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc subnet list
     ```

- API {#api}

   Чтобы удалить [подсеть](../concepts/network.md#subnet), воспользуйтесь методом REST API [delete](../api-ref/Subnet/delete.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Delete](../api-ref/grpc/Subnet/delete.md) и передайте в запросе идентификатор удаляемой подсети в параметре `subnetId`.

   {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Примеры {#examples}

### Удаление подсети из указанного каталога {#from-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Удалите подсеть из другого каталога:

  ```bash
  yc vpc subnet delete test-subnet-2 --folder-id b1gnbfd11bq5********
  ```

  Где `--folder-id` — идентификатор каталога.

  ```bash
  yc vpc subnet delete test-subnet-2 --folder-name test-folder
  ```

  Где `--folder-name` — имя каталога.

  Идентификатор и имя можно передавать не только как позиционный аргумент, но и с помощью параметров `--id` и `--name`:

  ```bash
  yc vpc subnet delete --id enpavfmgapum********
  ```

  ```bash
  yc vpc subnet delete --name test-network-1
  ```

{% endlist %}

