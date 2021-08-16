# Изменить ресурсную запись

Вы можете изменить значение [ресурсной записи](../concepts/resource-record.md). Чтобы изменить запись:

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ dns-name }}** в каталоге, где находится зона DNS, в которой требуется изменить запись.
  1. Выберите зону из списка.
  1. В меню слева нажмите **Записи**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке записи, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **Редактировать**.
  1. Измените TTL или значение записи.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить зону DNS:

  1. Посмотрите описание команды CLI для изменения записи:

     ```
     yc dns zone replace-records --help
     ```

  1. Измените значение записи:

     ```
     yc dns zone replace-records --name <имя зоны> \
     --record "<доменное имя записи> 600 <тип записи> <новое значение записи>"
     ```

- Terraform

  Подробнее о Terraform [читайте в документации](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить DNS запись, созданную с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием DNS записи.

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

     Проверить изменение DNS записи можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone list-records <имя зоны DNS>
     ```

{% endlist %}






