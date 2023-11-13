# Сделать динамический публичный IP-адрес статическим

Динамический публичный IP-адрес можно сделать статическим. Статические публичные адреса резервируются и не пропадают при остановке [виртуальных машин](../../glossary/vm.md) и сетевых балансировщиков.

{% note info %}

Обратите внимание на [правила тарификации](../pricing.md#prices-public-ip) неактивных статических публичных адресов.

{% endnote %}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится нужный адрес.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/vpc/ip-addresses.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Нажмите ![image](../../_assets/options.svg) в строке нужного адреса и выберите **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**.
   1. В открывшемся окне нажмите **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_static }}**.

- CLI

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

      ```bash
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff8n6ru1jl |      | 84.201.177.41 | false    | true |
      +----------------------+------+---------------+----------+------+
      ```

      Значение `false` параметра RESERVED для IP-адреса с ID `e2l46k8conff8n6ru1jl` показывает, что этот адрес динамический.

   1. Сделайте адрес статическим, используя ключ `--reserved=true` и ID адреса:

      ```bash
      yc vpc address update --reserved=true e2l46k8conff8n6ru1jl
      ```

      Результат:

      ```bash
      id: e2l46k8conff8n6ru1jl
      folder_id: b1g7gvsi89m34pipa3ke
      created_at: "2021-01-14T09:36:46Z"
      external_ipv4_address:
        address: 84.201.177.41
        zone_id: {{ region-id }}-a
        requirements: {}
      reserved: true
      used: true
      ```

      Параметр `reserved` принял значение `true`, теперь IP-адрес статический.

- API

  Чтобы изменить тип публичного IP-адреса с динамического на статический, воспользуйтесь методом REST API [update](../api-ref/Address/update.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Update](../api-ref/grpc/address_service.md#Update) и передайте в запросе:

  * Идентификатор адреса, который нужно сделать статическим, в параметре `addressId`.

    {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Значение `true` в параметре `reserved`.
  * Имя параметра `reserved`, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
