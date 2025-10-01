# Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты {{ sws-full-name }}

Сервисы могут быть развернуты в {{ yandex-cloud }} с использованием балансировщика [{{ network-load-balancer-full-name }}](../../network-load-balancer/), который распределяет трафик по облачным ресурсам. Защитить такие сервисы от [DDoS-атак](../../glossary/ddos.md) на уровне приложений можно с помощью [{{ sws-full-name }}](../../smartwebsecurity/). Для этого потребуется мигрировать сервис с балансировщика {{ network-load-balancer-name }} на L7-балансировщик [{{ alb-full-name }}](../../application-load-balancer/).

Процесс миграции сервисов зависит от того, какие целевые ресурсы использует или какую роль играет {{ network-load-balancer-name }}:

* [использует целевые ресурсы из виртуальных машин](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md);
* [использует целевые ресурсы из группы виртуальных машин (Instance Groups)](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md);
* [использует целевые ресурсы из кластера Managed Service for Kubernetes](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md);
* [выступает как целевой ресурс для {{ alb-name }}](../../tutorials/security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md).
