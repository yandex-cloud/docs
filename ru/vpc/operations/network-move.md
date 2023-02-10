# Переместить облачную сеть в другой каталог

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Консоль управления

  Чтобы переместить [облачную сеть](../concepts/network.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится облачная сеть.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке сети, которую требуется переместить, и выберите **Переместить**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **Переместить**.

  {% note info %}

  Вместе с облачной сетью в другой каталог будут перенесены и ее подсети.

  {% endnote %}

- CLI

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
      | encb4ubvmief09h6qg5e | default   |
      | enc39op1vq9m8tjr3udp | network-1 |
      | enc772aa2rgqiqq67ehu | network-2 |
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
      | b1cs8ie21pk10aurd2c3 | default                |        | ACTIVE |
      | b1chgf288nvg541tgu73 | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh690at5bm7 | my-folder-2            |        | ACTIVE |
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
     id: enc39op1vq9m8tjr3udp
      folder_id: b1chgf288nvg541tgu73
      created_at: "2022-10-06T14:54:48Z"
      name: network-1
      default_security_group_id: enc2ta63h3q2jsri70ll
     ```
     Подробнее о команде `yc vpc network move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/move.md).

{% endlist %}

## Примеры {#examples}

### Облачная сеть в текущем каталоге {#from-default-folder}

Переместите облачную сеть из текущего каталога, указав имя сети и имя каталога назначения:

{% list tabs %}

- CLI

  ```bash
  yc vpc network move network-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Облачная сеть в другом каталоге {#from-another-folder}

Переместите облачную сеть, которая находится в другом каталоге. Укажите идентификатор сети, а также идентификаторы исходного и целевого каталога:

{% list tabs %}

- CLI

  ```bash
  yc vpc network move enc39op1vq9m8tjr3udp \
    --folder-id b1chgf288nvg541tgu73 \
    --destination-folder-id b1cs8ie21pk10aurd2c3
  ```

{% endlist %}
