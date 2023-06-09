* Укажите идентификатор подсети или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.
  Если сети нет, нажмите **{{ ui-key.yacloud.compute.instances.create.button_net_empty-create }}** и создайте ее:

    * В открывшемся окне укажите имя сети.
    * (опционально) Для автоматического создания подсетей выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

  У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.compute.instances.create.button_create-subnetwork-new }}**.

* В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите способ назначения адреса:

    * `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
    * `{{ ui-key.yacloud.compute.instances.create.value_address-none }}` — чтобы не назначать публичный IP-адрес.

* Выберите [подходящие группы безопасности](../../vpc/concepts/security-groups.md).

  {% include [security-groups-note-vm](../vpc/security-groups-note-vm.md) %}

* (опционально) Создайте записи для ВМ в [зоне DNS](../../dns/concepts/dns-zone.md):

    * Разверните блок **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** и нажмите кнопку **{{ ui-key.yacloud.dns.button_add-record }}**.
    * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `{{ ui-key.yacloud.dns.label_auto-select-zone }}`.
      Вы можете добавить несколько записей во [внутренние зоны](../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../dns/concepts/compute-integration.md).
