# Переместить публичный IP-адрес в другой каталог

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Консоль управления

  Чтобы переместить [публичный адрес](../concepts/address.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится адрес.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/ip-addresses.svg) **IP-адреса**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке адреса, который требуется переместить, и выберите **Переместить**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **Переместить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы переместить [публичный адрес](../concepts/address.md) в другой каталог:

  1. Посмотрите описание команды CLI для перемещения адреса:

      ```bash
      yc vpc address move --help
      ```

  1. Узнайте имя или идентификатор адреса, который требуется переместить:

      ```bash
      yc vpc address list
      ```
      Результат:
      ```text
      +----------------------+------+---------------+----------+-------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED  |
      +----------------------+------+---------------+----------+-------+
      | e2l50m7qo8gp35c6c58i |      | 84.252.137.20 | true     | false |
      | e9b0qnmuh2cbglk265oi |      | 51.250.65.244 | true     | false |
      | e9br252il3ceakc3rk94 |      | 51.250.68.195 | false    | true  |
      +----------------------+------+---------------+----------+-------+
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

  1. Переместите адрес, указав имя или идентификатор адреса и каталога назначения:

     ```bash
     yc vpc address move <имя_или_идентификатор_адреса> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если адрес находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:
     ```text
      id: e9br252il3ceakc3rk94
      folder_id: b1chgf288nvg541tgu73
      created_at: "2022-10-10T05:38:43Z"
      external_ipv4_address:
        address: 51.250.68.195
        zone_id: {{ region-id }}-a
        requirements: {}
      used: true
      type: EXTERNAL
      ip_version: IPV4
     ```
     Подробнее о команде `yc vpc address move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/address/move.md).

{% endlist %}

## Примеры {#examples}

### Адрес в текущем каталоге {#from-default-folder}

Переместите адрес из текущего каталога, указав имя адреса и имя каталога назначения:

{% list tabs %}

- CLI

  ```bash
  yc vpc address move site-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Адрес в другом каталоге {#from-another-folder}

Переместите адрес, который находится в другом каталоге. Укажите идентификатор адреса, а также идентификаторы исходного и целевого каталога:

{% list tabs %}

- CLI

  ```bash
  yc vpc address move e9br252il3ceakc3rk94 \
    --folder-id b1chgf288nvg541tgu73 \
    --destination-folder-id b1cs8ie21pk10aurd2c3
  ```

{% endlist %}

