#### load-balancer.viewer {#lb-viewer}

Роль `{{ roles-lb-viewer }}` позволяет просматривать объекты ресурсной модели:
- [балансировщики нагрузки](../network-load-balancer/concepts/index.md);
- [целевые группы](../network-load-balancer/concepts/target-resources.md).

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}

Включает разрешения, предоставляемые ролью `load-balancer.auditor`.