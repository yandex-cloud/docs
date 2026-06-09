# Yandex Smart Web Security

Yandex Smart Web Security позволяет защитить вашу инфраструктуру от DDoS-атак и ботов на уровне приложений (L7).  Также вы можете подключить дополнительную защиту: <a href="concepts/waf.md">Web Application Firewall (WAF)</a> и ограничитель запросов <a href="concepts/arl.md">Advanced Rate Limiter (ARL)</a>.

# Yandex Smart Web Security

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Профили безопасности

 - [Создать профиль](operations/profile-create.md)

 - [Изменить основные параметры профиля](operations/profile-update.md)

 - [Получить информацию о профиле](operations/profile-get.md)

 - [Удалить профиль](operations/profile-delete.md)

 - [Добавить правило](operations/rule-add.md)

 - [Изменить правило](operations/rule-update.md)

 - [Удалить правило](operations/rule-delete.md)

 - [Подключить профиль к ресурсу](operations/host-connect.md)

 - [Отключить профиль от ресурса](operations/host-delete.md)

### Профили WAF

 - [Создать профиль](operations/waf-profile-create.md)

 - [Изменить основные параметры профиля](operations/waf-profile-update.md)

 - [Получить информацию о профиле](operations/waf-profile-get.md)

 - [Удалить профиль](operations/waf-profile-delete.md)

 - [Настроить наборы правил](operations/configure-set-rules.md)

 - [Получить информацию о наборе правил](operations/get-set-rules.md)

 - [Добавить правило-исключение](operations/exclusion-rule-add.md)

 - [Изменить правило-исключение](operations/exclusion-rule-update.md)

 - [Удалить правило-исключение](operations/exclusion-rule-delete.md)

### Профили ARL

 - [Создать профиль](operations/arl-profile-create.md)

 - [Изменить основные параметры профиля](operations/arl-profile-update.md)

 - [Получить информацию о профиле](operations/arl-profile-get.md)

 - [Удалить профиль](operations/arl-profile-delete.md)

 - [Добавить правило](operations/arl-rule-add.md)

 - [Изменить правило](operations/arl-rule-update.md)

 - [Удалить правило](operations/arl-rule-delete.md)

### Домены

 - [Создать прокси-сервер](operations/proxy-create.md)

 - [Создать домен](operations/domain-create.md)

 - [Настроить инфраструктуру](operations/setup-infrastructure.md)

 - [Проверить доступность ресурсов](operations/validate-availability.md)

 - [Списки адресов](operations/list-create.md)

### Шаблоны ответов

 - [Создать шаблон](operations/template-create.md)

 - [Добавить шаблон к профилю или правилу](operations/template-attach.md)

 - [Управлять шаблоном](operations/template-manage.md)

### Обязательные и рекомендуемые правила

 - [Правило для капчи](operations/captcha-rule.md)

 - [Правило для блокировки черных адресов](operations/black-list-rule.md)

 - [Посмотреть операции](operations/operation-logs.md)

 - [Настроить мониторинг](operations/monitoring.md)

 - [Настроить алерты](operations/alerting.md)

 - [Настроить логи через {{ sws-name }}](operations/configure-logging.md)

 - [Настроить логи через {{ alb-name }}](operations/configure-logging-alb.md)

 - [Миграция на новый формат условий в API, CLI и Terraform](operations/api-migration.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Базовая настройка SWS](tutorials/sws-basic-protection.md)

### Создание L7-балансировщика с профилем безопасности

 - [Обзор](tutorials/balancer-with-sws-profile/index.md)

 - [Консоль управления](tutorials/balancer-with-sws-profile/console.md)

 - [{{ TF }}](tutorials/balancer-with-sws-profile/terraform.md)

 - [Создание L7-балансировщика с профилем безопасности через Ingress-контроллер {{ alb-name }}](tutorials/alb-ingress-with-sws-profile.md)

 - [Управление источниками трафика](tutorials/traffic-sources-management.md)

### Создание L7-балансировщика с защитой от DDoS на уровне L3-L4 модели OSI

 - [Обзор](tutorials/alb-with-ddos-protection/index.md)

 - [Консоль управления, CLI](tutorials/alb-with-ddos-protection/console.md)

 - [{{ TF }}](tutorials/alb-with-ddos-protection/terraform.md)

 - [Защита {{ api-gw-name }} при помощи {{ sws-name }}](tutorials/api-gw-sws-integration.md)

 - [Экстренная защита сервисов в {{ alb-name }} от DDoS на уровне L7](tutorials/sws-protection-ongoing-ddos.md)

 - [Централизованная публикация в интернете и защита приложений от DDoS](tutorials/different-folders-services.md)

 - [Создание распределенной инфраструктуры с защищенным доступом](tutorials/distributed-secured-infrastructure.md)

### Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты {{ sws-name }}

 - [Обзор](tutorials/migration-from-nlb-to-alb/index.md)

#### Балансировщик NLB с целевыми ресурсами из виртуальных машин

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/console.md)

 - [{{ TF }}](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из группы виртуальных машин

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/console.md)

 - [{{ TF }}](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из кластера {{ managed-k8s-name }}

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/console.md)

 - [{{ TF }}](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/terraform.md)

#### Балансировщик NLB как целевой ресурс для ALB

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/console.md)

 - [{{ TF }}](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/terraform.md)

 - [Развертывание веб-приложения на серверах {{ baremetal-name }} с L7-балансировщиком и защитой {{ sws-name }}](tutorials/webapp-on-bms-behind-sws.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Профили безопасности](concepts/profiles.md)

 - [WAF](concepts/waf.md)

 - [ARL (лимит на запросы)](concepts/arl.md)

 - [Правила](concepts/rules.md)

 - [Условия](concepts/conditions.md)

 - [Списки](concepts/lists.md)

 - [Управление бот-трафиком](concepts/botes.md)

 - [Защита доменов](concepts/domain-protect.md)

 - [Шаблоны ответов](concepts/response-templates.md)

 - [Логирование](concepts/logging.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### security-profile

 - [Overview](cli-ref/security-profile/index.md)

 - [create](cli-ref/security-profile/create.md)

 - [delete](cli-ref/security-profile/delete.md)

 - [get](cli-ref/security-profile/get.md)

 - [list](cli-ref/security-profile/list.md)

 - [update](cli-ref/security-profile/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### security-profile

 - [Overview](cli-ref/v0/security-profile/index.md)

 - [create](cli-ref/v0/security-profile/create.md)

 - [delete](cli-ref/v0/security-profile/delete.md)

 - [get](cli-ref/v0/security-profile/get.md)

 - [list](cli-ref/v0/security-profile/list.md)

 - [update](cli-ref/v0/security-profile/update.md)

### v1

 - [Overview](cli-ref/v1/index.md)

#### security-profile

 - [Overview](cli-ref/v1/security-profile/index.md)

 - [create](cli-ref/v1/security-profile/create.md)

 - [delete](cli-ref/v1/security-profile/delete.md)

 - [get](cli-ref/v1/security-profile/get.md)

 - [list](cli-ref/v1/security-profile/list.md)

 - [update](cli-ref/v1/security-profile/update.md)

#### waf

 - [Overview](cli-ref/v1/waf/index.md)

##### waf-profile

 - [Overview](cli-ref/v1/waf/waf-profile/index.md)

 - [create](cli-ref/v1/waf/waf-profile/create.md)

 - [delete](cli-ref/v1/waf/waf-profile/delete.md)

 - [get](cli-ref/v1/waf/waf-profile/get.md)

 - [list](cli-ref/v1/waf/waf-profile/list.md)

 - [update](cli-ref/v1/waf/waf-profile/update.md)

### waf

 - [Overview](cli-ref/waf/index.md)

#### waf-profile

 - [Overview](cli-ref/waf/waf-profile/index.md)

 - [create](cli-ref/waf/waf-profile/create.md)

 - [delete](cli-ref/waf/waf-profile/delete.md)

 - [get](cli-ref/waf/waf-profile/get.md)

 - [list](cli-ref/waf/waf-profile/list.md)

 - [update](cli-ref/waf/waf-profile/update.md)

 - [Справочник {{ TF }}](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### SecurityProfile

 - [Overview](api-ref/grpc/SecurityProfile/index.md)

 - [Get](api-ref/grpc/SecurityProfile/get.md)

 - [List](api-ref/grpc/SecurityProfile/list.md)

 - [Create](api-ref/grpc/SecurityProfile/create.md)

 - [Update](api-ref/grpc/SecurityProfile/update.md)

 - [Delete](api-ref/grpc/SecurityProfile/delete.md)

#### SmartWebSecurity ARL API

 - [Overview](advanced_rate_limiter/api-ref/grpc/index.md)

##### AdvancedRateLimiterProfile

 - [Overview](advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/index.md)

 - [Get](advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/get.md)

 - [List](advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/list.md)

 - [Create](advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/create.md)

 - [Update](advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md)

 - [Delete](advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/delete.md)

##### Operation

 - [Overview](advanced_rate_limiter/api-ref/grpc/Operation/index.md)

 - [Get](advanced_rate_limiter/api-ref/grpc/Operation/get.md)

 - [Cancel](advanced_rate_limiter/api-ref/grpc/Operation/cancel.md)

#### SmartWebSecurity WAF API

 - [Overview](waf/api-ref/grpc/index.md)

##### Operation

 - [Overview](waf/api-ref/grpc/Operation/index.md)

 - [Get](waf/api-ref/grpc/Operation/get.md)

 - [Cancel](waf/api-ref/grpc/Operation/cancel.md)

##### RuleSetDescriptor

 - [Overview](waf/api-ref/grpc/RuleSetDescriptor/index.md)

 - [Get](waf/api-ref/grpc/RuleSetDescriptor/get.md)

##### WafProfile

 - [Overview](waf/api-ref/grpc/WafProfile/index.md)

 - [Get](waf/api-ref/grpc/WafProfile/get.md)

 - [List](waf/api-ref/grpc/WafProfile/list.md)

 - [Create](waf/api-ref/grpc/WafProfile/create.md)

 - [Update](waf/api-ref/grpc/WafProfile/update.md)

 - [Delete](waf/api-ref/grpc/WafProfile/delete.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### SecurityProfile

 - [Overview](api-ref/SecurityProfile/index.md)

 - [Get](api-ref/SecurityProfile/get.md)

 - [List](api-ref/SecurityProfile/list.md)

 - [Create](api-ref/SecurityProfile/create.md)

 - [Update](api-ref/SecurityProfile/update.md)

 - [Delete](api-ref/SecurityProfile/delete.md)

#### SmartWebSecurity ARL API

 - [Overview](advanced_rate_limiter/api-ref/index.md)

##### AdvancedRateLimiterProfile

 - [Overview](advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md)

 - [Get](advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/get.md)

 - [List](advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/list.md)

 - [Create](advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/create.md)

 - [Update](advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md)

 - [Delete](advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/delete.md)

##### Operation

 - [Overview](advanced_rate_limiter/api-ref/Operation/index.md)

 - [Get](advanced_rate_limiter/api-ref/Operation/get.md)

 - [Cancel](advanced_rate_limiter/api-ref/Operation/cancel.md)

#### SmartWebSecurity WAF API

 - [Overview](waf/api-ref/index.md)

##### Operation

 - [Overview](waf/api-ref/Operation/index.md)

 - [Get](waf/api-ref/Operation/get.md)

 - [Cancel](waf/api-ref/Operation/cancel.md)

##### RuleSetDescriptor

 - [Overview](waf/api-ref/RuleSetDescriptor/index.md)

 - [Get](waf/api-ref/RuleSetDescriptor/get.md)

##### WafProfile

 - [Overview](waf/api-ref/WafProfile/index.md)

 - [Get](waf/api-ref/WafProfile/get.md)

 - [List](waf/api-ref/WafProfile/list.md)

 - [Create](waf/api-ref/WafProfile/create.md)

 - [Update](waf/api-ref/WafProfile/update.md)

 - [Delete](waf/api-ref/WafProfile/delete.md)

 - [Метрики {{ monitoring-name }}](metrics.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [История изменений](release-notes.md)