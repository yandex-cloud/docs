# Изменить подсеть

После создания [подсети](../concepts/network.md#subnet) вы можете изменить ее имя, описание и настройки DCHP.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется изменить подсеть.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Нажмите ![image](../../_assets/options.svg) в строке нужной подсети и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите нужные изменения.
  1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.update.button_update }}**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров подсети:

      ```
      yc vpc subnet update --help
      ```

  1. Получите список всех подсетей в каталоге по умолчанию:

      ```
      yc vpc subnet list
      ```
	    
      Результат:

      ```
      +----------------------+-----------------------+----------------------+
      |          ID          |         NAME          |         ...          |
      +----------------------+-----------------------+----------------------+
      ...
      | e2l2prrbkbimvjuuhht2 |     test-subnet-1     |         ...          |
      ...
      +----------------------+-----------------------+----------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной подсети.
  1. Измените параметры подсети, например:

      ```
      yc vpc subnet update e2l2prrbkbimvjuuhht2 \
        --new-name test-subnet-renamed \
        --labels new_label=test_label
      ```

      Результат:

      ```
      id: e2l2prrbkbimvjuuhht2
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-10-24T13:54:10Z"
      name: test-subnet-renamed
      description: My test subnet
      labels:
        new_label: test_label
      network_id: enplom7a98s1t0lhass8
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.0.0/24
      ```

- API

  Чтобы изменить [подсеть](../concepts/network.md#subnet), воспользуйтесь методом REST API [update](../api-ref/Subnet/update.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../api-ref/grpc/subnet_service.md#Update).

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием подсети:

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

     Более подробную информацию о параметрах ресурса `yandex_vpc_subnet` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_subnet).

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

     Проверить изменение подсети можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc subnet get <имя подсети>
     ```

{% endlist %}

## Примеры {#examples}

### Изменение подсети с использованием флага имени {#using-name-flag}

{% list tabs %}

- CLI

  Можно изменять подсеть, используя ее имя вместо идентификатора:

  ```
  yc vpc subnet update test-subnet-1 \
    --new-name test-subnet-renamed \
    --labels new_label=test_label
  ```

  Результат:

  ```
  id: e2l2prrbkbimvjuuhht2
  folder_id: b1g6ci08ma55klukmdjs
  created_at: "2018-10-24T13:54:10Z"
  name: test-subnet-renamed
  description: My test subnet
  labels:
    new_label: test_label
  network_id: enplom7a98s1t0lhass8
  zone_id: {{ region-id }}-a
  v4_cidr_blocks:
  - 192.168.0.0/24
  ```

  Идентификатор и имя подсети можно передавать не только как позиционный аргумент, но и с помощью флагов `--id` и `--name`:

  ```
  yc vpc network update \
    --id enpavfmgapumnl7cqin8 \
    --new-name test-network-renamed \
    --labels new_label=test_label
  ```

  ```
  yc vpc network update \
    --name test-network-1 \
    --new-name test-network-renamed \
    --labels new_label=test_label
  ```

{% endlist %}
