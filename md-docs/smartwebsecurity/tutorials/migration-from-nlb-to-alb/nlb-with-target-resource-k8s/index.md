[Документация Yandex Cloud](../../../../index.md) > [Yandex Smart Web Security](../../../index.md) > [Практические руководства](../../index.md) > [Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Smart Web Security](../index.md) > Балансировщик NLB с целевыми ресурсами из кластера Managed Service for Kubernetes > Обзор

# Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера Yandex Managed Service for Kubernetes на L7-балансировщик ALB

# Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера Yandex Managed Service for Kubernetes на L7-балансировщик ALB


Вы можете мигрировать нагрузку с балансировщика [Yandex Network Load Balancer](../../../../network-load-balancer/index.md) на L7-балансировщик [Yandex Application Load Balancer](../../../../application-load-balancer/index.md). Сетевой балансировщик [используется](../../../../network-load-balancer/concepts/scenarios.md#nlb-mk8s) в составе [Ingress-контроллера NGINX](https://kubernetes.github.io/ingress-nginx/) внутри кластера [Yandex Managed Service for Kubernetes](../../../../managed-kubernetes/index.md). Кластер самостоятельно создает объекты сетевого балансировщика в соответствии с предоставленными манифестами и следит за составом целевой группы балансировщика, куда попадают виртуальные машины (ВМ) из групп узлов этого кластера.

В процессе миграции с помощью [Ingress-контроллера Application Load Balancer](../../../../application-load-balancer/tools/k8s-ingress-controller/index.md) будет создан L7-балансировщик с подключенным профилем безопасности [Yandex Smart Web Security](../../../index.md).

{% note warning %}

Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

Схема работы L7-балансировщика с подключенным профилем безопасности:

![image](../../../../_assets/tutorials/security/nlb-with-target-resource-k8s.svg)

Вы можете создать инфраструктуру для миграции сервисов с помощью следующих инструментов:

* [Консоль управления](console.md) — используйте консоль управления Yandex Cloud, чтобы создать инфраструктуру в пошаговом режиме.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../../terraform/index.md).