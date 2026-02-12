# Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера {{ managed-k8s-full-name }} на L7-балансировщик ALB


Вы можете мигрировать нагрузку с балансировщика [{{ network-load-balancer-full-name }}](../../network-load-balancer/) на L7-балансировщик [{{ alb-full-name }}](../../application-load-balancer/). Сетевой балансировщик [используется](../../network-load-balancer/concepts/scenarios.md#nlb-mk8s) в составе [Ingress-контроллера NGINX](https://kubernetes.github.io/ingress-nginx/) внутри кластера [{{ managed-k8s-full-name }}](../../managed-kubernetes/). Кластер самостоятельно создает объекты сетевого балансировщика в соответствии с предоставленными манифестами и следит за составом целевой группы балансировщика, куда попадают виртуальные машины (ВМ) из групп узлов этого кластера.

В процессе миграции с помощью [Ingress-контроллера {{ alb-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md) будет создан L7-балансировщик с подключенным профилем безопасности [{{ sws-full-name }}](../../smartwebsecurity/). Схема работы L7-балансировщика с подключенным профилем безопасности:

![image](../../_assets/tutorials/security/nlb-with-target-resource-k8s.svg)

Вы можете создать инфраструктуру для миграции сервисов с помощью следующих инструментов:
