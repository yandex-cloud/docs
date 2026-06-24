# Практические руководства по безопасности в Yandex Cloud

* [Получение сведений, необходимых для включения ресурса в белый список Минцифры](info-for-federal-ip-whitelist.md)

## Аутентификация и управление доступом {#authentication}

* [Разграничение прав доступа для групп пользователей с различными ролями в Yandex Identity Hub](authentication/user-group-access-control.md)
* [Использование сервисного аккаунта с профилем OS Login для управления ВМ с помощью Ansible](authentication/sa-oslogin-ansible.md)
* Управление федерациями удостоверений
    * [Аутентификация с помощью Active Directory](authentication/integration-adfs.md)
    * [Аутентификация с помощью Google Workspace](authentication/integration-gworkspace.md)
    * [Аутентификация с помощью Microsoft Entra ID](authentication/integration-azure.md)
    * [Аутентификация с помощью Keycloak](authentication/integration-keycloak.md)
    * Сопоставление групп пользователей
        * [Сопоставление групп пользователей в Microsoft Active Directory Federation Services](authentication/adfs.md)
        * [Сопоставление групп пользователей в Microsoft Entra ID](authentication/entra-id.md)
        * [Сопоставление групп пользователей в Keycloak](authentication/keycloak.md)

## Настройка SSO {#single-sign-on}

* [Создать OIDC-приложение в Yandex Identity Hub для интеграции с 1С:Предприятие](single-sign-on/oidc-1c-enterprise.md)
* Cloud.ru
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с Cloud.ru](single-sign-on/saml-cloud-ru.md)
    * [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Cloud.ru](single-sign-on/oidc-cloud-ru.md)
* Grafana
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с Grafana Cloud](single-sign-on/saml-grafana.md)
    * [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Grafana Cloud](single-sign-on/oidc-grafana.md)
    * [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Grafana OSS](single-sign-on/oidc-grafana-oss.md)
* [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Harbor](single-sign-on/oidc-harbor.md)
* Jenkins
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с Jenkins](single-sign-on/saml-jenkins.md)
    * [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Jenkins](single-sign-on/oidc-jenkins.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с Managed Service for GitLab](single-sign-on/saml-managed-gitlab.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с Managed Service for OpenSearch](single-sign-on/saml-opensearch.md)
* [Создать OIDC-приложение в Yandex Identity Hub для интеграции с MWS](single-sign-on/oidc-mws.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с OpenSearch](single-sign-on/saml-opensearch-self-managed.md)
* OpenVPN
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с OpenVPN Access Server](single-sign-on/saml-ovpn.md)
    * [Настроить аутентификацию в OpenVPN Community Edition через Yandex Identity Hub по протоколу OIDC](single-sign-on/oidc-ovpn.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с Selectel](single-sign-on/saml-selectel.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с Sentry](single-sign-on/saml-sentry.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с SonarQube](single-sign-on/saml-sonarqube.md)
* VK Cloud
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с VK Cloud](single-sign-on/saml-vk-cloud.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с Zabbix](single-sign-on/saml-zabbix.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с Пассворк](single-sign-on/saml-passwork.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с Яндекс 360](single-sign-on/saml-yandex-360.md)
* [Создать SAML-приложение в Yandex Identity Hub для интеграции с консолью управления Яндекс Браузера для организаций](single-sign-on/saml-ya-browser-corporate.md)
* [Использовать OIDC-приложение и OAuth2 Proxy для настройки единого входа в приложения, не поддерживающие SSO](single-sign-on/oidc-nginx-oauth2-proxy.md)


## Сетевая безопасность {#network-security}

* [Организация виртуального хостинга](network-security/virtual-hosting.md)
* [Автоматическое копирование объектов из одного бакета Yandex Object Storage в другой](network-security/bucket-to-bucket-copying.md)
* [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](network-security/data-transfer-direct-to-mch.md)
* [Создание балансировщика с защитой от DDoS](network-security/alb-with-ddos-protection/index.md)
* [Защищенный доступ пользователей к облачным ресурсам на основе WireGuard VPN](network-security/remote-wireguard-vpn.md)
* [Организация защищенного доступа к контенту в Yandex Cloud CDN](network-security/protected-access-to-content/index.md)


## Безопасная конфигурация виртуальной среды {#virtualenv-safe-config}

* [Хостинг статического сайта на фреймворке Gatsby в Yandex Object Storage](virtualenv-safe-config/gatsby-static-website.md)
* [Хранение подключений и переменных Apache Airflow™ в Yandex Lockbox](virtualenv-safe-config/lockbox-and-airflow.md)
* [Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами](virtualenv-safe-config/nodejs-cron-restart-vm.md)
* Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для защиты от DDoS-атак с помощью Yandex Smart Web Security
    * [Миграция сервисов с балансировщика NLB с целевыми ресурсами из виртуальных машин на L7-балансировщик ALB](virtualenv-safe-config/nlb-with-target-resource-vm.md)
    * [Миграция сервисов с балансировщика NLB с целевыми ресурсами из группы виртуальных машин (Instance Groups) на L7-балансировщик ALB](virtualenv-safe-config/nlb-with-target-resource-group-vm.md)
    * [Миграция сервисов с внешнего балансировщика NLB на L7-балансировщик ALB с целевым ресурсом — внутренним сетевым балансировщиком NLB](virtualenv-safe-config/nlb-as-target-resource-alb.md)


## Шифрование данных и управление ключами {#data-encryption-and-key-management}

* Шифрование данных
    * [Какой способ шифрования выбрать?](data-encryption-and-key-management/choose-encryption-method.md)
    * [Шифрование данных с помощью CLI и API Yandex Cloud](data-encryption-and-key-management/cli-api.md)
    * [Шифрование данных с помощью SDK Yandex Cloud](data-encryption-and-key-management/sdk.md)
    * [Шифрование данных с помощью AWS Encryption SDK](data-encryption-and-key-management/aws-encryption-sdk.md)
    * [Шифрование данных с помощью Google Tink](data-encryption-and-key-management/google-tink.md)
* [Управление ключами Yandex Key Management Service с HashiCorp Terraform](data-encryption-and-key-management/terraform-key.md)
* [Шифрование секретов в HashiCorp Terraform](data-encryption-and-key-management/terraform-secret.md)
* [Auto Unseal в HashiCorp Vault](data-encryption-and-key-management/vault-secret.md)
* [Безопасная передача пароля в скрипт инициализации](data-encryption-and-key-management/secure-password-script/index.md)
* [Терминирование TLS-соединений](data-encryption-and-key-management/tls-termination/index.md)
* [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](data-encryption-and-key-management/gitlab-lockbox-integration.md)
* [Использование секрета Yandex Lockbox для хранения статического ключа доступа](data-encryption-and-key-management/static-key-in-lockbox/index.md)
* [Получение значения секрета Yandex Lockbox на стороне GitHub](data-encryption-and-key-management/wlif-github-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне GitLab](data-encryption-and-key-management/wlif-gitlab-integration.md)
* [Загрузка объектов в бакет Yandex Object Storage с помощью эфемерного ключа доступа](data-encryption-and-key-management/ephemeral-key-storage.md)


## Сбор, мониторинг и анализ аудитных логов {#audit-logs}

* [Поиск событий Yandex Cloud в Yandex Query](audit-logs/query.md)
* [Поиск событий Yandex Cloud в Yandex Object Storage](audit-logs/search-bucket.md)
* [Поиск событий Yandex Cloud в Yandex Cloud Logging](audit-logs/search-cloud-logging.md)
* [Настройка дашбордов и алертов в Yandex Monitoring](audit-logs/alerts-monitoring.md)
* [Настройка реагирования в Yandex Cloud Logging и Yandex Cloud Functions](audit-logs/logging-functions.md)
* [Обработка аудитных логов Yandex Audit Trails](audit-logs/audit-trails.md)
* Экспорт аудитных логов в SIEM
    * [Загрузка аудитных логов в MaxPatrol SIEM](audit-logs/maxpatrol/index.md)
    * [Загрузка аудитных логов в SIEM Splunk](audit-logs/export-logs-to-splunk.md)
    * [Загрузка аудитных логов в SIEM ArcSight](audit-logs/export-logs-to-arcsight.md)
    * [Загрузка аудитных логов Yandex Audit Trails в SIEM KUMA](audit-logs/audit-trails-events-to-kuma/index.md)
* [Передача логов с ВМ в Yandex Cloud Logging](audit-logs/vm-fluent-bit-logging.md)
* [Запись логов балансировщика в PostgreSQL](audit-logs/logging.md)
* [Передача логов с Container Optimized Image в Yandex Cloud Logging](audit-logs/coi-fluent-bit-logging.md)


## Защита приложений {#app-security}

* [Построение пайплайна CI/CD в GitLab с использованием serverless-продуктов](app-security/ci-cd-serverless.md)
* [Создание интерактивного serverless-приложения с использованием WebSocket](app-security/websocket-app.md)
* [Создание L7-балансировщика Yandex Application Load Balancer с профилем безопасности Yandex Smart Web Security](app-security/balancer-with-sws-profile/index.md)
* [Защита Yandex API Gateway при помощи Yandex Smart Web Security](app-security/api-gw-sws-integration.md)
* [Управление источниками трафика](app-security/traffic-sources-management.md)
* [Добавление HTML-страницы для работы Yandex SmartCaptcha](app-security/website.md)
* [Yandex SmartCaptcha в приложении на Android](app-security/quickstart-android.md)
* [Невидимая Yandex SmartCaptcha в приложении на Android](app-security/invisible-captcha-android.md)
* [Yandex SmartCaptcha в приложении Android на Flutter](app-security/quickstart-android-flutter.md)
* [Yandex SmartCaptcha в приложении на iOS](app-security/quickstart-ios.md)


## Безопасность Kubernetes {#kubernetes-security}

* [Шифрование секретов в Yandex Managed Service for Kubernetes](kubernetes-security/kms-k8s.md)
* [Подпись и проверка Docker-образов Yandex Container Registry в Yandex Managed Service for Kubernetes](kubernetes-security/sign-cr-with-cosign.md)
* [Синхронизация с секретами Yandex Managed Service for Kubernetes](kubernetes-security/kubernetes-lockbox-secrets.md)
* [Получение значения секрета Yandex Lockbox на стороне пользовательской инсталляции Kubernetes](kubernetes-security/wlif-k8s-integration.md)
* [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](kubernetes-security/wlif-managed-k8s-integration.md)
* [Создание L7-балансировщика с профилем безопасности Yandex Smart Web Security через Ingress-контроллер Yandex Application Load Balancer](kubernetes-security/alb-ingress-with-sws-profile.md)
* [Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера Yandex Managed Service for Kubernetes на L7-балансировщик ALB](kubernetes-security/nlb-with-target-resource-k8s/index.md)
* [Передача логов кластера Yandex Managed Service for Kubernetes в Yandex Cloud Logging](kubernetes-security/k8s-fluent-bit-logging.md)