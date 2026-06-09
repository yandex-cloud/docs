# Переместить группу безопасности в другой каталог

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы переместить [группу безопасности](../concepts/security-groups.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится группа безопасности.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке группы, которую требуется переместить, и выберите **{{ ui-key.yacloud.common.move }}**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.move }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
      | enc2ta63h3q2******** | default-sg-enc39op1vq9m******** | Default security group for network | enc39op1vq9m******** |
      | enc612keceq8******** | default-sg-encb4ubvmief******** | Default security group for network | encb4ubvmief******** |
      | encnn4l7b3lp******** | default-sg-enc772aa2rgq******** | Default security group for network | enc772aa2rgq******** |
      | encemkpqg8fh******** | my-sg-1                         | Custom security group              | encb4ubvmief******** |
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
      | b1cs8ie21pk1******** | default                |        | ACTIVE |
      | b1chgf288nvg******** | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh6******** | my-folder-2            |        | ACTIVE |
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
     id: encemkpqg8fh********
     folder_id: b1chgf288nvg********
     created_at: "2022-10-10T13:24:59Z"
     name: my-sg-1
     network_id: encb4ubvmief********
     status: ACTIVE
     ```

     Подробнее о команде `yc vpc security-group move` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/security-group/move.md).

- API {#api}

  Чтобы переместить [группу безопасности](../concepts/security-groups.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/SecurityGroup/move.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Move](../api-ref/grpc/SecurityGroup/move.md) и передайте в запросе:

  * Идентификатор группы безопасности, которую нужно перенести, в параметре `securityGroupId`.

    Чтобы узнать идентификатор подсети, воспользуйтесь методом REST API [list](../api-ref/Subnet/list.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../api-ref/grpc/Subnet/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  * Идентификатор каталога, в который будет перенесена группа безопасности, в параметре `destinationFolderId`.

    О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}

## Примеры {#examples}

### Группа безопасности в текущем каталоге {#from-default-folder}

Переместите группу безопасности из текущего каталога, указав имя группы и имя каталога назначения:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc security-group move my-sg-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Группа безопасности в другом каталоге {#from-another-folder}

Переместите группу безопасности, которая находится в другом каталоге. Укажите идентификатор группы, а также идентификаторы исходного и целевого каталога:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc security-group move encemkpqg8fh******** \
    --folder-id b1chgf288nvg******** \
    --destination-folder-id b1cs8ie21pk1********
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-move.md)