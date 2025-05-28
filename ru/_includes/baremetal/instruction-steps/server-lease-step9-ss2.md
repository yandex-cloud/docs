* `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}` — чтобы назначить IP-адрес из диапазона адресов [выделенной публичной подсети](../../../baremetal/concepts/network.md#public-subnet).

    В появившемся поле выберите публичную подсеть или нажмите кнопку **{{ ui-key.yacloud.baremetal.action_create-public-subnet-from-server }}**, чтобы [заказать](../../../baremetal/operations/reserve-public-subnet.md) новую.

    {% note warning %}

    {% include [public-subnet-no-dhcp](../../../_includes/baremetal/public-subnet-no-dhcp.md) %}

    {% endnote %}
