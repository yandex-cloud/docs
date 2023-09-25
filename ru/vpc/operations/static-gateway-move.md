---
title: "Как переместить NAT-шлюз в другой каталог"
description: "Следуя данной инструкции, вы сможете переместить NAT-шлюз в другой каталог."
---

# Переместить NAT-шлюз в другой каталог

{% note info %}

{% include [Preview](../../_includes/vpc/preview.md) %}

{% endnote %}

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Консоль управления

  Чтобы переместить [NAT-шлюз](../concepts/gateways.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится NAT-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/gateways.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке NAT-шлюза, который требуется переместить, и выберите **{{ ui-key.yacloud.vpc.gateways.button_move-gateway }}**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы переместить [NAT-шлюз](../concepts/gateways.md) в другой каталог:

  1. Посмотрите описание команды CLI для перемещения NAT-шлюза:

      ```bash
      yc vpc gateway move --help
      ```

  1. Узнайте имя или идентификатор NAT-шлюза, который требуется переместить:

      ```bash
      yc vpc gateway list
      ```
      Результат:
      ```text
      +----------------------+----------+-------------+
      |          ID          |   NAME   | DESCRIPTION |
      +----------------------+----------+-------------+
      | enckq19qqsr54b727dct | router-1 |             |
      +----------------------+----------+-------------+
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

  1. Переместите NAT-шлюз, указав имя или идентификатор NAT-шлюза и каталога назначения:

     ```bash
     yc vpc gateway move <имя_или_идентификатор_шлюза> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если шлюз находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:
     ```text
     id: enckq19qqsr54b727dct
     folder_id: b1chgf288nvg541tgu73
     created_at: "2022-10-06T10:14:04Z"
     name: router-1
     shared_egress_gateway: {}
     ```
     Подробнее о команде `yc vpc address move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/gateway/move.md).

- API

  Чтобы переместить [NAT-шлюз](../concepts/gateways.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Gateway/move.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/Move](../api-ref/grpc/gateway_service.md#Move).

{% endlist %}

## Примеры {#examples}

### NAT-шлюз в другом каталоге {#from-another-folder}

Переместите NAT-шлюз, который находится в другом каталоге. Укажите идентификатор NAT-шлюза, а также идентификаторы исходного и целевого каталога:

{% list tabs %}

- CLI

  ```bash
  yc vpc gateway move enckq19qqsr54b727dct \
    --folder-id b1chgf288nvg541tgu73 \
    --destination-folder-id b1cs8ie21pk10aurd2c3
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-move.md)
* [{#T}](subnet-move.md)

