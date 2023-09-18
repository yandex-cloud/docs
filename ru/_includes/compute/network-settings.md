* Укажите идентификатор подсети или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.
  Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

    * В открывшемся окне укажите имя сети и каталог, в котором она будет создана.
    * (Опционально) Для автоматического создания подсетей выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    * Нажмите **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
    У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.

* В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:

    * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}. В этом случае можно включить [защиту от DDoS-атак](../../vpc/ddos-protection/index.md) при помощи опции ниже.
    * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../vpc/operations/set-static-ip.md).
    * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.

* В поле **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** выберите способ назначения внутренних адресов: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` или `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.

* (Опционально) Создайте записи для ВМ в [зоне DNS](../../dns/concepts/dns-zone.md):

    * Разверните блок **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** и нажмите **{{ ui-key.yacloud.dns.button_add-record }}**.
    * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `{{ ui-key.yacloud.dns.label_auto-select-zone }}`.
      Вы можете добавить несколько записей во [внутренние зоны](../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../dns/concepts/compute-integration.md).
    * Чтобы создать еще одну запись, нажмите кнопку **{{ ui-key.yacloud.dns.button_add-record }}**.

* Выберите [подходящие группы безопасности](../../vpc/concepts/security-groups.md).
