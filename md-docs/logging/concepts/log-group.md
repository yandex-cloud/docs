# Лог-группа в Cloud Logging

_Лог-группа_ — это способ группировки логов сервисов и пользовательских сообщений. Группы бывают двух видов:

* По умолчанию.

    Имя лог-группы по умолчанию — `default`. Она создается автоматически, когда [сервис](#services) или приложение пишет логи, указав в качестве назначения идентификатор каталога. Пользователь может самостоятельно [добавлять записи](../operations/write-logs.md) в нее. Если [создать лог-группу](../operations/create-group.md) с именем `default`, она будет лог-группой по умолчанию для того каталога, в котором создана.

* Пользовательские.

  Пользователь может самостоятельно создать лог-группу и добавлять записи в нее.

При добавлении записи в лог-группу можно указать время ее создания (`timestamp`). Время создания записи может отличаться от времени ее добавления в лог-группу и должно удовлетворять следующим условиям:
```text
Текущая дата - 30 дней < Время создания записи < Текущая дата + 1 день
```

## Сервисы, которые могут писать логи в Cloud Logging {#services}


* [API Gateway](../../api-gateway/index.md)
* [Application Load Balancer](../../application-load-balancer/index.md)
* [Audit Trails](../../audit-trails/index.md)
* [Cloud Functions](../../functions/index.md)
* [Compute Cloud](../../compute/index.md) (сбор логов ВМ и пользовательских приложений через [Yandex Unified Agent](../../monitoring/concepts/data-collection/unified-agent/index.md))
* [Container Registry](../../container-registry/index.md)
* [DataSphere](../../datasphere/index.md)
* [Managed Service for Apache Airflow™](../../managed-airflow/index.md)
* [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/index.md)
* [Managed Service for Kubernetes®](../../managed-kubernetes/index.md)
* [Serverless Containers](../../serverless-containers/index.md)
* [Serverless Integrations](../../serverless-integrations/index.md)
* [Yandex Cloud Postbox](../../postbox/index.md)
* [Yandex Cloud Notification Service](../../notifications/index.md)
* [Yandex Data Processing](../../data-proc/index.md)
* [Yandex Data Streams](../../data-streams/index.md)
* [Yandex IoT Core](../../iot-core/index.md)
* [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md)