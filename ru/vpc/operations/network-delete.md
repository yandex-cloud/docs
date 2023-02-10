# Удалить облачную сеть

{% note alert %}

Перед удалением сети из нее необходимо [удалить](subnet-delete.md) все подсети.
После удаления сеть невозможно восстановить.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы удалить [облачную сеть](../concepts/network.md#network):
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется удалить облачную сеть.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке сети, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления облачных сетей:

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
      | enpiuvhhd4t80k4n80i8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Удалите сеть:

      ```
      yc vpc network delete test-network-1
      ```

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Чтобы удалить облачную сеть, созданную с помощью {{ TF }}:

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

{% endlist %}
