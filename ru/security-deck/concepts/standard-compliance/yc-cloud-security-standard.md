---
title: Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}
description: В этом разделе приведен список правил контроля, которые входят в Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}.
---

# Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Приведенный набор правил содержит элементы управления безопасностью на основе [Стандарта](../../../security/standard/all.md) по защите облачной инфраструктуры {{ yandex-cloud }}.

Стандарт по защите облачной инфраструктуры {{ yandex-cloud }} предоставляет комплексные требования безопасности и лучшие практики для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.

Эти элементы управления помогают обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей безопасности облачных сред:

#|
|| Идентификатор требования | Требование [стандарта безопасности](../../../security/standard/all.md) | Идентификаторы проверки в [модуле {{ cspm-name }}](../cspm.md) ||
|| **Аутентификация и управление доступом** {.cell-align-center} | > | > ||
|| `IAM1` | [Настроена федерация удостоверений (Single Sign-On, SSO)](../../../security/standard/all.md#saml-federation) | [cspm.access.uses-federation](../../rules-reference/cspm.md#uses-federation) ||
|| `IAM2` | [Настроено сопоставление групп пользователей в федерации удостоверений](../../../security/standard/all.md#group-mapping) | [cspm.access.user-groups-mapping](../../rules-reference/cspm.md#access-user-groups-mapping) ||
|| `IAM4` | [Таймаут жизни cookie в федерации меньше 6 часов](../../../security/standard/all.md#cookie-timeout) | [cspm.cookie-timeout.organization](../../rules-reference/cspm.md#cookie-timeout-organization) ||
|| `IAM5` | [Только необходимые администраторы управляют членством в IAM-группах](../../../security/standard/all.md#iam-admins) | [cspm.access.user-groups-access](../../rules-reference/cspm.md#user-groups-access) ||
|| `IAM6` | [Используются сервисные роли вместо примитивных: admin, editor, viewer, auditor](../../../security/standard/all.md#min-privileges) | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| `IAM9` | [Сервисным аккаунтам назначены минимальные привилегии](../../../security/standard/all.md#sa-privileges) |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| `IAM10` | [Только доверенные администраторы имеют доступ к сервисным аккаунтам](../../../security/standard/all.md#sa-admins) | [cspm.access.privileged-sa-access](../../rules-reference/cspm.md#access-privileged-sa-access) ||
|| `IAM11` | [Выполняется периодическая ротация ключей сервисных аккаунтов](../../../security/standard/all.md#sa-key-rotation) | [cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation) ||
|| `IAM12` | [Для API-ключей сервисных аккаунтов задана область действия](../../../security/standard/all.md#api-key-scopes) | [cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes) ||
|| `IAM16` | [На ВМ отключено получение токена через AWS IMDSv1](../../../security/standard/all.md#aws-token) | [cspm.aws-token](../../rules-reference/cspm.md#aws-token) ||
|| `IAM18` | [Привилегированные роли назначены только доверенным администраторам](../../../security/standard/all.md#privileged-users) | [cspm.access.check-privileged-roles](../../rules-reference/cspm.md#check-privileged-roles) ||
|| `IAM22` | [Для ресурсов в организации отсутствует публичный доступ](../../../security/standard/all.md#public-access) | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| `IAM23` | [Контактные данные ответственного за организацию актуальны](../../../security/standard/all.md#org-contacts) | [cspm.procedure.organization-contacts](../../rules-reference/cspm.md#organization-contacts) ||
|| `IAM24` | [На ресурсах используются метки](../../../security/standard/all.md#labels) | [cspm.o11y.labeled-resources](../../rules-reference/cspm.md#labeled-resources) ||
|| `IAM27` | [Регулярно проводится аудит прав доступа пользователей и сервисных аккаунтов с использованием {{ sd-full-name }} {{ ciem-name }}](../../../security/standard/all.md#ciem-access-control) | [cspm.access.check-bindings](../../rules-reference/cspm.md#access-check-bindings) ||
|| **Сетевая безопасность** {.cell-align-center} | > | > ||
|| `NET1` | [Для объектов облака используется межсетевой экран или группы безопасности](../../../security/standard/all.md#firewall) | [cspm.network.firewall](../../rules-reference/cspm.md#firewall) ||
|| `NET2` | [В {{ vpc-full-name }} существует как минимум одна группа безопасности](../../../security/standard/all.md#vpc-sg) | [cspm.network.network-firewall](../../rules-reference/cspm.md#network-firewall) ||
|| `NET3` | [В группах безопасности отсутствует слишком широкое правило доступа](../../../security/standard/all.md#access-rule) |
[cspm.network.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#k8s-network-firewall-scope)
||
|| `NET4` | [Доступ по управляющим портам открыт только для доверенных IP-адресов](../../../security/standard/all.md#trusted-ip) |
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
||
|| `NET5` | [Включена защита от DDoS-атак](../../../security/standard/all.md#ddos-protection) |
[cspm.appsec.ddos-protection.l3](../../rules-reference/cspm.md#appsec-ddos-protection-l3)
[cspm.appsec.ddos-protection.l7](../../rules-reference/cspm.md#l7)
||
|| **Безопасная конфигурация виртуальной среды** {.cell-align-center} | > | > ||
|| `ENV1` | [Использование серийной консоли контролируется либо отсутствует](../../../security/standard/all.md#serial-console) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| `ENV7` | [Отсутствует публичный доступ к бакету {{ objstorage-name }}](../../../security/standard/all.md#bucket-access) | [cspm.access.bucket-public-access](../../rules-reference/cspm.md#bucket-public-access) ||
|| `ENV8` | [В {{ objstorage-name }} используются политики доступа (Bucket Policy)](../../../security/standard/all.md#bucket-policy) | [cspm.access.bucket-access-policy](../../rules-reference/cspm.md#bucket-access-policy) ||
|| `ENV9` | [В {{ objstorage-name }} включена функция «Блокировка версии объекта» (objectlock)](../../../security/standard/all.md#object-lock) | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
|| `ENV14` | [На управляемых базах данных назначена Группа безопасности](../../../security/standard/all.md#db-security-group) | [cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group) ||
|| `ENV15` | [На управляемых базах данных не назначен публичный IP-адрес](../../../security/standard/all.md#db-ip) | [cspm.network.db-ip](../../rules-reference/cspm.md#db-ip) ||
|| `ENV16` | [Включена настройка защиты от удаления (deletion protection)](../../../security/standard/all.md#deletion-protection) | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| `ENV17` | [Выключена настройка доступа из {{ datalens-name }} без необходимости](../../../security/standard/all.md#db-datalens-access) | [cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access) ||
|| `ENV18` | [На управляемых БД выключен доступ из консоли управления](../../../security/standard/all.md#db-console-access) | [cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access) ||
|| `ENV19` | [{{ serverless-containers-name }}/{{ sf-short-name }} использует внутреннюю сеть {{ vpc-short-name }}](../../../security/standard/all.md#vpc-functions) | [cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc) ||
|| `ENV26` | [Публичный доступ отсутствует для {{ ydb-short-name }}](../../../security/standard/all.md#ydb-public) | [cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public) ||
|| `ENV28` | [Настроен ACL по IP-адресам для {{ container-registry-full-name }}](../../../security/standard/all.md#acl-container-registry) | [cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry) ||
|| `ENV29` | [Срок действия сертификата {{ certificate-manager-full-name }} составляет как минимум 30 дней](../../../security/standard/all.md#certificate-validity) | [cspm.crypto.certificate-validity](../../rules-reference/cspm.md#certificate-validity) ||
|| `ENV33` | [Для подключения к виртуальной машине или узлу {{ k8s }} используется {{ oslogin }}](../../../security/standard/all.md#os-login-onto-hosts) | [cspm.access.os-login-onto-hosts.vm](../../rules-reference/cspm.md#vm) ||
|| `ENV34` | [Проводится сканирование уязвимостей на уровне облачных IP-адресов](../../../security/standard/all.md#ip-level) | [cspm.active.ip-vulnerability-scan](../../rules-reference/cspm.md#ip-vulnerability-scan) ||
|| `ENV37` | [Используется {{ backup-short-name }} или механизм snapshot по расписанию](../../../security/standard/all.md#snapshot) |
[cspm.compute.snapshot](../../rules-reference/cspm.md#snapshot)
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|| **Шифрование данных и управление ключами** {.cell-align-center} | > | > ||
|| `CRYPT1` | [В {{ objstorage-full-name }} включено шифрование данных at rest с ключом {{ kms-short-name }}](../../../security/standard/all.md#storage-kms) | [cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption) ||
|| `CRYPT2` | [В {{ objstorage-full-name }} включено HTTPS для хостинга статического сайта](../../../security/standard/all.md#storage-https) | [cspm.data.storage-https](../../rules-reference/cspm.md#storage-https) ||
|| `CRYPT3` | [В {{ alb-full-name }} используется HTTPS](../../../security/standard/all.md#alb-https) | [cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https) ||
|| `CRYPT4` | [В {{ api-gw-full-name }} используется HTTPS и собственный домен](../../../security/standard/all.md#api-gateway-https) | [cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https) ||
|| `CRYPT5` | [В {{ cdn-full-name }} используется HTTPS и собственный SSL-сертификат](../../../security/standard/all.md#cdn-https) | [cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https) ||
|| `CRYPT7` | [Используется шифрование данных на уровне приложения](../../../security/standard/all.md#self-data-app) | [cspm.data.application-encryption](../../rules-reference/cspm.md#application-encryption) ||
|| `CRYPT8` | [Используется шифрование дисков и снимков виртуальных машин](../../../security/standard/all.md#managed-vm-kms) | [cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms) ||
|| `CRYPT9` | [Ключи {{ kms-name }} хранятся в аппаратном модуле безопасности (HSM)](../../../security/standard/all.md#keys-hsm) | [cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm) ||
|| `CRYPT10` | [Права на управление ключами в {{ kms-short-name }} выданы контролируемым пользователям](../../../security/standard/all.md#keys-controlled-users) | [cspm.access.kms-keys-access](../../rules-reference/cspm.md#kms-keys-access) ||
|| `CRYPT11` | [Для ключей {{ kms-short-name }} включена ротация](../../../security/standard/all.md#keys-rotation) | [cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation) ||
|| `CRYPT12` | [Для ключей {{ kms-short-name }} включена защита от удаления](../../../security/standard/all.md#keys-deletion-protection) | [cspm.crypto.keys-deletion-protection](../../rules-reference/cspm.md#keys-deletion-protection) ||
|| `CRYPT13` | [В организации используется {{ lockbox-full-name }} для безопасного хранения секретов](../../../security/standard/all.md#secrets-lockbox) | [cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox) ||
|| `CRYPT14` | [Для {{ serverless-containers-name }} и {{ sf-name }} используются секреты {{ lockbox-short-name }}](../../../security/standard/all.md#secrets-serverless-functions) | [cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless) ||
|| **Сбор, мониторинг и анализ аудитных логов** {.cell-align-center} | > | > ||
|| `AUDIT1` | [Включен сервис {{ at-full-name }} на уровне организации](../../../security/standard/all.md#audit-trails) |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
||
|| `AUDIT5` | [Выполняется сбор аудит-логов с уровня ОС](../../../security/standard/all.md#os-level) | [cspm.o11y.os-logs-audited](../../rules-reference/cspm.md#os-logs-audited) ||
|| `AUDIT8` | [Отслеживаются события уровня сервисов](../../../security/standard/all.md#data-plane-events) | [cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events) ||
|| **Защита приложений** {.cell-align-center} | > | > ||
|| `APPSEC1` | [Используется {{ captcha-full-name }}](../../../security/standard/all.md#use-smartcaptcha) | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| `APPSEC2` | [Docker-образы сканируются при загрузке в {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| `APPSEC3` | [Выполняется периодическое сканирование Docker-образов, хранящихся в {{ container-registry-name }}](../../../security/standard/all.md#periodic-scan) | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| `APPSEC4` | [Контейнерные образы, используемые в продакшн-среде, имеют последнюю дату сканирования не позднее недели](../../../security/standard/all.md#last-scan-date) | [cspm.appsec.registry-recently-scan](../../rules-reference/cspm.md#registry-recently-scan) ||
|| `APPSEC9` | [Используется профиль безопасности {{ sws-name }}](../../../security/standard/all.md#use-sws) | [cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws) ||
|| `APPSEC10` | [Используется Web Application Firewall](../../../security/standard/all.md#use-waf) | [cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf) ||
|| `APPSEC11` | [Используется Advanced Rate Limiter](../../../security/standard/all.md#use-arl) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| **Безопасность {{ k8s }}** {.cell-align-center} | > | > ||
|| `K8S3` | [Нет доступа к API {{ k8s }}](../../../security/standard/all.md#api-security) | [cspm.k8s.api-security](../../rules-reference/cspm.md#api-security) ||
|| `K8S4` | [В {{ managed-k8s-name }} настроены аутентификация и управление доступом](../../../security/standard/all.md#kubernetes-auth) | [cspm.k8s.access](../../rules-reference/cspm.md#access) ||
|| `K8S5` | [В {{ managed-k8s-full-name }} используется безопасная конфигурация](../../../security/standard/all.md#kubernetes-safe-config) | [cspm.k8s.secure-configuration](../../rules-reference/cspm.md#secure-configuration) ||
|| `K8S8` | [Используется одна из трех последних версий {{ k8s }} и ведется мониторинг обновлений](../../../security/standard/all.md#version-update) | [cspm.k8s.version-update](../../rules-reference/cspm.md#version-update) ||
|| `K8S11` | [Используется политика безопасности {{ k8s }}](../../../security/standard/all.md#security-standards) | [cspm.k8s.kspm](../../rules-reference/cspm.md#k8s-kspm) ||
|| `K8S12` | [Настроен сбор аудитных логов для расследований инцидентов](../../../security/standard/all.md#audit-logs) | [cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs) ||
|#