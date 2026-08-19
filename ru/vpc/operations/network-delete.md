---
title: Как удалить облачную сеть
description: Следуя данной инструкции, вы сможете удалить облачную сеть.
---

# Удалить облачную сеть

{% note alert %}

Перед удалением сети из нее необходимо удалить все дочерние ресурсы.
После удаления сеть невозможно восстановить.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить [облачную сеть](../concepts/network.md#network):

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить облачную сеть.
  1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной сети и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [облачных сетей](../concepts/network.md#network):

     ```bash
     yc vpc network delete --help
     ```

  1. Получите список всех сетей в каталоге по умолчанию:

     ```bash
     yc vpc network list
     ```

     Результат:

     ```text
     +----------------------+----------------+
     |          ID          |      NAME      |
     +----------------------+----------------+
     | enpiuvhhd4t8******** | test-network-1 |
     | enplom7a98s1******** | default        |
     +----------------------+----------------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Удалите сеть:

     ```bash
     yc vpc network delete test-network-1
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы удалить [облачную сеть](../concepts/network.md#network), созданную с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием облачной сети.

     {% cut "Пример описания облачной сети в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_vpc_network" "default" {
       name        = "network-1"
       description = "My first network"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ...
     ```

     {% endcut %}

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

  ```bash
  yc vpc network list
  ```

- API {#api}

  Чтобы удалить [облачную сеть](../concepts/network.md), воспользуйтесь методом REST API [delete](../api-ref/Network/delete.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Delete](../api-ref/grpc/Network/delete.md) и передайте в запросе идентификатор удаляемой облачной сети в параметре `networkId`.

  {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
