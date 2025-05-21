# Изменить облачную сеть

После создания облачной сети вы можете изменить ее имя, описание и метки.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров [облачной сети](../concepts/network.md):

      ```
      yc vpc network update --help
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
      | enpavfmgapum******** | test-network-1 |
      | enplom7a98s1******** | default        |
      +----------------------+----------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Измените параметры облачной сети, указав ее имя:

      ```
      yc vpc network update enpavfmgapum******** --new-name test-network-renamed
      ```

      Результат:
      ```
      id: enpavfmgapum********
      folder_id: b1g6ci08ma55********
      created_at: "2018-10-23T14:05:32Z"
      name: test-network-renamed
      description: My first network
      labels:
        new_label: test_label
      ```
     
      Идентификатор и имя можно передавать не только как позиционный аргумент, но и с помощью параметров `--id` и `--name`:

      ```
      yc vpc network update \
        --id enpavfmgapum******** \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

      ```
      yc vpc network update \
        --name test-network-1 \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием [облачной сети](../concepts/network.md):

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

     Более подробную информацию о параметрах ресурса `yandex_vpc_network` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_network).

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

     Проверить изменение облачной сети можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc network get <имя_сети>
     ```

- API {#api}

  Чтобы изменить [облачную сеть](../concepts/network.md), воспользуйтесь методом REST API [update](../api-ref/Network/update.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Update](../api-ref/grpc/Network/update.md) и передайте в запросе:

  * Идентификатор изменяемой облачной сети в параметре `networkId`.

    {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Новые настройки сети по необходимости:

    * имя в параметре `name`;
    * описание в параметре `description`;
    * метки сети в параметре `labels`.

  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Примеры {#examples}

### Изменение облачной сети с использованием имени {#using-name}

Можно изменять облачную сеть, используя имя вместо идентификатора:

{% list tabs group=instructions %}

- CLI {#cli}

  ```
  yc vpc network update test-network-1 \
    --new-name test-network-renamed \
    --labels new_label=test_label
  ```

  Результат:
  ```
  id: enpavfmgapum********
  folder_id: b1g6ci08ma55********
  created_at: "2018-10-23T14:05:32Z"
  name: test-network-renamed
  description: My first network
  labels:
    new_label: test_label
  ```

{% endlist %}
