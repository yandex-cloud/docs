# Удалить подсеть

{% note alert %}

Перед удалением подсети необходимо отключить от нее все ресурсы.
После удаления подсеть невозможно восстановить.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы удалить [подсеть](../concepts/network.md#subnet):
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется удалить подсеть.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. Нажмите на имя облачной сети, в которой находится подсеть.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке подсети, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления подсети:

      ```
      yc vpc subnet delete --help
      ```

  1. Получите список всех подсетей в каталоге по умолчанию:

      ```
      yc vpc subnet list
      ```

      Результат:

      ```
      +----------------------+-----------------------+------------------------+
      |          ID          |         NAME          | ... |       RANGE      |
      +----------------------+-----------------------+------------------------+
      ...
      | e2l0psbfoloefpjb1rau | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной подсети.
  1. Удалите подсеть из каталога по умолчанию:

      ```
      yc vpc subnet delete test-subnet-1
      ```

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

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
       network_id     = "${yandex_vpc_network.lab-net.id}"
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
     yc vpc subnet list
     ```

{% endlist %}

## Примеры {#examples}

### Удаление подсети из указанного каталога {#from-folder}

{% list tabs %}

- CLI

  Удалите подсеть из другого каталога:

  ```
  yc vpc subnet delete test-subnet-2 --folder-id b1gnbfd11bq5g5vnjgr4
  ```

  Где `--folder-id` – идентификатор каталога.

  ```
  yc vpc subnet delete test-subnet-2 --folder-name test-folder
  ```

  Где `--folder-name` – имя каталога.

  Идентификатор и имя можно передавать не только как позиционный аргумент, но и с помощью флагов `--id` и `--name`:

  ```
  yc vpc subnet delete --id enpavfmgapumnl7cqin8
  ```
  
  ```
  yc vpc subnet delete --name test-network-1
  ```

{% endlist %}
