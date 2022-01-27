# Отключение ресурса

Чтобы остановить работу ресурса, вы можете отключить доступ конечных пользователей к контенту. Для этого:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ cdn-name }}**.

  1. На вкладке **CDN-ресурсы** нажмите на имя необходимого ресурса.

  1. В правом верхнем углу нажмите кнопку **Редактировать**.

  1. В блоке **Дополнительно** выключите **Доступ конечных пользователей к контенту**.

  1. Нажмите кнопку **Сохранить**.

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации Terraform и добавьте или измените блок ресурса `yandex_cdn_resource` на `active = false`.

     {% cut "Пример описания CDN-ресурса в конфигурации Terraform" %}

      ```hcl
     resource "yandex_cdn_resource" "my_resource" {
         cname               = "cdn1.yandex-example.ru"
         active              = false
         origin_protocol     = "https"
         secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
         origin_group_id     = yandex_cdn_origin_group.my_group.id
         ...
         options {
           edge_cache_settings = "345600"
           ignore_cookie       = true
           ...
         }
     }
      ```

     {% endcut %}

      Более подробную информацию о параметрах `yandex_cdn_resource` в Terraform см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cdn_resource).

  1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.

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
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc cdn resource list
     ```

{% endlist %}