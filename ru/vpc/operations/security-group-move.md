# Переместить группу безопасности в другой каталог

{% include [Preview](../../_includes/vpc/preview.md) %}

{% list tabs %}

- Консоль управления

  Чтобы переместить [группу безопасности](../concepts/security-groups.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится группа безопасности.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Группы безопасности**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке группы, которую требуется переместить, и выберите **Переместить**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **Переместить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы переместить [группу безопасности](../concepts/security-groups.md) в другой каталог:

  1. Посмотрите описание команды CLI для перемещения группы безопасности:

      ```bash
      yc vpc security-group move --help
      ```

  1. Узнайте имя или идентификатор группы безопасности, которую требуется переместить:

      ```bash
      yc vpc security-group list
      ```
      Результат:
      ```text
      +----------------------+---------------------------------+------------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      | enc2ta63h3q2jsri70ll | default-sg-enc39op1vq9m8tjr3udp | Default security group for network | enc39op1vq9m8tjr3udp |
      | enc612keceq8u2ioa2h6 | default-sg-encb4ubvmief09h6qg5e | Default security group for network | encb4ubvmief09h6qg5e |
      | encnn4l7b3lpm0095epd | default-sg-enc772aa2rgqiqq67ehu | Default security group for network | enc772aa2rgqiqq67ehu |
      | encemkpqg8fhu8em3uc0 | my-sg-1                         | Custom security group              | encb4ubvmief09h6qg5e |
      +----------------------+---------------------------------+------------------------------------+----------------------+
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
      | b1cs8ie21pk10aurd2c3 | default                |        | ACTIVE |
      | b1chgf288nvg541tgu73 | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh690at5bm7 | my-folder-2            |        | ACTIVE |
      +----------------------+------------------------+--------+--------+
      ```

  1. Переместите группу безопасности, указав имя или идентификатор группы и каталога назначения:

     ```bash
     yc vpc security-group move <имя_или_идентификатор_группы> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если группа безопасности находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:
     ```text
     id: encemkpqg8fhu8em3uc0
     folder_id: b1chgf288nvg541tgu73
     created_at: "2022-10-10T13:24:59Z"
     name: my-sg-1
     network_id: encb4ubvmief09h6qg5e
     status: ACTIVE
     ```
     Подробнее о команде `yc vpc security-group move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/move.md).

- API

  Чтобы переместить [группу безопасности](../concepts/security-groups.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/SecurityGroup/move.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Move](../api-ref/grpc/security_group_service.md#Move).

{% endlist %}

## Примеры {#examples}

### Группа безопасности в текущем каталоге {#from-default-folder}

Переместите группу безопасности из текущего каталога, указав имя группы и имя каталога назначения:

{% list tabs %}

- CLI

  ```bash
  yc vpc security-group move my-sg-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Группа безопасности в другом каталоге {#from-another-folder}

Переместите группу безопасности, которая находится в другом каталоге. Укажите идентификатор группы, а также идентификаторы исходного и целевого каталога:

{% list tabs %}

- CLI

  ```bash
  yc vpc security-group move encemkpqg8fhu8em3uc0 \
    --folder-id b1chgf288nvg541tgu73 \
    --destination-folder-id b1cs8ie21pk10aurd2c3
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-move.md)

