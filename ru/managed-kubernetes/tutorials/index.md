# Практические руководства {{ managed-k8s-name }}

C помощью {{ managed-k8s-name }} вы можете работать с [контейнеризованными приложениями](../../glossary/containerization.md) в инфраструктуре {{ yandex-cloud }}: разворачивать, масштабировать и управлять приложениями в контейнерах.

## Создание и настройка проекта {#creating-project}

* [{#T}](new-kubernetes-project.md)
* [{#T}](k8s-cluster-with-no-internet.md)
* [{#T}](running-pod-gpu.md)
* [{#T}](driverless-gpu.md)
* [{#T}](time-slicing-gpu.md)
* [{#T}](migration-to-an-availability-zone.md)
* [{#T}](terraform-modules.md)

## Настройка и тестирование масштабирования {#scaling}

* [{#T}](autoscaling.md)
* [{#T}](vpa-autoscaling.md)


* [{#T}](metrics-server.md)
* [{#T}](load-testing-grpc-autoscaling.md)


## Установка NGINX {#nginx}

* [{#T}](ingress-cert-manager.md)
* [{#T}](nginx-ingress-certificate-manager.md)

Об установке Ingress-контроллера NGINX с помощью {{ marketplace-full-name }} читайте в [инструкции](../operations/applications/ingress-nginx.md).

## Использование {{ container-registry-full-name }} {#container-registry}

* [{#T}](container-registry.md)
* [{#T}](sign-cr-with-cosign.md)

## Непрерывная интеграция с {{ GL }} {#gitlab}

* [{#T}](gitlab-containers.md)


* [{#T}](cr-scanner-with-k8s-and-gitlab.md)


## Работа с DNS {#dns}

* [{#T}](custom-dns.md)
* [{#T}](dns-autoscaler.md)
* [{#T}](node-local-dns.md)
* [{#T}](dnschallenge.md)
* [{#T}](cert-manager-webhook.md)

## Резервное копирование {#backup}

* [{#T}](kubernetes-backup.md)
* [{#T}](pvc-snapshot-restore.md)

## Мониторинг {#monitoring}

* [{#T}](prometheus-grafana-monitoring.md)
* [{#T}](filebeat-oss-monitoring.md)


## Использование продуктов {{ marketplace-full-name }} {#marketplace-tutorials}

* [{#T}](marketplace/argo-cd.md)
* [{#T}](marketplace/crossplane.md)
* [{#T}](kubernetes-lockbox-secrets.md)
* [{#T}](fluent-bit-logging.md)
* [{#T}](marketplace/gateway-api.md)
* [{#T}](alb-ingress-controller.md)
* [{#T}](alb-ingress-controller-log-options.md)
* [{#T}](custom-health-checks.md)
* [{#T}](marketplace/jaeger-over-ydb.md)
* [{#T}](marketplace/kyverno.md)
* [{#T}](marketplace/metrics-provider.md)
* [{#T}](marketplace/thumbor.md)
* [{#T}](marketplace/istio.md)
* [{#T}](marketplace/hashicorp-vault.md)
