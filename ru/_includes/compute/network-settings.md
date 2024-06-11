* Укажите идентификатор подсети или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.
  Если сети нет, нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

    * В открывшемся окне укажите имя сети и каталог, в котором она будет создана.
    * (Опционально) Для автоматического создания подсетей выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
    У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.

* В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:

    * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}. В этом случае можно включить [защиту от DDoS-атак](../../vpc/ddos-protection/index.md) при помощи опции ниже.
    * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../vpc/operations/set-static-ip.md).
    * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.

* Выберите [подходящие группы безопасности](../../vpc/concepts/security-groups.md).

* Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите способ назначения внутренних адресов:
    * `{{ ui-key.yacloud.common.label_auto }}` — чтобы назначить случайный IP-адрес из пула адресов, доступных в выбранной подсети.
    * `{{ ui-key.yacloud.common.label_list }}` — чтобы выбрать внутренний IP-адрес из списка зарезервированных заранее IP-адресов. При необходимости нажмите кнопку **{{ ui-key.yacloud.component.internal-v4-address-field.button_internal-address-reserve }}**, чтобы зарезервировать внутренний IP-адрес в выбранной подсети.
    * При необходимости включите опцию **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**. Опция доступна, если ранее в настройках публичного адреса вы выбрали автоматический способ назначения адреса.

* (Опционально) Создайте записи для ВМ в [зоне DNS](../../dns/concepts/dns-zone.md):

    * Разверните блок **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** и нажмите **{{ ui-key.yacloud.dns.button_add-record }}**.
    * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `{{ ui-key.yacloud.dns.label_auto-select-zone }}`.
      Вы можете добавить несколько записей во [внутренние зоны](../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../dns/concepts/compute-integration.md).
    * Чтобы создать еще одну запись, нажмите кнопку **{{ ui-key.yacloud.dns.button_add-record }}**.

Если вы хотите добавить на ВМ дополнительный [сетевой интерфейс](../../compute/concepts/network.md), нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-network-interface }}** и в появившемся блоке настроек нового интерфейса повторите действия, описанные выше в этом шаге. На одну ВМ можно добавить до восьми сетевых интерфейсов.