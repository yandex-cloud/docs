[Документация Yandex Cloud](../index.md) > Yandex Application Load Balancer > Application Load Balancer

# Yandex Application Load Balancer

Yandex Application Load Balancer служит для распределения запросов по бэкендам ваших сетевых приложений и терминирования TLS-шифрования.

С помощью Application Load Balancer вы можете:

<ul><li>Гибко распределять трафик между бэкендами ваших приложений.</li> <li>Обрабатывать TLS-трафик: устанавливать соединения и терминировать TLS-сессии с помощью сертификатов из Yandex Certificate Manager.</li> <li>Анализировать поток запросов по access-логам L7-балансировщика.</li> <li>Плавно переносить нагрузку с одной версии приложения на другую.</li> <li>Создавать и модифицировать ответы на запросы прямо на L7-балансировщике.</li> <li>Организовывать защиту ваших сервисов от злоумышленников с помощью ограничения поступающего трафика.</li></ul>

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_apploadbalancer">Уровень обслуживания Yandex Application Load Balancer</a>.

# Yandex Application Load Balancer

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создать инфраструктуру Application Load Balancer c помощью визарда](quickstart-wizard.md)

### Целевые группы

 - [Создать целевую группу](operations/target-group-create.md)

 - [Получить информацию о целевой группе](operations/target-group-get.md)

 - [Изменить целевую группу](operations/target-group-update.md)

 - [Удалить целевую группу](operations/target-group-delete.md)

### Группы бэкендов

 - [Создать группу бэкендов](operations/backend-group-create.md)

 - [Получить информацию о группе бэкендов](operations/backend-group-get.md)

 - [Изменить группу бэкендов](operations/backend-group-update.md)

 - [Удалить группу бэкендов](operations/backend-group-delete.md)

### HTTP-роутеры

 - [Создать HTTP-роутер для HTTP-трафика](operations/http-router-create.md)

 - [Создать HTTP-роутер для gRPC-трафика](operations/http-router-create-grpc.md)

 - [Получить информацию об HTTP-роутере](operations/http-router-get.md)

 - [Изменить HTTP-роутер](operations/http-router-update.md)

 - [Управлять виртуальными хостами](operations/manage-virtual-hosts.md)

 - [Управлять маршрутами](operations/manage-routes.md)

 - [Удалить HTTP-роутер](operations/http-router-delete.md)

### L7-балансировщики

 - [Создать L7-балансировщик](operations/application-load-balancer-create.md)

 - [Изменить L7-балансировщик](operations/application-load-balancer-update.md)

 - [Получить информацию об L7-балансировщике](operations/application-load-balancer-get.md)

 - [Посмотреть статистику L7-балансировщика](operations/application-load-balancer-get-stats.md)

 - [Настроить алерты](operations/application-load-balancer-manage-alerts.md)

 - [Посмотреть логи L7-балансировщика](operations/application-load-balancer-get-logs.md)

 - [Настроить запись логов L7-балансировщика](operations/application-load-balancer-manage-logs.md)

 - [Получить идентификатор лог-группы L7-балансировщика](operations/application-load-balancer-get-log-group-id.md)

 - [Остановить и запустить L7-балансировщик](operations/application-load-balancer-stop-and-start.md)

 - [Переместить ВМ в целевую группу в новой зоне доступности](operations/application-load-balancer-relocate.md)

#### Управление зоной доступности

 - [Разрешить и запретить отключение зоны доступности](operations/manage-zone/allow-and-deny-shift.md)

 - [Отключить и включить зону доступности](operations/manage-zone/start-and-cancel-shift.md)

 - [Удалить L7-балансировщик](operations/application-load-balancer-delete.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Тестирование отказоустойчивости в инфраструктуре Yandex Cloud](tutorials/testing-zone-failure-for-alb.md)

 - [Организация виртуального хостинга](tutorials/virtual-hosting.md)

### Создание L7-балансировщика с защитой от DDoS

 - [Обзор](tutorials/alb-with-ddos-protection/index.md)

 - [Консоль управления, CLI](tutorials/alb-with-ddos-protection/console.md)

 - [Terraform](tutorials/alb-with-ddos-protection/terraform.md)

 - [Создание L7-балансировщика с профилем безопасности Smart Web Security через Ingress-контроллер Application Load Balancer](tutorials/alb-ingress-with-sws-profile.md)

### Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Smart Web Security

 - [Обзор](tutorials/migration-from-nlb-to-alb/index.md)

#### Балансировщик NLB с целевыми ресурсами из виртуальных машин

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из группы виртуальных машин

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из кластера Managed Service for Kubernetes

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/terraform.md)

#### Балансировщик NLB как целевой ресурс для ALB

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/terraform.md)

### Интеграция L7-балансировщика с CDN и Object Storage

 - [Обзор](tutorials/cdn-storage-integration/index.md)

 - [Консоль управления, CLI и API](tutorials/cdn-storage-integration/console.md)

 - [Terraform](tutorials/cdn-storage-integration/terraform.md)

 - [Сине-зеленое и канареечное развертывание версий сервиса](tutorials/blue-green-canary-deployment.md)

### Терминирование TLS-соединений

 - [Обзор](tutorials/tls-termination/index.md)

 - [Консоль управления](tutorials/tls-termination/console.md)

 - [Terraform](tutorials/tls-termination/terraform.md)

 - [Запись логов балансировщика в PostgreSQL](tutorials/logging.md)

 - [Настройка Gateway API в Yandex Managed Service for Kubernetes](tutorials/gateway-api.md)

 - [Настройка L7-балансировщика Application Load Balancer с помощью Ingress-контроллера](tutorials/alb-ingress-controller.md)

 - [Настройка логирования для L7-балансировщика Application Load Balancer с помощью Ingress-контроллера](tutorials/alb-ingress-controller-log-options.md)

### Отказоустойчивый сайт с балансировкой нагрузки через Application Load Balancer

 - [Обзор](tutorials/application-load-balancer-website/index.md)

 - [Консоль управления](tutorials/application-load-balancer-website/console.md)

 - [Terraform](tutorials/application-load-balancer-website/terraform.md)

 - [Проверка состояния приложений в кластере Managed Service for Kubernetes с помощью L7-балансировщика Application Load Balancer](tutorials/custom-health-checks.md)

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Next-Generation Firewall](tutorials/high-accessible-dmz.md)

### Создание L7-балансировщика Application Load Balancer с профилем безопасности Smart Web Security

 - [Обзор](tutorials/balancer-with-sws-profile/index.md)

 - [Консоль управления](tutorials/balancer-with-sws-profile/console.md)

 - [Terraform](tutorials/balancer-with-sws-profile/terraform.md)

### Развертывание Nextcloud в интеграции с Object Storage

 - [Обзор](tutorials/integrate-nextcloud/index.md)

 - [Развертывание Nextcloud на ВМ из образа Container Optimized Image](tutorials/integrate-nextcloud/coi-based.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ вручную](tutorials/integrate-nextcloud/fault-tolerant.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ с помощью Terraform](tutorials/integrate-nextcloud/terraform.md)

 - [Развертывание веб-приложения на серверах BareMetal с L7-балансировщиком и защитой Smart Web Security](tutorials/webapp-on-bms-behind-sws.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Балансировщики нагрузки](concepts/application-load-balancer.md)

 - [HTTP-роутеры](concepts/http-router.md)

 - [Лимит на количество запросов](concepts/rate-limiter.md)

 - [Группы бэкендов](concepts/backend-group.md)

 - [Целевые группы](concepts/target-group.md)

 - [Мониторинг и логирование](concepts/monitoring.md)

 - [Графики мониторинга](concepts/function-monitoring.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Рекомендации по настройке проверок состояния](concepts/best-practices.md)

## Инструменты для Managed Service for Kubernetes

 - [Обзор](tools/index.md)

### Gwin

 - [Обзор](tools/gwin/index.md)

 - [Установка Gwin](tools/gwin/quickstart.md)

 - [Политики Gwin](tools/gwin/policies.md)

 - [Миграция приложений с ALB Ingress-контроллера на Gwin](tools/gwin/ingress-gwin-migration.md)

 - [Механизм Attachment для интеграции Gwin с Application Load Balancer](tools/gwin/gwin-alb-attachment.md)

#### Конфигурация ресурсов (англ.)

 - [Gateway](gwin-ref/gateway.md)

 - [GatewayPolicy](gwin-ref/gatewaypolicy.md)

 - [GRPCRoute](gwin-ref/grpcroute.md)

 - [HTTPRoute](gwin-ref/httproute.md)

 - [Ingress](gwin-ref/ingress.md)

 - [IngressBackendGroup](gwin-ref/ingressbackendgroup.md)

 - [IngressPolicy](gwin-ref/ingresspolicy.md)

 - [RoutePolicy](gwin-ref/routepolicy.md)

 - [Service](gwin-ref/service.md)

 - [ServicePolicy](gwin-ref/servicepolicy.md)

 - [TLSRoute](gwin-ref/tlsroute.md)

 - [YCCertificate](gwin-ref/yccertificate.md)

 - [YCStorageBucket](gwin-ref/ycstoragebucket.md)

### Ingress-контроллер

 - [Обзор](tools/k8s-ingress-controller/index.md)

 - [Принципы работы](tools/k8s-ingress-controller/principles.md)

 - [Установить Ingress-контроллер](operations/k8s-ingress-controller-install.md)

 - [Обновить Ingress-контроллер](operations/k8s-ingress-controller-upgrade.md)

#### Конфигурация ресурсов

 - [Ingress](k8s-ref/ingress.md)

 - [HttpBackendGroup](k8s-ref/http-backend-group.md)

 - [GrpcBackendGroup](k8s-ref/grpc-backend-group.md)

 - [IngressClass](k8s-ref/ingress-class.md)

 - [Service для Ingress](k8s-ref/service-for-ingress.md)

### Gateway API

 - [Обзор](tools/k8s-gateway-api/index.md)

 - [Установить Gateway API](operations/k8s-gateway-api-install.md)

#### Конфигурация ресурсов

 - [Gateway](k8s-ref/gateway.md)

 - [GatewayPolicy](k8s-ref/gateway-policy.md)

 - [HTTPRoute](k8s-ref/http-route.md)

 - [GRPCRoute](k8s-ref/grpc-route.md)

 - [RoutePolicy](k8s-ref/route-policy.md)

 - [TLSRoute](k8s-ref/tls-route.md)

 - [Service для Gateway API](k8s-ref/service-for-gateway.md)

 - [YCCertificate](k8s-ref/yc-certificate.md)

 - [YCStorageBucket](k8s-ref/yc-storage-bucket.md)

 - [Настройка групп безопасности](tools/k8s-ingress-controller/security-groups.md)

 - [Работа с сервисными аккаунтами](tools/k8s-ingress-controller/service-account.md)

 - [Создание и изменение ресурсов по конфигурации](operations/k8s-ingress-controller-apply.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### backend-group

 - [Overview](cli-ref/backend-group/index.md)

 - [add-grpc-backend](cli-ref/backend-group/add-grpc-backend.md)

 - [add-http-backend](cli-ref/backend-group/add-http-backend.md)

 - [add-stream-backend](cli-ref/backend-group/add-stream-backend.md)

 - [create](cli-ref/backend-group/create.md)

 - [delete](cli-ref/backend-group/delete.md)

 - [delete-grpc-backend](cli-ref/backend-group/delete-grpc-backend.md)

 - [delete-http-backend](cli-ref/backend-group/delete-http-backend.md)

 - [delete-stream-backend](cli-ref/backend-group/delete-stream-backend.md)

 - [get](cli-ref/backend-group/get.md)

 - [list](cli-ref/backend-group/list.md)

 - [update](cli-ref/backend-group/update.md)

 - [update-grpc-backend](cli-ref/backend-group/update-grpc-backend.md)

 - [update-http-backend](cli-ref/backend-group/update-http-backend.md)

 - [update-stream-backend](cli-ref/backend-group/update-stream-backend.md)

### http-router

 - [Overview](cli-ref/http-router/index.md)

 - [create](cli-ref/http-router/create.md)

 - [delete](cli-ref/http-router/delete.md)

 - [get](cli-ref/http-router/get.md)

 - [list](cli-ref/http-router/list.md)

 - [update](cli-ref/http-router/update.md)

### load-balancer

 - [Overview](cli-ref/load-balancer/index.md)

 - [add-listener](cli-ref/load-balancer/add-listener.md)

 - [add-location](cli-ref/load-balancer/add-location.md)

 - [add-sni](cli-ref/load-balancer/add-sni.md)

 - [add-stream-listener](cli-ref/load-balancer/add-stream-listener.md)

 - [add-stream-sni](cli-ref/load-balancer/add-stream-sni.md)

 - [autoscale](cli-ref/load-balancer/autoscale.md)

 - [cancel-zonal-shift](cli-ref/load-balancer/cancel-zonal-shift.md)

 - [create](cli-ref/load-balancer/create.md)

 - [delete](cli-ref/load-balancer/delete.md)

 - [disable-traffic](cli-ref/load-balancer/disable-traffic.md)

 - [disable-zones](cli-ref/load-balancer/disable-zones.md)

 - [enable-traffic](cli-ref/load-balancer/enable-traffic.md)

 - [enable-zones](cli-ref/load-balancer/enable-zones.md)

 - [get](cli-ref/load-balancer/get.md)

 - [list](cli-ref/load-balancer/list.md)

 - [list-operations](cli-ref/load-balancer/list-operations.md)

 - [logging](cli-ref/load-balancer/logging.md)

 - [remove-listener](cli-ref/load-balancer/remove-listener.md)

 - [remove-location](cli-ref/load-balancer/remove-location.md)

 - [remove-sni](cli-ref/load-balancer/remove-sni.md)

 - [start](cli-ref/load-balancer/start.md)

 - [start-zonal-shift](cli-ref/load-balancer/start-zonal-shift.md)

 - [stop](cli-ref/load-balancer/stop.md)

 - [target-states](cli-ref/load-balancer/target-states.md)

 - [update](cli-ref/load-balancer/update.md)

 - [update-listener](cli-ref/load-balancer/update-listener.md)

 - [update-sni](cli-ref/load-balancer/update-sni.md)

 - [update-stream-listener](cli-ref/load-balancer/update-stream-listener.md)

 - [update-stream-sni](cli-ref/load-balancer/update-stream-sni.md)

### target-group

 - [Overview](cli-ref/target-group/index.md)

 - [add-targets](cli-ref/target-group/add-targets.md)

 - [create](cli-ref/target-group/create.md)

 - [delete](cli-ref/target-group/delete.md)

 - [get](cli-ref/target-group/get.md)

 - [list](cli-ref/target-group/list.md)

 - [remove-targets](cli-ref/target-group/remove-targets.md)

 - [update](cli-ref/target-group/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### backend-group

 - [Overview](cli-ref/v0/backend-group/index.md)

 - [add-grpc-backend](cli-ref/v0/backend-group/add-grpc-backend.md)

 - [add-http-backend](cli-ref/v0/backend-group/add-http-backend.md)

 - [add-stream-backend](cli-ref/v0/backend-group/add-stream-backend.md)

 - [create](cli-ref/v0/backend-group/create.md)

 - [delete](cli-ref/v0/backend-group/delete.md)

 - [delete-grpc-backend](cli-ref/v0/backend-group/delete-grpc-backend.md)

 - [delete-http-backend](cli-ref/v0/backend-group/delete-http-backend.md)

 - [delete-stream-backend](cli-ref/v0/backend-group/delete-stream-backend.md)

 - [get](cli-ref/v0/backend-group/get.md)

 - [list](cli-ref/v0/backend-group/list.md)

 - [update](cli-ref/v0/backend-group/update.md)

 - [update-grpc-backend](cli-ref/v0/backend-group/update-grpc-backend.md)

 - [update-http-backend](cli-ref/v0/backend-group/update-http-backend.md)

 - [update-stream-backend](cli-ref/v0/backend-group/update-stream-backend.md)

#### http-router

 - [Overview](cli-ref/v0/http-router/index.md)

 - [create](cli-ref/v0/http-router/create.md)

 - [delete](cli-ref/v0/http-router/delete.md)

 - [get](cli-ref/v0/http-router/get.md)

 - [list](cli-ref/v0/http-router/list.md)

 - [update](cli-ref/v0/http-router/update.md)

#### load-balancer

 - [Overview](cli-ref/v0/load-balancer/index.md)

 - [add-listener](cli-ref/v0/load-balancer/add-listener.md)

 - [add-location](cli-ref/v0/load-balancer/add-location.md)

 - [add-sni](cli-ref/v0/load-balancer/add-sni.md)

 - [add-stream-listener](cli-ref/v0/load-balancer/add-stream-listener.md)

 - [add-stream-sni](cli-ref/v0/load-balancer/add-stream-sni.md)

 - [autoscale](cli-ref/v0/load-balancer/autoscale.md)

 - [cancel-zonal-shift](cli-ref/v0/load-balancer/cancel-zonal-shift.md)

 - [create](cli-ref/v0/load-balancer/create.md)

 - [delete](cli-ref/v0/load-balancer/delete.md)

 - [disable-traffic](cli-ref/v0/load-balancer/disable-traffic.md)

 - [disable-zones](cli-ref/v0/load-balancer/disable-zones.md)

 - [enable-traffic](cli-ref/v0/load-balancer/enable-traffic.md)

 - [enable-zones](cli-ref/v0/load-balancer/enable-zones.md)

 - [get](cli-ref/v0/load-balancer/get.md)

 - [list](cli-ref/v0/load-balancer/list.md)

 - [list-operations](cli-ref/v0/load-balancer/list-operations.md)

 - [logging](cli-ref/v0/load-balancer/logging.md)

 - [remove-listener](cli-ref/v0/load-balancer/remove-listener.md)

 - [remove-location](cli-ref/v0/load-balancer/remove-location.md)

 - [remove-sni](cli-ref/v0/load-balancer/remove-sni.md)

 - [start](cli-ref/v0/load-balancer/start.md)

 - [start-zonal-shift](cli-ref/v0/load-balancer/start-zonal-shift.md)

 - [stop](cli-ref/v0/load-balancer/stop.md)

 - [target-states](cli-ref/v0/load-balancer/target-states.md)

 - [update](cli-ref/v0/load-balancer/update.md)

 - [update-listener](cli-ref/v0/load-balancer/update-listener.md)

 - [update-sni](cli-ref/v0/load-balancer/update-sni.md)

 - [update-stream-listener](cli-ref/v0/load-balancer/update-stream-listener.md)

 - [update-stream-sni](cli-ref/v0/load-balancer/update-stream-sni.md)

#### target-group

 - [Overview](cli-ref/v0/target-group/index.md)

 - [add-targets](cli-ref/v0/target-group/add-targets.md)

 - [create](cli-ref/v0/target-group/create.md)

 - [delete](cli-ref/v0/target-group/delete.md)

 - [get](cli-ref/v0/target-group/get.md)

 - [list](cli-ref/v0/target-group/list.md)

 - [remove-targets](cli-ref/v0/target-group/remove-targets.md)

 - [update](cli-ref/v0/target-group/update.md)

#### virtual-host

 - [Overview](cli-ref/v0/virtual-host/index.md)

 - [append-grpc-route](cli-ref/v0/virtual-host/append-grpc-route.md)

 - [append-http-route](cli-ref/v0/virtual-host/append-http-route.md)

 - [create](cli-ref/v0/virtual-host/create.md)

 - [delete](cli-ref/v0/virtual-host/delete.md)

 - [get](cli-ref/v0/virtual-host/get.md)

 - [insert-grpc-route](cli-ref/v0/virtual-host/insert-grpc-route.md)

 - [insert-http-route](cli-ref/v0/virtual-host/insert-http-route.md)

 - [list](cli-ref/v0/virtual-host/list.md)

 - [prepend-grpc-route](cli-ref/v0/virtual-host/prepend-grpc-route.md)

 - [prepend-http-route](cli-ref/v0/virtual-host/prepend-http-route.md)

 - [remove-grpc-route](cli-ref/v0/virtual-host/remove-grpc-route.md)

 - [remove-http-route](cli-ref/v0/virtual-host/remove-http-route.md)

 - [update](cli-ref/v0/virtual-host/update.md)

 - [update-grpc-route](cli-ref/v0/virtual-host/update-grpc-route.md)

 - [update-http-route](cli-ref/v0/virtual-host/update-http-route.md)

### virtual-host

 - [Overview](cli-ref/virtual-host/index.md)

 - [append-grpc-route](cli-ref/virtual-host/append-grpc-route.md)

 - [append-http-route](cli-ref/virtual-host/append-http-route.md)

 - [create](cli-ref/virtual-host/create.md)

 - [delete](cli-ref/virtual-host/delete.md)

 - [get](cli-ref/virtual-host/get.md)

 - [insert-grpc-route](cli-ref/virtual-host/insert-grpc-route.md)

 - [insert-http-route](cli-ref/virtual-host/insert-http-route.md)

 - [list](cli-ref/virtual-host/list.md)

 - [prepend-grpc-route](cli-ref/virtual-host/prepend-grpc-route.md)

 - [prepend-http-route](cli-ref/virtual-host/prepend-http-route.md)

 - [remove-grpc-route](cli-ref/virtual-host/remove-grpc-route.md)

 - [remove-http-route](cli-ref/virtual-host/remove-http-route.md)

 - [update](cli-ref/virtual-host/update.md)

 - [update-grpc-route](cli-ref/virtual-host/update-grpc-route.md)

 - [update-http-route](cli-ref/virtual-host/update-http-route.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### BackendGroup

 - [Overview](api-ref/grpc/BackendGroup/index.md)

 - [Get](api-ref/grpc/BackendGroup/get.md)

 - [List](api-ref/grpc/BackendGroup/list.md)

 - [Create](api-ref/grpc/BackendGroup/create.md)

 - [Update](api-ref/grpc/BackendGroup/update.md)

 - [Delete](api-ref/grpc/BackendGroup/delete.md)

 - [AddBackend](api-ref/grpc/BackendGroup/addBackend.md)

 - [RemoveBackend](api-ref/grpc/BackendGroup/removeBackend.md)

 - [UpdateBackend](api-ref/grpc/BackendGroup/updateBackend.md)

 - [ListOperations](api-ref/grpc/BackendGroup/listOperations.md)

#### HttpRouter

 - [Overview](api-ref/grpc/HttpRouter/index.md)

 - [Get](api-ref/grpc/HttpRouter/get.md)

 - [List](api-ref/grpc/HttpRouter/list.md)

 - [Create](api-ref/grpc/HttpRouter/create.md)

 - [Update](api-ref/grpc/HttpRouter/update.md)

 - [Delete](api-ref/grpc/HttpRouter/delete.md)

 - [ListOperations](api-ref/grpc/HttpRouter/listOperations.md)

#### LoadBalancer

 - [Overview](api-ref/grpc/LoadBalancer/index.md)

 - [Get](api-ref/grpc/LoadBalancer/get.md)

 - [List](api-ref/grpc/LoadBalancer/list.md)

 - [Create](api-ref/grpc/LoadBalancer/create.md)

 - [Update](api-ref/grpc/LoadBalancer/update.md)

 - [Delete](api-ref/grpc/LoadBalancer/delete.md)

 - [Start](api-ref/grpc/LoadBalancer/start.md)

 - [Stop](api-ref/grpc/LoadBalancer/stop.md)

 - [AddListener](api-ref/grpc/LoadBalancer/addListener.md)

 - [RemoveListener](api-ref/grpc/LoadBalancer/removeListener.md)

 - [UpdateListener](api-ref/grpc/LoadBalancer/updateListener.md)

 - [AddSniMatch](api-ref/grpc/LoadBalancer/addSniMatch.md)

 - [UpdateSniMatch](api-ref/grpc/LoadBalancer/updateSniMatch.md)

 - [RemoveSniMatch](api-ref/grpc/LoadBalancer/removeSniMatch.md)

 - [GetTargetStates](api-ref/grpc/LoadBalancer/getTargetStates.md)

 - [ListOperations](api-ref/grpc/LoadBalancer/listOperations.md)

 - [StartZonalShift](api-ref/grpc/LoadBalancer/startZonalShift.md)

 - [CancelZonalShift](api-ref/grpc/LoadBalancer/cancelZonalShift.md)

 - [DisableZones](api-ref/grpc/LoadBalancer/disableZones.md)

 - [EnableZones](api-ref/grpc/LoadBalancer/enableZones.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### TargetGroup

 - [Overview](api-ref/grpc/TargetGroup/index.md)

 - [Get](api-ref/grpc/TargetGroup/get.md)

 - [List](api-ref/grpc/TargetGroup/list.md)

 - [Create](api-ref/grpc/TargetGroup/create.md)

 - [Update](api-ref/grpc/TargetGroup/update.md)

 - [Delete](api-ref/grpc/TargetGroup/delete.md)

 - [AddTargets](api-ref/grpc/TargetGroup/addTargets.md)

 - [RemoveTargets](api-ref/grpc/TargetGroup/removeTargets.md)

 - [ListOperations](api-ref/grpc/TargetGroup/listOperations.md)

#### VirtualHost

 - [Overview](api-ref/grpc/VirtualHost/index.md)

 - [Get](api-ref/grpc/VirtualHost/get.md)

 - [List](api-ref/grpc/VirtualHost/list.md)

 - [Create](api-ref/grpc/VirtualHost/create.md)

 - [Update](api-ref/grpc/VirtualHost/update.md)

 - [Delete](api-ref/grpc/VirtualHost/delete.md)

 - [RemoveRoute](api-ref/grpc/VirtualHost/removeRoute.md)

 - [UpdateRoute](api-ref/grpc/VirtualHost/updateRoute.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### BackendGroup

 - [Overview](api-ref/BackendGroup/index.md)

 - [Get](api-ref/BackendGroup/get.md)

 - [List](api-ref/BackendGroup/list.md)

 - [Create](api-ref/BackendGroup/create.md)

 - [Update](api-ref/BackendGroup/update.md)

 - [Delete](api-ref/BackendGroup/delete.md)

 - [AddBackend](api-ref/BackendGroup/addBackend.md)

 - [RemoveBackend](api-ref/BackendGroup/removeBackend.md)

 - [UpdateBackend](api-ref/BackendGroup/updateBackend.md)

 - [ListOperations](api-ref/BackendGroup/listOperations.md)

#### HttpRouter

 - [Overview](api-ref/HttpRouter/index.md)

 - [Get](api-ref/HttpRouter/get.md)

 - [List](api-ref/HttpRouter/list.md)

 - [Create](api-ref/HttpRouter/create.md)

 - [Update](api-ref/HttpRouter/update.md)

 - [Delete](api-ref/HttpRouter/delete.md)

 - [ListOperations](api-ref/HttpRouter/listOperations.md)

#### LoadBalancer

 - [Overview](api-ref/LoadBalancer/index.md)

 - [Get](api-ref/LoadBalancer/get.md)

 - [List](api-ref/LoadBalancer/list.md)

 - [Create](api-ref/LoadBalancer/create.md)

 - [Update](api-ref/LoadBalancer/update.md)

 - [Delete](api-ref/LoadBalancer/delete.md)

 - [Start](api-ref/LoadBalancer/start.md)

 - [Stop](api-ref/LoadBalancer/stop.md)

 - [AddListener](api-ref/LoadBalancer/addListener.md)

 - [RemoveListener](api-ref/LoadBalancer/removeListener.md)

 - [UpdateListener](api-ref/LoadBalancer/updateListener.md)

 - [AddSniMatch](api-ref/LoadBalancer/addSniMatch.md)

 - [UpdateSniMatch](api-ref/LoadBalancer/updateSniMatch.md)

 - [RemoveSniMatch](api-ref/LoadBalancer/removeSniMatch.md)

 - [GetTargetStates](api-ref/LoadBalancer/getTargetStates.md)

 - [ListOperations](api-ref/LoadBalancer/listOperations.md)

 - [StartZonalShift](api-ref/LoadBalancer/startZonalShift.md)

 - [CancelZonalShift](api-ref/LoadBalancer/cancelZonalShift.md)

 - [DisableZones](api-ref/LoadBalancer/disableZones.md)

 - [EnableZones](api-ref/LoadBalancer/enableZones.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### TargetGroup

 - [Overview](api-ref/TargetGroup/index.md)

 - [Get](api-ref/TargetGroup/get.md)

 - [List](api-ref/TargetGroup/list.md)

 - [Create](api-ref/TargetGroup/create.md)

 - [Update](api-ref/TargetGroup/update.md)

 - [Delete](api-ref/TargetGroup/delete.md)

 - [AddTargets](api-ref/TargetGroup/addTargets.md)

 - [RemoveTargets](api-ref/TargetGroup/removeTargets.md)

 - [ListOperations](api-ref/TargetGroup/listOperations.md)

#### VirtualHost

 - [Overview](api-ref/VirtualHost/index.md)

 - [Get](api-ref/VirtualHost/get.md)

 - [List](api-ref/VirtualHost/list.md)

 - [Create](api-ref/VirtualHost/create.md)

 - [Update](api-ref/VirtualHost/update.md)

 - [Delete](api-ref/VirtualHost/delete.md)

 - [RemoveRoute](api-ref/VirtualHost/removeRoute.md)

 - [UpdateRoute](api-ref/VirtualHost/updateRoute.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

## Справочник аудитных логов

 - [AddBackendGroupBackend](events-ref/AddBackendGroupBackend.md)

 - [AddLoadBalancerListener](events-ref/AddLoadBalancerListener.md)

 - [AddLoadBalancerSniMatch](events-ref/AddLoadBalancerSniMatch.md)

 - [AddTargetGroupTargets](events-ref/AddTargetGroupTargets.md)

 - [CancelZonalShift](events-ref/CancelZonalShift.md)

 - [CreateBackendGroup](events-ref/CreateBackendGroup.md)

 - [CreateHttpRouter](events-ref/CreateHttpRouter.md)

 - [CreateLoadBalancer](events-ref/CreateLoadBalancer.md)

 - [CreateTargetGroup](events-ref/CreateTargetGroup.md)

 - [CreateVirtualHost](events-ref/CreateVirtualHost.md)

 - [DeleteBackendGroup](events-ref/DeleteBackendGroup.md)

 - [DeleteHttpRouter](events-ref/DeleteHttpRouter.md)

 - [DeleteLoadBalancer](events-ref/DeleteLoadBalancer.md)

 - [DeleteTargetGroup](events-ref/DeleteTargetGroup.md)

 - [DeleteVirtualHost](events-ref/DeleteVirtualHost.md)

 - [LoadBalancerHTTPAccessLog](events-ref/LoadBalancerHTTPAccessLog.md)

 - [LoadBalancerTCPAccessLog](events-ref/LoadBalancerTCPAccessLog.md)

 - [RemoveBackendGroupBackend](events-ref/RemoveBackendGroupBackend.md)

 - [RemoveLoadBalancerListener](events-ref/RemoveLoadBalancerListener.md)

 - [RemoveLoadBalancerSniMatch](events-ref/RemoveLoadBalancerSniMatch.md)

 - [RemoveTargetGroupTargets](events-ref/RemoveTargetGroupTargets.md)

 - [RemoveVirtualHostRoute](events-ref/RemoveVirtualHostRoute.md)

 - [StartLoadBalancer](events-ref/StartLoadBalancer.md)

 - [StartZonalShift](events-ref/StartZonalShift.md)

 - [StopLoadBalancer](events-ref/StopLoadBalancer.md)

 - [UpdateBackendGroup](events-ref/UpdateBackendGroup.md)

 - [UpdateBackendGroupBackend](events-ref/UpdateBackendGroupBackend.md)

 - [UpdateHttpRouter](events-ref/UpdateHttpRouter.md)

 - [UpdateLoadBalancer](events-ref/UpdateLoadBalancer.md)

 - [UpdateLoadBalancerListener](events-ref/UpdateLoadBalancerListener.md)

 - [UpdateLoadBalancerSniMatch](events-ref/UpdateLoadBalancerSniMatch.md)

 - [UpdateTargetGroup](events-ref/UpdateTargetGroup.md)

 - [UpdateVirtualHost](events-ref/UpdateVirtualHost.md)

 - [UpdateVirtualHostRoute](events-ref/UpdateVirtualHostRoute.md)

 - [Логи L7-балансировщика](logs-ref.md)

 - [История изменений](release-notes.md)

 - [Обучающие курсы](training.md)