# {{ managed-k8s-name }} practical guidelines

* [{#T}](new-kubernetes-project.md)
* [{#T}](container-registry.md)
* [{#T}](running-pod-gpu.md)
* [{#T}](ingress-cert-manager.md)
* [{#T}](nginx-ingress-certificate-manager.md)
* [{#T}](backup.md)
* [{#T}](autoscaling.md)
* [{#T}](vpa-autoscaling.md)

{% if product == "yandex-cloud" %}

* [{#T}](load-testing-grpc-autoscaling.md)

{% endif %}

* [{#T}](pvc-snapshot-restore.md)
* [{#T}](custom-dns.md)
* [{#T}](dns-autoscaler.md)
* [{#T}](node-local-dns.md)
* [{#T}](gitlab-containers.md)

{% if product == "yandex-cloud" %}

## Using {{ marketplace-full-name }} products {#marketplace-tutorials}

* [{#T}](marketplace/argo-cd.md)
* [{#T}](marketplace/crossplane.md)
* [{#T}](kubernetes-lockbox-secrets.md)
* [{#T}](fluent-bit-logging.md)
* [{#T}](alb-ingress-controller.md)
* [{#T}](marketplace/jaeger-over-ydb.md)

{% endif %}