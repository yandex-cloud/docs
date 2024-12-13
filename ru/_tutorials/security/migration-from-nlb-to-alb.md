# Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для защиты от DDoS-атак с помощью {{ sws-full-name }}

[DDoS](https://ru.wikipedia.org/wiki/DoS-атака) (Distributed Denial of Service) — это кибератака, при которой отправляется множество запросов на сервер или сеть с целью перегрузить их и вывести из строя.

Сервисы могут быть развернуты в {{ yandex-cloud }} с использованием балансировщика [{{ network-load-balancer-full-name }}](../../network-load-balancer/), который распределяет трафик по облачным ресурсам. Для защиты таких сервисов от DDoS-атак и ботов на уровне приложений (L7) с помощью [{{ sws-full-name }}](../../smartwebsecurity/) потребуется мигрировать сервис с балансировщика {{ network-load-balancer-name }} на L7-балансировщик [{{ alb-full-name }}](../../application-load-balancer/).

Миграция сервисов зависит от того, какие целевые ресурсы использует {{ network-load-balancer-name }}:

* [{{ network-load-balancer-name }} с целевыми ресурсами из виртуальных машин](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-vm.md).
* [{{ network-load-balancer-name }} с целевыми ресурсами из группы виртуальных машин (Instance Groups)](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm.md).
* [{{ network-load-balancer-name }} с целевыми ресурсами из кластера Managed Service for Kubernetes](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s.md).
* [{{ network-load-balancer-name }} как целевой ресурс для {{ alb-name }}](../../tutorials/security/migration-from-nlb-to-alb/nlb-as-target-resource-alb.md).
