# Сделать статический публичный IP-адрес динамическим

Статический публичный IP-адрес, заданный облачному ресурсу, можно сделать динамическим. Если динамический IP-адрес используется [виртуальной машиной](../../glossary/vm.md), после ее остановки он пропадет, а при следующем запуске изменится на новый.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится нужный адрес.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного адреса и выберите **{{ ui-key.yacloud.vpc.addresses.button_action-dynamic }}**.
   1. В открывшемся окне нажмите **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_dynamic }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Просмотрите описание команд CLI для изменения атрибутов адреса:

      ```bash
      yc vpc address update --help
      ```

   1. Получите список адресов в каталоге по умолчанию:

      ```bash
      yc vpc address list
      ```

      Результат:

      ```text
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff******** |      | 84.201.177.41 | true     | true |
      +----------------------+------+---------------+----------+------+
      ```

      Значение `true` параметра RESERVED для IP-адреса с ID `e2l46k8conff********` показывает, что этот адрес статический.

   1. Сделайте адрес динамическим, используя ключ `--reserved=false` и ID адреса:

      ```bash
      yc vpc address update --reserved=false e2l46k8conff********
      ```

      Результат:

      ```text
      id: e2l46k8conff********
      folder_id: b1g7gvsi89m3********
      created_at: "2021-01-14T09:36:46Z"
      external_ipv4_address:
        address: 84.201.177.41
        zone_id: {{ region-id }}-a
        requirements: {}
      used: true
      ```

      Теперь IP-адрес стал динамическим.

- API {#api}

  Чтобы изменить тип публичного IP-адреса со статического на динамический, воспользуйтесь методом REST API [update](../api-ref/Address/update.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Update](../api-ref/grpc/Address/update.md) и передайте в запросе:

  * Идентификатор адреса, который нужно сделать динамическим, в параметре `addressId`.

    {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Значение `false` в параметре `reserved`.
  * Имя параметра `reserved`, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
