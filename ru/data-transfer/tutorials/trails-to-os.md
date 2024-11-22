---
noIndex: true
---

# Загрузка логов из {{ at-full-name }} в {{ OS }}

[{{ at-name }}](../../audit-trails) — сервис сбора и выгрузки аудитных логов, который позволяет применять инструменты анализа и оперативного реагирования к событиям на уровне ресурсов {{ yandex-cloud }}. [OpenSearch](../../managed-opensearch/) выступает в роли SIEM-системы для анализа логов и реагирования на события безопасности.

Мы покажем, как всего за несколько шагов настроить выгрузку логов из {{ at-name }}, используя сервисы [{{ yds-full-name }}](../../data-streams/) и [{{ data-transfer-full-name }}](../../data-transfer/) и выбрав {{ mos-full-name }} в качестве SIEM-системы для анализа логов и реагирования на события безопасности.

{% include notitle [trails-logs-opensearch](../../_tutorials/security/trails-logs-opensearch.md) %}
