Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

* [Удалите кластер {{ mkf-full-name }}](../../managed-kafka/operations/cluster-delete.md).
* {% if audience != "internal" %}[Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md){% else %}Удалите виртуальную машину{% endif %}.
* Если вы зарезервировали публичные статические IP-адреса, освободите и {% if audience != "internal" %}[удалите их](../../vpc/operations/address-delete.md){% else %}удалите их{% endif %}
