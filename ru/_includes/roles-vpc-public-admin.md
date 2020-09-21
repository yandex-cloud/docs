### vpc.publicAdmin {#vpc-public-admin}

Роль `{{ roles-vpc-public-admin }}` позволяет управлять внешней связностью:
- создавать [статические публичные IP-адреса](../vpc/concepts/address.md);
- включать и выключать функцию <q>NAT в интернет</q>.

Наличие роли `{{ roles-vpc-public-admin }}` также необходимо для создания ресурсов с публичными IP-адресами, например: виртуальных машин или кластеров управляемых баз данных.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
