# Инструменты для {{ managed-k8s-name }}

Чтобы создавать балансировщики нагрузки и управлять ими в кластерах {{ managed-k8s-name }}, сервис {{ alb-name }} предоставляет следующие инструменты:

* [ALB Ingress-контроллер]({{ ingress-local-link2 }}/index.md) — для спецификации {{ k8s }} [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/);
* [Gateway API]({{ gateway-local-link2 }}/index.md) — для спецификации {{ k8s }} [Gateway API](https://gateway-api.sigs.k8s.io/);
* [{{ yandex-cloud }} Gwin]({{ gwin-tip-local-link }}) — для спецификаций {{ k8s }} [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) и [Gateway API](https://gateway-api.sigs.k8s.io/).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [{{ yandex-cloud }} Gwin]({{ gwin-tip-local-link }}).

{% endnote %}