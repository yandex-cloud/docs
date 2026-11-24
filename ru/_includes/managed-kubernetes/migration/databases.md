Проверьте в [матрице трансферов](../../../data-transfer/transfer-matrix.md), что для вашей комбинации источника и приемника поддерживается трансфер типа [{{ dt-type-copy-repl }}](../../../data-transfer/concepts/transfer-lifecycle.md#copy-and-replication), и выполните миграцию в соответствии с [руководством для вашей базы данных](../../../data-transfer/tutorials/index.md#migration).

{% note info %}

Если вы не используете [{{ interconnect-name }}](../../../interconnect/concepts/index.md) или [IPsec VPN](../../../tutorials/routing/ipsec/index.md), разрешите подключение к кластеру-источнику из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../overview/concepts/public-ips.md#virtual-private-cloud).

{% endnote %}

Если {{ data-transfer-name }} не поддерживает нужный источник или требуется больший контроль, ознакомьтесь с документацией управляемых баз данных, куда запланирована миграция.
