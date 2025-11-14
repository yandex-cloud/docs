1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ к {{ backup-name }}.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и выберите нужную ВМ.
1. В блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** добавьте группу безопасности в [сетевой интерфейс](../../../compute/concepts/network.md) ВМ:

    * В правом верхнем углу блока нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
    * В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** выберите созданную ранее группу безопасности.
    * Нажмите **{{ ui-key.yacloud.common.save }}**.

1. Если у ВМ нет [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), то в секции **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. В открывшемся окне:

    * В поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** выберите `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, чтобы автоматически получить IP-адрес, или `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, чтобы выбрать зарезервированный адрес из списка.
    * (Опционально) Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, включите опцию **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. Подробнее см. в разделе [{#T}](../../../vpc/ddos-protection/index.md).
    * Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, выберите IP-адрес, который хотите привязать к ВМ. IP-адрес и ВМ должны находиться в одной [зоне доступности](../../../overview/concepts/geo-scope.md).
    * Нажмите **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

    Вместо назначения ВМ публичного IP-адреса вы можете привязать к подсети с ВМ [таблицу маршрутизации](../../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.