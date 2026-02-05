---
title: Базовые правила безопасности облачной платформы {{ yandex-cloud }}
description: В этом разделе приведен список правил контроля, которые входят в базовый набор правил безопасности облачной платформы {{ yandex-cloud }}.
---

# Базовые правила безопасности облачной платформы {{ yandex-cloud }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Приведенный набор правил содержит базовые проверки безопасности, необходимые для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.

Эти правила помогают снизить риски от базовых угроз безопасности в облачных средах:

Идентификатор требования | Требование [стандарта безопасности](../../../security/standard/all.md) | Идентификатор проверки в [модуле CSPM](../cspm.md)
--- | --- | ---
`IAM1` | [Настроена федерация удостоверений (Single Sign-On, SSO)](../../../security/standard/all.md#saml-federation) | `cspm.access.uses-federation` 
`IAM22` | [Для ресурсов в организации отсутствует публичный доступ](../../../security/standard/all.md#public-access) | `cspm.access.public-access`
`NET3` | [В группах безопасности отсутствует слишком широкое правило доступа](../../../security/standard/all.md#access-rule) | `cspm.network.network-firewall-scope`
`ENV1` | [Использование серийной консоли контролируется либо отсутствует](../../../security/standard/all.md#serial-console) | `cspm.access.serial-console`
`CRYPT13` | [В организации используется {{ lockbox-full-name }} для безопасного хранения секретов](../../../security/standard/all.md#secrets-lockbox) | `cspm.crypto.secrets-lockbox`
`CRYPT14` | [Для {{ serverless-containers-full-name }} и {{ sf-full-name }} используются секреты {{ lockbox-name }}](../../../security/standard/all.md#secrets-serverless-functions) | `cspm.crypto.secrets-serverless`
`AUDIT2` | [События {{ at-full-name }} экспортируются в SIEM-системы](../../../security/standard/all.md#events) | `cspm.o11y.logs-exported-to-siem`
`AUDIT8` | [Отслеживаются события уровня сервисов](../../../security/standard/all.md#data-plane-events) | `cspm.o11y.data-plane-events`
`APPSEC2` | [Docker-образы сканируются при загрузке в {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | `cspm.appsec.upload-policy`
`APPSEC3` | [Выполняется периодическое сканирование Docker-образов, хранящихся в {{ container-registry-name }}](../../../security/standard/all.md#periodic-scan) | `cspm.appsec.periodic-scan`
`APPSEC9` | [Используется профиль безопасности {{ sws-full-name }}](../../../security/standard/all.md#use-sws) | `cspm.appsec.use-sws`
`APPSEC11` | [Используется Advanced Rate Limiter](../../../security/standard/all.md#use-arl) | `cspm.appsec.use-arl`
`K8S8` | [Используется одна из трех последних версий {{ k8s }} и ведется мониторинг обновлений](../../../security/standard/all.md#version-update) | `cspm.k8s.version-update`
`K8S12` | [Настроен сбор аудитных логов для расследований инцидентов](../../../security/standard/all.md#audit-logs) | `cspm.k8s.audit-logs`