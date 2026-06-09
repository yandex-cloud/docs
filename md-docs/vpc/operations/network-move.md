# Переместить облачную сеть в другой каталог

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы переместить [облачную сеть](../concepts/network.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится облачная сеть.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной сети и выберите **{{ ui-key.yacloud.common.move }}**.
  1. В открывшемся окне выберите каталог назначения.
  1. Нажмите **{{ ui-key.yacloud.common.move }}**.

  {% note info %}

  Вместе с облачной сетью в другой каталог будут перенесены и ее подсети.

  {% endnote %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  Чтобы переместить [облачную сеть](../concepts/network.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Network/move.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Move](../api-ref/grpc/Network/move.md) и передайте в запросе:

  * Идентификатор переносимой облачной сети в параметре `networkId`.

    Чтобы узнать идентификатор облачной сети, воспользуйтесь методом REST API [list](../api-ref/Network/list.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/List](../api-ref/grpc/Network/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  * Идентификатор каталога, в который будет перенесена облачная сеть, в параметре `destinationFolderId`.

    О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

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