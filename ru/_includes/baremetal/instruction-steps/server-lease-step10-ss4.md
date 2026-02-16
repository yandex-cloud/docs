В поле **{{ ui-key.yacloud.baremetal.servers.BandwidthRow.bandwidthTitle_wvZra }}** выберите пакет [потребления трафика сервера](../../../baremetal/concepts/network-restrictions.md#bandwidth-for-pubic-network). Доступные пакеты потребления трафика:

* `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan10Tb_2BFQU }}`;
* `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan100Tb_4AB2b }}`.

{% note info %}

Возможность выбора пакетов трафика доступна только для конфигураций с публичным IP-адресом и с сетевыми картами со скоростью соединения 10 Гбит/с и выше.

Уменьшить емкость подключения до 10 ТБ в сутки можно будет не раньше, чем через 24 часа после начала аренды сервера.

{% endnote %}