# Привязать к виртуальной машине публичный IP-адрес

Если вы создали виртуальную машину без публичного IP-адреса, вы можете привязать к ней адрес, [зарезервированный вами](../../../vpc/operations/get-static-ip.md) в {{ vpc-name }} или выбранный {{ compute-name }} автоматически из свободных адресов.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Выберите виртуальную машину.
  1. В блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** в правом верхнем углу нажмите ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
  1. В открывшемся окне:
     * В поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** выберите `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, чтобы автоматически получить адрес, или `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, чтобы выбрать зарезервированный адрес из списка.
     * (опционально) Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, включите опцию **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. Подробнее см. в разделе [{#T}](../../../vpc/ddos-protection/index.md).
     * Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, выберите адрес, который хотите привязать к ВМ.
     * Нажмите кнопку **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы привязать к ВМ публичный IP-адрес выполните команду CLI:

    ```bash
    yc compute instance add-one-to-one-nat
      --id=<идентификатор_ВМ> 
      --network-interface-index=<индекс_сетевого_интерфейса_ВМ> 
      --nat-address=<IP-адрес>
    ```

    Где:

    * `id` — идентификатор (ID) ВМ. Получите список идентификаторов ВМ, доступных в каталоге, с помощью [команды CLI](../../../cli/cli-ref/managed-services/compute/instance/list.md) `yc compute instance list`.
    * `network-interface-index` — индекс сетевого интерфейса ВМ. По умолчанию — `0`.
    * `nat-address` — публичный IP-адрес, который нужно присвоить ВМ. Получите список зарезервированных публичных IP-адресов, доступных в каталоге, с помощью [команды CLI](../../../cli/cli-ref/managed-services/vpc/address/list.md) `yc vpc address list`. По умолчанию публичный IP-адрес присваивается автоматически.

    Пример использования:

    ```bash
    yc compute instance add-one-to-one-nat
      --id=fhmsbag62tafcus1a12c 
      --network-interface-index=0
      --nat-address=51.250.9.203
    ```    

    Результат:

    ```bash
    id: fhmsbag62tafcus1a12c
    folder_id: b1gv87ssvu497lpgjh5o
    created_at: "2022-05-06T10:41:56Z"
    name: steel-machine
    description: for work
    zone_id: {{ region-id }}-a
    platform_id: standard-v3
    resources:
      memory: "1073741824"
      cores: "2"
      core_fraction: "20"
    status: RUNNING
    boot_disk:
      mode: READ_WRITE
      device_name: fhmeihe6vgg1smqp763q
      auto_delete: true
      disk_id: fhmeihe6vgg1smqp763q
    network_interfaces:
    - index: "0"
      mac_address: d0:0d:1c:5a:a0:61
      subnet_id: e9bn57jvjnbujnmk3mba
      primary_v4_address:
        address: 10.128.0.23
        one_to_one_nat:
          address: 51.250.9.203
          ip_version: IPV4
      security_group_ids:
      - enpcuhcljhb0jq9s3sb7
    fqdn: steel-machine.{{ region-id }}.internal
    scheduling_policy:
      preemptible: true
    network_settings:
      type: STANDARD
    placement_policy: {}
    ```

    Подробнее о команде `yc compute instance add-one-to-one-nat` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/add-one-to-one-nat.md).

{% endlist %}
