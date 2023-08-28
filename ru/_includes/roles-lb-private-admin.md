#### load-balancer.privateAdmin {#lb-private-admin}

Роль `{{ roles-lb-private-admin }}` позволяет создавать, изменять и удалять [балансировщики нагрузки](../network-load-balancer/concepts/index.md) и [целевые группы](../network-load-balancer/concepts/target-resources.md). Однако наличие этой роли не позволит сделать балансировщик нагрузки доступным из интернета. Для последнего потребуется роль `{{ roles-lb-admin }}`.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
