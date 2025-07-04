---
title: Резервные копии MongoDB
description: '{{ mmg-short-name }} обеспечивает автоматическое и ручное резервное копирование баз данных MongoDB. Резервные копии занимают место в объеме хранилища, выделенном для кластера. Поддерживается восстановление состояния кластера на заданный момент времени (Point-in-Time-Recovery, PITR).'
keywords:
  - бэкап
  - бекап
  - backup
  - резервное копирование
  - резервное копирование MongoDB
  - backup MongoDB
  - MongoDB
---

# Резервные копии в {{ mmg-name }}

{{ mmg-short-name }} обеспечивает автоматическое и ручное резервное копирование баз данных.

{{ mmg-name }} позволяет восстановить состояние кластера _на любой момент времени_ (Point-in-Time-Recovery, PITR) от создания самой старой резервной копии и до архивации самой свежей коллекции [oplog](https://www.mongodb.com/docs/manual/core/replica-set-oplog/). Это достигается за счет дополнения данных резервной копии, выбранной в качестве начальной точки для восстановления, записями из коллекции oplog кластера.

При создании резервных копий и восстановлении из них на заданный момент времени учитывайте, что:

* Коллекция oplog архивируется в работающем кластере несколько раз в минуту, после чего загружается в объектное хранилище.

* На создание и загрузку архива коллекции oplog в объектное хранилище требуется некоторое время. Из-за этого состояние кластера, которое хранится в объектном хранилище, может отличаться от реального.

Для использования PITR в кластере должен быть выключен механизм [шардирования](../tutorials/sharding.md). PITR работает только для кластера с единичным набором реплик (replica set).

Чтобы восстановить кластер из резервной копии, [следуйте инструкциям](../operations/cluster-backups.md#restore).

## Создание резервной копии {#size}

Резервные копии можно создавать автоматически или вручную, в обоих случаях создается полная резервная копия всех баз данных.

Для шардированных кластеров создаются две резервные копии: шардированная и нешардированная. Для шардированной копии отображается больший размер, который включает:
* Размер резервной копии для хостов с типом `mongoinfra` или `mongocfg`.
* Сумму размеров всех нешардированных резервных копий. Эта сумма учитывается при подсчете общего размера шардированной копии, но фактически нешардированные копии не занимают дополнительное место в хранилище в составе шардированной копии.

Из нешардированной копии можно восстановить только нешардированный кластер. Из шардированной копии можно восстановить кластер со стандартным или расширенным шардированием, независимо от того, какое шардирование использовалось в исходном кластере. Шарды восстанавливаемого кластера должны соответствовать шардам исходного кластера на момент создания резервной копии.

Резервная копия всех данных кластера автоматически создается раз в день. Отключить автоматическое создание резервной копии невозможно. Однако при [создании](../operations/cluster-create.md) или [изменении](../operations/update.md#change-additional-settings) кластера для таких резервных копий можно задать:

* [Срок их хранения](#storage).
* Промежуток времени, в течение которого начинается резервное копирование. По умолчанию — `22:00 - 23:00` UTC (Coordinated Universal Time).

После создания резервная копия сжимается для дальнейшего хранения. Чтобы узнать ее точный размер, запросите [список резервных копий](../operations/cluster-backups.md#list-backups).

Резервные копии создаются только на работающих кластерах. Если вы используете кластер {{ mmg-short-name }} не круглосуточно, проверьте [настройки](../operations/update.md#change-additional-settings) и убедитесь, что резервное копирование выполняется во время работы кластера.

О том, как вручную создать резервную копию, читайте в разделе [Управление резервными копиями](../operations/cluster-backups.md).

## Хранение резервной копии {#storage}

Особенности хранения резервных копий в {{ mmg-name }}:

* Резервные копии хранятся во внутреннем хранилище Яндекса в виде логических дампов и шифруются с помощью [GPG](https://ru.wikipedia.org/wiki/GnuPG). У каждого кластера свои ключи шифрования.

* Срок хранения резервных копий существующего кластера зависит от способа их создания:

    * Автоматические резервные копии по умолчанию хранятся {{ mmg-backup-retention }} дней. При [создании](../operations/cluster-create.md) кластера или [изменении](../operations/update.md#change-additional-settings) его настроек можно задать другой срок хранения в диапазоне от {{ mmg-backup-retention-min }} до {{ mmg-backup-retention-max }} дней.

    * Резервные копии, созданные вручную, хранятся бессрочно.

* После удаления кластера все его резервные копии хранятся 7 дней.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}
* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    Подробнее см. в разделе [Правила тарификации](../pricing.md#rules-storage).

## Проверка восстановления из резервной копии {#capabilities}

Для проверки возможностей резервного копирования [восстановите кластер из резервной копии](../operations/cluster-backups.md) и проверьте целостность ваших данных.
