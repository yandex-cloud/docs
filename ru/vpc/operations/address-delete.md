# Удалить статический публичный IP-адрес

{% note alert %}

Перед удалением адрес необходимо освободить, удалив ресурс, к которому он привязан.
После удаления адрес невозможно восстановить.

{% endnote %}

{% list tabs %}

- Консоль управления
  
   Чтобы удалить [статический адрес](../concepts/address.md):
   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется удалить статический адрес.
   1. В списке сервисов выберите **{{ vpc-name }}**.
   1. На панели слева выберите ![image](../../_assets/vpc/ip-addresses.svg) **IP-адреса**.
   1. Нажмите значок ![image](../../_assets/options.svg) в строке адреса, который требуется удалить.
   1. В открывшемся меню нажмите кнопку **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.
  
- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы удалить статический IP-адрес:

   1. Просмотрите описание команды CLI для удаления адреса:

      ```bash
      yc vpc address delete --help
      ```

   1. Получите список адресов в каталоге по умолчанию:

      ```bash
      yc vpc address list
      ```

      Результат:

      ```bash
      +----------------------+------+----------------+----------+-------+
      |          ID          | NAME |    ADDRESS     | RESERVED | USED  |
      +----------------------+------+----------------+----------+-------+
      | e9b6un9gkso6stdh6b3p |      | 178.154.253.52 | true     | false |
      +----------------------+------+----------------+----------+-------+
      ```

   1. Удалите адрес, указав его ID:

      ```bash
      yc vpc address delete e9b6un9gkso6stdh6b3p
      ```

- API

  Чтобы удалить [статический адрес](../concepts/address.md), воспользуйтесь методом REST API [delete](../api-ref/Address/delete.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Delete](../api-ref/grpc/address_service.md#Delete).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить статический публичный IP-адрес, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием статического публичного IP-адреса.
     
     Пример описания статического публичного IP-адреса в конфигурации {{ TF }}:

     ```hcl
     ...
     resource "yandex_vpc_address" "addr" {
       name = "exampleAddress"
       external_ipv4_address {
         zone_id = "{{ region-id }}-a"
       }
     }
     ...
     ```

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

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc address list
     ```

{% endlist %}
