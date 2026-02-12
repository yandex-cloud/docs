---
title: Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}
description: В этом разделе приведен список правил контроля, которые входят в Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}.
---

# Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Приведенный набор правил содержит элементы управления безопасностью на основе [Стандарта](../../../security/standard/all.md) по защите облачной инфраструктуры {{ yandex-cloud }}.

Стандарт по защите облачной инфраструктуры {{ yandex-cloud }} предоставляет комплексные требования безопасности и лучшие практики для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.

Эти элементы управления помогают обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей безопасности облачных сред:

Идентификатор требования | Требование [стандарта безопасности](../../../security/standard/all.md) | Идентификатор проверки в [модуле CSPM](../cspm.md)
--- | --- | ---
`IAM6` | [Используются сервисные роли вместо примитивных: admin, editor, viewer, auditor](../../../security/standard/all.md#min-privileges) | `cspm.access.min-privileges`
`IAM9` | [Сервисным аккаунтам назначены минимальные привилегии](../../../security/standard/all.md#sa-privileges) | `cspm.access.sa-privileges`
`IAM12` | [Для API-ключей сервисных аккаунтов задана область действия](../../../security/standard/all.md#api-key-scopes) | `cspm.access.defined-key-scopes`
`IAM22` | [Для ресурсов в организации отсутствует публичный доступ](../../../security/standard/all.md#public-access) | `cspm.access.public-access`
`NET2` | [В {{ vpc-full-name }} существует как минимум одна группа безопасности](../../../security/standard/all.md#vpc-sg) | `cspm.network.network-firewall`
`NET3` | [В группах безопасности отсутствует слишком широкое правило доступа](../../../security/standard/all.md#access-rule) | `cspm.network.network-firewall-scope`
`NET5` | [Включена защита от DDoS-атак](../../../security/standard/all.md#ddos-protection) | `cspm.appsec.ddos-protection.l7`
`ENV1` | [Использование серийной консоли контролируется либо отсутствует](../../../security/standard/all.md#serial-console) | `cspm.access.serial-console`
`ENV7` | [Отсутствует публичный доступ к бакету {{ objstorage-full-name }}](../../../security/standard/all.md#bucket-access) | `cspm.access.bucket-public-access`
`ENV14` | [На управляемых базах данных назначена Группа безопасности](../../../security/standard/all.md#db-security-group) | `cspm.network.db-security-group`
`ENV15` | [На управляемых базах данных не назначен публичный IP-адрес](../../../security/standard/all.md#db-ip) | `cspm.network.db-ip`
`ENV16` | [Включена настройка защиты от удаления (deletion protection)](../../../security/standard/all.md#deletion-protection) | `cspm.db.db-deletion-protection`
`ENV17` | [Выключена настройка доступа из {{ datalens-full-name }} без необходимости](../../../security/standard/all.md#db-datalens-access) | `cspm.access.db-datalens-access`
`ENV18` | [На управляемых БД выключен доступ из консоли управления](../../../security/standard/all.md#db-console-access) | `cspm.access.db-console-access`
`ENV26` | [Публичный доступ отсутствует для {{ ydb-short-name }}](../../../security/standard/all.md#ydb-public) | `cspm.network.ydb-public`
`ENV28` | [Настроен ACL по IP-адресам для {{ container-registry-full-name }}](../../../security/standard/all.md#acl-container-registry) | `cspm.access.acl-container-registry`
`ENV29` | [Срок действия сертификата {{ certificate-manager-full-name }} составляет как минимум 30 дней](../../../security/standard/all.md#certificate-validity) | `cspm.crypto.certificate-validity`
`ENV33` | [Для подключения к виртуальной машине или узлу {{ k8s }} используется {{ oslogin }}](../../../security/standard/all.md#os-login-onto-hosts) | `cspm.access.os-login-onto-hosts.vm`
`ENV34` | [Проводится сканирование уязвимостей на уровне облачных IP-адресов](../../../security/standard/all.md#ip-level) | `cspm.active.ip-vulnerability-scan`
`CRYPT1` | [В {{ objstorage-full-name }} включено шифрование данных at rest с ключом {{ kms-short-name }}](../../../security/standard/all.md#storage-kms) | `cspm.data.object-storage-encryption`
`CRYPT3` | [В {{ alb-full-name }} используется HTTPS](../../../security/standard/all.md#alb-https) | `cspm.appsec.alb-https`
`CRYPT5` | [В {{ cdn-full-name }} используется HTTPS и собственный SSL-сертификат](../../../security/standard/all.md#cdn-https) | `cspm.appsec.cdn-https`
`CRYPT7` | [Используется шифрование данных на уровне приложения](../../../security/standard/all.md#self-data-app) | `cspm.data.application-encryption`
`CRYPT8` | [Используется шифрование дисков и снимков виртуальных машин](../../../security/standard/all.md#managed-vm-kms) | `cspm.crypto.managed-vm-kms`
`CRYPT11` | [Для ключей {{ kms-short-name }} включена ротация](../../../security/standard/all.md#keys-rotation) | `cspm.crypto.keys-rotation`
`CRYPT12` | [Для ключей {{ kms-short-name }} включена защита от удаления](../../../security/standard/all.md#keys-deletion-protection) | `cspm.crypto.keys-deletion-protection`
`CRYPT13` | [В организации используется {{ lockbox-full-name }} для безопасного хранения секретов](../../../security/standard/all.md#secrets-lockbox) | `cspm.crypto.secrets-lockbox`
`CRYPT14` | [Для {{ serverless-containers-full-name }} и {{ sf-full-name }} используются секреты {{ lockbox-name }}](../../../security/standard/all.md#secrets-serverless-functions) | `cspm.crypto.secrets-serverless`
`AUDIT1` | [Включен сервис {{ at-full-name }} на уровне организации](../../../security/standard/all.md#audit-trails) | `cspm.o11y.audit-trails`
`AUDIT8` | [Отслеживаются события уровня сервисов](../../../security/standard/all.md#data-plane-events) | `cspm.o11y.data-plane-events`
`APPSEC2` | [Docker-образы сканируются при загрузке в {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | `appsec.secure-registry`
`APPSEC3` | [Выполняется периодическое сканирование Docker-образов, хранящихся в {{ container-registry-name }}](../../../security/standard/all.md#periodic-scan) | `cspm.appsec.periodic-scan`
`APPSEC9` | [Используется профиль безопасности {{ sws-full-name }}](../../../security/standard/all.md#use-sws) | `cspm.appsec.use-sws`
`APPSEC11` | [Используется Advanced Rate Limiter](../../../security/standard/all.md#use-arl) | `cspm.appsec.use-arl`
`K8S5` | [В {{ managed-k8s-full-name }} используется безопасная конфигурация](../../../security/standard/all.md#kubernetes-safe-config) | `cspm.k8s.secure-configuration`
`K8S8` | [Используется одна из трех последних версий {{ k8s }} и ведется мониторинг обновлений](../../../security/standard/all.md#version-update) | `cspm.k8s.version-update`
`K8S12` | [Настроен сбор аудитных логов для расследований инцидентов](../../../security/standard/all.md#audit-logs) | `cspm.k8s.audit-logs`