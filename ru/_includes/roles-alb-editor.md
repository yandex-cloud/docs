#### alb.editor {#alb-editor}

Роль `{{ roles-alb-editor }}` позволяет создавать, изменять и удалять объекты ресурсной модели:
* [L7-балансировщики](../application-load-balancer/concepts/application-load-balancer.md);
* [HTTP-роутеры](../application-load-balancer/concepts/http-router.md);
* [группы бэкендов](../application-load-balancer/concepts/backend-group.md);
* [целевые группы](../application-load-balancer/concepts/target-group.md).

Включает в себя все разрешения, предоставляемые ролью `alb.user`.

{% note info %}

Обладание ролью `{{ roles-alb-admin }}` одновременно с ролью `vpc.publicAdmin` на сеть, в которой находится балансировщик, позволяет создавать L7-балансировщик с публичным IP-адресом.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
