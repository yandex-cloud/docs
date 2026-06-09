# Справочник инструментов Application Load Balancer для Managed Service for Kubernetes


Чтобы создавать балансировщики нагрузки и управлять ими в кластерах Managed Service for Kubernetes, сервис Application Load Balancer предоставляет следующие инструменты:

* [ALB Ingress-контроллер](ingress-controller/index.md) — для спецификации Kubernetes [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/);
* [Gateway API](gateway-api/index.md) — для спецификации Kubernetes [Gateway API](https://gateway-api.sigs.k8s.io/);
* [Yandex Cloud Gwin](gwin-index.md) — для спецификаций Kubernetes [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) и [Gateway API](https://gateway-api.sigs.k8s.io/).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](gwin-index.md).

{% endnote %}