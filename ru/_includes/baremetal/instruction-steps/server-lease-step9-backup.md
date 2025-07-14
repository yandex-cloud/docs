В блоке **Сетевые настройки**:

1. В поле **{{ ui-key.yacloud.baremetal.field_subnet-id }}** выберите существующую [приватную подсеть](../../../baremetal/concepts/network.md#private-subnet) или нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать новую.
1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите способ назначения публичного адреса:

    {% include [server-lease-step9-ss1](./server-lease-step9-ss1.md) %}

    {% include [server-lease-step9-ss2](./server-lease-step9-ss2.md) %}

    {% include [server-lease-cli-backup-network](./server-lease-cli-backup-network.md) %}

    {% include [outgoing traffic](../../backup/outgoing-rules.md) %}