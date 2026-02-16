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
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется удалить облачную сеть.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной сети и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [облачных сетей](../concepts/network.md#network):

      ```
      yc vpc network delete --help
      ```

  1. Получите список всех сетей в каталоге по умолчанию:

      ```
      yc vpc network list
      ```
      
      Результат:
      ```
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpiuvhhd4t8******** | test-network-1 |
      | enplom7a98s1******** | default        |
      +----------------------+----------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Удалите сеть:

      ```
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

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

     ```
     yc vpc network list
     ```

- API {#api}

   Чтобы удалить [облачную сеть](../concepts/network.md), воспользуйтесь методом REST API [delete](../api-ref/Network/delete.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Delete](../api-ref/grpc/Network/delete.md) и передайте в запросе идентификатор удаляемой облачной сети в параметре `networkId`.

   {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
