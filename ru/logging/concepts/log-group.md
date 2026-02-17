---
title: Лог-группа в {{ cloud-logging-full-name }}
description: Лог-группа — это способ группировки логов сервисов и пользовательских сообщений.
---

# Лог-группа в {{ cloud-logging-name }}

_Лог-группа_ — это способ группировки логов сервисов и пользовательских сообщений. Группы бывают двух видов:

* По умолчанию.

    Имя лог-группы по умолчанию — `default`. Она создается автоматически, когда [сервис](#services) или приложение пишет логи, указав в качестве назначения идентификатор каталога. Пользователь может самостоятельно [добавлять записи](../operations/write-logs.md) в нее. Если [создать лог-группу](../operations/create-group.md) с именем `default`, она будет лог-группой по умолчанию для того каталога, в котором создана.

* Пользовательские.

  Пользователь может самостоятельно создать лог-группу и добавлять записи в нее.

При добавлении записи в лог-группу можно указать время ее создания (`timestamp`). Время создания записи может отличаться от времени ее добавления в лог-группу и должно удовлетворять следующим условиям:
```text
Текущая дата - 30 дней < Время создания записи < Текущая дата + 1 день
```

## Сервисы, которые могут писать логи в {{ cloud-logging-name }} {#services}


* [{{ api-gw-name }}](../../api-gateway/)
* [{{ alb-name }}](../../application-load-balancer/)
* [{{ at-name }}](../../audit-trails/)
* [{{ sf-name }}](../../functions/)
* [{{ compute-name }}](../../compute/) (сбор логов ВМ и пользовательских приложений через [{{ unified-agent-full-name }}](../../monitoring/concepts/data-collection/unified-agent/))
* [{{ container-registry-name }}](../../container-registry/)
* [{{ ml-platform-name }}](../../datasphere/)
* [{{ maf-name }}](../../managed-airflow/)
* [{{ mgp-name }}](../../managed-greenplum/)
* [{{ managed-k8s-name }}®](../../managed-kubernetes/)
* [{{ serverless-containers-name }}](../../serverless-containers/)
* [{{ si-name }}](../../serverless-integrations/)
* [{{ postbox-name }}](../../postbox/)
* [{{ cns-full-name }}](../../notifications/)
* [{{ dataproc-name }}](../../data-proc/)
* [{{ yds-full-name }}](../../data-streams/)
* [{{ iot-name }}](../../iot-core/)
* [{{ mpg-full-name }}](../../managed-postgresql/)