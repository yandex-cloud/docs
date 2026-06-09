# Изменить параметры приватного соединения

{% note warning %}

Чтобы запросить доступ к данной функции, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

Чтобы изменить [приватное соединение](../concepts/priv-con.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**.
  1. В строке с нужным приватным соединением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

      1. (Опционально) Измените транковое подключение, к которому относится приватное соединение. Для этого поместите курсор в поле **{{ ui-key.yacloud.interconnect.private-connection.TrunkConnectionSuggestOrCreate.title_oPBF7 }}** и выберите нужное подключение.

          При необходимости нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать новое транковое подключение.
      1. (Опционально) В поле **{{ ui-key.yacloud.interconnect.vlan-id_2wghK }}** измените `VLAN ID` приватного соединения в 802.1Q-транке. Например: `123`.
      
          Значение не должно совпадать со значениями `VLAN ID` других приватных соединений в данном транке.
      1. (Опционально) В поле **{{ ui-key.yacloud.interconnect.peering-subnet_eYRTR }}** измените [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) стыковой подсети для BGP-пиринга. Например: `192.168.1.0/31`. Подробнее читайте в разделе [{#T}](../concepts/priv-con.md#priv-address).
      1. (Опционально) В поле **{{ ui-key.yacloud.interconnect.peer-ip_pMdxo }}** измените IP-адрес из стыковой (пиринговой) подсети на оборудовании клиента. Например: `192.168.1.0`.
      1. (Опционально) В поле **{{ ui-key.yacloud.interconnect.cloud-ip_6ESSe }}** измените IP-адрес из стыковой (пиринговой) подсети на оборудовании {{ yandex-cloud }}. Например: `192.168.1.1`.
      1. (Опционально) В поле **{{ ui-key.yacloud.interconnect.bgp-asn_3dSL7 }}** измените номер BGP ASN на оборудовании клиента в формате ASPlain. Например: `64513`. Подробнее читайте в разделе [{#T}](../concepts/priv-con.md#bgp-asn).
      1. (Опционально) В поле **{{ ui-key.yacloud.interconnect.bgp-key_cn2dU }}** измените зашифрованное значение ключа для установления BGP-соединения.
      1. (Опционально) В поле **IPv4 StaticRoute prefix** измените CIDR-префиксы назначения статических маршрутов, которые анонсируются в сети на стороне инфраструктуры клиента. В одном приватном соединении вы можете анонсировать несколько статических маршрутов:

          * Чтобы добавить новый статический маршрут, нажмите **{{ ui-key.yacloud.interconnect.private-connection.StaticRoutePrefixRow.add-prefix-button_n11CU }}** и укажите нужный префикс.
          * Чтобы удалить существующий статический маршрут, нажмите значок ![trash-bin](../../_assets/console-icons/trash-bin.svg) в строке с соответствующим маршрутом.
      1. (Опционально) В блоке **{{ ui-key.yacloud.common.section-base }}** измените:

          * **{{ ui-key.yacloud.common.name }}** приватного соединения. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

              Если не указать имя, приватному соединению будет присвоено имя, идентичное [идентификатору](../../api-design-guide/concepts/resources-identification.md) этого соединения.
          * **{{ ui-key.yacloud.common.description }}** приватного соединения.
          * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md), назначаемые приватному соединению.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Вы можете изменить параметры приватного соединения с помощью следующих команд:
  * [yc cic private-connection update](../../cli/cli-ref/cic/cli-ref/private-connection/update.md) — позволяет изменять все параметры приватного соединения, в том числе полностью заменять список статических маршрутов новым списком.
  * [yc cic private-connection upsert-static-routes](../../cli/cli-ref/cic/cli-ref/private-connection/upsert-static-routes.md) — позволяет добавлять в приватное соединение новые статические маршруты в дополнение к существующим.
  * [yc cic private-connection remove-static-routes](../../cli/cli-ref/cic/cli-ref/private-connection/remove-static-routes.md) — позволяет удалять из приватного соединения часть статических маршрутов, сохраняя остальные.

  **yc cic private-connection update**

  1. Посмотрите описание команды CLI для изменения параметров приватного соединения:

      ```bash
      yc cic private-connection update --help
      ```

  1. Измените значение параметра `vlan-id` и список статических маршрутов приватного соединения:

      ```bash
      yc cic private-connection update cf3r5ke20fo0******** \
        --vlan-id 201 \
        --ipv4-static-routes "192.168.12.0/24,192.168.13.0/28" \
        --async
      ```

      Ожидаемый результат:

      ```text
      id: bd60h5qtn90s********
      description: private connection update
      created_at: "2025-04-08T21:21:33.106772882Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-04-08T21:21:33.106772882Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdatePrivateConnectionMetadata
        private_connection_id: cf3r5ke20fo0********
      ```

  1. Проверьте значение изменяемого параметра после завершения выполнения операции:

      ```bash
      yc cic private-connection get cf3r5ke20fo0********
      ```

  **yc cic private-connection upsert-static-routes**

  1. Посмотрите описание команды CLI для добавления в приватное соединение новых статических маршрутов:

      ```bash
      yc cic private-connection upsert-static-routes --help
      ```

  1. Добавьте статические маршруты в приватное соединение:

      ```bash
      yc cic private-connection upsert-static-routes cf3dcodot14p******** \
        --ipv4-static-routes "10.0.0.0/8,192.168.100.0/24" \
        --async
      ```

  **yc cic private-connection remove-static-routes**

  1. Посмотрите описание команды CLI для удаления статических маршрутов из приватного соединения:

      ```bash
      yc cic private-connection remove-static-routes --help
      ```
      
  1. Удалите статические маршруты из приватного соединения:

      ```bash
      yc cic private-connection remove-static-routes cf3dcodot14p******** \
        --ipv4-static-routes "10.0.0.0/8,192.168.100.0/24" \
        --async
      ```

{% endlist %}