В блоке **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

1. В поле **{{ ui-key.yacloud.baremetal.field_subnet-id }}** выберите существующую [приватную подсеть](../../../baremetal/concepts/network.md#private-subnet) или нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать новую.
1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите способ назначения публичного адреса:

    {% include [server-lease-step9-ss1](./server-lease-step9-ss1.md) %}

    {% include [server-lease-step9-ss2](./server-lease-step9-ss2.md) %}

    Чтобы [агент {{ backup-name }}](../../../backup/concepts/agent.md) мог обмениваться данными с серверами [провайдера резервного копирования](../../../backup/concepts/index.md#providers), на сервере должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице: {#ip-access}

    {% include [outgoing traffic](../../backup/outgoing-rules.md) %}