---
title: Базовые правила безопасности облачной платформы {{ yandex-cloud }}
description: В этом разделе приведен список правил контроля, которые входят в базовый набор правил безопасности облачной платформы {{ yandex-cloud }}.
---

# Базовые правила безопасности облачной платформы {{ yandex-cloud }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Приведенный набор правил содержит базовые проверки безопасности, необходимые для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.

Эти правила помогают снизить риски от базовых угроз безопасности в облачных средах:

#|
|| Идентификатор требования | Требование [стандарта безопасности](../../../security/standard/all.md) | Идентификатор проверки в [модуле {{ cspm-name }}](../cspm.md) ||
|| **Аутентификация и управление доступом** (IAM) {.cell-align-center} | > | > ||
|| IAM5 | [Только необходимые администраторы управляют членством в IAM-группах](../../../security/standard/all.md#iam-admins) | [cspm.access.user-groups-access](../../rules-reference/cspm.md#user-groups-access) ||
|| IAM22 | [Для ресурсов в организации отсутствует публичный доступ](../../../security/standard/all.md#public-access) | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| IAM27 | [Регулярно проводится аудит прав доступа пользователей и сервисных аккаунтов с использованием {{ sd-full-name }} {{ ciem-name }}](../../../security/standard/all.md#ciem-access-control) | [cspm.access.check-bindings](../../rules-reference/cspm.md#access-check-bindings) ||
|| **Сетевая безопасность** (NET) {.cell-align-center} | > | > ||
|| NET3 | [В группах безопасности отсутствует слишком широкое правило доступа](../../../security/standard/all.md#access-rule) | [cspm.network.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope) ||
|| **Безопасная конфигурация виртуальной среды** (ENV) {.cell-align-center} | > | > ||
|| ENV1 | [Использование серийной консоли контролируется либо отсутствует](../../../security/standard/all.md#serial-console) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| **Шифрование данных и управление ключами** (CRYPT) {.cell-align-center} | > | > ||
|| CRYPT9 | [Ключи {{ kms-short-name }} хранятся в аппаратном модуле безопасности (HSM)](../../../security/standard/all.md#keys-hsm) | [cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm) ||
|| CRYPT13 | [В организации используется {{ lockbox-full-name }} для безопасного хранения секретов](../../../security/standard/all.md#secrets-lockbox) | [cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox) ||
|| CRYPT14 | [Для {{ serverless-containers-full-name }} и {{ sf-full-name }} используются секреты {{ lockbox-name }}](../../../security/standard/all.md#secrets-serverless-functions) | [cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless) ||
|| **Сбор, мониторинг и анализ аудитных логов** (AUDIT) {.cell-align-center} | > | > ||
|| AUDIT1 | [Включен сервис {{ at-full-name }} на уровне организации](../../../security/standard/all.md#audit-trails) | [cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors) ||
|| AUDIT8 | [Отслеживаются события уровня сервисов](../../../security/standard/all.md#data-plane-events) | [cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events) ||
|| **Защита приложений** (APPSEC) {.cell-align-center} | > | > ||
|| APPSEC1 | [Используется {{ captcha-full-name }}](../../../security/standard/all.md#use-smartcaptcha) | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| APPSEC2 | [Docker-образы сканируются при загрузке в {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| APPSEC3 | [Выполняется периодическое сканирование Docker-образов, хранящихся в {{ container-registry-name }}](../../../security/standard/all.md#periodic-scan) | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| APPSEC9 | [Используется профиль безопасности {{ sws-full-name }}](../../../security/standard/all.md#use-sws) | [cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws) ||
|| APPSEC10 | [Используется Web Application Firewall](../../../security/standard/all.md#use-waf) | [cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf) ||
|| APPSEC11 | [Используется Advanced Rate Limiter](../../../security/standard/all.md#use-arl) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| **Безопасность {{ k8s }}** (K8S) {.cell-align-center} | > | > ||
|| K8S8 | [Используется одна из трех последних версий {{ k8s }} и ведется мониторинг обновлений](../../../security/standard/all.md#version-update) | [cspm.k8s.version-update](../../rules-reference/cspm.md#version-update) ||
|| K8S11 | [Используется политика безопасности {{ k8s }}](../../../security/standard/all.md#security-standards) | [cspm.k8s.kspm](../../rules-reference/cspm.md#k8s-kspm) ||
|| K8S12 | [Настроен сбор аудитных логов для расследований инцидентов](../../../security/standard/all.md#audit-logs) | [cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs) ||
|#
