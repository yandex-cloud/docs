# Привязать к виртуальной машине публичный IP-адрес

Если вы создали [ВМ](../../concepts/vm.md) без [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), вы можете привязать к ней адрес, [зарезервированный вами](../../../vpc/operations/get-static-ip.md) в [{{ vpc-full-name }}](../../../vpc/) или выбранный {{ compute-name }} автоматически из свободных адресов. Зарезервированный IP-адрес и ВМ должны находиться в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

Если у ВМ несколько [сетевых интерфейсов](../../concepts/network.md), вы можете привязать публичные IP-адреса к каждому из них.

{% include [vm-attach-public-ip](../../../_includes/compute/vm-attach-public-ip.md) %}
