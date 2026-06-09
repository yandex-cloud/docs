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


* [{{ api-gw-name }}](../../api-gateway/index.md)
* [{{ alb-name }}](../../application-load-balancer/index.md)
* [{{ at-name }}](../../audit-trails/index.md)
* [{{ sf-name }}](../../functions/index.md)
* [{{ compute-name }}](../../compute/index.md) (сбор логов ВМ и пользовательских приложений через [{{ unified-agent-full-name }}](../../monitoring/concepts/data-collection/unified-agent/index.md))
* [{{ container-registry-name }}](../../container-registry/index.md)
* [{{ ml-platform-name }}](../../datasphere/index.md)
* [{{ maf-name }}](../../managed-airflow/index.md)
* [{{ mgp-name }}](../../managed-greenplum/index.md)
* [{{ managed-k8s-name }}®](../../managed-kubernetes/index.md)
* [{{ serverless-containers-name }}](../../serverless-containers/index.md)
* [{{ si-name }}](../../serverless-integrations/index.md)
* [{{ postbox-name }}](../../postbox/index.md)
* [{{ cns-full-name }}](../../notifications/index.md)
* [{{ dataproc-name }}](../../data-proc/index.md)
* [{{ yds-full-name }}](../../data-streams/index.md)
* [{{ iot-name }}](../../iot-core/index.md)
* [{{ mpg-full-name }}](../../managed-postgresql/index.md)