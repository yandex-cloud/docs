---
title: Обновление цепочки TLS-сертификатов для доступа к кластерам {{ mpg-full-name }}
description: В этом разделе вы узнаете об особенностях обновления цепочки TLS-сертификатов в сервисах платформы данных {{ yandex-cloud }} и о действиях, которые могут потребоваться для сохранения возможности подключаться к хостам кластеров {{ mpg-full-name }} с публичным доступом.
---

# Обновление цепочки TLS-сертификатов в сервисах платформы данных

{% include [info-page-part1](../../../_includes/mdb/update-certificate-chain/info-page-part1.md) %}

Во время планового [технического обслуживания](../../concepts/maintenance.md) серверные сертификаты кластеров будут переведены на новый промежуточный сертификат.


## Особенности предстоящих изменений {#upcoming-changes}

{% include [info-page-part2](../../../_includes/mdb/update-certificate-chain/info-page-part2.md) %}

* Дата и время обновления конкретного кластера будут указаны в соответствующей [задаче на техническое обслуживание](../cluster-maintenance.md#get-maintenance).


## Возможные проблемы {#possible-impact}

{% include [info-page-part3-1](../../../_includes/mdb/update-certificate-chain/info-page-part3-1.md) %}

{% include [info-page-part3-2](../../../_includes/mdb/update-certificate-chain/info-page-part3-2.md) %}

## Что сделать до обслуживания {#to-do-list}

{% include [info-page-part4](../../../_includes/mdb/update-certificate-chain/info-page-part4.md) %}

Подробнее о командах установки сертификата с примерами подключений читайте в разделе [{#T}](./index.md).


## Если подключение перестало работать {#troubleshoot}

{% include [info-page-part5](../../../_includes/mdb/update-certificate-chain/info-page-part5.md) %}


#### Полезные ссылки {#see-also}

* [{#T}](./index.md)
* [{#T}](../../concepts/maintenance.md)
* [{#T}](../cluster-maintenance.md)