# Редактирование ACL объекта

Помимо [{{ iam-short-name }}](../../../iam/), {{ objstorage-name }} поддерживает управление доступом с помощью [ACL](../../concepts/acl.md).

{% list tabs %}

- Консоль управления
  
    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ objstorage-name }}**.
    1. Нажмите на имя бакета.
    1. Чтобы отредактировать ACL, нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) справа от имени объекта и выберите **ACL объекта**.
      
        Также можно нажать на имя объекта, на открывшейся странице нажать ![image](../../../_assets/horizontal-ellipsis.svg) и выбрать **ACL объекта**.

    1. В появившемся окне **Редактирование ACL** выдайте или отзовите необходимые разрешения.

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы отредактировать ACL объекта:

  1. Откройте файл конфигурации {{ TF }} и добавьте параметр `acl` в описание объекта.

     ```hcl
     ...
     resource "yandex_storage_object" "cute-cat-picture" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "cat-pictures"
       key        = "cute-cat"
       source     = "/images/cats/cute-cat.jpg"
       acl        = "public-read"
     }
     ...
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `acl` — [предопределенный ACL](../../../storage/concepts/acl.md#predefined-acls) объекта. Значение по умолчанию — `private`: пользователи {{ yandex-cloud }} получают разрешения в соответствии со своими ролями в {{ iam-short-name }}.

     Более подробную информацию о параметрах ресурса `yandex_storage_object` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/storage_object).

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

     Проверить изменение группы безопасности можно в [консоли управления]({{ link-console-main }}).

{% endlist %}
