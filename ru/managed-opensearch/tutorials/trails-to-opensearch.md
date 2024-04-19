# Загрузка логов из {{ at-full-name }}

[{{ at-name }}](../../audit-trails/index.yaml) — сервис сбора и выгрузки аудитных логов, который позволяет применять инструменты анализа и оперативного реагирования к событиям на уровне ресурсов {{ yandex-cloud }}. [{{ OS }}](../index.yaml) выступает в роли SIEM-системы для анализа логов и реагирования на события безопасности.

Мы покажем, как всего за несколько шагов настроить выгрузку логов из {{ at-name }}, используя сервисы [{{ yds-full-name }}](../../data-streams/index.yaml) и [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) и выбрав {{ mos-full-name }} в качестве SIEM-системы для анализа логов и реагирования на события безопасности.

{% include notitle [trails-logs-opensearch](../../_tutorials/security/trails-logs-opensearch.md) %}
