#### load-balancer.admin {#lb-admin}

Роль `{{ roles-lb-admin }}` позволяет:
- создавать, изменять и удалять [балансировщики нагрузки](../network-load-balancer/concepts/index.md) и [целевые группы](../network-load-balancer/concepts/target-resources.md);
- назначать балансировщику нагрузки [публичный IP-адрес](../vpc/concepts/address.md).

{% note info %}

Обладание ролью `{{ roles-lb-admin }}` одновременно с разрешением на создание виртуальных машин позволяет создавать виртуальные машины с публичным IP-адресом. В случае если это нежелательно, используйте роль `{{ roles-lb-private-admin }}`.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
