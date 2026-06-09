# Руководства по безопасности

* [Разграничение прав доступа для групп пользователей с различными ролями в Yandex Identity Hub](user-group-access-control.md)
* [Создание L7-балансировщика с защитой от DDoS](alb-with-ddos-protection/index.md)
* [Базовая настройка защиты в Smart Web Security](sws-basic-protection.md)
* [Создание L7-балансировщика с профилем безопасности Smart Web Security через Ingress-контроллер Application Load Balancer](alb-ingress-with-sws-profile.md)
* [Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Yandex Smart Web Security](migration-from-nlb-to-alb/index.md)
* [Терминирование TLS-соединений](tls-termination/index.md)
* [Передача логов с виртуальной машины в Yandex Cloud Logging](vm-fluent-bit-logging.md)
* [Запись логов балансировщика в PostgreSQL](logging.md)
* [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](gitlab-lockbox-integration.md)
* [Использование секрета Yandex Lockbox для хранения статического ключа доступа](static-key-in-lockbox/index.md)
* [Использование сервисного аккаунта с профилем OS Login для управления ВМ с помощью Ansible](sa-oslogin-ansible.md)
* [Организация защищенного доступа к контенту в Cloud CDN](protected-access-to-content/index.md)
* [Загрузка аудитных логов Yandex Audit Trails в SIEM KUMA](audit-trails-events-to-kuma/index.md)
* [Поиск событий в аудитных логах](search-events-audit-logs/index.md)
* [Получение значения секрета Yandex Lockbox на стороне GitHub](wlif-github-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне GitLab](wlif-gitlab-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне пользовательской инсталляции Kubernetes](wlif-k8s-integration.md)
* [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](wlif-managed-k8s-integration.md)
* [Передача логов с Container Optimized Image в Yandex Cloud Logging](coi-fluent-bit-logging.md)
* [Передача логов кластера Yandex Managed Service for Kubernetes в Yandex Cloud Logging](../container-infrastructure/k8s-fluent-bit-logging.md)
* [Создание L7-балансировщика Yandex Application Load Balancer с профилем безопасности Yandex Smart Web Security](balancer-with-sws-profile/index.md)
* [Создание распределенной инфраструктуры с защищенным доступом](distributed-secured-infrastructure.md)
* [Централизованная публикация в интернете и защита от DDoS-атак приложений, размещенных в разных каталогах Yandex Cloud](different-folders-services.md)
* [Настройка дашбордов и алертов в Yandex Monitoring](alerts-monitoring.md)
* [Загрузка аудитных логов в MaxPatrol SIEM](maxpatrol/index.md)
* [Загрузка аудитных логов в SIEM Splunk](export-logs-to-splunk.md)
* [Загрузка аудитных логов в SIEM ArcSight](export-logs-to-arcsight.md)
* [Передача логов кластера Yandex MPP Analytics for PostgreSQL в Yandex Cloud Logging](mgp-to-cloud-logging.md)
* [Получение сведений, необходимых для включения ресурса в белый список Минцифры](info-for-federal-ip-whitelist.md)
* [Загрузка объектов в бакет Yandex Object Storage с помощью эфемерного ключа доступа](ephemeral-key-storage.md)

## Управление федерациями удостоверений {#federations}

* [Аутентификация с помощью Active Directory](integration-adfs.md)
* [Аутентификация с помощью Google Workspace](integration-gworkspace.md)
* [Аутентификация с помощью Microsoft Entra ID](integration-azure.md)
* [Аутентификация с помощью Keycloak](integration-keycloak.md)

### Сопоставление групп пользователей {#matching-user-groups}

* [Сопоставление групп пользователей в Microsoft Active Directory Federation Services](adfs.md)
* [Сопоставление групп пользователей в Microsoft Entra ID](entra-id.md)
* [Сопоставление групп пользователей в Keycloak](keycloak.md)

## Сценарии использования Yandex SmartCaptcha {#smartcaptcha}

* [Добавление HTML-страницы для работы Yandex SmartCaptcha](mobile-app/website.md)
* [Yandex SmartCaptcha в приложении на Android](mobile-app/android/quickstart-android.md)
* [Невидимая Yandex SmartCaptcha в приложении на Android](mobile-app/android/invisible-captcha-android.md)
* [Yandex SmartCaptcha в приложении Android на Flutter](mobile-app/android/quickstart-android-flutter.md)
* [Yandex SmartCaptcha в приложении на iOS](mobile-app/ios/quickstart-ios.md)
* [Синхронизация секретов Yandex Lockbox и Yandex Managed Service for Kubernetes](../container-infrastructure/kubernetes-lockbox-secrets.md)
* [Шифрование секретов в Yandex Managed Service for Kubernetes](../container-infrastructure/kms-k8s.md)
* [Подпись и проверка Docker-образов Yandex Container Registry в Yandex Managed Service for Kubernetes](../container-infrastructure/sign-cr-with-cosign.md)
* [Управление ключами Yandex Key Management Service с HashiCorp Terraform](terraform-key.md)
* [Шифрование секретов в HashiCorp Terraform](terraform-secret.md)
* [Auto Unseal в HashiCorp Vault](vault-secret.md)

## Шифрование данных {#encrypt}

* [Какой способ шифрования выбрать?](encrypt/index.md)
* [Шифрование данных с помощью CLI и API Yandex Cloud](encrypt/cli-api.md)
* [Шифрование данных с помощью SDK Yandex Cloud](encrypt/sdk.md)
* [Шифрование данных с помощью AWS Encryption SDK](encrypt/aws-encryption-sdk.md)
* [Шифрование данных с помощью Google Tink](encrypt/google-tink.md)
* [Получение значения секрета Yandex Lockbox на стороне GitHub](wlif-github-integration.md)
* [Шифрование для бакета Object Storage на стороне сервера](server-side-encryption.md)

## Интеграции федераций удостоверений сервисных аккаунтов {#wlif-integration}

* [Получение значения секрета Yandex Lockbox на стороне GitHub](wlif-github-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне GitLab](wlif-gitlab-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне пользовательской инсталляции Kubernetes](wlif-k8s-integration.md)
* [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](wlif-managed-k8s-integration.md)

## Настройка единого входа в приложения (SSO) {#sso}

* [1С:Предприятие](single-sign-on/oidc-1c-enterprise.md)
* Cloud.ru
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с Cloud.ru](single-sign-on/cloud-ru/saml-cloud-ru.md)
    * [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Cloud.ru](single-sign-on/cloud-ru/oidc-cloud-ru.md)
* Grafana Cloud
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с Grafana Cloud](single-sign-on/grafana/saml-grafana.md)
    * [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Grafana Cloud](single-sign-on/grafana/oidc-grafana.md)
* [Grafana OSS](single-sign-on/oidc-grafana-oss.md)
* [Harbor](single-sign-on/oidc-harbor.md)
* Jenkins
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с Jenkins](single-sign-on/jenkins/saml-jenkins.md)
    * [Создать OIDC-приложение в Yandex Identity Hub для интеграции с Jenkins](single-sign-on/jenkins/oidc-jenkins.md)
* [Managed Service for GitLab](single-sign-on/saml-managed-gitlab.md)
* [Managed Service for OpenSearch](single-sign-on/saml-opensearch.md)
* [MWS](single-sign-on/oidc-mws.md)
* [OpenSearch](single-sign-on/saml-opensearch-self-managed.md)
* OpenVPN
    * [OpenVPN Access Server](single-sign-on/saml-ovpn.md)
    * [OpenVPN Community Edition](single-sign-on/oidc-ovpn.md)
* [Selectel](single-sign-on/saml-selectel.md)
* [Sentry](single-sign-on/saml-sentry.md)
* [SonarQube](single-sign-on/saml-sonarqube.md)
* VK Cloud
    * [Создать SAML-приложение в Yandex Identity Hub для интеграции с VK Cloud](single-sign-on/vk-cloud/saml-vk-cloud.md)
* [Zabbix](single-sign-on/saml-zabbix.md)
* [Пассворк](single-sign-on/saml-passwork.md)
* [Яндекс 360](single-sign-on/saml-yandex-360.md)
* [Яндекс Браузер для организаций](single-sign-on/saml-ya-browser-corporate.md)
* [Настройка единого входа в приложения, не поддерживающие SSO](single-sign-on/oidc-nginx-oauth2-proxy.md)