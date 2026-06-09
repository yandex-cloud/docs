# Безопасность в Yandex Cloud

В разделе содержатся рекомендации по построению безопасной инфраструктуры в Yandex Cloud, практические инструкции, бюллетени безопасности.

# Безопасность в Yandex Cloud

 - [Ключевые принципы безопасности](principles.md)

 - [Разделение ответственности за обеспечение безопасности](respons.md)

 - [Соответствие требованиям](conform.md)

 - [Меры безопасности на стороне {{ yandex-cloud }}](standarts.md)

 - [Средства защиты, доступные пользователям облачных сервисов](user-side.md)

## Рекомендации по защите облачной инфраструктуры

 - [Все рекомендации](domains/index.md)

 - [Чеклист безопасности IaaS](domains/iaas-checklist.md)

 - [Чеклист безопасности аутентификации и авторизации](domains/iam-checklist.md)

 - [Безопасность Kubernetes](domains/kubernetes.md)

 - [Референсная архитектура для облачной инфраструктуры в изолированном режиме без доступа в интернет](domains/architecture-isolated.md)

## Стандарт по защите облачной инфраструктуры, версия {{ security-standard-current-version }}

 - [Все разделы на одной странице](standard/all.md)

 - [Введение](standard/index.md)

 - [Аутентификация и управление доступом](standard/authentication.md)

 - [Сетевая безопасность](standard/network-security.md)

 - [Безопасная конфигурация виртуальной среды](standard/virtualenv-safe-config.md)

 - [Шифрование данных и управление ключами](standard/encryption.md)

 - [Сбор, мониторинг и анализ аудитных логов](standard/audit-logs.md)

 - [Защита приложений](standard/app-security.md)

 - [Безопасность {{ k8s }}](standard/kubernetes-security.md)

 - [Версии](standard/versions.md)

## Стандарт по защите и безопасному использованию {{ yandex-360 }}, версия {{ 360-standard-current-version }}

 - [Все разделы на одной странице](standard-360/all.md)

 - [Введение](standard-360/index.md)

 - [Аутентификация и управление доступом](standard-360/authentication.md)

 - [Безопасность сессий и cookies](standard-360/session-security.md)

 - [Мониторинг и аудит](standard-360/monitoring.md)

 - [Шифрование и защита данных](standard-360/encryption-data-protection.md)

 - [Интеграции и сторонние сервисы](standard-360/integrations.md)

 - [Фреймворк безопасной работы с агентами AI-SAFE](ai-safe.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Аутентификация и управление доступом

 - [Разграничение прав доступа для групп пользователей с различными ролями в {{ org-full-name }}](tutorials/authentication/user-group-access-control.md)

 - [Использование сервисного аккаунта с профилем {{ oslogin }} для управления ВМ с помощью Ansible](tutorials/authentication/sa-oslogin-ansible.md)

 - [Аутентификация с помощью {{ microsoft-idp.ad-short }}](tutorials/authentication/integration-adfs.md)

 - [Аутентификация с помощью Google Workspace](tutorials/authentication/integration-gworkspace.md)

 - [Аутентификация с помощью {{ microsoft-idp.entra-id-full }}](tutorials/authentication/integration-azure.md)

 - [Аутентификация с помощью Keycloak](tutorials/authentication/integration-keycloak.md)

 - [Сопоставление групп пользователей в {{ microsoft-idp.adfs-short }}](tutorials/authentication/adfs.md)

 - [Сопоставление групп пользователей в {{ microsoft-idp.entra-id-full }}](tutorials/authentication/entra-id.md)

 - [Сопоставление групп пользователей в {{ keycloak }}](tutorials/authentication/keycloak.md)

### Настройка SSO

 - [Настройка единого входа в 1С:Предприятие по стандарту OIDC](tutorials/single-sign-on/oidc-1c-enterprise.md)

#### Cloud.ru

 - [Настройка единого входа в Cloud.ru по стандарту SAML](tutorials/single-sign-on/saml-cloud-ru.md)

 - [Настройка единого входа в Cloud.ru по стандарту OIDC](tutorials/single-sign-on/oidc-cloud-ru.md)

#### Grafana

 - [Настройка единого входа в Grafana Cloud по стандарту SAML](tutorials/single-sign-on/saml-grafana.md)

 - [Настройка единого входа в Grafana Cloud по стандарту OIDC](tutorials/single-sign-on/oidc-grafana.md)

 - [Настройка единого входа в Grafana OSS по стандарту OIDC](tutorials/single-sign-on/oidc-grafana-oss.md)

 - [Настройка единого входа в Harbor по стандарту OIDC](tutorials/single-sign-on/oidc-harbor.md)

#### Jenkins

 - [Настройка единого входа в Jenkins по стандарту SAML](tutorials/single-sign-on/saml-jenkins.md)

 - [Настройка единого входа в Jenkins по стандарту OIDC](tutorials/single-sign-on/oidc-jenkins.md)

 - [Настройка единого входа в {{ mgl-name }} по стандарту SAML](tutorials/single-sign-on/saml-managed-gitlab.md)

 - [Настройка единого входа в {{ mos-name }} по стандарту SAML](tutorials/single-sign-on/saml-opensearch.md)

 - [Настройка единого входа в MWS по стандарту OIDC](tutorials/single-sign-on/oidc-mws.md)

 - [Настройка единого входа в {{ OS }} по стандарту SAML](tutorials/single-sign-on/saml-opensearch-self-managed.md)

#### OpenVPN

 - [Настройка единого входа в OpenVPN Access Server по стандарту SAML](tutorials/single-sign-on/saml-ovpn.md)

 - [Настройка единого входа в OpenVPN Community Edition по стандарту OIDC](tutorials/single-sign-on/oidc-ovpn.md)

 - [Настройка единого входа в Selectel по стандарту SAML](tutorials/single-sign-on/saml-selectel.md)

 - [Настройка единого входа в Sentry по стандарту SAML](tutorials/single-sign-on/saml-sentry.md)

 - [Настройка единого входа в SonarQube по стандарту SAML](tutorials/single-sign-on/saml-sonarqube.md)

#### VK Cloud

 - [Настройка единого входа в VK Cloud по стандарту SAML](tutorials/single-sign-on/saml-vk-cloud.md)

 - [Настройка единого входа в Zabbix по стандарту SAML](tutorials/single-sign-on/saml-zabbix.md)

 - [Настройка единого входа в Пассворк по стандарту SAML](tutorials/single-sign-on/saml-passwork.md)

 - [Настройка единого входа в {{ yandex-360 }} по стандарту SAML](tutorials/single-sign-on/saml-yandex-360.md)

 - [Яндекс Браузер для организаций](tutorials/single-sign-on/saml-ya-browser-corporate.md)

 - [Использование OAuth2 Proxy для приложений, не поддерживающих SSO](tutorials/single-sign-on/oidc-nginx-oauth2-proxy.md)

### Сетевая безопасность

 - [Организация виртуального хостинга](tutorials/network-security/virtual-hosting.md)

 - [Автоматическое копирование объектов из одного бакета {{ objstorage-name }} в другой](tutorials/network-security/bucket-to-bucket-copying.md)

 - [Загрузка данных из {{ yandex-direct }} в витрину {{ mch-name }} с использованием {{ sf-name }}, {{ objstorage-name }} и {{ data-transfer-name }}](tutorials/network-security/data-transfer-direct-to-mch.md)

#### Создание балансировщика с защитой от DDoS

 - [Обзор](tutorials/network-security/alb-with-ddos-protection/index.md)

 - [Создание L7-балансировщика с защитой от DDoS с помощью консоли управления или CLI](tutorials/network-security/alb-with-ddos-protection/console.md)

 - [Создание L7-балансировщика с защитой от DDoS с помощью {{ TF }}](tutorials/network-security/alb-with-ddos-protection/terraform.md)

 - [Защищенный доступ пользователей к облачным ресурсам на основе WireGuard VPN](tutorials/network-security/remote-wireguard-vpn.md)

 - [ViPNet Coordinator VA в {{ yandex-cloud }}](tutorials/network-security/vipnet-to-yc.md)

#### Организация защищенного доступа к контенту в {{ cdn-name }}

 - [Обзор](tutorials/network-security/protected-access-to-content/index.md)

 - [Организация защищенного доступа к контенту в {{ cdn-name }} с помощью консоли управления, CLI или API](tutorials/network-security/protected-access-to-content/console.md)

 - [Организация защищенного доступа к контенту в {{ cdn-name }} с помощью {{ TF }}](tutorials/network-security/protected-access-to-content/terraform.md)

### Безопасная конфигурация виртуальной среды

 - [Хостинг статического сайта на фреймворке Gatsby в {{ objstorage-name }}](tutorials/virtualenv-safe-config/gatsby-static-website.md)

 - [Хранение подключений и переменных {{ AF }} в {{ lockbox-name }}](tutorials/virtualenv-safe-config/lockbox-and-airflow.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами](tutorials/virtualenv-safe-config/nodejs-cron-restart-vm.md)

 - [Миграция сервисов с балансировщика NLB с целевыми ресурсами из виртуальных машин на L7-балансировщик ALB](tutorials/virtualenv-safe-config/nlb-with-target-resource-vm.md)

 - [Миграция сервисов с балансировщика NLB с целевыми ресурсами из группы виртуальных машин (Instance Groups) на L7-балансировщик ALB](tutorials/virtualenv-safe-config/nlb-with-target-resource-group-vm.md)

 - [Миграция сервисов с внешнего балансировщика NLB на L7-балансировщик ALB с целевым ресурсом — внутренним сетевым балансировщиком NLB](tutorials/virtualenv-safe-config/nlb-as-target-resource-alb.md)

### Шифрование данных и управление ключами

 - [Какой способ шифрования выбрать?](tutorials/data-encryption-and-key-management/choose-encryption-method.md)

 - [Шифрование данных с помощью CLI и API {{ yandex-cloud }}](tutorials/data-encryption-and-key-management/cli-api.md)

 - [Шифрование данных с помощью SDK {{ yandex-cloud }}](tutorials/data-encryption-and-key-management/sdk.md)

 - [Шифрование данных с помощью AWS Encryption SDK](tutorials/data-encryption-and-key-management/aws-encryption-sdk.md)

 - [Шифрование данных с помощью Google Tink](tutorials/data-encryption-and-key-management/google-tink.md)

 - [Управление ключами {{ kms-name }} с {{ TF }}](tutorials/data-encryption-and-key-management/terraform-key.md)

 - [Шифрование секретов в {{ TF }}](tutorials/data-encryption-and-key-management/terraform-secret.md)

 - [Auto Unseal в HashiCorp Vault](tutorials/data-encryption-and-key-management/vault-secret.md)

#### Безопасная передача пароля в скрипт инициализации

 - [Обзор](tutorials/data-encryption-and-key-management/secure-password-script/index.md)

 - [Консоль управления, CLI, API](tutorials/data-encryption-and-key-management/secure-password-script/console.md)

 - [{{ TF }}](tutorials/data-encryption-and-key-management/secure-password-script/terraform.md)

#### Терминирование TLS-соединений

 - [Обзор](tutorials/data-encryption-and-key-management/tls-termination/index.md)

 - [Терминирование TLS-соединений с помощью консоли управления](tutorials/data-encryption-and-key-management/tls-termination/console.md)

 - [Терминирование TLS-соединений с помощью {{ TF }}](tutorials/data-encryption-and-key-management/tls-termination/terraform.md)

 - [Безопасное хранение паролей для {{ GL }} CI в виде секретов {{ lockbox-name }}](tutorials/data-encryption-and-key-management/gitlab-lockbox-integration.md)

#### Использование секрета {{ lockbox-name }} для хранения статического ключа доступа

 - [Обзор](tutorials/data-encryption-and-key-management/static-key-in-lockbox/index.md)

 - [Использование секрета {{ lockbox-name }} для хранения статического ключа доступа с помощью CLI](tutorials/data-encryption-and-key-management/static-key-in-lockbox/console.md)

 - [Использование секрета {{ lockbox-name }} для хранения статического ключа доступа с помощью {{ TF }}](tutorials/data-encryption-and-key-management/static-key-in-lockbox/terraform.md)

 - [Получение значения секрета {{ lockbox-name }} на стороне GitHub](tutorials/data-encryption-and-key-management/wlif-github-integration.md)

 - [Получение значения секрета {{ lockbox-name }} на стороне {{ GL }}](tutorials/data-encryption-and-key-management/wlif-gitlab-integration.md)

 - [Загрузка объектов в бакет {{ objstorage-name }} с помощью эфемерного ключа доступа](tutorials/data-encryption-and-key-management/ephemeral-key-storage.md)

### Сбор, мониторинг и анализ аудитных логов

 - [Поиск событий {{ yandex-cloud }} в {{ yq-name }}](tutorials/audit-logs/query.md)

 - [Поиск событий {{ yandex-cloud }} в {{ objstorage-name }}](tutorials/audit-logs/search-bucket.md)

 - [Поиск событий {{ yandex-cloud }} в {{ cloud-logging-name }}](tutorials/audit-logs/search-cloud-logging.md)

 - [Настройка алертов и дашбордов в {{ monitoring-name }}](tutorials/audit-logs/alerts-monitoring.md)

 - [Настройка реагирования в {{ cloud-logging-name }} и {{ sf-name }}](tutorials/audit-logs/logging-functions.md)

 - [Обработка аудитных логов {{ at-name }}](tutorials/audit-logs/audit-trails.md)

 - [Загрузка аудитных логов в {{ mes-name }}](tutorials/audit-logs/trails-logs-opensearch.md)

#### Загрузка аудитных логов в MaxPatrol SIEM

 - [Обзор](tutorials/audit-logs/maxpatrol/index.md)

 - [Консоль управления](tutorials/audit-logs/maxpatrol/console.md)

 - [{{ TF }}](tutorials/audit-logs/maxpatrol/terraform.md)

 - [Загрузка аудитных логов в SIEM Splunk](tutorials/audit-logs/export-logs-to-splunk.md)

 - [Загрузка аудитных логов в SIEM ArcSight](tutorials/audit-logs/export-logs-to-arcsight.md)

#### Загрузка аудитных логов {{ at-name }} в SIEM KUMA

 - [Обзор](tutorials/audit-logs/audit-trails-events-to-kuma/index.md)

 - [Загрузка аудитных логов в SIEM KUMA с помощью консоли управления, CLI или API](tutorials/audit-logs/audit-trails-events-to-kuma/console.md)

 - [Загрузка аудитных логов в SIEM KUMA с помощью {{ TF }}](tutorials/audit-logs/audit-trails-events-to-kuma/terraform.md)

 - [Передача логов с ВМ в {{ cloud-logging-name }}](tutorials/audit-logs/vm-fluent-bit-logging.md)

 - [Запись логов балансировщика в {{ PG }}](tutorials/audit-logs/logging.md)

 - [Передача логов с {{ coi }} в {{ cloud-logging-name }}](tutorials/audit-logs/coi-fluent-bit-logging.md)

### Защита приложений

 - [Установка Ingress-контроллера NGINX с сертификатом из {{ certificate-manager-name }}](tutorials/app-security/nginx-ingress-certificate-manager.md)

 - [Построение пайплайна CI/CD в {{ GL }} с использованием serverless-продуктов](tutorials/app-security/ci-cd-serverless.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/app-security/websocket-app.md)

#### Создание L7-балансировщика {{ alb-name }} с профилем безопасности {{ sws-name }}

 - [Обзор](tutorials/app-security/balancer-with-sws-profile/index.md)

 - [Консоль управления](tutorials/app-security/balancer-with-sws-profile/console.md)

 - [{{ TF }}](tutorials/app-security/balancer-with-sws-profile/terraform.md)

 - [Защита {{ api-gw-name }} при помощи {{ sws-name }}](tutorials/app-security/api-gw-sws-integration.md)

 - [Управление источниками трафика](tutorials/app-security/traffic-sources-management.md)

 - [Добавление HTML-страницы для работы {{ captcha-name }}](tutorials/app-security/website.md)

 - [{{ captcha-name }} в приложении на Android](tutorials/app-security/quickstart-android.md)

 - [Невидимая {{ captcha-name }} в приложении на Android](tutorials/app-security/invisible-captcha-android.md)

 - [{{ captcha-name }} в приложении Android на Flutter](tutorials/app-security/quickstart-android-flutter.md)

 - [{{ captcha-name }} в приложении на iOS](tutorials/app-security/quickstart-ios.md)

### Безопасность {{ k8s }}

 - [Шифрование секретов в {{ managed-k8s-name }}](tutorials/kubernetes-security/kms-k8s.md)

 - [Подпись и проверка Docker-образов {{ container-registry-name }} в {{ managed-k8s-name }}](tutorials/kubernetes-security/sign-cr-with-cosign.md)

 - [Синхронизация с секретами {{ managed-k8s-name }}](tutorials/kubernetes-security/kubernetes-lockbox-secrets.md)

 - [Получение значения секрета {{ lockbox-name }} на стороне пользовательской инсталляции {{ k8s }}](tutorials/kubernetes-security/wlif-k8s-integration.md)

 - [Доступ к API {{ yandex-cloud }} из кластера {{ managed-k8s-name }} с помощью федерации сервисных аккаунтов](tutorials/kubernetes-security/wlif-managed-k8s-integration.md)

 - [Создание L7-балансировщика с профилем безопасности {{ sws-name }} через Ingress-контроллер {{ alb-name }}](tutorials/kubernetes-security/alb-ingress-with-sws-profile.md)

#### Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера {{ managed-k8s-name }} на L7-балансировщик ALB

 - [Обзор](tutorials/kubernetes-security/nlb-with-target-resource-k8s/index.md)

 - [Консоль управления](tutorials/kubernetes-security/nlb-with-target-resource-k8s/console.md)

 - [{{ TF }}](tutorials/kubernetes-security/nlb-with-target-resource-k8s/terraform.md)

 - [Передача логов кластера {{ managed-k8s-name }} в {{ cloud-logging-name }}](tutorials/kubernetes-security/k8s-fluent-bit-logging.md)

 - [Получение сведений для запроса на включение ресурса в белый список Минцифры](tutorials/info-for-federal-ip-whitelist.md)

## Инструкции

 - [Удаление аккаунта на Яндексе из {{ org-full-name }}](operations/account-deletion.md)

 - [Если вас атакуют с адресов {{ yandex-cloud }}](operations/outgoing-ddos.md)

 - [Поиск секретов {{ yandex-cloud }} в открытых источниках](operations/search-secrets.md)

 - [Политика поддержки пользователей при проведении проверки уязвимостей](compliance/pentest.md)

 - [Бюллетени безопасности](security-bulletins/index.md)

 - [Диапазоны публичных IP-адресов](ip-list.md)