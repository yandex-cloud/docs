---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Удалить ресурсную запись

Чтобы удалить [ресурсную запись](../concepts/resource-record.md):

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ dns-name }}** в каталоге, где находится зона DNS из которой требуется удалить запись.
  1. Выберите зону из списка.
  1. В меню слева нажмите **Записи**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке записи, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления записей:

      ```
      yc dns zone delete-records --help
      ```
  1. Получите список всех записей в зоне:

      ```
      yc dns zone list-records --name <имя зоны DNS>
      ```
  1. Удалите запись:

     ```
     yc dns zone delete-records --name <имя зоны DNS> \
     --record "<доменное имя> <TTL> <тип записи> <значение>"
     ```

- Terraform

  Подробнее о Terraform [читайте в документации](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить из зоны DNS запись, созданную с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием DNS записи.
     
     {% cut "Пример описания DNS записи в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_dns_recordset" "rs1" {
       zone_id = yandex_dns_zone.zone1.id
       name    = "srv.example.com."
       type    = "A"
       ttl     = 200
       data    = ["10.1.0.1"]
     }
     ...
     ```

     {% endcut %}


  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите Enter.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone list-records <имя зоны DNS>
     ```

{% endlist %}
