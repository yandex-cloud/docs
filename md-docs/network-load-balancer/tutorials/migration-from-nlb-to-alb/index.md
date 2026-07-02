[Документация Yandex Cloud](../../../index.md) > [Yandex Network Load Balancer](../../index.md) > [Практические руководства](../index.md) > Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Smart Web Security > Обзор

# Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Yandex Smart Web Security

# Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Yandex Smart Web Security

Сервисы могут быть развернуты в Yandex Cloud с использованием балансировщика [Yandex Network Load Balancer](../../index.md), который распределяет трафик по облачным ресурсам. Защитить такие сервисы от [DDoS-атак](../../../glossary/ddos.md) на уровне приложений можно с помощью [Yandex Smart Web Security](../../../smartwebsecurity/index.md). Для этого потребуется мигрировать сервис с балансировщика Network Load Balancer на L7-балансировщик [Yandex Application Load Balancer](../../../application-load-balancer/index.md).

Процесс миграции сервисов зависит от того, какие целевые ресурсы использует или какую роль играет Network Load Balancer:

* [использует целевые ресурсы из виртуальных машин](../../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md);
* [использует целевые ресурсы из группы виртуальных машин (Instance Groups)](../../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md);
* [использует целевые ресурсы из кластера Managed Service for Kubernetes](../../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md);
* [выступает как целевой ресурс для Application Load Balancer](../../../tutorials/security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md).