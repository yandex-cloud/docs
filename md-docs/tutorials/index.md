# Практические руководства платформы Yandex Cloud

Практические руководства, которые помогут вам решать различные задачи с помощью сервисов Yandex Cloud.

# Практические руководства

## Безопасность

 - [Все руководства](security/index.md)

 - [Разграничение прав доступа для групп пользователей](security/user-group-access-control.md)

 - [Приглашение нового пользователя и назначение ролей](security/add-account-and-assign-roles.md)

### Создание L7-балансировщика с защитой от DDoS

 - [Обзор](security/alb-with-ddos-protection/index.md)

 - [Консоль управления, CLI](security/alb-with-ddos-protection/console.md)

 - [Terraform](security/alb-with-ddos-protection/terraform.md)

### Создание L7-балансировщика Application Load Balancer с профилем безопасности Smart Web Security

 - [Обзор](security/balancer-with-sws-profile/index.md)

 - [Консоль управления](security/balancer-with-sws-profile/console.md)

 - [Terraform](security/balancer-with-sws-profile/terraform.md)

 - [Создание L7-балансировщика с профилем безопасности Smart Web Security через Ingress-контроллер Application Load Balancer](security/alb-ingress-with-sws-profile.md)

 - [Создание распределенной инфраструктуры с защищенным доступом](security/distributed-secured-infrastructure.md)

 - [Централизованная публикация в интернете и защита приложений от DDoS](security/different-folders-services.md)

 - [Базовая настройка SWS](security/sws-basic-protection.md)

 - [Экстренная защита сервисов в Application Load Balancer от DDoS на уровне L7](security/sws-protection-ongoing-ddos.md)

### Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Smart Web Security

 - [Обзор](security/migration-from-nlb-to-alb/index.md)

#### Балансировщик NLB с целевыми ресурсами из виртуальных машин

 - [Обзор](security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/console.md)

 - [Terraform](security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из группы виртуальных машин

 - [Обзор](security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/console.md)

 - [Terraform](security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из кластера Managed Service for Kubernetes

 - [Обзор](security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/console.md)

 - [Terraform](security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/terraform.md)

#### Балансировщик NLB как целевой ресурс для ALB

 - [Обзор](security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)

 - [Консоль управления](security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/console.md)

 - [Terraform](security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/terraform.md)

### Терминирование TLS-соединений

 - [Обзор](security/tls-termination/index.md)

 - [Консоль управления](security/tls-termination/console.md)

 - [Terraform](security/tls-termination/terraform.md)

 - [Передача логов с виртуальной машины в Cloud Logging](security/vm-fluent-bit-logging.md)

 - [Запись логов балансировщика в PostgreSQL](security/logging.md)

 - [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](security/gitlab-lockbox-integration.md)

### Хранение статического ключа доступа в секрете Yandex Lockbox

 - [Обзор](security/static-key-in-lockbox/index.md)

 - [CLI](security/static-key-in-lockbox/console.md)

 - [Terraform](security/static-key-in-lockbox/terraform.md)

 - [Сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](security/sa-oslogin-ansible.md)

### Организация защищенного доступа к контенту в Cloud CDN

 - [Обзор](security/protected-access-to-content/index.md)

 - [Консоль управления, CLI, API](security/protected-access-to-content/console.md)

 - [Terraform](security/protected-access-to-content/terraform.md)

### Загрузка аудитных логов в SIEM KUMA

 - [Обзор](security/audit-trails-events-to-kuma/index.md)

 - [Консоль управления, CLI, API](security/audit-trails-events-to-kuma/console.md)

 - [Terraform](security/audit-trails-events-to-kuma/terraform.md)

 - [Передача логов с Container Optimized Image в Cloud Logging](security/coi-fluent-bit-logging.md)

### Поиск событий в аудитных логах

 - [Обзор](security/search-events-audit-logs/index.md)

 - [Инструменты для работы с аудитными логами](security/search-events-audit-logs/tools.md)

 - [Примеры запросов для поиска событий](security/search-events-audit-logs/examples.md)

 - [Настройка работы с Query](security/search-events-audit-logs/query.md)

 - [Добавление HTML-страницы для работы SmartCaptcha](security/mobile-app/website.md)

### Создание L7-балансировщика с профилем безопасности

 - [Обзор](security/balancer-with-sws-profile/index.md)

 - [Консоль управления](security/balancer-with-sws-profile/console.md)

 - [Terraform](security/balancer-with-sws-profile/terraform.md)

 - [ViPNet Coordinator в Yandex Cloud](security/vipnet-to-yc.md)

 - [Настройка алертов и дашбордов в Monitoring](security/alerts-monitoring.md)

### Загрузка аудитных логов в MaxPatrol SIEM

 - [Обзор](security/maxpatrol/index.md)

 - [Консоль управления](security/maxpatrol/console.md)

 - [Terraform](security/maxpatrol/terraform.md)

 - [Загрузка аудитных логов в SIEM Splunk](security/export-logs-to-splunk.md)

 - [Загрузка аудитных логов в SIEM ArcSight](security/export-logs-to-arcsight.md)

### Управление федерациями удостоверений

 - [Аутентификация с помощью Active Directory](security/integration-adfs.md)

 - [Аутентификация с помощью Google Workspace](security/integration-gworkspace.md)

 - [Аутентификация с помощью Microsoft Entra ID](security/integration-azure.md)

 - [Аутентификация с помощью Keycloak](security/integration-keycloak.md)

#### Сопоставление групп пользователей

 - [Сопоставление групп пользователей в Active Directory Federation Services](security/adfs.md)

 - [Сопоставление групп пользователей в Microsoft Entra ID](security/entra-id.md)

 - [Сопоставление групп пользователей в Keycloak](security/keycloak.md)

### Сценарии использования SmartCaptcha

 - [Капча в приложении Android](security/mobile-app/android/quickstart-android.md)

 - [Невидимая капча в приложении Android](security/mobile-app/android/invisible-captcha-android.md)

 - [Капча в приложении Android на Flutter](security/mobile-app/android/quickstart-android-flutter.md)

 - [Капча в приложении iOS](security/mobile-app/ios/quickstart-ios.md)

### Шифрование данных

 - [Какой способ шифрования выбрать?](security/encrypt/index.md)

 - [Шифрование с помощью CLI и API Yandex Cloud](security/encrypt/cli-api.md)

 - [Шифрование с помощью SDK Yandex Cloud](security/encrypt/sdk.md)

 - [Шифрование с помощью AWS Encryption SDK](security/encrypt/aws-encryption-sdk.md)

 - [Шифрование с помощью Google Tink](security/encrypt/google-tink.md)

 - [Шифрование для бакета Object Storage на стороне сервера](security/server-side-encryption.md)

 - [Шифрование секретов в HashiCorp Terraform](security/terraform-secret.md)

 - [Управление ключами KMS с HashiCorp Terraform](security/terraform-key.md)

 - [Auto Unseal в HashiCorp Vault](security/vault-secret.md)

### Интеграции федераций удостоверений сервисных аккаунтов

 - [GitHub](security/wlif-github-integration.md)

 - [GitLab](security/wlif-gitlab-integration.md)

 - [Пользовательская инсталляция Kubernetes](security/wlif-k8s-integration.md)

 - [Managed Service for Kubernetes](security/wlif-managed-k8s-integration.md)

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

 - [Managed Service for GitLab](security/single-sign-on/saml-managed-gitlab.md)

 - [Managed Service for OpenSearch](security/single-sign-on/saml-opensearch.md)

 - [MWS](security/single-sign-on/oidc-mws.md)

 - [NetBird](security/single-sign-on/oidc-netbird.md)

 - [OpenSearch](security/single-sign-on/saml-opensearch-self-managed.md)

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

 - [Яндекс 360](security/single-sign-on/saml-yandex-360.md)

 - [Яндекс Браузер для организаций](security/single-sign-on/saml-ya-browser-corporate.md)

 - [Использование OAuth2 Proxy для приложений, не поддерживающих SSO](security/single-sign-on/oidc-nginx-oauth2-proxy.md)

 - [Загрузка аудитных логов в Managed Service for OpenSearch](security/trails-logs-opensearch.md)

 - [Передача логов кластера Yandex MPP Analytics for PostgreSQL в Yandex Cloud Logging](security/mgp-to-cloud-logging.md)

 - [Получение сведений для запроса на включение ресурса в белый список Минцифры](security/info-for-federal-ip-whitelist.md)

 - [Загрузка объектов в бакет Object Storage с помощью эфемерного ключа доступа](security/ephemeral-key-storage.md)

## Хранение и восстановление данных

 - [Все руководства](archive/index.md)

### Резервное копирование в Object Storage

 - [Обзор](archive/storage-backup-overview.md)

 - [Резервное копирование в Object Storage с помощью aws s3 sync](archive/storage-backup-aws-s3-sync.md)

 - [Резервное копирование в Object Storage с помощью rclone](archive/storage-backup-rclone.md)

 - [Резервное копирование в Object Storage с помощью GeeseFS](archive/storage-backup-geesefs.md)

 - [Резервное копирование в Object Storage с помощью MSP360 Backup (CloudBerry Desktop Backup)](archive/object-storage-cloudberry.md)

 - [Резервное копирование в Object Storage с помощью Duplicati](archive/object-storage-duplicati.md)

 - [Резервное копирование в Object Storage с помощью Bacula](archive/backup-with-bacula.md)

 - [Резервное копирование в Object Storage с помощью Veritas Backup Exec](archive/object-storage-veritas.md)

 - [Резервное копирование в Object Storage с помощью Veeam Backup](archive/backup-with-veeam.md)

 - [Резервное копирование ВМ с помощью Хайстекс Акура](infrastructure-management/hystax-backup.md)

 - [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](archive/kubernetes-backup.md)

 - [Миграция в Yandex Cloud с помощью Хайстекс Акура](infrastructure-management/hystax-migration.md)

 - [Защита от сбоев с помощью Хайстекс Акура](infrastructure-management/hystax-disaster-recovery.md)

### Однонодовый файловый сервер

 - [Обзор](archive/single-node-file-server/index.md)

 - [Консоль управления](archive/single-node-file-server/console.md)

 - [Terraform](archive/single-node-file-server/terraform.md)

 - [Настройка SFTP-сервера на Centos 7](archive/backup-and-archive-to-sftp.md)

 - [Развертывание параллельной файловой системы GlusterFS в высокодоступном режиме](archive/ha-regional-glusterfs.md)

 - [Развертывание параллельной файловой системы GlusterFS в высокопроизводительном режиме](archive/ha-regional-glusterfs-high-performance.md)

### Автоматическая привязка политики резервного копирования Cloud Backup к ВМ

 - [Обзор](archive/vm-with-backup-policy/index.md)

 - [Консоль управления, CLI, API](archive/vm-with-backup-policy/console.md)

 - [Terraform](archive/vm-with-backup-policy/terraform.md)

 - [Репликация логов в Object Storage с помощью Data Streams](archive/replicate-logs-to-storage-via-data-streams.md)

 - [Репликация логов в Object Storage с помощью Fluent Bit](archive/replicate-logs-to-storage.md)

 - [Использование Object Storage в Yandex Data Processing](archive/copy-files-from-object-storage.md)

 - [Подключить сервер BareMetal к Cloud Backup](archive/backup-baremetal.md)

### Развертывание Nextcloud в интеграции с Object Storage

 - [Обзор](archive/integrate-nextcloud/index.md)

 - [Развертывание Nextcloud на ВМ из образа Container Optimized Image](archive/integrate-nextcloud/coi-based.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ вручную](archive/integrate-nextcloud/fault-tolerant.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ с помощью Terraform](archive/integrate-nextcloud/terraform.md)

## Разработка и тестирование

 - [Все руководства](dev/index.md)

 - [Организация сине-зеленого и канареечного развертывания версий веб-сервиса](web/blue-green-canary-deployment.md)

 - [Автоматизация сборки образов с помощью Jenkins и Packer](infrastructure-management/jenkins.md)

 - [Непрерывное развертывание контейнеризованных приложений с помощью GitLab](infrastructure-management/gitlab-containers.md)

 - [Тестирование приложений с помощью GitLab](testing/gitlab.md)

 - [Создание тестовых ВМ через GitLab CI](testing/ci-for-snapshots.md)

 - [Интеграция GitLab с Трекер](dev/gitlab-tracker-integration.md)

 - [Высокопроизводительные вычисления (HPC) на прерываемых ВМ](testing/hpc-on-preemptible.md)

 - [Нагрузочное тестирование gRPC-сервиса](testing/loadtesting-grpc.md)

 - [HTTPS-тест с постоянной нагрузкой с помощью Phantom](testing/loadtesting-https-phantom.md)

 - [HTTPS-тест со ступенчатой нагрузкой с помощью Pandora](testing/loadtesting-https-pandora.md)

 - [HTTP-тест с нагрузкой по сценарию с помощью Pandora](testing/loadtesting-http-scenario-pandora.md)

 - [Нагрузочное тестирование с нескольких агентов](testing/loadtesting-multiply.md)

 - [Запуск внешних агентов для нагрузочного тестирования](testing/loadtesting-external-agent.md)

 - [Нагрузочный тест с помощью JMeter](testing/loadtesting-jmeter.md)

 - [Получение статистики запросов к объектам Object Storage с использованием Query](testing/server-logs-yq.md)

 - [Получение количества запросов к объектам Object Storage](testing/server-logs.md)

 - [Вызов нагрузочного тестирования из GitLab CI](testing/loadtesting-gitlab-ci.md)

 - [Развертывание GitLab Runner на виртуальной машине Compute Cloud](dev/install-gitlab-runner.md)

 - [Развертывание воркера SourceCraft на виртуальной машине Compute Cloud](dev/self-hosted-worker-sourcecraft.md)

 - [Сравнение результатов нагрузочных тестов](testing/loadtesting-results-compare.md)

 - [Миграция нагрузочного тестирования на k6](testing/loadtesting-migration-to-k6.md)

 - [ИИ-ревью пул-реквестов на GitHub с помощью Yandex Workflows и GitHub Actions](dev/ai-powered-github-pr-review.md)

## Базовая инфраструктура

 - [Все руководства](infrastructure/index.md)

 - [Архитектура и защита базового интернет-сервиса](routing/web-service.md)

 - [Анализ поресурсной детализации расходов с помощью Object Storage](infrastructure/billing-resource-detailing.md)

 - [Получение сведений для запроса на включение ресурса в белый список Минцифры](infrastructure/info-for-federal-ip-whitelist.md)

### Отказоустойчивость и масштабирование

 - [Настройка отказоустойчивой архитектуры в Yandex Cloud](infrastructure-management/fault-tolerance.md)

#### Отказоустойчивый сайт с балансировкой нагрузки через Network Load Balancer

 - [Обзор](web/load-balancer-website/index.md)

 - [Консоль управления](web/load-balancer-website/console.md)

 - [Terraform](web/load-balancer-website/terraform.md)

#### Отказоустойчивый сайт с балансировкой нагрузки через Application Load Balancer

 - [Обзор](web/application-load-balancer-website/index.md)

 - [Консоль управления](web/application-load-balancer-website/console.md)

 - [Terraform](web/application-load-balancer-website/terraform.md)

#### Интеграция L7-балансировщика с Cloud CDN и Object Storage

 - [Обзор](web/cdn-storage-integration/index.md)

 - [Консоль управления, CLI и API](web/cdn-storage-integration/console.md)

 - [Terraform](web/cdn-storage-integration/terraform.md)

#### Работа с группой ВМ с автоматическим масштабированием

 - [Обзор](infrastructure-management/vm-autoscale/index.md)

 - [Консоль управления, CLI и API](infrastructure-management/vm-autoscale/console.md)

 - [Terraform](infrastructure-management/vm-autoscale/terraform.md)

#### Масштабирование группы виртуальных машин по расписанию

 - [Обзор](infrastructure-management/vm-scale-scheduled/index.md)

 - [Консоль управления, CLI и API](infrastructure-management/vm-scale-scheduled/console.md)

 - [Terraform](infrastructure-management/vm-scale-scheduled/terraform.md)

 - [Автомасштабирование группы ВМ для обработки сообщений из очереди Message Queue](infrastructure-management/autoscale-monitoring.md)

 - [Обновление группы ВМ под нагрузкой](infrastructure-management/updating-under-load.md)

 - [Создание триггера для бюджетов, который вызывает функцию для остановки ВМ](infrastructure-management/serverless-trigger-budget-vm.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми ВМ](infrastructure/nodejs-cron-restart-vm.md)

 - [Создание триггеров, которые вызывают функции для остановки ВМ и отправки уведомлений в Telegram](infrastructure-management/serverless-trigger-budget-queue-vm-tg.md)

### Инструменты

 - [Начало работы с Terraform](infrastructure-management/terraform-quickstart.md)

 - [Источники данных Terraform](infrastructure-management/terraform-data-sources.md)

 - [Загрузка состояний Terraform в Object Storage](infrastructure-management/terraform-state-storage.md)

 - [Начало работы с Packer](infrastructure-management/packer-quickstart.md)

 - [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](infrastructure-management/packer-custom-image.md)

 - [Блокировка состояний Terraform с помощью Managed Service for YDB](infrastructure-management/terraform-state-lock.md)

 - [Использование модулей Yandex Cloud в Terraform](infrastructure-management/terraform-modules.md)

 - [Управление ресурсами Kubernetes с помощью провайдера Terraform](infrastructure-management/kubernetes-terraform-provider.md)

 - [Создать ВМ и группу ВМ с Container Optimized Image с помощью Terraform](infrastructure/coi-with-terraform.md)

#### Запуск Docker-образа на виртуальной машине

 - [Обзор](infrastructure-management/run-docker-on-vm/index.md)

 - [Консоль управления, CLI и API](infrastructure-management/run-docker-on-vm/console.md)

 - [Terraform](infrastructure-management/run-docker-on-vm/terraform.md)

 - [Передача логов через HTTP-вход Unified Agent в Cloud Logging](infrastructure-management/ua-http-logging.md)

 - [Запуск языковой модели DeepSeek-R1 в кластере GPU Compute Cloud](infrastructure/gpu-cluster-deepseek.md)

### Сеть

 - [Настройка синхронизации часов с помощью NTP](infrastructure-management/ntp.md)

 - [Настройки DHCP для работы с корпоративным DNS-сервером](routing/dhcp-options.md)

#### Маршрутизация через NAT-инстанс

 - [Обзор](routing/nat-instance/index.md)

 - [Консоль управления](routing/nat-instance/console.md)

 - [Terraform](routing/nat-instance/terraform.md)

 - [Установка виртуального роутера Cisco CSR 1000v](routing/cisco.md)

 - [Установка виртуального роутера Mikrotik CHR](routing/mikrotik.md)

### VPNs

#### Организация сетевой связности с помощью IPsec-шлюзов

 - [Схема решения](routing/ipsec/index.md)

 - [Самостоятельная реализация средствами Yandex Cloud](routing/ipsec/ipsec-vpn.md)

 - [Развертывание S2S VPN с помощью strongSwan в Yandex Cloud](routing/ipsec/s2s-vpn.md)

 - [Решение SGW от команды архитекторов Yandex Cloud](routing/ipsec/sgw.md)

 - [Соединение с облачной сетью при помощи OpenVPN](routing/openvpn.md)

 - [Создание и настройка шлюза UserGate в режиме прокси-сервера](routing/usergate-proxy.md)

### Cloud DNS

 - [Настройка локального кеширующего DNS-резолвера](infrastructure-management/local-dns-cache.md)

 - [Миграция DNS-зон из Яндекс 360 в Cloud DNS](infrastructure-management/connect-migration.md)

 - [Настройка Cloud DNS для доступа к кластеру Managed Service for ClickHouse® из других облачных сетей](dataplatform/clickhouse-dns-peering.md)

 - [Интеграция Cloud DNS и корпоративного сервиса DNS](infrastructure-management/dns-integration.md)

 - [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](infrastructure-management/cert-manager-webhook.md)

### GPU

 - [Запуск языковой модели DeepSeek-R1 в кластере GPU](infrastructure-management/gpu-cluster-deepseek.md)

 - [Запуск библиотеки vLLM с языковой моделью Gemma 3 на ВМ с GPU](infrastructure-management/vllm-gemma-gpu.md)

## Контейнерная инфраструктура

 - [Все руководства](container-infrastructure/index.md)

 - [Настройка подключения к Managed Service for PostgreSQL из контейнера Serverless Containers](container-infrastructure/container-pg-connect.md)

 - [Создать ВМ с Container Optimized Image](container-infrastructure/vm-create.md)

 - [Создать ВМ с Container Optimized Image и дополнительным томом для Docker-контейнера](container-infrastructure/vm-create-with-second-disk.md)

 - [Создать группу ВМ с Container Optimized Image и несколькими Docker-контейнерами](container-infrastructure/ig-with-containers.md)

 - [Создать группу ВМ с Container Optimized Image](container-infrastructure/ig-create.md)

 - [Создать ВМ с Container Optimized Image и несколькими Docker-контейнерами](container-infrastructure/docker-compose.md)

 - [Изменить ВМ с Container Optimized Image](container-infrastructure/vm-update.md)

 - [Настройка вывода информации из Docker-контейнера в серийный порт](container-infrastructure/serial-port.md)

 - [Запуск Docker-образа на виртуальной машине с помощью Cloud Registry](container-infrastructure/docker-cloud-registry.md)

### Managed Service for Kubernetes

 - [Создание нового Kubernetes-проекта](container-infrastructure/new-kubernetes-project.md)

 - [Создание кластера Kubernetes без доступа в интернет](container-infrastructure/k8s-cluster-with-no-internet.md)

 - [Создание кластера Kubernetes с помощью провайдера Yandex Cloud для Kubernetes Cluster API](container-infrastructure/k8s-cluster-api-provider-yandex.md)

 - [Запуск рабочих нагрузок с GPU](container-infrastructure/running-pod-gpu.md)

 - [Использование групп узлов c GPU без предустановленных драйверов](container-infrastructure/driverless-gpu.md)

 - [Установка Time-Slicing GPUs](container-infrastructure/time-slicing-gpu.md)

 - [Миграция ресурсов в другую зону доступности](container-infrastructure/migration-to-an-availability-zone.md)

 - [Шифрование секретов](container-infrastructure/kms-k8s.md)

 - [Подключение сервера BareMetal как внешнего узла к кластеру Managed Service for Kubernetes](container-infrastructure/k8s-connect-bms-as-node.md)

#### Настройка и тестирование масштабирования

 - [Горизонтальное масштабирование приложения в кластере](container-infrastructure/autoscaling.md)

 - [Вертикальное масштабирование приложения в кластере](container-infrastructure/vpa-autoscaling.md)

 - [Развертывание и нагрузочное тестирование gRPC-сервиса с масштабированием](container-infrastructure/loadtesting-grpc-autoscaling.md)

#### Использование Container Registry

 - [Интеграция с Container Registry](container-infrastructure/container-registry.md)

 - [Подпись и проверка Docker-образов Container Registry](container-infrastructure/sign-cr-with-cosign.md)

 - [Хранение Docker-образов из проектов Managed Service for GitLab](container-infrastructure/image-storage.md)

#### Непрерывная интеграция с GitLab

 - [Сканирование уязвимостей Container Registry при непрерывном развертывании приложений с помощью GitLab](container-infrastructure/cr-scanner-with-k8s-and-gitlab.md)

#### Работа с DNS

 - [Интеграция с корпоративной зоной DNS](container-infrastructure/custom-dns.md)

 - [Автоматическое масштабирование DNS по размеру кластера](container-infrastructure/dns-autoscaler.md)

 - [Настройка NodeLocal DNS Cache](container-infrastructure/node-local-dns.md)

 - [Проверка DNS Challenge для сертификатов Let's Encrypt®](container-infrastructure/dnschallenge.md)

#### Резервное копирование

 - [Работа со снапшотами Compute Cloud](container-infrastructure/pvc-snapshot-restore.md)

#### Мониторинг

 - [Мониторинг кластера с помощью Prometheus и Grafana](container-infrastructure/prometheus-grafana-monitoring.md)

 - [Мониторинг кластера Managed Service for Kubernetes с помощью Filebeat OSS](container-infrastructure/filebeat-oss-monitoring.md)

#### Использование продуктов Cloud Marketplace

 - [Интеграция с Argo CD](container-infrastructure/argo-cd.md)

 - [Интеграция с Crossplane](container-infrastructure/crossplane.md)

 - [Синхронизация секретов Yandex Lockbox и Managed Service for Kubernetes](container-infrastructure/kubernetes-lockbox-secrets.md)

 - [Передача логов кластера Managed Service for Kubernetes в Cloud Logging](container-infrastructure/k8s-fluent-bit-logging.md)

 - [Настройка Gateway API](container-infrastructure/gateway-api.md)

 - [Настройка Ingress-контроллера Application Load Balancer](container-infrastructure/alb-ingress-controller.md)

 - [Настройки логирования для Ingress-контроллеров Application Load Balancer](container-infrastructure/alb-ingress-controller-log-options.md)

 - [Проверка состояния приложений в кластере Managed Service for Kubernetes с помощью Ingress-контроллера Application Load Balancer](container-infrastructure/custom-health-checks.md)

 - [Настройка Kyverno & Kyverno Policies](container-infrastructure/kyverno.md)

 - [Использование Metrics Provider для трансляции метрик](container-infrastructure/metrics-provider.md)

 - [Редактирование изображений для сайтов с помощью Thumbor](container-infrastructure/thumbor.md)

 - [Использование Istio](container-infrastructure/istio.md)

 - [Использование HashiCorp Vault для хранения секретов](container-infrastructure/hashicorp-vault.md)

## Прикладные решения

 - [Все руководства](applied/index.md)

### Создание сайта

#### Статический сайт в Object Storage

 - [Обзор](web/static/index.md)

 - [Консоль управления](web/static/console.md)

 - [Terraform](web/static/terraform.md)

#### Статический сайт в Object Storage с доступом через Cloud CDN

 - [Обзор](applied/cdn-hosting/index.md)

 - [Консоль управления, CLI, API](applied/cdn-hosting/console.md)

 - [Terraform](applied/cdn-hosting/terraform.md)

#### Сайт на WordPress

 - [Обзор](web/wordpress-overview.md)

 - [Сайт на WordPress High Availability с помощью Cloud Apps](web/wordpress-ha-cloudapp.md)

 - [Сайт на WordPress с помощью Cloud Apps](web/wordpress-cloudapp.md)

##### Сайт на WordPress с помощью Marketplace

 - [Обзор](web/wordpress/index.md)

 - [Консоль управления](web/wordpress/console.md)

 - [Terraform](web/wordpress/terraform.md)

##### Сайт на WordPress с БД MySQL®

 - [Обзор](web/wordpress-mysql/index.md)

 - [Консоль управления](web/wordpress-mysql/console.md)

 - [Terraform](web/wordpress-mysql/terraform.md)

 - [Перенос WordPress-сайта с хостинга в Yandex Cloud](web/wordpress-transfer.md)

#### Сайт на LAMP- или LEMP-стеке

 - [Обзор](web/lamp-lemp/index.md)

 - [Консоль управления](web/lamp-lemp/console.md)

 - [Terraform](web/lamp-lemp/terraform.md)

#### Создание сайта на CMS Joomla с базой данных PostgreSQL

 - [Обзор](web/joomla-postgresql/index.md)

 - [Консоль управления](web/joomla-postgresql/console.md)

 - [Terraform](web/joomla-postgresql/terraform.md)

#### Создание сайта на базе «1С-Битрикс»

 - [Обзор](web/bitrix-website/index.md)

 - [Консоль управления](web/bitrix-website/console.md)

 - [Terraform](web/bitrix-website/terraform.md)

#### Интернет-магазин на платформе OpenCart

 - [Обзор](internet-store/opencart/index.md)

 - [Консоль управления](internet-store/opencart/console.md)

 - [Terraform](internet-store/opencart/terraform.md)

 - [Организация виртуального хостинга](web/virtual-hosting.md)

#### Привязка доменного имени к ВМ с веб-сервером

 - [Обзор](web/bind-domain-vm/index.md)

 - [Консоль управления, CLI и API](web/bind-domain-vm/console.md)

 - [Terraform](web/bind-domain-vm/terraform.md)

 - [Создание веб-приложения на Python с использованием фреймворка Flask](web/flask.md)

 - [Хостинг статического сайта на фреймворке Gatsby](web/gatsby-static-website.md)

 - [Установка Ghost CMS High Availability с помощью Cloud Apps](web/ghost-cms-cloudapp.md)

 - [Миграция в Cloud CDN из стороннего CDN-провайдера](web/migrate-to-yc-cdn.md)

 - [Получение статистики посещения сайта с использованием S3 Select](web/user-agent-statistics.md)

 - [Оформление контента из Cloud Video в IFrame](web/video-iframe.md)

### 1С

#### Интернет-магазин на «1С-Битрикс»

 - [Обзор](internet-store/bitrix-shop/index.md)

 - [Консоль управления](internet-store/bitrix-shop/console.md)

 - [Terraform](internet-store/bitrix-shop/terraform.md)

 - [Создание кластера Linux-серверов «1С:Предприятия» с кластером Managed Service for PostgreSQL](infrastructure-management/1c-postgresql-linux.md)

 - [Мониторинг кластера «1С:Предприятие» на базе Linux](infrastructure-management/collect-metrics-1c-cluster.md)

### Интернет вещей (IoT)

#### Работа с помощью Mosquitto

 - [Отправить сообщение](iot/mosquitto/mosquitto-publish.md)

 - [Подписать устройство или реестр на получение сообщений](iot/mosquitto/mosquitto-subscribe.md)

 - [Работа с Yandex IoT Core с устройства с Android на языке Java](iot/android-java.md)

 - [Работа с Yandex IoT Core на языке C#](iot/c-sharp.md)

 - [Работа с Yandex IoT Core на языке Java](iot/java.md)

 - [Мониторинг состояния географически распределенных устройств](iot/datalens.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](iot/monitoring.md)

 - [Тестирование доставки сообщения](iot/message-delivery-check.md)

 - [Эмуляция множества IoT-устройств](testing/iot-emulation.md)

 - [Запись данных с устройства в базу данных](iot/data-recording.md)

### Алиса

#### Создание навыка Алисы

 - [Обзор](applied/alice-skill/index.md)

 - [Консоль управления, CLI и API](applied/alice-skill/console.md)

 - [Terraform](applied/alice-skill/terraform.md)

 - [Разработка навыка Алисы и сайта с авторизацией](applied/alice-shareable-todolist.md)

### Прочее

 - [Публикация обновлений для игр с помощью Cloud CDN](web/prefetch.md)

 - [Создание SAP-программы в Yandex Cloud](infrastructure-management/sap.md)

 - [Развертывание сервера Minecraft в Yandex Cloud](infrastructure/minecraft-server.md)

 - [Развертывание мультиплеер-сервера для GTA V в Yandex Cloud](infrastructure/gta-v-server.md)

#### Конвертация видео в GIF на Python

 - [Обзор](serverless/video-converting-queue/index.md)

 - [Консоль управления](serverless/video-converting-queue/console.md)

 - [Terraform](serverless/video-converting-queue/terraform.md)

 - [Настройка печати с Cloud Desktop на локальный принтер в Linux](applied/desktop-linux-printer.md)

## Построение Data Platform

 - [Все руководства](dataplatform/index.md)

 - [Самостоятельное развертывание веб-интерфейса Apache Kafka®](dataplatform/deploy-kafka-ui.md)

 - [Обновление кластера Managed Service for Apache Kafka® с ZooKeeper на KRaft](dataplatform/zk-kraft-kafka-migration.md)

 - [Миграция БД из стороннего кластера Apache Kafka® в Managed Service for Apache Kafka®](dataplatform/kafka-connector.md)

 - [Перенос данных между кластерами Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/data-transfer-mkf.md)

 - [Поставка данных из Managed Service for MySQL® в Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/data-transfer-mmy.md)

 - [Поставка данных из Managed Service for MySQL® в Managed Service for Apache Kafka® с помощью Debezium](dataplatform/debezium-mmy.md)

 - [Поставка данных из Managed Service for PostgreSQL в Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/data-transfer-mpg.md)

 - [Поставка данных из Managed Service for PostgreSQL в Managed Service for Apache Kafka® с помощью Debezium](dataplatform/debezium-mpg.md)

 - [Поставка данных из Managed Service for YDB в Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/ydb-mkf-replication.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Managed Service for ClickHouse® с помощью Data Transfer](dataplatform/data-transfer-mkf-mch.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Yandex MPP Analytics for PostgreSQL с помощью Data Transfer](dataplatform/managed-kafka-to-greenplum.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Yandex StoreDoc с помощью Data Transfer](dataplatform/data-transfer-mkf-mmg.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Managed Service for MySQL® с помощью Data Transfer](dataplatform/data-transfer-mkf-mmy.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Managed Service for OpenSearch с помощью Data Transfer](dataplatform/data-transfer-mkf-mos.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Managed Service for PostgreSQL с помощью Data Transfer](dataplatform/mkf-to-mpg.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Managed Service for YDB с помощью Data Transfer](dataplatform/mkf-ydb-stream.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Data Streams с помощью Data Transfer](dataplatform/mkf-yds-stream.md)

 - [Поставка данных из Data Streams в Managed Service for YDB с помощью Data Transfer](dataplatform/yds-to-ydb.md)

 - [Поставка данных из Data Streams в Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/yds-to-kafka.md)

 - [Захват изменений YDB и поставка в YDS](dataplatform/ydb-to-yds.md)

 - [Настройка Kafka Connect для работы с кластером Managed Service for Apache Kafka®](dataplatform/kafka-connect.md)

 - [Синхронизация топиков Apache Kafka® в Object Storage без использования интернета](dataplatform/kafka-topic-s3-sync-private.md)

### Использование схем формата данных с Managed Service for Apache Kafka®

 - [Управление схемами данных в Managed Service for Apache Kafka®](dataplatform/schema-registry-overview.md)

 - [Использование Managed Schema Registry с Managed Service for Apache Kafka®](dataplatform/managed-schema-registry.md)

 - [Использование Managed Schema Registry с Managed Service for Apache Kafka® с помощью REST API](dataplatform/managed-schema-registry-rest.md)

 - [Использование Confluent Schema Registry с Managed Service for Apache Kafka®](dataplatform/confluent-schema-registry.md)

 - [Отслеживание потери сообщений в топике Apache Kafka®](dataplatform/retention-policy.md)

 - [Автоматизация задач Query с помощью Managed Service for Apache Airflow™](dataplatform/airflow-auto-tasks.md)

 - [Отправка запросов к API Yandex Cloud через Yandex Cloud Python SDK](dataplatform/using-python-sdk-in-airflow.md)

 - [Настройка SMTP-сервера для отправки уведомлений по электронной почте](dataplatform/airflow-test-smtp-notification.md)

 - [Добавление данных в БД ClickHouse®](dataplatform/insert-data-ch.md)

 - [Миграция данных в Managed Service for ClickHouse® средствами ClickHouse®](dataplatform/clickhouse-migration.md)

 - [Миграция данных в Managed Service for ClickHouse® при помощи Data Transfer](dataplatform/ch-to-mch-migration.md)

 - [Поставка данных из Managed Service for MySQL® в Managed Service for ClickHouse® с помощью Data Transfer](dataplatform/mysql-to-clickhouse.md)

 - [Асинхронная репликация данных из PostgreSQL в ClickHouse®](dataplatform/rdbms-to-clickhouse.md)

 - [Обмен данными между Managed Service for ClickHouse® и Yandex Data Processing](dataplatform/dp-mch-data-exchange.md)

 - [Настройка Managed Service for ClickHouse® для Graphite](dataplatform/clickhouse-for-graphite.md)

 - [Получение данных из Managed Service for Apache Kafka® в Managed Service for ClickHouse®](dataplatform/fetch-data-from-mkf.md)

 - [Получение данных из Managed Service for Apache Kafka® в ksqlDB](dataplatform/use-ksqldb-with-mkf.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Managed Service for ClickHouse® с помощью Data Transfer](dataplatform/data-transfer-mkf-mch.md)

 - [Получение данных из RabbitMQ в Managed Service for ClickHouse®](dataplatform/fetch-data-from-rabbitmq.md)

 - [Сохранение потока данных Data Streams в Managed Service for ClickHouse®](dataplatform/yds-to-clickhouse.md)

 - [Асинхронная репликация данных из Яндекс Метрика в ClickHouse® с помощью Data Transfer](dataplatform/metrika-to-clickhouse.md)

 - [Использование гибридного хранилища в Managed Service for ClickHouse®](dataplatform/clickhouse-hybrid-storage.md)

 - [Шардирование таблиц Managed Service for ClickHouse®](dataplatform/clickhouse-sharding.md)

 - [Загрузка данных из Яндекс Директ в витрину Managed Service for ClickHouse® с использованием Cloud Functions, Object Storage и Data Transfer](dataplatform/data-transfer-direct-to-mch.md)

 - [Загрузка данных из Object Storage в Managed Service for ClickHouse® с помощью Data Transfer](dataplatform/object-storage-to-clickhouse.md)

 - [Миграция данных со сменой хранилища из Managed Service for OpenSearch в Managed Service for ClickHouse® с помощью Data Transfer](dataplatform/opensearch-to-clickhouse.md)

 - [Загрузка данных из Managed Service for YDB в Managed Service for ClickHouse® с помощью Data Transfer](dataplatform/ydb-to-clickhouse.md)

 - [Интеграция Yandex Managed Service for ClickHouse® с Microsoft SQL Server через ClickHouse® JDBC Bridge](dataplatform/jdbc-ch-to-sql-server-integration.md)

 - [Миграция базы данных из Google BigQuery в Managed Service for ClickHouse®](dataplatform/bigquery-to-clickhouse.md)

 - [Интеграция Yandex Managed Service for ClickHouse® с Oracle через ClickHouse® JDBC Bridge](dataplatform/jdbc-ch-to-oracle-integration.md)

 - [Настройка Cloud DNS для доступа к кластеру Managed Service for ClickHouse® из других облачных сетей](dataplatform/clickhouse-dns-peering.md)

 - [Миграция кластера Yandex Data Processing с HDFS в другую зону доступности](dataplatform/hdfs-cluster-migration.md)

 - [Импорт данных из Managed Service for MySQL® в Yandex Data Processing с помощью Sqoop](dataplatform/sqoop-mmy.md)

 - [Импорт данных из Managed Service for PostgreSQL в Yandex Data Processing с помощью Sqoop](dataplatform/sqoop-mpg.md)

 - [Монтирование бакетов Object Storage к файловой системе хостов Yandex Data Processing](dataplatform/data-processing-init-actions-geesefs.md)

 - [Работа с топиками Apache Kafka® с помощью Yandex Data Processing](dataplatform/data-processing-and-kafka.md)

 - [Автоматизация работы с Yandex Data Processing с помощью Managed Service for Apache Airflow™](dataplatform/data-processing-and-airflow.md)

 - [Совместная работа с таблицами Yandex Data Processing с использованием Apache Hive™ Metastore](dataplatform/data-processing-to-data-processing.md)

 - [Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore](dataplatform/metastore-import.md)

 - [Импорт данных из Object Storage, обработка и экспорт в Managed Service for ClickHouse®](dataplatform/s3-data-processing-ch.md)

### Работа с заданиями Yandex Data Processing

 - [Работа с заданиями Hive](dataplatform/hive-job-basics.md)

 - [Работа с заданиями MapReduce](dataplatform/mapreduce-job-basics.md)

 - [Работа с заданиями PySpark](dataplatform/pyspark-job-basics.md)

 - [Работа с заданиями Spark](dataplatform/spark-job-basics.md)

 - [Запуск заданий Apache Hive](dataplatform/how-to-use-hive.md)

 - [Запуск Spark-приложений](dataplatform/run-spark-job.md)

 - [Запуск заданий с удаленного хоста](dataplatform/remote-run-job.md)

 - [Миграция коллекций из стороннего кластера MongoDB в Yandex StoreDoc](dataplatform/mongodb-migration-with-data-transfer.md)

 - [Миграция данных в Yandex StoreDoc](dataplatform/storedoc-data-migration.md)

 - [Миграция кластера Yandex StoreDoc с версии 4.4 на 6.0](dataplatform/storedoc-versions.md)

 - [Шардирование коллекций Yandex StoreDoc](dataplatform/storedoc-sharding.md)

 - [Анализ производительности и оптимизация Yandex StoreDoc](dataplatform/storedoc-profiling.md)

### Миграция БД из стороннего кластера MySQL® в кластер Managed Service for MySQL®

 - [Обзор](dataplatform/mysql-data-migration/index.md)

 - [Перенос данных с использованием сервиса Data Transfer](dataplatform/mysql-data-migration/data-transfer.md)

 - [Перенос данных с помощью логического дампа](dataplatform/mysql-data-migration/logical-dump-migration.md)

 - [Анализ производительности и оптимизация Managed Service for MySQL®](dataplatform/profiling-mmy.md)

 - [Синхронизация данных из стороннего кластера MySQL® в Managed Service for MySQL® с помощью Data Transfer](dataplatform/sync-mysql.md)

 - [Миграция БД из Managed Service for MySQL® в сторонний кластер MySQL®](dataplatform/mmy-to-mysql-migration.md)

 - [Миграция БД из Managed Service for MySQL® в Object Storage с помощью Data Transfer](dataplatform/mmy-objs-migration.md)

 - [Перенос данных из Object Storage в Managed Service for MySQL® с использованием Data Transfer](dataplatform/objs-mmy-migration.md)

 - [Импорт данных из Managed Service for MySQL® в Yandex Data Processing с помощью Sqoop](dataplatform/sqoop-mmy.md)

 - [Поставка данных из Managed Service for MySQL® в Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/data-transfer-mmy.md)

 - [Поставка данных из Managed Service for MySQL® в Managed Service for Apache Kafka® с помощью Debezium](dataplatform/debezium-mmy.md)

 - [Миграция БД из Managed Service for MySQL® в Managed Service for YDB с помощью Data Transfer](dataplatform/mmy-ydb-migration.md)

 - [Захват изменений MySQL® и поставка в YDS](dataplatform/mmy-to-yds.md)

 - [Миграция данных из Managed Service for MySQL® в Managed Service for PostgreSQL с помощью Data Transfer](dataplatform/mmy-to-mpg.md)

 - [Миграция данных из AWS RDS for PostgreSQL в Managed Service for PostgreSQL с помощью Data Transfer](dataplatform/rds-to-mpg.md)

 - [Миграция данных из Managed Service for MySQL® в Yandex MPP Analytics for PostgreSQL с помощью Data Transfer](dataplatform/mmy-to-mgp.md)

 - [Настройка политики индексов в Managed Service for OpenSearch](dataplatform/opensearch-index-policy.md)

 - [Настройка политики холодного хранилища в Managed Service for OpenSearch](dataplatform/opensearch-cold-storage-policy.md)

 - [Миграция данных в Managed Service for OpenSearch из стороннего кластера OpenSearch с помощью Data Transfer](dataplatform/mos-migration-from-standalone.md)

 - [Загрузка данных из Managed Service for OpenSearch в Object Storage с помощью Data Transfer](dataplatform/opensearch-to-object-storage.md)

 - [Миграция данных из Managed Service for OpenSearch в Managed Service for YDB с помощью Data Transfer](dataplatform/opensearch-to-ydb.md)

 - [Копирование данных из Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](dataplatform/opensearch-to-greenplum.md)

 - [Миграция данных из Managed Service for PostgreSQL в Managed Service for OpenSearch с помощью Data Transfer](dataplatform/postgresql-to-opensearch.md)

 - [Аутентификация в OpenSearch Dashboards кластера Managed Service for OpenSearch с помощью Keycloak](dataplatform/opensearch-saml-keycloak.md)

 - [Использование плагина yandex-lemmer в Managed Service for OpenSearch](dataplatform/opensearch-yandex-lemmer.md)

 - [Отправка оповещений по электронной почте в Managed Service for OpenSearch](dataplatform/opensearch-email-notifications.md)

 - [Подключение MCP-клиента к кластеру OpenSearch](dataplatform/mos-mcp.md)

 - [Создание кластера PostgreSQL для «1С:Предприятия»](dataplatform/1c-postgresql.md)

 - [Поиск проблем с производительностью кластера Managed Service for PostgreSQL](dataplatform/mpg-performance-problems.md)

 - [Анализ производительности и оптимизация Managed Service for PostgreSQL](dataplatform/mpg-profiling.md)

 - [Логическая репликация PostgreSQL](dataplatform/mpg-replication-overview.md)

 - [Миграция БД из стороннего кластера PostgreSQL в Managed Service for PostgreSQL](dataplatform/postgresql-data-migration.md)

 - [Миграция БД из Managed Service for PostgreSQL](dataplatform/outbound-replication.md)

 - [Миграция кластера Managed Service for PostgreSQL на другую версию](dataplatform/postgresql-versions.md)

 - [Асинхронная репликация данных из PostgreSQL в ClickHouse®](dataplatform/rdbms-to-clickhouse.md)

 - [Поставка данных из Managed Service for PostgreSQL в Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/data-transfer-mpg.md)

 - [Поставка данных из Managed Service for PostgreSQL в Managed Service for Apache Kafka® с помощью Debezium](dataplatform/debezium-mpg.md)

 - [Импорт данных из Managed Service for PostgreSQL в Yandex Data Processing с помощью Sqoop](dataplatform/sqoop-mpg.md)

 - [Поставка данных из Managed Service for PostgreSQL в Managed Service for YDB с помощью Data Transfer](dataplatform/mpg-ydb-replication.md)

 - [Загрузка данных из Managed Service for YDB в Managed Service for PostgreSQL с помощью Data Transfer](dataplatform/ydb-to-postgresql.md)

 - [Миграция БД из Managed Service for PostgreSQL в Object Storage](dataplatform/mpg-to-objstorage.md)

 - [Перенос данных из Object Storage в Managed Service for PostgreSQL с использованием Data Transfer](dataplatform/object-storage-to-postgresql.md)

 - [Захват изменений PostgreSQL и поставка в YDS](dataplatform/mpg-to-yds.md)

 - [Миграция данных из Managed Service for PostgreSQL в Managed Service for MySQL® с помощью Data Transfer](dataplatform/mpg-to-mmy.md)

 - [Миграция данных из Managed Service for PostgreSQL в Managed Service for OpenSearch с помощью Data Transfer](dataplatform/postgresql-to-opensearch.md)

 - [Решение проблем с сортировкой строк в PostgreSQL после обновления glibc](dataplatform/postgresql-glibc-collation-issues.md)

 - [Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL](dataplatform/job-pyspark-secret-access.md)

 - [Настройка прав доступа к секрету, созданному Connection Manager, для пользователя Managed Service for PostgreSQL](dataplatform/conn-man-secret-access.md)

 - [Миграция БД из Greenplum® в ClickHouse®](dataplatform/greenplum-to-clickhouse.md)

 - [Миграция БД из Greenplum® в PostgreSQL](dataplatform/greenplum-to-postgresql.md)

 - [Выгрузка данных Greenplum® в холодное хранилище Object Storage](dataplatform/greenplum-yezzey.md)

 - [Загрузка данных из Object Storage в Yandex MPP Analytics for PostgreSQL с помощью Data Transfer](dataplatform/object-storage-to-greenplum.md)

 - [Копирование данных из Managed Service for OpenSearch в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](dataplatform/opensearch-to-greenplum.md)

 - [Создание внешней таблицы на базе таблицы из бакета Object Storage с помощью конфигурационного файла](dataplatform/mgp-config-server-for-s3.md)

 - [Получение данных из внешних источников с помощью именованных запросов в Greenplum®](dataplatform/pxf-named-queries.md)

 - [Миграция БД из стороннего кластера Valkey™ в Yandex Managed Service for Valkey™](dataplatform/valkey-data-migration.md)

 - [Использование кластера Yandex Managed Service for Valkey™ в качестве хранилища сессий PHP](dataplatform/valkey-as-php-sessions-storage.md)

 - [Поставка данных из Managed Service for YDB в Managed Service for Apache Kafka® с помощью Data Transfer](dataplatform/ydb-mkf-replication.md)

 - [Поставка данных из Managed Service for Apache Kafka® в Managed Service for YDB с помощью Data Transfer](dataplatform/mkf-ydb-stream.md)

 - [Миграция БД из Managed Service for MySQL® в Managed Service for YDB с помощью Data Transfer](dataplatform/mmy-ydb-migration.md)

 - [Поставка данных из Managed Service for PostgreSQL в Managed Service for YDB с помощью Data Transfer](dataplatform/mpg-ydb-replication.md)

 - [Загрузка данных из Object Storage в Managed Service for YDB с помощью Data Transfer](dataplatform/object-storage-to-ydb.md)

 - [Загрузка данных из Managed Service for YDB в Object Storage с помощью Data Transfer](dataplatform/ydb-to-object-storage.md)

 - [Обработка аудитных логов Audit Trails](dataplatform/audit-log-processing.md)

 - [Обработка логов Cloud Logging](dataplatform/cloud-logging-processing.md)

 - [Обработка потока изменений Debezium](dataplatform/debezium-yq.md)

 - [Анализ данных с помощью Jupyter](dataplatform/jupyter-yq.md)

 - [Обработка файлов детализации в сервисе Yandex Cloud Billing](dataplatform/billing-detail-files-processing.md)

 - [Ввод данных в системы хранения](dataplatform/data-ingestion.md)

 - [Умная обработка логов](dataplatform/log-ingestion.md)

 - [Передача данных в микросервисных архитектурах](dataplatform/message-broker.md)

 - [Миграция данных в Object Storage с помощью Data Transfer](dataplatform/yds-obj-migration.md)

 - [Миграция данных из стороннего кластера Greenplum® или PostgreSQL в Yandex MPP Analytics for PostgreSQL с помощью Data Transfer](dataplatform/managed-greenplum.md)

 - [Миграция кластера Yandex StoreDoc](dataplatform/storedoc.md)

 - [Миграция кластера MySQL®](dataplatform/managed-mysql.md)

 - [Миграция на сторонний кластер MySQL®](dataplatform/managed-mysql-to-mysql.md)

 - [Миграция кластера PostgreSQL](dataplatform/managed-postgresql.md)

 - [Создание реестра схем для поставки данных в формате Debezium CDC из Apache Kafka®](dataplatform/schema-registry-cdc-debezium-kafka.md)

 - [Автоматизация работы с помощью Yandex Managed Service for Apache Airflow™](dataplatform/airflow-and-spark.md)

 - [Работа с таблицей в Object Storage из PySpark-задания](dataplatform/spark-simple-rw-job.md)

 - [Интеграция Yandex Managed Service for Apache Spark™ и Apache Hive™ Metastore](dataplatform/metastore-and-spark.md)

 - [Запуск PySpark-задания с помощью Yandex Managed Service for Apache Airflow™](dataplatform/airflow-spark-min.md)

 - [Использование Yandex Object Storage в Yandex Managed Service for Apache Spark™](dataplatform/spark-objstorage-integration.md)

 - [Интеграция Yandex Managed Service for Apache Spark™ и DataSphere](dataplatform/spark-and-datasphere.md)

 - [Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL](dataplatform/job-pyspark-secret-access.md)

 - [Запуск PySpark-задания в Yandex Managed Service for YTsaurus](dataplatform/yt-run-spark-job.md)

## Продукты Microsoft в Yandex Cloud

 - [Все руководства](windows/index.md)

### Безопасная передача пароля в скрипт инициализации

 - [Обзор](windows/secure-password-script/index.md)

 - [Консоль управления, CLI, API](windows/secure-password-script/console.md)

 - [Terraform](windows/secure-password-script/terraform.md)

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

### BareMetal

 - [Настройка VRRP для кластера серверов BareMetal](routing/bms-vrf-routing.md)

 - [Настройка сетевой связности в подсети BareMetal](routing/bms-simple-subnet.md)

 - [Настройка сетевой связности между подсетями BareMetal и Virtual Private Cloud](routing/bm-vrf-and-vpc-interconnect.md)

 - [Доставка USB-устройств на сервер BareMetal или виртуальную машину](routing/usb-over-ip.md)

 - [Настройка межсетевого экрана OPNsense в режиме кластера высокой доступности на серверах BareMetal](routing/opnsense-failover-cluster.md)

 - [Развертывание веб-приложения на серверах BareMetal с L7-балансировщиком и защитой Smart Web Security](routing/webapp-on-bms-behind-sws.md)

 - [Организация сетевой связности между подсетями BareMetal и On-Prem с помощью Cloud Interconnect](routing/bms-cic-onprem.md)

### Cloud Interconnect

 - [Организация доступа через Cloud Interconnect к облачным сетям, размещенным за NGFW](routing/cic-with-ngfw.md)

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

 - [Настройка сети для Yandex Data Processing](routing/data-processing-nat-instance.md)

 - [Переключение сетевого соединения при пересоздании кластера Yandex Data Processing](routing/data-processing-dns-reconnect.md)

### Подключение к сервисам

 - [Подключение к Object Storage из VPC](routing/storage-vpc-access.md)

 - [Подключение к Container Registry из VPC](routing/vpc-cr-access.md)

## Анализ и визуализация данных

 - [Все руководства](datalens/index.md)

### Аналитика

 - [Визуализация логов в Grafana с помощью плагина Cloud Logging](serverless/grafana-logs-plugin.md)

 - [Поиск событий Yandex Cloud в Query](analysis/search-events-query.md)

 - [Поиск событий Yandex Cloud в Object Storage](analysis/search-events-bucket.md)

 - [Поиск событий Yandex Cloud в Cloud Logging](analysis/search-events-logging.md)

### DataLens

#### Знакомство с DataLens

 - [Простой дашборд из CSV-файла](datalens/data-from-csv-visualization.md)

 - [Публичный чарт с картой Москвы из CSV-файла](datalens/data-from-csv-to-public-visualization.md)

 - [Дашборд сети магазинов из БД ClickHouse®](datalens/data-from-ch-visualization.md)

#### Работа с геоданными

 - [Анализ открытых данных ДТП на дорогах России](datalens/data-from-csv-geo-visualization.md)

 - [Анализ продаж и локаций пиццерий на данных из БД ClickHouse® и Marketplace](datalens/data-from-ch-to-geolayers-visualization.md)

 - [Геокодинг с помощью API Яндекс Карт для визуализации в DataLens](datalens/data-from-ch-geocoder.md)

 - [Визуализация данных с использованием инструмента Тепловые карты](datalens/data-on-heat-map-dashboard.md)

#### Аналитика сервисов

 - [Яндекс Метрика: прямое подключение](datalens/data-from-metrica-visualization.md)

 - [Яндекс Метрика: экспорт, постобработка и визуализация данных](datalens/data-from-metrica-yc-visualization.md)

 - [AppMetrica: прямое подключение](datalens/data-from-appmetrica-visualization.md)

 - [AppMetrica: экспорт, постобработка и визуализация данных](datalens/data-from-appmetrica-yc-visualization.md)

 - [Битрикс24: прямое подключение](datalens/data-from-bitrix24-visualization.md)

 - [Трекер: экспорт и визуализация данных](datalens/data-from-tracker.md)

 - [Анализ логов Object Storage при помощи DataLens](datalens/storage-logs-analysis.md)

 - [Подкасты Яндекс Музыки: статистика](datalens/data-from-podcasts.md)

 - [Визуализация данных Query](datalens/data-from-yandex-query-visualization.md)

 - [Визуализация данных Monitoring](datalens/data-from-monitoring-visualization.md)

 - [Визуализация данных из YTsaurus CHYT](datalens/data-from-ch-over-yt.md)

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

 - [Разработка пользовательской интеграции в API Gateway](serverless/api-gw-integration.md)

#### Сокращатель ссылок

 - [Обзор](serverless/serverless-url-shortener/index.md)

 - [Консоль управления](serverless/serverless-url-shortener/console.md)

 - [Terraform](serverless/serverless-url-shortener/terraform.md)

 - [Разработка CRUD API для сервиса фильмов](serverless/movies-database.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](serverless/websocket-app.md)

 - [Работа с API-шлюзом по протоколу WebSocket](serverless/api-gw-websocket.md)

 - [Создание функции Node.js с помощью TypeScript](serverless/nodejs-typescript.md)

 - [Запуск контейнерного приложения в Serverless Containers](serverless/deploy-app-container.md)

 - [Подключение к YDB из функции Cloud Functions на Python](serverless/connect-from-cf.md)

 - [Подключение к базе данных YDB из функции Cloud Functions на Node.js](serverless/connect-from-cf-nodejs.md)

 - [Настройка подключения к Yandex Managed Service for PostgreSQL из контейнера Serverless Containers](serverless/container-pg-connect.md)

 - [Развертывание веб-приложения с JWT-авторизацией в API Gateway и аутентификацией в Firebase](serverless/jwt-authorizer-firebase.md)

 - [Разработка функций в Functions Framework и их развертывание в Yandex Serverless Containers](serverless/functions-framework-to-container.md)

 - [Канареечный релиз функции Cloud Functions](serverless/canary-release.md)

 - [Интерактивная отладка функций Cloud Functions](serverless/serverless-live-debug.md)

 - [Создание адреса Yandex Cloud Postbox и проверка владения доменом с помощью Terraform](serverless/domain-identity-creating.md)

 - [Настройка Postfix для отправки через Yandex Cloud Postbox](serverless/postfix-integration.md)

### Боты на Serverless

 - [Разработка Slack-бота](serverless/slack-bot-serverless.md)

#### Разработка Telegram-бота

 - [Обзор](serverless/telegram-bot-serverless/index.md)

 - [Консоль управления](serverless/telegram-bot-serverless/console.md)

 - [Terraform](serverless/telegram-bot-serverless/terraform.md)

 - [Разработка Telegram-бота для распознавания текста на изображениях, синтеза и распознавания аудио](serverless/recognizer-bot.md)

### ETL на Serverless

 - [Ввод данных в системы хранения](serverless/data-ingestion.md)

 - [Хранение журналов работы приложения](serverless/log-ingestion.md)

 - [Запись данных с устройства в базу данных](serverless/data-recording.md)

 - [Запись логов балансировщика в PostgreSQL](serverless/logging.md)

 - [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](serverless/data-transfer-direct-to-mch.md)

 - [Передача событий Yandex Cloud Postbox в Data Streams и их анализ с помощью DataLens](serverless/events-from-postbox-to-yds.md)

 - [Трекер: экспорт и визуализация данных](serverless/data-from-tracker.md)

#### Поставка данных из Яндекс Формы в Yandex DataLens с использованием Yandex Cloud Functions и Yandex Query

 - [Обзор](serverless/forms-and-datalens-integration/index.md)

 - [Консоль управления](serverless/forms-and-datalens-integration/console.md)

 - [Terraform](serverless/forms-and-datalens-integration/terraform.md)

 - [Интеграция Yandex Cloud Postbox с внешними системами через вебхуки](serverless/postbox-webhook.md)

### Рабочие процессы и автоматизация на Serverless

 - [Построение пайплайна CI/CD в GitLab](serverless/ci-cd-serverless.md)

 - [Запуск GitLab Runner в Serverless Containers](serverless/serverless-gitlab-runner.md)

 - [Создание триггера для бюджетов, который вызывает функцию Cloud Functions для остановки ВМ](serverless/serverless-trigger-budget-vm.md)

 - [Автоматическое копирование объектов из одного бакета Object Storage в другой](serverless/bucket-to-bucket-copying.md)

 - [Запуск вычислений по расписанию в DataSphere](serverless/regular-launch.md)

 - [Регулярное распознавание аудиофайлов из Object Storage](serverless/batch-recognition-stt.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами](serverless/nodejs-cron-restart-vm.md)

 - [Создание триггеров, которые вызывают функции Cloud Functions для остановки ВМ и отправки уведомлений в Telegram](serverless/serverless-trigger-budget-queue-vm-tg.md)

#### Масштабирование группы виртуальных машин по расписанию

 - [Обзор](serverless/vm-scale-scheduled/index.md)

 - [Консоль управления, CLI и API](serverless/vm-scale-scheduled/console.md)

 - [Terraform](serverless/vm-scale-scheduled/terraform.md)

 - [Запуск вычислений в DataSphere с помощью API](serverless/batch-code-execution.md)

 - [Настройка CI/CD между Cloud Functions и SourceCraft](serverless/ci-cd-sourcecraft-functions.md)

 - [Настройка CI/CD между Cloud Functions и GitHub](serverless/ci-cd-github-functions.md)

 - [Настройка CI/CD в SourceCraft для развертывания приложения в Serverless Containers с помощью GitHub Actions](serverless/ci-cd-sourcecraft-github-actions.md)

 - [Автоматическая загрузка данных в Yandex SpeechSense с помощью Yandex Workflows](serverless/auto-upload.md)

 - [Настройка реагирования в Cloud Logging и Yandex Cloud Functions](serverless/logging-functions.md)

 - [Регулярное распознавание изображений и PDF-документов из бакета Object Storage](serverless/vision-ocrrecognizer-storage.md)

 - [Настройка интеграций Workflows с Трекер, YandexGPT и Yandex Cloud Postbox](serverless/tracker-yandexgpt-postbox-integrations.md)

### Интернет вещей (IoT)

 - [Мониторинг состояния географически распределенных устройств](serverless/datalens.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](serverless/monitoring.md)

 - [Эмуляция множества IoT-устройств](serverless/iot-emulation.md)

 - [Работа с Yandex IoT Core с устройства с Android на языке Java](serverless/android-java.md)

 - [Работа с Yandex IoT Core на языке C#](serverless/c-sharp.md)

 - [Работа с Yandex IoT Core на языке Java](serverless/java.md)

 - [Тестирование доставки сообщения](serverless/message-delivery-check.md)

 - [Отправить сообщение с помощью Mosquitto](serverless/mosquitto-publish.md)

 - [Подписать устройство или реестр на получение сообщений с помощью Mosquitto](serverless/mosquitto-subscribe.md)

### Интеграция с сервисами Яндекса и Yandex Cloud

 - [Защита API Gateway при помощи Smart Web Security](serverless/api-gw-sws-integration.md)

#### Создание навыка Алисы

 - [Обзор](serverless/alice-skill/index.md)

 - [Консоль управления, CLI и API](serverless/alice-skill/console.md)

 - [Terraform](serverless/alice-skill/terraform.md)

 - [Разработка навыка Алисы и сайта с авторизацией](serverless/alice-shareable-todolist.md)

 - [Использование API Gateway для настройки синтеза речи в SpeechKit](serverless/speechkit-integrarion-via-agi-gw.md)

### Искусственный интеллект

 - [Разработка Telegram-бота с поддержкой AI-агента](serverless/telegram-ai-bot-workflows.md)

 - [Создание AI-агента с помощью Yandex Cloud Functions](serverless/create-ai-agent-function.md)

 - [ИИ-ревью пул-реквестов на GitHub с помощью Workflows и GitHub Actions](serverless/ai-powered-github-pr-review.md)

 - [Создание AI-агента со стримингом ответа через веб-сокеты](serverless/streaming-openai-agent.md)

### Отправка писем в Yandex Cloud Postbox с помощью AWS SDK

 - [.NET Core](serverless/send-emails-aws-sdk-csharp.md)

 - [Go](serverless/send-emails-aws-sdk-go.md)

 - [JavaScript](serverless/send-emails-aws-sdk-js.md)

 - [Python](serverless/send-emails-aws-sdk-python.md)

## Машинное обучение и искусственный интеллект

 - [Все руководства](ml-ai/index.md)

### Разработка с помощью DataSphere

 - [Интеграция сервиса DataSphere с сервисом Yandex Data Processing](ml-ai/data-processing-integration.md)

 - [Классификация изображений на видеокадрах](ml-ai/video-recognition.md)

 - [Запуск вычислений по расписанию в DataSphere](ml-ai/regular-launch.md)

 - [Запуск вычислений в DataSphere с помощью API](ml-ai/batch-code-execution.md)

 - [Использование данных из Object Storage для обучения модели в DataSphere](ml-ai/s3-to-datasphere.md)

 - [Создание сервера MLFlow для логирования экспериментов и артефактов](ml-ai/mlflow-datasphere.md)

 - [Дообучение моделей в DataSphere](ml-ai/models-fine-tuning.md)

### Эксплуатация DataSphere

 - [Развертывание сервиса в DataSphere из модели ONNX](ml-ai/node-from-model.md)

 - [Развертывание сервиса в DataSphere на основе Docker-образа](ml-ai/node-from-docker.md)

 - [Развертывание сервиса в DataSphere на основе Docker-образа с FastAPI](ml-ai/node-from-docker-fast-api.md)

 - [Развертывание gRPC-сервиса на основе Docker-образа](ml-ai/grpc-node.md)

 - [Генерация изображения с помощью модели Stable Diffusion](ml-ai/stable-diffusion.md)

### Аналитика с помощью DataSphere

 - [Анализ данных с помощью Query](ml-ai/yq.md)

 - [Работа с данными в Object Storage](ml-ai/yq-storage.md)

 - [Работа с данными в Managed Service for ClickHouse®](ml-ai/yq-clickhouse.md)

 - [Работа с данными в Managed Service for PostgreSQL](ml-ai/yq-postgre.md)

 - [Федеративные запросы к данным](ml-ai/yq-federative-queries.md)

 - [Использование сервиса Managed Service for Apache Spark™](dataplatform/spark-and-datasphere.md)

### Разработка с помощью Yandex Managed Service for GitLab

 - [Управление жизненным циклом MLOps с помощью ML Registry](ml-ai/mlops-ml-registry.md)

### Распознавание изображений, текста и речи

 - [Распознавание архива изображений в Vision OCR](ml-ai/archive-from-vision-to-object-storage.md)

 - [Разработка Telegram-бота для распознавания текста и аудио](ml-ai/recognizer-bot.md)

 - [Регулярное асинхронное распознавание аудиофайлов из Object Storage](ml-ai/batch-recognition-stt.md)

 - [Регулярное распознавание изображений и PDF-документов из бакета Object Storage](ml-ai/vision-ocrrecognizer-storage.md)

### Речевая аналитика

 - [Автоматическая загрузка данных в Yandex SpeechSense с помощью Yandex Workflows](ml-ai/speechsense/auto-upload.md)

 - [Интеграция SpeechSense с amoCRM](ml-ai/speechsense/amocrm.md)

 - [Интеграция SpeechSense с Битрикс24](ml-ai/speechsense/bitrix24.md)

 - [Работа с AI-ассистентом в SpeechSense](ml-ai/speechsense/ai-assistant.md)

### Использование генеративных нейросетей Yandex AI Studio

 - [Интеграция генеративных моделей в Visual Studio Code в качестве ассистента для написания кода](ml-ai/ai-model-ide-integration.md)

 - [Интеграция AI-аналитика данных с Data Catalog](ml-ai/data-catalog-integration.md)