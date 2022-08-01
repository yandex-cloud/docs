# Удаление бакета

{% note info %}

Удалить можно только пустой бакет.

{% endnote %}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого хотите удалить бакет.
  1. Выберите сервис **{{ objstorage-name }}**. Вы попадете на страницу со списком бакетов.
  1. Чтобы удалить один бакет, нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) слева от имени бакета и выберите **Удалить**.
  1. Подтвердите удаление.

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% if audience != "internal" %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% endif %}

  Чтобы удалить бакет, созданный с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием бакета.

     {% cut "Пример описания бакета в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "YCAJEX9Aw2ge1VKjlYXf-w-lJ"
       secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZMcSJz2N0"
       bucket     = "tf-test-bucket"
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

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).
  
{% endlist %}
