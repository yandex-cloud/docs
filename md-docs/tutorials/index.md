# Практические руководства платформы Yandex Cloud

Практические руководства, которые помогут вам решать различные задачи с помощью сервисов {{ yandex-cloud }}.

# Практические руководства

## Безопасность

 - [Все руководства](security/index.md)

 - [Разграничение прав доступа для групп пользователей](security/user-group-access-control.md)

 - [Приглашение нового пользователя и назначение ролей](security/add-account-and-assign-roles.md)

### Создание L7-балансировщика с защитой от DDoS

 - [Обзор](security/alb-with-ddos-protection/index.md)

 - [Консоль управления, CLI](security/alb-with-ddos-protection/console.md)

 - [{{ TF }}](security/alb-with-ddos-protection/terraform.md)

### Создание L7-балансировщика {{ alb-name }} с профилем безопасности {{ sws-name }}

 - [Обзор](security/balancer-with-sws-profile/index.md)

 - [Консоль управления](security/balancer-with-sws-profile/console.md)

 - [{{ TF }}](security/balancer-with-sws-profile/terraform.md)

 - [Создание L7-балансировщика с профилем безопасности {{ sws-name }} через Ingress-контроллер {{ alb-name }}](security/alb-ingress-with-sws-profile.md)

 - [Создание распределенной инфраструктуры с защищенным доступом](security/distributed-secured-infrastructure.md)

 - [Централизованная публикация в интернете и защита приложений от DDoS](security/different-folders-services.md)

 - [Базовая настройка SWS](security/sws-basic-protection.md)

 - [Экстренная защита сервисов в {{ alb-name }} от DDoS на уровне L7](security/sws-protection-ongoing-ddos.md)

### Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты {{ sws-name }}

 - [Обзор](security/migration-from-nlb-to-alb/index.md)

#### Балансировщик NLB с целевыми ресурсами из виртуальных машин

 - [Обзор](security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/console.md)

 - [{{ TF }}](security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из группы виртуальных машин

 - [Обзор](security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/console.md)

 - [{{ TF }}](security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из кластера {{ managed-k8s-name }}

 - [Обзор](security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/console.md)

 - [{{ TF }}](security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/terraform.md)

#### Балансировщик NLB как целевой ресурс для ALB

 - [Обзор](security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/console.md)

 - [{{ TF }}](security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/terraform.md)

### Терминирование TLS-соединений

 - [Обзор](security/tls-termination/index.md)

 - [Консоль управления](security/tls-termination/console.md)

 - [{{ TF }}](security/tls-termination/terraform.md)

 - [Передача логов с виртуальной машины в {{ cloud-logging-name }}](security/vm-fluent-bit-logging.md)

 - [Запись логов балансировщика в {{ PG }}](security/logging.md)

 - [Безопасное хранение паролей для {{ GL }} CI в виде секретов {{ lockbox-name }}](security/gitlab-lockbox-integration.md)

### Хранение статического ключа доступа в секрете {{ lockbox-name }}

 - [Обзор](security/static-key-in-lockbox/index.md)

 - [CLI](security/static-key-in-lockbox/console.md)

 - [{{ TF }}](security/static-key-in-lockbox/terraform.md)

 - [Сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](security/sa-oslogin-ansible.md)

### Организация защищенного доступа к контенту в {{ cdn-name }}

 - [Обзор](security/protected-access-to-content/index.md)

 - [Консоль управления, CLI, API](security/protected-access-to-content/console.md)

 - [{{ TF }}](security/protected-access-to-content/terraform.md)

### Загрузка аудитных логов в SIEM KUMA

 - [Обзор](security/audit-trails-events-to-kuma/index.md)

 - [Консоль управления, CLI, API](security/audit-trails-events-to-kuma/console.md)

 - [{{ TF }}](security/audit-trails-events-to-kuma/terraform.md)

 - [Передача логов с {{ coi }} в {{ cloud-logging-name }}](security/coi-fluent-bit-logging.md)

### Поиск событий в аудитных логах

 - [Обзор](security/search-events-audit-logs/index.md)

 - [Инструменты для работы с аудитными логами](security/search-events-audit-logs/tools.md)

 - [Примеры запросов для поиска событий](security/search-events-audit-logs/examples.md)

 - [Настройка работы с {{ yq-name }}](security/search-events-audit-logs/query.md)

 - [Добавление HTML-страницы для работы {{ captcha-name }}](security/mobile-app/website.md)

### Создание L7-балансировщика с профилем безопасности

 - [Обзор](security/balancer-with-sws-profile/index.md)

 - [Консоль управления](security/balancer-with-sws-profile/console.md)

 - [{{ TF }}](security/balancer-with-sws-profile/terraform.md)

 - [ViPNet Coordinator в {{ yandex-cloud }}](security/vipnet-to-yc.md)

 - [Настройка алертов и дашбордов в {{ monitoring-name }}](security/alerts-monitoring.md)

### Загрузка аудитных логов в MaxPatrol SIEM

 - [Обзор](security/maxpatrol/index.md)

 - [Консоль управления](security/maxpatrol/console.md)

 - [{{ TF }}](security/maxpatrol/terraform.md)

 - [Загрузка аудитных логов в SIEM Splunk](security/export-logs-to-splunk.md)

 - [Загрузка аудитных логов в SIEM ArcSight](security/export-logs-to-arcsight.md)

### Управление федерациями удостоверений

 - [Аутентификация с помощью Active Directory](security/integration-adfs.md)

 - [Аутентификация с помощью Google Workspace](security/integration-gworkspace.md)

 - [Аутентификация с помощью {{ microsoft-idp.entra-id-full }}](security/integration-azure.md)

 - [Аутентификация с помощью Keycloak](security/integration-keycloak.md)

#### Сопоставление групп пользователей

 - [Сопоставление групп пользователей в {{ microsoft-idp.adfs-short }}](security/adfs.md)

 - [Сопоставление групп пользователей в {{ microsoft-idp.entra-id-full }}](security/entra-id.md)

 - [Сопоставление групп пользователей в Keycloak](security/keycloak.md)

### Сценарии использования {{ captcha-name }}

 - [Капча в приложении Android](security/mobile-app/android/quickstart-android.md)

 - [Невидимая капча в приложении Android](security/mobile-app/android/invisible-captcha-android.md)

 - [Капча в приложении Android на Flutter](security/mobile-app/android/quickstart-android-flutter.md)

 - [Капча в приложении iOS](security/mobile-app/ios/quickstart-ios.md)

### Шифрование данных

 - [Какой способ шифрования выбрать?](security/encrypt/index.md)

 - [Шифрование с помощью CLI и API {{ yandex-cloud }}](security/encrypt/cli-api.md)

 - [Шифрование с помощью SDK Yandex Cloud](security/encrypt/sdk.md)

 - [Шифрование с помощью AWS Encryption SDK](security/encrypt/aws-encryption-sdk.md)

 - [Шифрование с помощью Google Tink](security/encrypt/google-tink.md)

 - [Шифрование для бакета {{ objstorage-name }} на стороне сервера](security/server-side-encryption.md)

 - [Шифрование секретов в {{ TF-full }}](security/terraform-secret.md)

 - [Управление ключами KMS с {{ TF-full }}](security/terraform-key.md)

 - [Auto Unseal в HashiCorp Vault](security/vault-secret.md)

### Интеграции федераций удостоверений сервисных аккаунтов

 - [GitHub](security/wlif-github-integration.md)

 - [{{ GL }}](security/wlif-gitlab-integration.md)

 - [Пользовательская инсталляция {{ k8s }}](security/wlif-k8s-integration.md)

 - [{{ managed-k8s-name }}](security/wlif-managed-k8s-integration.md)

### Настройка единого входа в приложения (SSO)

 - [1С:Предприятие](security/single-sign-on/oidc-1c-enterprise.md)

#### Cloud.ru

 - [SAML](security/single-sign-on/cloud-ru/saml-cloud-ru.md)

 - [OpenID Connect](security/single-sign-on/cloud-ru/oidc-cloud-ru.md)

#### Grafana Cloud

 - [SAML](security/single-sign-on/grafana/saml-grafana.md)

 - [OpenID Connect](security/single-sign-on/grafana/oidc-grafana.md)

 - [Grafana OSS](security/single-sign-on/oidc-grafana-oss.md)

 - [Harbor](security/single-sign-on/oidc-harbor.md)

#### Jenkins

 - [SAML](security/single-sign-on/jenkins/saml-jenkins.md)

 - [OpenID Connect](security/single-sign-on/jenkins/oidc-jenkins.md)

 - [{{ mgl-name }}](security/single-sign-on/saml-managed-gitlab.md)

 - [{{ mos-name }}](security/single-sign-on/saml-opensearch.md)

 - [MWS](security/single-sign-on/oidc-mws.md)

 - [{{ OS }}](security/single-sign-on/saml-opensearch-self-managed.md)

#### OpenVPN

 - [OpenVPN Access Server](security/single-sign-on/saml-ovpn.md)

 - [OpenVPN Community Edition](security/single-sign-on/oidc-ovpn.md)

 - [Selectel](security/single-sign-on/saml-selectel.md)

 - [Sentry](security/single-sign-on/saml-sentry.md)

 - [SonarQube](security/single-sign-on/saml-sonarqube.md)

#### VK Cloud

 - [SAML](security/single-sign-on/vk-cloud/saml-vk-cloud.md)

 - [Zabbix](security/single-sign-on/saml-zabbix.md)

 - [Пассворк](security/single-sign-on/saml-passwork.md)

 - [{{ yandex-360 }}](security/single-sign-on/saml-yandex-360.md)

 - [Яндекс Браузер для организаций](security/single-sign-on/saml-ya-browser-corporate.md)

 - [Использование OAuth2 Proxy для приложений, не поддерживающих SSO](security/single-sign-on/oidc-nginx-oauth2-proxy.md)

 - [Загрузка аудитных логов в {{ mos-name }}](security/trails-logs-opensearch.md)

 - [Передача логов кластера {{ mgp-name }} в {{ cloud-logging-full-name }}](security/mgp-to-cloud-logging.md)

 - [Получение сведений для запроса на включение ресурса в белый список Минцифры](security/info-for-federal-ip-whitelist.md)

 - [Загрузка объектов в бакет {{ objstorage-name }} с помощью эфемерного ключа доступа](security/ephemeral-key-storage.md)

## Хранение и восстановление данных

 - [Все руководства](archive/index.md)

### Резервное копирование в {{ objstorage-name }}

 - [Обзор](archive/storage-backup-overview.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью aws s3 sync](archive/storage-backup-aws-s3-sync.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью rclone](archive/storage-backup-rclone.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью GeeseFS](archive/storage-backup-geesefs.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью MSP360 Backup (CloudBerry Desktop Backup)](archive/object-storage-cloudberry.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью Duplicati](archive/object-storage-duplicati.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью Bacula](archive/backup-with-bacula.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью Veritas Backup Exec](archive/object-storage-veritas.md)

 - [Резервное копирование в {{ objstorage-name }} с помощью Veeam Backup](archive/backup-with-veeam.md)

 - [Резервное копирование ВМ с помощью Хайстекс Акура](infrastructure-management/hystax-backup.md)

 - [Резервное копирование кластера {{ managed-k8s-name }} в {{ objstorage-name }}](archive/kubernetes-backup.md)

 - [Миграция в {{ yandex-cloud }} с помощью Хайстекс Акура](infrastructure-management/hystax-migration.md)

 - [Защита от сбоев с помощью Хайстекс Акура](infrastructure-management/hystax-disaster-recovery.md)

### Однонодовый файловый сервер

 - [Обзор](archive/single-node-file-server/index.md)

 - [Консоль управления](archive/single-node-file-server/console.md)

 - [{{ TF }}](archive/single-node-file-server/terraform.md)

 - [Настройка SFTP-сервера на Centos 7](archive/backup-and-archive-to-sftp.md)

 - [Развертывание параллельной файловой системы GlusterFS в высокодоступном режиме](archive/ha-regional-glusterfs.md)

 - [Развертывание параллельной файловой системы GlusterFS в высокопроизводительном режиме](archive/ha-regional-glusterfs-high-performance.md)

### Автоматическая привязка политики резервного копирования {{ backup-name }} к ВМ

 - [Обзор](archive/vm-with-backup-policy/index.md)

 - [Консоль управления, CLI, API](archive/vm-with-backup-policy/console.md)

 - [{{ TF }}](archive/vm-with-backup-policy/terraform.md)

 - [Репликация логов в {{ objstorage-name }} с помощью {{ yds-name }}](archive/replicate-logs-to-storage-via-data-streams.md)

 - [Репликация логов в {{ objstorage-name }} с помощью Fluent Bit](archive/replicate-logs-to-storage.md)

 - [Использование {{ objstorage-name }} в {{ dataproc-name }}](archive/copy-files-from-object-storage.md)

 - [Подключить сервер {{ baremetal-name }} к {{ backup-name }}](archive/backup-baremetal.md)

### Развертывание Nextcloud в интеграции с {{ objstorage-name }}

 - [Обзор](archive/integrate-nextcloud/index.md)

 - [Развертывание Nextcloud на ВМ из образа {{ coi }}](archive/integrate-nextcloud/coi-based.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ вручную](archive/integrate-nextcloud/fault-tolerant.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ с помощью {{ TF }}](archive/integrate-nextcloud/terraform.md)

## Разработка и тестирование

 - [Все руководства](dev/index.md)

 - [Организация сине-зеленого и канареечного развертывания версий веб-сервиса](web/blue-green-canary-deployment.md)

 - [Автоматизация сборки образов с помощью Jenkins и Packer](infrastructure-management/jenkins.md)

 - [Непрерывное развертывание контейнеризованных приложений с помощью {{ GL }}](infrastructure-management/gitlab-containers.md)

 - [Тестирование приложений с помощью {{ GL }}](testing/gitlab.md)

 - [Создание тестовых ВМ через {{ GL }} CI](testing/ci-for-snapshots.md)

 - [Интеграция {{ GL }} с {{ tracker-name }}](dev/gitlab-tracker-integration.md)

 - [Высокопроизводительные вычисления (HPC) на прерываемых ВМ](testing/hpc-on-preemptible.md)

 - [Нагрузочное тестирование gRPC-сервиса](testing/loadtesting-grpc.md)

 - [HTTPS-тест с постоянной нагрузкой с помощью Phantom](testing/loadtesting-https-phantom.md)

 - [HTTPS-тест со ступенчатой нагрузкой с помощью Pandora](testing/loadtesting-https-pandora.md)

 - [HTTP-тест с нагрузкой по сценарию с помощью Pandora](testing/loadtesting-http-scenario-pandora.md)

 - [Нагрузочное тестирование с нескольких агентов](testing/loadtesting-multiply.md)

 - [Запуск внешних агентов для нагрузочного тестирования](testing/loadtesting-external-agent.md)

 - [Нагрузочный тест с помощью JMeter](testing/loadtesting-jmeter.md)

 - [Получение статистики запросов к объектам {{ objstorage-name }} с использованием {{ yq-name }}](testing/server-logs-yq.md)

 - [Получение количества запросов к объектам {{ objstorage-name }}](testing/server-logs.md)

 - [Вызов нагрузочного тестирования из {{ GL }} CI](testing/loadtesting-gitlab-ci.md)

 - [Развертывание {{ GLR }} на виртуальной машине {{ compute-name }}](dev/install-gitlab-runner.md)

 - [Развертывание воркера {{ src-full-name }} на виртуальной машине {{ compute-name }}](dev/self-hosted-worker-sourcecraft.md)

 - [Сравнение результатов нагрузочных тестов](testing/loadtesting-results-compare.md)

 - [Миграция нагрузочного тестирования на k6](testing/loadtesting-migration-to-k6.md)

 - [ИИ-ревью пул-реквестов на GitHub с помощью {{ sw-full-name }} и GitHub Actions](dev/ai-powered-github-pr-review.md)

## Базовая инфраструктура

 - [Все руководства](infrastructure/index.md)

 - [Архитектура и защита базового интернет-сервиса](routing/web-service.md)

 - [Анализ поресурсной детализации расходов с помощью {{ objstorage-name }}](infrastructure/billing-resource-detailing.md)

 - [Получение сведений для запроса на включение ресурса в белый список Минцифры](infrastructure/info-for-federal-ip-whitelist.md)

### Отказоустойчивость и масштабирование

 - [Настройка отказоустойчивой архитектуры в {{ yandex-cloud }}](infrastructure-management/fault-tolerance.md)

#### Отказоустойчивый сайт с балансировкой нагрузки через {{ network-load-balancer-name }}

 - [Обзор](web/load-balancer-website/index.md)

 - [Консоль управления](web/load-balancer-website/console.md)

 - [{{ TF }}](web/load-balancer-website/terraform.md)

#### Отказоустойчивый сайт с балансировкой нагрузки через {{ alb-name }}

 - [Обзор](web/application-load-balancer-website/index.md)

 - [Консоль управления](web/application-load-balancer-website/console.md)

 - [{{ TF }}](web/application-load-balancer-website/terraform.md)

#### Интеграция L7-балансировщика с {{ cdn-name }} и {{ objstorage-name }}

 - [Обзор](web/cdn-storage-integration/index.md)

 - [Консоль управления, CLI и API](web/cdn-storage-integration/console.md)

 - [{{ TF }}](web/cdn-storage-integration/terraform.md)

#### Работа с группой ВМ с автоматическим масштабированием

 - [Обзор](infrastructure-management/vm-autoscale/index.md)

 - [Консоль управления, CLI и API](infrastructure-management/vm-autoscale/console.md)

 - [{{ TF }}](infrastructure-management/vm-autoscale/terraform.md)

#### Масштабирование группы виртуальных машин по расписанию

 - [Обзор](infrastructure-management/vm-scale-scheduled/index.md)

 - [Консоль управления, CLI и API](infrastructure-management/vm-scale-scheduled/console.md)

 - [{{ TF }}](infrastructure-management/vm-scale-scheduled/terraform.md)

 - [Автомасштабирование группы ВМ для обработки сообщений из очереди {{ message-queue-name }}](infrastructure-management/autoscale-monitoring.md)

 - [Обновление группы ВМ под нагрузкой](infrastructure-management/updating-under-load.md)

 - [Создание триггера для бюджетов, который вызывает функцию для остановки ВМ](infrastructure-management/serverless-trigger-budget-vm.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми ВМ](infrastructure/nodejs-cron-restart-vm.md)

 - [Создание триггеров, которые вызывают функции для остановки ВМ и отправки уведомлений в Telegram](infrastructure-management/serverless-trigger-budget-queue-vm-tg.md)

### Инструменты

 - [Начало работы с {{ TF }}](infrastructure-management/terraform-quickstart.md)

 - [Источники данных {{ TF }}](infrastructure-management/terraform-data-sources.md)

 - [Загрузка состояний {{ TF }} в {{ objstorage-name }}](infrastructure-management/terraform-state-storage.md)

 - [Начало работы с Packer](infrastructure-management/packer-quickstart.md)

 - [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](infrastructure-management/packer-custom-image.md)

 - [Блокировка состояний {{ TF }} с помощью {{ ydb-name }}](infrastructure-management/terraform-state-lock.md)

 - [Использование модулей {{ yandex-cloud }} в {{ TF }}](infrastructure-management/terraform-modules.md)

 - [Управление ресурсами {{ k8s }} с помощью провайдера {{ TF }}](infrastructure-management/kubernetes-terraform-provider.md)

 - [Создать ВМ и группу ВМ с {{ coi }} с помощью {{ TF }}](infrastructure/coi-with-terraform.md)

#### Запуск Docker-образа на виртуальной машине

 - [Обзор](infrastructure-management/run-docker-on-vm/index.md)

 - [Консоль управления, CLI и API](infrastructure-management/run-docker-on-vm/console.md)

 - [{{ TF }}](infrastructure-management/run-docker-on-vm/terraform.md)

 - [Передача логов через HTTP-вход {{ unified-agent-short-name }} в {{ cloud-logging-name }}](infrastructure-management/ua-http-logging.md)

 - [Запуск языковой модели DeepSeek-R1 в кластере GPU {{ compute-name }}](infrastructure/gpu-cluster-deepseek.md)

### Сеть

 - [Настройка синхронизации часов с помощью NTP](infrastructure-management/ntp.md)

 - [Настройки DHCP для работы с корпоративным DNS-сервером](routing/dhcp-options.md)

#### Маршрутизация через NAT-инстанс

 - [Обзор](routing/nat-instance/index.md)

 - [Консоль управления](routing/nat-instance/console.md)

 - [{{ TF }}](routing/nat-instance/terraform.md)

 - [Установка виртуального роутера Cisco CSR 1000v](routing/cisco.md)

 - [Установка виртуального роутера Mikrotik CHR](routing/mikrotik.md)

### VPNs

#### Организация сетевой связности с помощью IPsec-шлюзов

 - [Схема решения](routing/ipsec/index.md)

 - [Самостоятельная реализация средствами {{ yandex-cloud }}](routing/ipsec/ipsec-vpn.md)

 - [Развертывание S2S VPN с помощью strongSwan в {{ yandex-cloud }}](routing/ipsec/s2s-vpn.md)

 - [Решение SGW от команды архитекторов {{ yandex-cloud }}](routing/ipsec/sgw.md)

 - [Соединение с облачной сетью при помощи OpenVPN](routing/openvpn.md)

 - [Создание и настройка шлюза UserGate в режиме прокси-сервера](routing/usergate-proxy.md)

### {{ dns-name }}

 - [Настройка локального кеширующего DNS-резолвера](infrastructure-management/local-dns-cache.md)

 - [Миграция DNS-зон из Яндекс 360 в {{ dns-name }}](infrastructure-management/connect-migration.md)

 - [Настройка {{ dns-name }} для доступа к кластеру {{ mch-name }} из других облачных сетей](dataplatform/clickhouse-dns-peering.md)

 - [Интеграция {{ dns-name }} и корпоративного сервиса DNS](infrastructure-management/dns-integration.md)

 - [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](infrastructure-management/cert-manager-webhook.md)

### GPU

 - [Запуск языковой модели DeepSeek-R1 в кластере GPU](infrastructure-management/gpu-cluster-deepseek.md)

 - [Запуск библиотеки vLLM с языковой моделью Gemma 3 на ВМ с GPU](infrastructure-management/vllm-gemma-gpu.md)

## Контейнерная инфраструктура

 - [Все руководства](container-infrastructure/index.md)

 - [Настройка подключения к {{ mpg-name }} из контейнера {{ serverless-containers-name }}](container-infrastructure/container-pg-connect.md)

 - [Создать ВМ с {{ coi }}](container-infrastructure/vm-create.md)

 - [Создать ВМ с {{ coi }} и дополнительным томом для Docker-контейнера](container-infrastructure/vm-create-with-second-disk.md)

 - [Создать группу ВМ с {{ coi }} и несколькими Docker-контейнерами](container-infrastructure/ig-with-containers.md)

 - [Создать группу ВМ с {{ coi }}](container-infrastructure/ig-create.md)

 - [Создать ВМ с {{ coi }} и несколькими Docker-контейнерами](container-infrastructure/docker-compose.md)

 - [Изменить ВМ с {{ coi }}](container-infrastructure/vm-update.md)

 - [Настройка вывода информации из Docker-контейнера в серийный порт](container-infrastructure/serial-port.md)

 - [Запуск Docker-образа на виртуальной машине с помощью {{ cloud-registry-name }}](container-infrastructure/docker-cloud-registry.md)

### {{ managed-k8s-name }}

 - [Создание нового {{ k8s }}-проекта](container-infrastructure/new-kubernetes-project.md)

 - [Создание кластера {{ k8s }} без доступа в интернет](container-infrastructure/k8s-cluster-with-no-internet.md)

 - [Создание кластера {{ k8s }} с помощью провайдера {{ yandex-cloud }} для {{ k8s }} Cluster API](container-infrastructure/k8s-cluster-api-provider-yandex.md)

 - [Запуск рабочих нагрузок с GPU](container-infrastructure/running-pod-gpu.md)

 - [Использование групп узлов c GPU без предустановленных драйверов](container-infrastructure/driverless-gpu.md)

 - [Установка Time-Slicing GPUs](container-infrastructure/time-slicing-gpu.md)

 - [Миграция ресурсов в другую зону доступности](container-infrastructure/migration-to-an-availability-zone.md)

 - [Шифрование секретов](container-infrastructure/kms-k8s.md)

 - [Подключение сервера {{ baremetal-name }} как внешнего узла к кластеру {{ managed-k8s-name }}](container-infrastructure/k8s-connect-bms-as-node.md)

#### Настройка и тестирование масштабирования

 - [Горизонтальное масштабирование приложения в кластере](container-infrastructure/autoscaling.md)

 - [Вертикальное масштабирование приложения в кластере](container-infrastructure/vpa-autoscaling.md)

 - [Развертывание и нагрузочное тестирование gRPC-сервиса с масштабированием](container-infrastructure/loadtesting-grpc-autoscaling.md)

#### Установка NGINX

 - [Установка Ingress-контроллера NGINX с {{ lets-encrypt }}](container-infrastructure/ingress-cert-manager.md)

 - [Установка Ingress-контроллера NGINX с сертификатом из {{ certificate-manager-name }}](container-infrastructure/nginx-ingress-certificate-manager.md)

#### Использование {{ container-registry-name }}

 - [Интеграция с {{ container-registry-name }}](container-infrastructure/container-registry.md)

 - [Подпись и проверка Docker-образов {{ container-registry-name }}](container-infrastructure/sign-cr-with-cosign.md)

 - [Хранение Docker-образов из проектов {{ mgl-name }}](container-infrastructure/image-storage.md)

#### Непрерывная интеграция с {{ GL }}

 - [Сканирование уязвимостей {{ container-registry-name }} при непрерывном развертывании приложений с помощью {{ GL }}](container-infrastructure/cr-scanner-with-k8s-and-gitlab.md)

#### Работа с DNS

 - [Интеграция с корпоративной зоной DNS](container-infrastructure/custom-dns.md)

 - [Автоматическое масштабирование DNS по размеру кластера](container-infrastructure/dns-autoscaler.md)

 - [Настройка NodeLocal DNS Cache](container-infrastructure/node-local-dns.md)

 - [Проверка DNS Challenge для сертификатов {{ lets-encrypt }}](container-infrastructure/dnschallenge.md)

#### Резервное копирование

 - [Работа со снапшотами {{ compute-name }}](container-infrastructure/pvc-snapshot-restore.md)

#### Мониторинг

 - [Мониторинг кластера с помощью {{ prometheus-name }} и {{ grafana-name }}](container-infrastructure/prometheus-grafana-monitoring.md)

 - [Мониторинг кластера {{ managed-k8s-name }} с помощью Filebeat OSS](container-infrastructure/filebeat-oss-monitoring.md)

#### Использование продуктов {{ marketplace-name }}

 - [Интеграция с Argo CD](container-infrastructure/argo-cd.md)

 - [Интеграция с Crossplane](container-infrastructure/crossplane.md)

 - [Синхронизация секретов {{ lockbox-name }} и {{ managed-k8s-name }}](container-infrastructure/kubernetes-lockbox-secrets.md)

 - [Передача логов кластера {{ managed-k8s-name }} в {{ cloud-logging-name }}](container-infrastructure/k8s-fluent-bit-logging.md)

 - [Настройка Gateway API](container-infrastructure/gateway-api.md)

 - [Настройка Ingress-контроллера {{ alb-name }}](container-infrastructure/alb-ingress-controller.md)

 - [Настройки логирования для Ingress-контроллеров {{ alb-name }}](container-infrastructure/alb-ingress-controller-log-options.md)

 - [Проверка состояния приложений в кластере {{ managed-k8s-name }} с помощью Ingress-контроллера {{ alb-name }}](container-infrastructure/custom-health-checks.md)

 - [Настройка Kyverno & Kyverno Policies](container-infrastructure/kyverno.md)

 - [Использование {{ MP }} для трансляции метрик](container-infrastructure/metrics-provider.md)

 - [Редактирование изображений для сайтов с помощью Thumbor](container-infrastructure/thumbor.md)

 - [Использование Istio](container-infrastructure/istio.md)

 - [Использование HashiCorp Vault для хранения секретов](container-infrastructure/hashicorp-vault.md)

## Прикладные решения

 - [Все руководства](applied/index.md)

### Создание сайта

#### Статический сайт в {{ objstorage-name }}

 - [Обзор](web/static/index.md)

 - [Консоль управления](web/static/console.md)

 - [Terraform](web/static/terraform.md)

#### Статический сайт в {{ objstorage-name }} с доступом через {{ cdn-name }}

 - [Обзор](applied/cdn-hosting/index.md)

 - [Консоль управления, CLI, API](applied/cdn-hosting/console.md)

 - [{{ TF }}](applied/cdn-hosting/terraform.md)

#### Сайт на WordPress

 - [Обзор](web/wordpress-overview.md)

 - [Сайт на WordPress High Availability с помощью {{ cloud-apps-name }}](web/wordpress-ha-cloudapp.md)

 - [Сайт на WordPress с помощью {{ cloud-apps-name }}](web/wordpress-cloudapp.md)

##### Сайт на WordPress с помощью {{ marketplace-short-name }}

 - [Обзор](web/wordpress/index.md)

 - [Консоль управления](web/wordpress/console.md)

 - [{{ TF }}](web/wordpress/terraform.md)

##### Сайт на WordPress с БД {{ MY }}

 - [Обзор](web/wordpress-mysql/index.md)

 - [Консоль управления](web/wordpress-mysql/console.md)

 - [{{ TF }}](web/wordpress-mysql/terraform.md)

 - [Перенос WordPress-сайта с хостинга в {{ yandex-cloud }}](web/wordpress-transfer.md)

#### Сайт на LAMP- или LEMP-стеке

 - [Обзор](web/lamp-lemp/index.md)

 - [Консоль управления](web/lamp-lemp/console.md)

 - [{{ TF }}](web/lamp-lemp/terraform.md)

#### Создание сайта на CMS Joomla с базой данных {{ PG }}

 - [Обзор](web/joomla-postgresql/index.md)

 - [Консоль управления](web/joomla-postgresql/console.md)

 - [{{ TF }}](web/joomla-postgresql/terraform.md)

#### Создание сайта на базе «1С-Битрикс»

 - [Обзор](web/bitrix-website/index.md)

 - [Консоль управления](web/bitrix-website/console.md)

 - [{{ TF }}](web/bitrix-website/terraform.md)

#### Интернет-магазин на платформе OpenCart

 - [Обзор](internet-store/opencart/index.md)

 - [Консоль управления](internet-store/opencart/console.md)

 - [{{ TF }}](internet-store/opencart/terraform.md)

 - [Организация виртуального хостинга](web/virtual-hosting.md)

#### Привязка доменного имени к ВМ с веб-сервером

 - [Обзор](web/bind-domain-vm/index.md)

 - [Консоль управления, CLI и API](web/bind-domain-vm/console.md)

 - [{{ TF }}](web/bind-domain-vm/terraform.md)

 - [Создание веб-приложения на Python с использованием фреймворка Flask](web/flask.md)

 - [Хостинг статического сайта на фреймворке Gatsby](web/gatsby-static-website.md)

 - [Установка Ghost CMS High Availability с помощью {{ cloud-apps-name }}](web/ghost-cms-cloudapp.md)

 - [Миграция в {{ cdn-name }} из стороннего CDN-провайдера](web/migrate-to-yc-cdn.md)

 - [Получение статистики посещения сайта с использованием S3 Select](web/user-agent-statistics.md)

 - [Оформление контента из {{ video-name }} в IFrame](web/video-iframe.md)

### 1С

#### Интернет-магазин на «1С-Битрикс»

 - [Обзор](internet-store/bitrix-shop/index.md)

 - [Консоль управления](internet-store/bitrix-shop/console.md)

 - [{{ TF }}](internet-store/bitrix-shop/terraform.md)

 - [Создание кластера Linux-серверов «1С:Предприятия» с кластером {{ mpg-name }}](infrastructure-management/1c-postgresql-linux.md)

 - [Мониторинг кластера «1С:Предприятие» на базе Linux](infrastructure-management/collect-metrics-1c-cluster.md)

### Интернет вещей (IoT)

#### Работа с помощью Mosquitto

 - [Отправить сообщение](iot/mosquitto/mosquitto-publish.md)

 - [Подписать устройство или реестр на получение сообщений](iot/mosquitto/mosquitto-subscribe.md)

 - [Работа с {{ iot-name }} с устройства с Android на языке Java](iot/android-java.md)

 - [Работа с {{ iot-name }} на языке C#](iot/c-sharp.md)

 - [Работа с {{ iot-name }} на языке Java](iot/java.md)

 - [Мониторинг состояния географически распределенных устройств](iot/datalens.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](iot/monitoring.md)

 - [Тестирование доставки сообщения](iot/message-delivery-check.md)

 - [Эмуляция множества IoT-устройств](testing/iot-emulation.md)

 - [Запись данных с устройства в базу данных](iot/data-recording.md)

### Алиса

 - [Создание навыка Алисы](serverless/alice-skill.md)

 - [Разработка навыка Алисы и сайта с авторизацией](serverless/alice-shareable-todolist.md)

### Прочее

 - [Публикация обновлений для игр с помощью {{ cdn-name }}](web/prefetch.md)

 - [Создание SAP-программы в {{ yandex-cloud }}](infrastructure-management/sap.md)

 - [Развертывание сервера Minecraft в {{ yandex-cloud }}](infrastructure/minecraft-server.md)

 - [Развертывание мультиплеер-сервера для GTA V в {{ yandex-cloud }}](infrastructure/gta-v-server.md)

#### Конвертация видео в GIF на Python

 - [Обзор](serverless/video-converting-queue/index.md)

 - [Консоль управления](serverless/video-converting-queue/console.md)

 - [{{ TF }}](serverless/video-converting-queue/terraform.md)

 - [Настройка печати с {{ cloud-desktop-name }} на локальный принтер в Linux](applied/desktop-linux-printer.md)

## Построение Data Platform

 - [Все руководства](dataplatform/index.md)

 - [Самостоятельное развертывание веб-интерфейса {{ KF }}](dataplatform/deploy-kafka-ui.md)

 - [Обновление кластера {{ mkf-name }} с {{ ZK }} на {{ kraft-short-name }}](dataplatform/zk-kraft-kafka-migration.md)

 - [Миграция БД из стороннего кластера {{ KF }} в {{ mkf-name }}](dataplatform/kafka-connector.md)

 - [Перенос данных между кластерами {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mkf.md)

 - [Поставка данных из {{ mmy-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mmy.md)

 - [Поставка данных из {{ mmy-name }} в {{ mkf-name }} с помощью Debezium](dataplatform/debezium-mmy.md)

 - [Поставка данных из {{ mpg-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mpg.md)

 - [Поставка данных из {{ mpg-name }} в {{ mkf-name }} с помощью Debezium](dataplatform/debezium-mpg.md)

 - [Поставка данных из {{ ydb-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/ydb-mkf-replication.md)

 - [Поставка данных из {{ mkf-name }} в {{ mch-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mkf-mch.md)

 - [Поставка данных из {{ mkf-name }} в {{ mgp-name }} с помощью {{ data-transfer-name }}](dataplatform/managed-kafka-to-greenplum.md)

 - [Поставка данных из {{ mkf-name }} в {{ mmg-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mkf-mmg.md)

 - [Поставка данных из {{ mkf-name }} в {{ mmy-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mkf-mmy.md)

 - [Поставка данных из {{ mkf-name }} в {{ mos-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mkf-mos.md)

 - [Поставка данных из {{ mkf-name }} в {{ mpg-name }} с помощью {{ data-transfer-name }}](dataplatform/mkf-to-mpg.md)

 - [Поставка данных из {{ mkf-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/mkf-ydb-stream.md)

 - [Поставка данных из {{ mkf-name }} в {{ yds-name }} с помощью {{ data-transfer-name }}](dataplatform/mkf-yds-stream.md)

 - [Поставка данных из {{ yds-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/yds-to-ydb.md)

 - [Поставка данных из {{ yds-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/yds-to-kafka.md)

 - [Захват изменений {{ ydb-short-name }} и поставка в {{ DS }}](dataplatform/ydb-to-yds.md)

 - [Настройка Kafka Connect для работы с кластером {{ mkf-name }}](dataplatform/kafka-connect.md)

 - [Синхронизация топиков {{ KF }} в {{ objstorage-name }} без использования интернета](dataplatform/kafka-topic-s3-sync-private.md)

### Использование схем формата данных с {{ mkf-name }}

 - [Управление схемами данных в {{ mkf-name }}](dataplatform/schema-registry-overview.md)

 - [Использование {{ mkf-msr }} с {{ mkf-name }}](dataplatform/managed-schema-registry.md)

 - [Использование {{ mkf-msr }} с {{ mkf-name }} с помощью REST API](dataplatform/managed-schema-registry-rest.md)

 - [Использование Confluent Schema Registry с {{ mkf-name }}](dataplatform/confluent-schema-registry.md)

 - [Отслеживание потери сообщений в топике {{ KF }}](dataplatform/retention-policy.md)

 - [Автоматизация задач {{ yq-name }} с помощью {{ maf-name }}](dataplatform/airflow-auto-tasks.md)

 - [Отправка запросов к API {{ yandex-cloud }} через {{ yandex-cloud }} Python SDK](dataplatform/using-python-sdk-in-airflow.md)

 - [Настройка SMTP-сервера для отправки уведомлений по электронной почте](dataplatform/airflow-test-smtp-notification.md)

 - [Добавление данных в БД {{ CH }}](dataplatform/insert-data-ch.md)

 - [Миграция данных в {{ mch-name }} средствами {{ CH }}](dataplatform/clickhouse-migration.md)

 - [Миграция данных в {{ mch-name }} при помощи {{ data-transfer-name }}](dataplatform/ch-to-mch-migration.md)

 - [Поставка данных из {{ mmy-name }} в {{ mch-name }} с помощью {{ data-transfer-name }}](dataplatform/mysql-to-clickhouse.md)

 - [Асинхронная репликация данных из {{ PG }} в {{ CH }}](dataplatform/rdbms-to-clickhouse.md)

 - [Обмен данными между {{ mch-name }} и {{ dataproc-name }}](dataplatform/dp-mch-data-exchange.md)

 - [Настройка {{ mch-name }} для Graphite](dataplatform/clickhouse-for-graphite.md)

 - [Получение данных из {{ mkf-name }} в {{ mch-name }}](dataplatform/fetch-data-from-mkf.md)

 - [Получение данных из {{ mkf-name }} в ksqlDB](dataplatform/use-ksqldb-with-mkf.md)

 - [Поставка данных из {{ mkf-name }} в {{ mch-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mkf-mch.md)

 - [Получение данных из {{ RMQ }} в {{ mch-name }}](dataplatform/fetch-data-from-rabbitmq.md)

 - [Сохранение потока данных {{ yds-name }} в {{ mch-name }}](dataplatform/yds-to-clickhouse.md)

 - [Асинхронная репликация данных из {{ metrika }} в {{ CH }} с помощью {{ data-transfer-name }}](dataplatform/metrika-to-clickhouse.md)

 - [Использование гибридного хранилища в {{ mch-name }}](dataplatform/clickhouse-hybrid-storage.md)

 - [Шардирование таблиц {{ mch-name }}](dataplatform/clickhouse-sharding.md)

 - [Загрузка данных из {{ yandex-direct }} в витрину {{ mch-name }} с использованием {{ sf-name }}, {{ objstorage-name }} и {{ data-transfer-name }}](dataplatform/data-transfer-direct-to-mch.md)

 - [Загрузка данных из {{ objstorage-name }} в {{ mch-name }} с помощью {{ data-transfer-name }}](dataplatform/object-storage-to-clickhouse.md)

 - [Миграция данных со сменой хранилища из {{ mos-name }} в {{ mch-name }} с помощью {{ data-transfer-name }}](dataplatform/opensearch-to-clickhouse.md)

 - [Загрузка данных из {{ ydb-name }} в {{ mch-name }} с помощью {{ data-transfer-name }}](dataplatform/ydb-to-clickhouse.md)

 - [Интеграция {{ mch-full-name }} с Microsoft SQL Server через {{ CH }} JDBC Bridge](dataplatform/jdbc-ch-to-sql-server-integration.md)

 - [Миграция базы данных из Google BigQuery в {{ mch-name }}](dataplatform/bigquery-to-clickhouse.md)

 - [Интеграция {{ mch-full-name }} с Oracle через {{ CH }} JDBC Bridge](dataplatform/jdbc-ch-to-oracle-integration.md)

 - [Настройка {{ dns-name }} для доступа к кластеру {{ mch-name }} из других облачных сетей](dataplatform/clickhouse-dns-peering.md)

 - [Миграция кластера {{ dataproc-name }} с HDFS в другую зону доступности](dataplatform/hdfs-cluster-migration.md)

 - [Импорт данных из {{ mmy-name }} в {{ dataproc-name }} с помощью Sqoop](dataplatform/sqoop-mmy.md)

 - [Импорт данных из {{ mpg-name }} в {{ dataproc-name }} с помощью Sqoop](dataplatform/sqoop-mpg.md)

 - [Монтирование бакетов {{ objstorage-name }} к файловой системе хостов {{ dataproc-name }}](dataplatform/data-processing-init-actions-geesefs.md)

 - [Работа с топиками {{ KF }} с помощью {{ dataproc-name }}](dataplatform/data-processing-and-kafka.md)

 - [Автоматизация работы с {{ dataproc-name }} с помощью {{ maf-name }}](dataplatform/data-processing-and-airflow.md)

 - [Совместная работа с таблицами {{ dataproc-name }} с использованием {{ metastore-name }}](dataplatform/data-processing-to-data-processing.md)

 - [Перенос метаданных между кластерами {{ dataproc-name }} с помощью {{ metastore-name }}](dataplatform/metastore-import.md)

 - [Импорт данных из {{ objstorage-name }}, обработка и экспорт в {{ mch-name }}](dataplatform/s3-data-processing-ch.md)

### Работа с заданиями {{ dataproc-name }}

 - [Работа с заданиями Hive](dataplatform/hive-job-basics.md)

 - [Работа с заданиями MapReduce](dataplatform/mapreduce-job-basics.md)

 - [Работа с заданиями PySpark](dataplatform/pyspark-job-basics.md)

 - [Работа с заданиями Spark](dataplatform/spark-job-basics.md)

 - [Запуск заданий Apache Hive](dataplatform/how-to-use-hive.md)

 - [Запуск Spark-приложений](dataplatform/run-spark-job.md)

 - [Запуск заданий с удаленного хоста](dataplatform/remote-run-job.md)

 - [Миграция коллекций из стороннего кластера {{ MG }} в {{ mmg-name }}](dataplatform/mongodb-migration-with-data-transfer.md)

 - [Миграция данных в {{ mmg-name }}](dataplatform/storedoc-data-migration.md)

 - [Миграция кластера {{ mmg-name }} с версии 4.4 на 6.0](dataplatform/storedoc-versions.md)

 - [Шардирование коллекций {{ SD }}](dataplatform/storedoc-sharding.md)

 - [Анализ производительности и оптимизация {{ SD }}](dataplatform/storedoc-profiling.md)

### Миграция БД из стороннего кластера {{ MY }} в кластер {{ mmy-name }}

 - [Обзор](dataplatform/mysql-data-migration/index.md)

 - [Перенос данных с использованием сервиса {{ data-transfer-name }}](dataplatform/mysql-data-migration/data-transfer.md)

 - [Перенос данных с помощью логического дампа](dataplatform/mysql-data-migration/logical-dump-migration.md)

 - [Анализ производительности и оптимизация {{ mmy-name }}](dataplatform/profiling-mmy.md)

 - [Синхронизация данных из стороннего кластера {{ MY }} в {{ mmy-name }} с помощью {{ data-transfer-name }}](dataplatform/sync-mysql.md)

 - [Миграция БД из {{ mmy-name }} в сторонний кластер {{ MY }}](dataplatform/mmy-to-mysql-migration.md)

 - [Миграция БД из {{ mmy-name }} в {{ objstorage-name }} с помощью {{ data-transfer-name }}](dataplatform/mmy-objs-migration.md)

 - [Перенос данных из {{ objstorage-name }} в {{ mmy-name }} с использованием {{ data-transfer-name }}](dataplatform/objs-mmy-migration.md)

 - [Импорт данных из {{ mmy-name }} в {{ dataproc-name }} с помощью Sqoop](dataplatform/sqoop-mmy.md)

 - [Поставка данных из {{ mmy-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mmy.md)

 - [Поставка данных из {{ mmy-name }} в {{ mkf-name }} с помощью Debezium](dataplatform/debezium-mmy.md)

 - [Миграция БД из {{ mmy-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/mmy-ydb-migration.md)

 - [Захват изменений {{ MY }} и поставка в {{ DS }}](dataplatform/mmy-to-yds.md)

 - [Миграция данных из {{ mmy-name }} в {{ mpg-name }} с помощью {{ data-transfer-name }}](dataplatform/mmy-to-mpg.md)

 - [Миграция данных из AWS RDS for {{ PG }} в {{ mpg-name }} с помощью {{ data-transfer-name }}](dataplatform/rds-to-mpg.md)

 - [Миграция данных из {{ mmy-name }} в {{ mgp-name }} с помощью {{ data-transfer-name }}](dataplatform/mmy-to-mgp.md)

 - [Настройка политики индексов в {{ mos-name }}](dataplatform/opensearch-index-policy.md)

 - [Настройка политики холодного хранилища в {{ mos-name }}](dataplatform/opensearch-cold-storage-policy.md)

 - [Миграция данных в {{ mos-name }} из стороннего кластера {{ OS }} с помощью {{ data-transfer-name }}](dataplatform/mos-migration-from-standalone.md)

 - [Загрузка данных из {{ mos-name }} в {{ objstorage-name }} с помощью {{ data-transfer-name }}](dataplatform/opensearch-to-object-storage.md)

 - [Миграция данных из {{ mos-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/opensearch-to-ydb.md)

 - [Копирование данных из {{ mos-name }} в {{ mgp-name }} с помощью {{ data-transfer-full-name }}](dataplatform/opensearch-to-greenplum.md)

 - [Миграция данных из {{ mpg-name }} в {{ mos-name }} с помощью {{ data-transfer-name }}](dataplatform/postgresql-to-opensearch.md)

 - [Аутентификация в {{ OS }} Dashboards кластера {{ mos-name }} с помощью {{ keycloak }}](dataplatform/opensearch-saml-keycloak.md)

 - [Использование плагина yandex-lemmer в {{ mos-name }}](dataplatform/opensearch-yandex-lemmer.md)

 - [Отправка оповещений по электронной почте в {{ mos-name }}](dataplatform/opensearch-email-notifications.md)

 - [Подключение MCP-клиента к кластеру {{ OS }}](dataplatform/mos-mcp.md)

 - [Создание кластера {{ PG }} для «1С:Предприятия»](dataplatform/1c-postgresql.md)

 - [Поиск проблем с производительностью кластера {{ mpg-name }}](dataplatform/mpg-performance-problems.md)

 - [Анализ производительности и оптимизация {{ mpg-name }}](dataplatform/mpg-profiling.md)

 - [Логическая репликация {{ PG }}](dataplatform/mpg-replication-overview.md)

 - [Миграция БД из стороннего кластера {{ PG }} в {{ mpg-name }}](dataplatform/postgresql-data-migration.md)

 - [Миграция БД из {{ mpg-name }}](dataplatform/outbound-replication.md)

 - [Миграция кластера {{ mpg-name }} на другую версию](dataplatform/postgresql-versions.md)

 - [Асинхронная репликация данных из {{ PG }} в {{ CH }}](dataplatform/rdbms-to-clickhouse.md)

 - [Поставка данных из {{ mpg-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/data-transfer-mpg.md)

 - [Поставка данных из {{ mpg-name }} в {{ mkf-name }} с помощью Debezium](dataplatform/debezium-mpg.md)

 - [Импорт данных из {{ mpg-name }} в {{ dataproc-name }} с помощью Sqoop](dataplatform/sqoop-mpg.md)

 - [Поставка данных из {{ mpg-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/mpg-ydb-replication.md)

 - [Загрузка данных из {{ ydb-name }} в {{ mpg-name }} с помощью {{ data-transfer-name }}](dataplatform/ydb-to-postgresql.md)

 - [Миграция БД из {{ mpg-name }} в {{ objstorage-name }}](dataplatform/mpg-to-objstorage.md)

 - [Перенос данных из {{ objstorage-name }} в {{ mpg-name }} с использованием {{ data-transfer-name }}](dataplatform/object-storage-to-postgresql.md)

 - [Захват изменений {{ PG }} и поставка в {{ DS }}](dataplatform/mpg-to-yds.md)

 - [Миграция данных из {{ mpg-name }} в {{ mmy-name }} с помощью {{ data-transfer-name }}](dataplatform/mpg-to-mmy.md)

 - [Миграция данных из {{ mpg-name }} в {{ mos-name }} с помощью {{ data-transfer-name }}](dataplatform/postgresql-to-opensearch.md)

 - [Решение проблем с сортировкой строк в {{ PG }} после обновления glibc](dataplatform/postgresql-glibc-collation-issues.md)

 - [Использование секрета {{ lockbox-name }} в PySpark-задании для подключения к {{ mpg-full-name }}](dataplatform/job-pyspark-secret-access.md)

 - [Настройка прав доступа к секрету, созданному {{ connection-manager-name }}, для пользователя {{ mpg-name }}](dataplatform/conn-man-secret-access.md)

 - [Миграция БД из {{ GP }} в {{ CH }}](dataplatform/greenplum-to-clickhouse.md)

 - [Миграция БД из {{ GP }} в {{ PG }}](dataplatform/greenplum-to-postgresql.md)

 - [Выгрузка данных {{ GP }} в холодное хранилище {{ objstorage-name }}](dataplatform/greenplum-yezzey.md)

 - [Загрузка данных из {{ objstorage-name }} в {{ mgp-name }} с помощью {{ data-transfer-name }}](dataplatform/object-storage-to-greenplum.md)

 - [Копирование данных из {{ mos-name }} в {{ mgp-name }} с помощью {{ data-transfer-full-name }}](dataplatform/opensearch-to-greenplum.md)

 - [Создание внешней таблицы на базе таблицы из бакета {{ objstorage-name }} с помощью конфигурационного файла](dataplatform/mgp-config-server-for-s3.md)

 - [Получение данных из внешних источников с помощью именованных запросов в {{ GP }}](dataplatform/pxf-named-queries.md)

 - [Миграция БД из стороннего кластера {{ VLK }} в {{ mrd-name }}](dataplatform/valkey-data-migration.md)

 - [Использование кластера {{ mrd-name }} в качестве хранилища сессий PHP](dataplatform/valkey-as-php-sessions-storage.md)

 - [Поставка данных из {{ ydb-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}](dataplatform/ydb-mkf-replication.md)

 - [Поставка данных из {{ mkf-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/mkf-ydb-stream.md)

 - [Миграция БД из {{ mmy-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/mmy-ydb-migration.md)

 - [Поставка данных из {{ mpg-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/mpg-ydb-replication.md)

 - [Загрузка данных из {{ objstorage-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}](dataplatform/object-storage-to-ydb.md)

 - [Загрузка данных из {{ ydb-name }} в {{ objstorage-name }} с помощью {{ data-transfer-name }}](dataplatform/ydb-to-object-storage.md)

 - [Обработка аудитных логов {{ at-name }}](dataplatform/audit-log-processing.md)

 - [Обработка логов {{ cloud-logging-name }}](dataplatform/cloud-logging-processing.md)

 - [Обработка потока изменений Debezium](dataplatform/debezium-yq.md)

 - [Анализ данных с помощью {{ jlab }}](dataplatform/jupyter-yq.md)

 - [Обработка файлов детализации в сервисе {{ billing-name }}](dataplatform/billing-detail-files-processing.md)

 - [Ввод данных в системы хранения](dataplatform/data-ingestion.md)

 - [Умная обработка логов](dataplatform/log-ingestion.md)

 - [Передача данных в микросервисных архитектурах](dataplatform/message-broker.md)

 - [Миграция данных в {{ objstorage-name }} с помощью {{ data-transfer-name }}](dataplatform/yds-obj-migration.md)

 - [Миграция данных из стороннего кластера {{ GP }} или {{ PG }} в {{ mgp-name }} с помощью {{ data-transfer-name }}](dataplatform/managed-greenplum.md)

 - [Миграция кластера {{ mmg-name }}](dataplatform/storedoc.md)

 - [Миграция кластера {{ MY }}](dataplatform/managed-mysql.md)

 - [Миграция на сторонний кластер {{ MY }}](dataplatform/managed-mysql-to-mysql.md)

 - [Миграция кластера {{ PG }}](dataplatform/managed-postgresql.md)

 - [Создание реестра схем для поставки данных в формате Debezium CDC из {{ KF }}](dataplatform/schema-registry-cdc-debezium-kafka.md)

 - [Автоматизация работы с помощью {{ maf-full-name }}](dataplatform/airflow-and-spark.md)

 - [Работа с таблицей в {{ objstorage-name }} из PySpark-задания](dataplatform/spark-simple-rw-job.md)

 - [Интеграция {{ msp-full-name }} и {{ metastore-full-name }}](dataplatform/metastore-and-spark.md)

 - [Запуск PySpark-задания с помощью {{ maf-full-name }}](dataplatform/airflow-spark-min.md)

 - [Использование {{ objstorage-full-name }} в {{ msp-full-name }}](dataplatform/spark-objstorage-integration.md)

 - [Интеграция {{ msp-full-name }} и {{ ml-platform-name }}](dataplatform/spark-and-datasphere.md)

 - [Использование секрета {{ lockbox-name }} в PySpark-задании для подключения к {{ mpg-full-name }}](dataplatform/job-pyspark-secret-access.md)

 - [Запуск PySpark-задания в {{ myt-full-name }}](dataplatform/yt-run-spark-job.md)

## Продукты Microsoft в {{ yandex-cloud }}

 - [Все руководства](windows/index.md)

### Безопасная передача пароля в скрипт инициализации

 - [Обзор](windows/secure-password-script/index.md)

 - [Консоль управления, CLI, API](windows/secure-password-script/console.md)

 - [{{ TF }}](windows/secure-password-script/terraform.md)

 - [Развертывание Active Directory](windows/active-directory.md)

 - [Развертывание Microsoft Exchange](windows/exchange.md)

 - [Развертывание Remote Desktop Services](windows/rds.md)

 - [Развертывание группы доступности Always On с внутренним сетевым балансировщиком](windows/mssql-alwayson-lb.md)

 - [Развертывание Remote Desktop Gateway](windows/rds-gw.md)

 - [Подключение бакета как диска в Windows](windows/s3-disk-connect.md)

## Архитектура, сетевое взаимодействие

 - [Все руководства](routing/index.md)

### Организация VPN-подключений

 - [Создание бастионного хоста](routing/bastion.md)

 - [Создание туннеля между двумя подсетями при помощи OpenVPN Access Server](routing/site-to-site-openvpn.md)

 - [Защищенный доступ пользователей к облачным ресурсам на основе WireGuard VPN](routing/remote-wireguard-vpn.md)

 - [Настройка защищенного туннеля GRE поверх IPsec](routing/gre-over-ipsec.md)

### Сетевая облачная инфраструктура на основе NGFW

 - [Сегментация облачной инфраструктуры с помощью решения Check Point Next-Generation Firewall](routing/network-segmentation-checkpoint.md)

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Check Point NGFW](routing/high-accessible-dmz.md)

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе UserGate NGFW](routing/high-accessible-dmz-usergate.md)

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Смарт-Софт NGFW](routing/high-accessible-dmz-ting.md)

 - [Создание и настройка шлюза UserGate в режиме межсетевого экрана](routing/usergate-firewall.md)

### {{ baremetal-name }}

 - [Настройка VRRP для кластера серверов {{ baremetal-name }}](routing/bms-vrf-routing.md)

 - [Настройка сетевой связности в подсети {{ baremetal-name }}](routing/bms-simple-subnet.md)

 - [Настройка сетевой связности между подсетями {{ baremetal-name }} и {{ vpc-name }}](routing/bm-vrf-and-vpc-interconnect.md)

 - [Доставка USB-устройств на сервер {{ baremetal-name }} или виртуальную машину](routing/usb-over-ip.md)

 - [Настройка межсетевого экрана OPNsense в режиме кластера высокой доступности на серверах {{ baremetal-name }}](routing/opnsense-failover-cluster.md)

 - [Развертывание веб-приложения на серверах {{ baremetal-name }} с L7-балансировщиком и защитой {{ sws-name }}](routing/webapp-on-bms-behind-sws.md)

 - [Организация сетевой связности между подсетями {{ baremetal-name }} и On-Prem с помощью {{ interconnect-name }}](routing/bms-cic-onprem.md)

### {{ interconnect-name }}

 - [Организация доступа через {{ interconnect-name }} к облачным сетям, размещенным за NGFW](routing/cic-with-ngfw.md)

 - [Создание прямого транкового подключения и приватного соединения в нем](routing/trunk-priv-add.md)

 - [Создание прямого транкового подключения и публичного соединения в нем](routing/trunk-pub-add.md)

 - [Создание нового партнерского транкового подключения и приватного соединения в нем](routing/partner-trunk-priv-add.md)

 - [Создание нового партнерского транкового подключения и публичного соединения в нем](routing/partner-trunk-pub-add.md)

 - [Добавление приватного соединения в прямое или партнерское транковое подключение](routing/priv-add.md)

 - [Добавление публичного соединения в прямое или партнерское транковое подключение](routing/pub-add.md)

 - [Изменить емкость транкового подключения](routing/trunk-capacity-change.md)

 - [Удалить приватное соединение](routing/priv-del.md)

 - [Удалить публичное соединение](routing/pub-del.md)

 - [Удалить транковое подключение](routing/trunk-del.md)

### Настройка сетевых ресурсов и взаимодействие между ними

 - [Настройка сетевого взаимодействия ресурсов из разных каталогов](routing/multi-folder-vpc.md)

 - [Реализация отказоустойчивых сценариев для сетевых ВМ](routing/route-switcher.md)

 - [Настройка сети для {{ dataproc-name }}](routing/data-processing-nat-instance.md)

 - [Переключение сетевого соединения при пересоздании кластера {{ dataproc-name }}](routing/data-processing-dns-reconnect.md)

### Подключение к сервисам

 - [Подключение к {{ objstorage-name }} из {{ vpc-short-name }}](routing/storage-vpc-access.md)

 - [Подключение к {{ container-registry-name }} из {{ vpc-short-name }}](routing/vpc-cr-access.md)

## Анализ и визуализация данных

 - [Все руководства](datalens/index.md)

### Аналитика

 - [Визуализация логов в {{ grafana-name }} с помощью плагина {{ cloud-logging-name }}](serverless/grafana-logs-plugin.md)

 - [Поиск событий {{ yandex-cloud }} в {{ yq-name }}](analysis/search-events-query.md)

 - [Поиск событий {{ yandex-cloud }} в {{ objstorage-name }}](analysis/search-events-bucket.md)

 - [Поиск событий {{ yandex-cloud }} в {{ cloud-logging-name }}](analysis/search-events-logging.md)

### {{ datalens-name }}

#### Знакомство с {{ datalens-short-name }}

 - [Простой дашборд из CSV-файла](datalens/data-from-csv-visualization.md)

 - [Публичный чарт с картой Москвы из CSV-файла](datalens/data-from-csv-to-public-visualization.md)

 - [Дашборд сети магазинов из БД {{ CH }}](datalens/data-from-ch-visualization.md)

#### Работа с геоданными

 - [Анализ открытых данных ДТП на дорогах России](datalens/data-from-csv-geo-visualization.md)

 - [Анализ продаж и локаций пиццерий на данных из БД {{ CH }} и Marketplace](datalens/data-from-ch-to-geolayers-visualization.md)

 - [Геокодинг с помощью API Яндекс Карт для визуализации в {{ datalens-short-name }}](datalens/data-from-ch-geocoder.md)

 - [Визуализация данных с использованием инструмента Тепловые карты](datalens/data-on-heat-map-dashboard.md)

#### Аналитика сервисов

 - [Яндекс Метрика: прямое подключение](datalens/data-from-metrica-visualization.md)

 - [Яндекс Метрика: экспорт, постобработка и визуализация данных](datalens/data-from-metrica-yc-visualization.md)

 - [AppMetrica: прямое подключение](datalens/data-from-appmetrica-visualization.md)

 - [AppMetrica: экспорт, постобработка и визуализация данных](datalens/data-from-appmetrica-yc-visualization.md)

 - [Битрикс24: прямое подключение](datalens/data-from-bitrix24-visualization.md)

 - [{{ tracker-name }}: экспорт и визуализация данных](datalens/data-from-tracker.md)

 - [Анализ логов {{ objstorage-name }} при помощи {{ datalens-name }}](datalens/storage-logs-analysis.md)

 - [Подкасты Яндекс Музыки: статистика](datalens/data-from-podcasts.md)

 - [Визуализация данных {{ yq-name }}](datalens/data-from-yandex-query-visualization.md)

 - [Визуализация данных {{ monitoring-name }}](datalens/data-from-monitoring-visualization.md)

 - [Визуализация данных из {{ ytsaurus-name }} CHYT](datalens/data-from-ch-over-yt.md)

#### Функциональные

 - [Использование параметров в вычисляемых полях](datalens/data-from-ch-with-parameters.md)

 - [Параметризация источников](datalens/data-from-ch-dataset-parametrization.md)

 - [Примеры создания QL-чартов](datalens/data-from-ch-to-sql-chart.md)

## Бессерверные технологии

 - [Все руководства](serverless/index.md)

### Бэкенд на Serverless

 - [Развертывание веб-приложения с использованием Java Servlet API](serverless/java-servlet-todo-list.md)

#### Конвертация видео в GIF на Python

 - [Обзор](serverless/video-converting-queue/index.md)

 - [Консоль управления](serverless/video-converting-queue/console.md)

 - [Terraform](serverless/video-converting-queue/terraform.md)

 - [Разработка пользовательской интеграции в {{ api-gw-name }}](serverless/api-gw-integration.md)

#### Сокращатель ссылок

 - [Обзор](serverless/serverless-url-shortener/index.md)

 - [Консоль управления](serverless/serverless-url-shortener/console.md)

 - [{{ TF }}](serverless/serverless-url-shortener/terraform.md)

 - [Разработка CRUD API для сервиса фильмов](serverless/movies-database.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](serverless/websocket-app.md)

 - [Работа с API-шлюзом по протоколу WebSocket](serverless/api-gw-websocket.md)

 - [Создание функции Node.js с помощью TypeScript](serverless/nodejs-typescript.md)

 - [Запуск контейнерного приложения в {{ serverless-containers-name }}](serverless/deploy-app-container.md)

 - [Подключение к {{ ydb-short-name }} из функции {{ sf-name }} на Python](serverless/connect-from-cf.md)

 - [Подключение к базе данных {{ ydb-short-name }} из функции {{ sf-name }} на Node.js](serverless/connect-from-cf-nodejs.md)

 - [Настройка подключения к {{ mpg-full-name }} из контейнера {{ serverless-containers-name }}](serverless/container-pg-connect.md)

 - [Развертывание веб-приложения с JWT-авторизацией в {{ api-gw-name }} и аутентификацией в Firebase](serverless/jwt-authorizer-firebase.md)

 - [Разработка функций в Functions Framework и их развертывание в {{ serverless-containers-full-name }}](serverless/functions-framework-to-container.md)

 - [Канареечный релиз функции {{ sf-name }}](serverless/canary-release.md)

 - [Интерактивная отладка функций {{ sf-name }}](serverless/serverless-live-debug.md)

 - [Создание адреса {{ postbox-full-name }} и проверка владения доменом с помощью {{ TF }}](serverless/domain-identity-creating.md)

 - [Настройка Postfix для отправки через {{ postbox-full-name }}](serverless/postfix-integration.md)

### Боты на Serverless

 - [Разработка Slack-бота](serverless/slack-bot-serverless.md)

#### Разработка Telegram-бота

 - [Обзор](serverless/telegram-bot-serverless/index.md)

 - [Консоль управления](serverless/telegram-bot-serverless/console.md)

 - [{{ TF }}](serverless/telegram-bot-serverless/terraform.md)

 - [Разработка Telegram-бота для распознавания текста на изображениях, синтеза и распознавания аудио](serverless/recognizer-bot.md)

### ETL на Serverless

 - [Ввод данных в системы хранения](serverless/data-ingestion.md)

 - [Хранение журналов работы приложения](serverless/log-ingestion.md)

 - [Запись данных с устройства в базу данных](serverless/data-recording.md)

 - [Запись логов балансировщика в {{ PG }}](serverless/logging.md)

 - [Загрузка данных из {{ yandex-direct }} в витрину {{ mch-full-name }} с использованием {{ sf-full-name }}, {{ objstorage-full-name }} и {{ data-transfer-full-name }}](serverless/data-transfer-direct-to-mch.md)

 - [Передача событий {{ postbox-name }} в {{ yds-name }} и их анализ с помощью {{ datalens-name }}](serverless/events-from-postbox-to-yds.md)

 - [{{ tracker-name }}: экспорт и визуализация данных](serverless/data-from-tracker.md)

#### Поставка данных из {{ forms-full-name }} в {{ datalens-full-name }} с использованием {{ sf-full-name }} и {{ yq-full-name }}

 - [Обзор](serverless/forms-and-datalens-integration/index.md)

 - [Консоль управления](serverless/forms-and-datalens-integration/console.md)

 - [Terraform](serverless/forms-and-datalens-integration/terraform.md)

 - [Интеграция {{ postbox-full-name }} с внешними системами через вебхуки](serverless/postbox-webhook.md)

### Рабочие процессы и автоматизация на Serverless

 - [Построение пайплайна CI/CD в {{ GL }}](serverless/ci-cd-serverless.md)

 - [Запуск {{ GLR }} в {{ serverless-containers-name }}](serverless/serverless-gitlab-runner.md)

 - [Создание триггера для бюджетов, который вызывает функцию {{ sf-name }} для остановки ВМ](serverless/serverless-trigger-budget-vm.md)

 - [Автоматическое копирование объектов из одного бакета {{ objstorage-name }} в другой](serverless/bucket-to-bucket-copying.md)

 - [Запуск вычислений по расписанию в {{ ml-platform-name }}](serverless/regular-launch.md)

 - [Регулярное распознавание аудиофайлов из {{ objstorage-name }}](serverless/batch-recognition-stt.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами](serverless/nodejs-cron-restart-vm.md)

 - [Создание триггеров, которые вызывают функции {{ sf-name }} для остановки ВМ и отправки уведомлений в Telegram](serverless/serverless-trigger-budget-queue-vm-tg.md)

#### Масштабирование группы виртуальных машин по расписанию

 - [Обзор](serverless/vm-scale-scheduled/index.md)

 - [Консоль управления, CLI и API](serverless/vm-scale-scheduled/console.md)

 - [{{ TF }}](serverless/vm-scale-scheduled/terraform.md)

 - [Запуск вычислений в {{ ml-platform-name }} с помощью API](serverless/batch-code-execution.md)

 - [Настройка CI/CD между {{ sf-name }} и {{ src-name }}](serverless/ci-cd-sourcecraft-functions.md)

 - [Настройка CI/CD между {{ sf-name }} и GitHub](serverless/ci-cd-github-functions.md)

 - [Настройка CI/CD в {{ src-name }} для развертывания приложения в {{ serverless-containers-name }} с помощью GitHub Actions](serverless/ci-cd-sourcecraft-github-actions.md)

 - [Автоматическая загрузка данных в {{ speechsense-full-name }} с помощью {{ sw-full-name }}](serverless/auto-upload.md)

 - [Настройка реагирования в {{ cloud-logging-name }} и {{ sf-full-name }}](serverless/logging-functions.md)

 - [Регулярное распознавание изображений и PDF-документов из бакета {{ objstorage-short-name }}](serverless/vision-ocrrecognizer-storage.md)

 - [Настройка интеграций {{ sw-name }} с {{ tracker-name }}, {{ yagpt-name }} и {{ postbox-name }}](serverless/tracker-yandexgpt-postbox-integrations.md)

### Интернет вещей (IoT)

 - [Мониторинг состояния географически распределенных устройств](serverless/datalens.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](serverless/monitoring.md)

 - [Эмуляция множества IoT-устройств](serverless/iot-emulation.md)

 - [Работа с {{ iot-name }} с устройства с Android на языке Java](serverless/android-java.md)

 - [Работа с {{ iot-name }} на языке C#](serverless/c-sharp.md)

 - [Работа с {{ iot-name }} на языке Java](serverless/java.md)

 - [Тестирование доставки сообщения](serverless/message-delivery-check.md)

 - [Отправить сообщение с помощью Mosquitto](serverless/mosquitto-publish.md)

 - [Подписать устройство или реестр на получение сообщений с помощью Mosquitto](serverless/mosquitto-subscribe.md)

### Интеграция с сервисами Яндекса и Yandex Cloud

 - [Защита {{ api-gw-name }} при помощи {{ sws-name }}](serverless/api-gw-sws-integration.md)

 - [Создание навыка Алисы](serverless/alice-skill.md)

 - [Разработка навыка Алисы и сайта с авторизацией](serverless/alice-shareable-todolist.md)

 - [Использование {{ api-gw-name }} для настройки синтеза речи в {{ speechkit-name }}](serverless/speechkit-integrarion-via-agi-gw.md)

### Искусственный интеллект

 - [Разработка Telegram-бота с поддержкой AI-агента](serverless/telegram-ai-bot-workflows.md)

 - [Создание AI-агента с помощью {{ sf-full-name }}](serverless/create-ai-agent-function.md)

 - [ИИ-ревью пул-реквестов на GitHub с помощью {{ sw-name }} и GitHub Actions](serverless/ai-powered-github-pr-review.md)

 - [Создание AI-агента со стримингом ответа через веб-сокеты](serverless/streaming-openai-agent.md)

### Отправка писем в {{ postbox-full-name }} с помощью AWS SDK

 - [.NET Core](serverless/send-emails-aws-sdk-csharp.md)

 - [Go](serverless/send-emails-aws-sdk-go.md)

 - [JavaScript](serverless/send-emails-aws-sdk-js.md)

 - [Python](serverless/send-emails-aws-sdk-python.md)

## Машинное обучение и искусственный интеллект

 - [Все руководства](ml-ai/index.md)

### Разработка с помощью {{ ml-platform-name }}

 - [Интеграция сервиса {{ ml-platform-name }} с сервисом {{ dataproc-name }}](ml-ai/data-processing-integration.md)

 - [Классификация изображений на видеокадрах](ml-ai/video-recognition.md)

 - [Запуск вычислений по расписанию в {{ ml-platform-name }}](ml-ai/regular-launch.md)

 - [Запуск вычислений в {{ ml-platform-name }} с помощью API](ml-ai/batch-code-execution.md)

 - [Использование данных из {{ objstorage-name }} для обучения модели в {{ ml-platform-name }}](ml-ai/s3-to-datasphere.md)

 - [Создание сервера MLFlow для логирования экспериментов и артефактов](ml-ai/mlflow-datasphere.md)

 - [Дообучение моделей в {{ ml-platform-name }}](ml-ai/models-fine-tuning.md)

### Эксплуатация {{ ml-platform-name }}

 - [Развертывание сервиса в {{ ml-platform-name }} из модели ONNX](ml-ai/node-from-model.md)

 - [Развертывание сервиса в {{ ml-platform-name }} на основе Docker-образа](ml-ai/node-from-docker.md)

 - [Развертывание сервиса в {{ ml-platform-name }} на основе Docker-образа с FastAPI](ml-ai/node-from-docker-fast-api.md)

 - [Развертывание gRPC-сервиса на основе Docker-образа](ml-ai/grpc-node.md)

 - [Генерация изображения с помощью модели Stable Diffusion](ml-ai/stable-diffusion.md)

### Аналитика с помощью {{ ml-platform-name }}

 - [Анализ данных с помощью {{ yq-name }}](ml-ai/yq.md)

 - [Работа с данными в {{ objstorage-name }}](ml-ai/yq-storage.md)

 - [Работа с данными в {{ mch-name }}](ml-ai/yq-clickhouse.md)

 - [Работа с данными в {{ mpg-name }}](ml-ai/yq-postgre.md)

 - [Федеративные запросы к данным](ml-ai/yq-federative-queries.md)

 - [Использование сервиса {{ msp-name }}](dataplatform/spark-and-datasphere.md)

### Разработка с помощью {{ mgl-full-name }}

 - [Управление жизненным циклом MLOps с помощью ML Registry](ml-ai/mlops-ml-registry.md)

### Распознавание изображений, текста и речи

 - [Распознавание архива изображений в {{ vision-name }}](ml-ai/archive-from-vision-to-object-storage.md)

 - [Разработка Telegram-бота для распознавания текста и аудио](ml-ai/recognizer-bot.md)

 - [Регулярное асинхронное распознавание аудиофайлов из {{ objstorage-name }}](ml-ai/batch-recognition-stt.md)

 - [Регулярное распознавание изображений и PDF-документов из бакета {{ objstorage-name }}](ml-ai/vision-ocrrecognizer-storage.md)

### Речевая аналитика

 - [Автоматическая загрузка данных в {{ speechsense-full-name }} с помощью {{ sw-full-name }}](ml-ai/speechsense/auto-upload.md)

 - [Интеграция {{ speechsense-name }} с {{ amocrm-name }}](ml-ai/speechsense/amocrm.md)

 - [Интеграция {{ speechsense-name }} с {{ bitrix24-name }}](ml-ai/speechsense/bitrix24.md)

 - [Работа с AI-ассистентом в {{ speechsense-name }}](ml-ai/speechsense/ai-assistant.md)

### Использование генеративных нейросетей {{ ai-studio-full-name }}

 - [Интеграция генеративных моделей в Visual Studio Code в качестве ассистента для написания кода](ml-ai/ai-model-ide-integration.md)

 - [Интеграция AI-аналитика данных с {{ data-catalog-name }}](ml-ai/data-catalog-integration.md)