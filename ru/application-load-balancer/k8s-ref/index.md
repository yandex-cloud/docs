# Справочник Ingress-контроллера {{ alb-name }} для {{ managed-k8s-name }}

[Ingress-контроллер {{ alb-name }}](../tools/k8s-ingress-controller/index.md) позволяет разворачивать L7-балансировщики нагрузки в кластерах {{ managed-k8s-full-name }}. Для конфигурации разворачиваемой инфраструктуры используются следующие основные ресурсы {{ k8s }}:

* [Ingress](ingress.md) — правила распределения трафика между бэкендами.
* [HttpBackendGroup](http-backend-group.md) — объединение бэкендов в группы.
* [Service](service.md) — описание сервисов {{ k8s }}, используемых в качестве бэкендов.