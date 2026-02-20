# Протокол {{ kraft-name }} в кластерах {{ mkf-name }}

_[{{ kraft-name }}](https://docs.confluent.io/platform/current/kafka-metadata/kraft.html)_ (сокращенно {{ kraft-short-name }}) — протокол согласования, который позволяет хранить метаданные и управлять ими внутри {{ KF }}. {{ kraft-short-name }} устраняет зависимость {{ KF }} от внешнего сервиса синхронизации метаданных {{ ZK }}.

[{{ kraft-short-name }} поддержан](index.md#kraft) в кластерах {{ mkf-name }} с версией {{ KF }} 3.6 и выше.

[{{ ZK }} поддержан](index.md#zookeeper) в кластерах с версиями {{ KF }} 3.9 и ниже.

{% note info %}

Причина замены {{ ZK }} на {{ kraft-short-name }} — с версией {{ KF }} 4.0 поддержка {{ ZK }} прекратится.

{% endnote %}

## Топология кластера {{ mkf-name }} {#cluster-topology}

{% include [kraft-cluster-topology](../../_includes/mdb/mkf/kraft-cluster-topology.md) %}

## Преимущества и недостатки {{ kraft-name }} {#pros-and-cons}

Преимущества {{ kraft-short-name }} связаны с тем, что {{ KF }} больше не зависит от внешней системы {{ ZK }}:

* Для информационной безопасности используется один механизм вместо нескольких.
* Управлять кластером с {{ kraft-short-name }} проще, так как в кластере нет хостов {{ ZK }}.
* Повышается отказоустойчивость кластера, в случае сбоя кластер восстанавливается почти мгновенно.
* Можно создавать бо́льшее количество партиций в кластере.

Подробнее см. на [сайте](https://developer.confluent.io/learn/kraft/#benefits-of-kafkas-new-quorum-controller) и в [документации](https://docs.confluent.io/platform/current/kafka-metadata/kraft.html) Confluent.

Недостатки {{ kraft-short-name }} объясняются [особенностями топологии кластеров](#cluster-topology):

* В комбинированном режиме контроллеры метаданных {{ kraft-short-name }} не изолированы от {{ KF }} настолько же хорошо, как в split-режиме с выделенным подкластером контроллеров метаданных. Поэтому [{{ KF }} не рекомендует](https://kafka.apache.org/42/operations/kraft/#process-roles) использовать комбинированный режим в критически важных средах разработки. Комбинированный режим больше подходит для локальной разработки и тестирования.
* В кластере с {{ kraft-short-name }} нельзя гибко управлять количеством хостов, допускается ровно три хоста.
