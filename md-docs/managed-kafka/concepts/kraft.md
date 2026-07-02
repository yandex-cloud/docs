[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Kafka®](../index.md) > [Концепции](index.md) > Протокол KRaft

# Протокол Apache Kafka® Raft в кластерах Managed Service for Apache Kafka®

_[Apache Kafka® Raft](https://docs.confluent.io/platform/current/kafka-metadata/kraft.html)_ (сокращенно KRaft) — протокол согласования, который позволяет хранить метаданные и управлять ими внутри Apache Kafka®. KRaft устраняет зависимость Apache Kafka® от внешнего сервиса синхронизации метаданных ZooKeeper.

[KRaft поддержан](index.md#kraft) в кластерах Managed Service for Apache Kafka® с версией Apache Kafka® 3.6 и выше.

[ZooKeeper поддержан](index.md#zookeeper) в кластерах с версиями Apache Kafka® 3.9 и ниже.

{% note info %}

Причина замены ZooKeeper на KRaft — с версией Apache Kafka® 4.0 поддержка ZooKeeper прекратится.

{% endnote %}

## Топология кластера Managed Service for Apache Kafka® {#cluster-topology}

KRaft автоматически настраивается и размещается в кластере в зависимости от выбранного режима работы и количества хостов-брокеров:

* **KRaft (комбинированный режим)** — на одном хосте Apache Kafka® одновременно размещаются [брокер](brokers.md) и контроллер метаданных KRaft. 


При этом в кластере создаются только три хоста-брокера Apache Kafka® в одной из конфигураций:
  * три хоста-брокера находятся в одной [зоне доступности](../../overview/concepts/geo-scope.md);
  * каждый хост-брокер расположен в отдельной зоне доступности.

  
  Задать количество хостов-брокеров вручную нельзя.

* **KRaft (на отдельных хостах)** — брокер и контроллер метаданных KRaft размещаются на отдельных хостах. При создании кластера с несколькими хостами-брокерами, в него добавляются три отдельных хоста KRaft.

  Количество хостов-брокеров задается вручную.

Хосты KRaft нельзя удалить. Количество хостов KRaft фиксировано.

Подробнее о создании кластера Managed Service for Apache Kafka® с протоколом KRaft читайте в [инструкции](../operations/cluster-create.md#create-cluster-kraft).

## Преимущества и недостатки Apache Kafka® Raft {#pros-and-cons}

Преимущества KRaft связаны с тем, что Apache Kafka® больше не зависит от внешней системы ZooKeeper:

* Для информационной безопасности используется один механизм вместо нескольких.
* Управлять кластером с KRaft проще, так как в кластере нет хостов ZooKeeper.
* Повышается отказоустойчивость кластера, в случае сбоя кластер восстанавливается почти мгновенно.
* Можно создавать бо́льшее количество партиций в кластере.

Подробнее на [сайте](https://developer.confluent.io/learn/kraft/#benefits-of-kafkas-new-quorum-controller) и в [документации](https://docs.confluent.io/platform/current/kafka-metadata/kraft.html) Confluent.

Недостатки KRaft объясняются [особенностями топологии кластеров](#cluster-topology):

* В комбинированном режиме контроллеры метаданных KRaft не изолированы от Apache Kafka® настолько же хорошо, как в split-режиме с выделенным подкластером контроллеров метаданных. Поэтому [Apache Kafka® не рекомендует](https://kafka.apache.org/42/operations/kraft/#process-roles) использовать комбинированный режим в критически важных средах разработки. Комбинированный режим больше подходит для локальной разработки и тестирования.
* В кластере с KRaft нельзя гибко управлять количеством хостов, допускается ровно три хоста.