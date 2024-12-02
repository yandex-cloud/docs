# Переместить облачную сеть в другой каталог

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы переместить [облачную сеть](../concepts/network.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится облачная сеть.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной сети и выберите **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
  1. В открывшемся окне выберите каталог назначения.
  1. Нажмите **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

  {% note info %}

  Вместе с облачной сетью в другой каталог будут перенесены и ее подсети.

  {% endnote %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы переместить [облачную сеть](../concepts/network.md) в другой каталог:

  1. Посмотрите описание команды CLI для перемещения облачной сети:

      ```bash
      yc vpc network move --help
      ```

  1. Узнайте имя или идентификатор облачной сети, которую требуется переместить:

      ```bash
      yc vpc network list
      ```
      Результат:
      ```text
      +----------------------+-----------+
      |          ID          |   NAME    |
      +----------------------+-----------+
      | encb4ubvmief******** | default   |
      | enc39op1vq9m******** | network-1 |
      | enc772aa2rgq******** | network-2 |
      +----------------------+-----------+
      ```

  1. Получите список доступных каталогов:

      ```bash
      yc resource-manager folder list
      ```

      Результат:
      ```text
      +----------------------+------------------------+--------+--------+
      |          ID          |          NAME          | LABELS | STATUS |
      +----------------------+------------------------+--------+--------+
      | b1cs8ie21pk1******** | default                |        | ACTIVE |
      | b1chgf288nvg******** | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh6******** | my-folder-2            |        | ACTIVE |
      +----------------------+------------------------+--------+--------+
      ```

  1. Переместите сеть, указав имя или идентификатор сети и каталога назначения:

     ```bash
     yc vpc network move <имя_или_идентификатор_сети> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если сеть находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:

     ```text
     id: enc39op1vq9m********
      folder_id: b1chgf288nvg********
      created_at: "2022-10-06T14:54:48Z"
      name: network-1
      default_security_group_id: enc2ta63h3q2********
     ```

     Подробнее о команде `yc vpc network move` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/move.md).

- API {#api}

  Чтобы переместить [облачную сеть](../concepts/network.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Network/move) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Move](../api-ref/grpc/Network/move.md) и передайте в запросе:

  * Идентификатор переносимой облачной сети в параметре `networkId`.

    {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

  * Идентификатор каталога, в который будет перенесена облачная сеть, в параметре `destinationFolderId`.

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Примеры {#examples}

### Облачная сеть в текущем каталоге {#from-default-folder}

Переместите облачную сеть из текущего каталога, указав имя сети и имя каталога назначения:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc network move network-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Облачная сеть в другом каталоге {#from-another-folder}

Переместите облачную сеть, которая находится в другом каталоге. Укажите идентификатор сети, а также идентификаторы исходного и целевого каталога:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc network move enc39op1vq9m******** \
    --folder-id b1chgf288nvg******** \
    --destination-folder-id b1cs8ie21pk1********
  ```

{% endlist %}
