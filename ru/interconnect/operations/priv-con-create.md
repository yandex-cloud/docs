---
title: Как создать приватное соединение в транковом подключении {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете создать приватное соединение в транковом подключении {{ interconnect-name }}.
---

# Создать приватное соединение

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}** и нажмите кнопку **{{ ui-key.yacloud.interconnect.private-connection.create-private-connection_6K9tP }}**. В открывшемся окне:

      1. Поместите курсор в поле **{{ ui-key.yacloud.interconnect.private-connection.TrunkConnectionSuggestOrCreate.title_oPBF7 }}** и выберите транковое подключение, в котором вы хотите создать приватное соединение.

          При необходимости нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать новое транковое подключение.
      1. В поле **{{ ui-key.yacloud.interconnect.vlan-id_2wghK }}** задайте произвольный `VLAN ID` для данного приватного соединения в 802.1Q-транке. Например: `123`.
      
          Значение не должно совпадать со значениями `VLAN ID` других приватных соединений в данном транке.
      1. В поле **{{ ui-key.yacloud.interconnect.peering-subnet_eYRTR }}** укажите [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) стыковой подсети для BGP-пиринга. Например: `192.168.1.0/31`. Подробнее читайте в разделе [{#T}](../concepts/priv-con.md#priv-address).
      1. В поле **{{ ui-key.yacloud.interconnect.peer-ip_pMdxo }}** укажите IP-адрес из стыковой (пиринговой) подсети на оборудовании клиента. Например: `192.168.1.0`.
      1. В поле **{{ ui-key.yacloud.interconnect.cloud-ip_6ESSe }}** укажите IP-адрес из стыковой (пиринговой) подсети на оборудовании {{ yandex-cloud }}. Например: `192.168.1.1`.
      1. В поле **{{ ui-key.yacloud.interconnect.bgp-asn_3dSL7 }}** укажите номер BGP ASN на оборудовании клиента в формате ASPlain. Например: `64513`. Подробнее читайте в разделе [{#T}](../concepts/priv-con.md#bgp-asn).
      1. (Опционально) В поле **{{ ui-key.yacloud.interconnect.bgp-key_cn2dU }}** укажите зашифрованное значение ключа для установления BGP-соединения.
      1. В поле **IPv4 StaticRoute prefix** нажмите кнопку **{{ ui-key.yacloud.interconnect.private-connection.StaticRoutePrefixRow.add-prefix-button_n11CU }}**, чтобы добавить в приватное соединение CIDR-префикс назначения статического маршрута, который будет анонсироваться в сети на стороне инфраструктуры клиента.

          В одном приватном соединении вы можете анонсировать несколько статических маршрутов. Для этого повторно нажмите **{{ ui-key.yacloud.interconnect.private-connection.StaticRoutePrefixRow.add-prefix-button_n11CU }}** необходимое количество раз.
      1. (Опционально) В блоке **{{ ui-key.yacloud.common.section-base }}** задайте для создаваемого соединения:

          * **{{ ui-key.yacloud.common.name }}**. Требования к имени:

              {% include [name-format](../../_includes/name-format.md) %}

              Если не указать имя, приватному соединению будет присвоено имя, идентичное [идентификатору](../../api-design-guide/concepts/resources-identification.md) этого соединения.
          * Произвольное **{{ ui-key.yacloud.common.description }}** соединения.
          * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md), назначаемые соединению.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания [приватного соединения](../concepts/priv-con.md):

      ```bash
      yc cic private-connection create --help
      ```

  1. Создайте приватное соединение:

      ```bash
      yc cic private-connection create \
        --name prc-pop1 \
        --description "Private connection #1 via POP-1" \
        --trunk-id cf3dcodot14p******** \
        --vlan-id 125 \
        --ipv4-peering peering-subnet=192.168.10.0/30,peer-ip=192.168.10.1,cloud-ip=192.168.10.2,peer-bgp-asn=65202 \
        --async
      ```

      {% note info %}

      По умолчанию приватное соединение будет создано в том же каталоге, что и транковое подключение. Для упрощения дальнейшей эксплуатации не рекомендуется создавать транковые подключения и приватные соединения в разных каталогах.

      {% endnote %}

      Ожидаемый результат:

      ```text
      id: bd6g2l17c8sv********
      name: prc-pop1
      folder_id: b1gt6g8ht345********
      region_id: {{ region-id }}
      trunk_connection_id: cf3dcodot14p********
      vlan_id: "125"
      ipv4_peering:
        peering_subnet: 192.168.10.0/30
        peer_ip: 192.168.10.1
        cloud_ip: 192.168.10.2
        peer_bgp_asn: "20001"
        peer_bgp_md5_key: '*** hidden ***'
      status: ACTIVE
      created_at: "2025-03-20T08:25:33Z"
      ```

      Где:

      * `id` — идентификатор приватного соединения.
      * `name` — название приватного соединения.
      * `description` — описание приватного соединения.
      * `folder_id` — идентификатор облачного каталога, в котором было создано приватное соединение.
      * `region_id` — регион облака, в котором было создано приватное соединение.
      * `trunk_connection_id` — идентификатор транкового подключения, в котором было создано приватное соединение.
      * `vlan_id` — идентификатор VLAN ID для данного приватного соединения в 802.1Q-транке. Выбирается клиентом. Не может совпадать со значениями VLAN ID ранее настроенных приватных соединений в данном транке.
      * `ipv4_peering` — группа параметров IP/BGP-связности для приватного соединения:
        * `peering_subnet` — [стыковая подсеть](../concepts/priv-con.md#priv-address) для BGP-пиринга. Выбирается клиентом.
        * `peer_ip` — IP-адрес из стыковой (пиринговой) подсети на оборудовании клиента. Выбирается клиентом.
        * `cloud_ip` — IP-адрес из стыковой (пиринговой) подсети на оборудовании {{ yandex-cloud }}. Выбирается клиентом.
        * `peer_bgp_asn` — номер [BGP ASN](../concepts/priv-con.md#bgp-asn) на оборудовании клиента в формате ASPlain. Выбирается клиентом.
        * `peer_bgp_md5_key` — необязательный параметр. Зашифрованное значение ключа для установления BGP-соединения.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`.
      * `created_at` — дата и время создания ресурса.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуется все операции с изменением ресурсов выполнять в этом режиме.

{% endlist %}
