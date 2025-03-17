# Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера {{ managed-k8s-full-name }} на L7-балансировщик ALB


Сетевой балансировщик [{{ network-load-balancer-full-name }}](../../network-load-balancer/) [может использоваться](../../network-load-balancer/concepts/scenarios.md#nlb-mk8s) в составе сервисов внутри кластера [{{ managed-k8s-full-name }}](../../managed-kubernetes/). Кластер самостоятельно создает объекты сетевого балансировщика в соответствии с предоставленными манифестами и следит за составом целевой группы балансировщика, куда попадают виртуальные машины (ВМ) из групп узлов этого кластера.

Одним из вариантов применения сетевого балансировщика в кластере {{ managed-k8s-name }} является его использование в составе [Ingress-контроллера NGINX](../../managed-kubernetes/operations/applications/ingress-nginx.md).

В этом практическом руководстве рассмотрен переход с сетевого балансировщика на L7-балансировщик [{{ alb-full-name }}](../../application-load-balancer/), который создается [Ingress-контроллером {{ alb-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md), с подключенным профилем безопасности [{{ sws-full-name }}](../../smartwebsecurity/).

Схема работы L7-балансировщика с подключенным профилем безопасности {{ sws-name }}:

![image](../../_assets/tutorials/security/nlb-with-target-resource-k8s.svg)

Вы можете создать инфраструктуру для миграции сервисов с помощью следующих инструментов:
