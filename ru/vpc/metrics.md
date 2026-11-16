---
title: Справочник метрик сервиса {{ vpc-full-name }} в {{ metrics-name }}
description: На этой странице приведен справочник метрик сервиса {{ vpc-short-name }}, поставляемых в {{ metrics-name }}.
---

# Справочник метрик {{ vpc-short-name }}

Метрики сервисных подключений {{ vpc-short-name }} автоматически передаются в [{{ metrics-name }}](../monium/metrics/overview.md), в [проект каталога](*monium-folder-project), в котором находится сервисное подключение.

{% include [vpc](../_includes/monitoring/metrics-ref/vpc.md) %}

[*monium-folder-project]: Проект {{ monium-name }} с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.
