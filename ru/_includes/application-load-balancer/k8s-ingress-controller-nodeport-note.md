{% note warning %}

Сервисы {{ k8s }}, используемые в качестве бэкендов (указанные в правилах `Ingress` напрямую или в `HttpBackendGroup`/`GrpcBackendGroup`), должны иметь тип `NodePort`. Подробнее об этом типе см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

{% endnote %}