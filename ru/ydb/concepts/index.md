---
title: Yandex Database (YDB). Обзор СУБД
description: 'Yandex Database (YDB) — это горизонтально масштабируемая распределённая отказоустойчивая СУБД. YDB спроектирована с учетом требований высокой производительности — например, обычный сервер может обрабатывать десятки тысяч запросов в секунду. В дизайн системы заложена работа с объемами данных в сотни петабайт.'
---

База данных {{ ydb-short-name }} является региональной и располагается в регионе `ru-central1`. Регион `ru-central1` имеет три зоны доступности. Подробнее о регионах и зонах доступности читайте в разделе [{#T}](../../overview/concepts/geo-scope.md).

{% include notitle [cli-install](../oss/public/_includes/index.md) %}

Вы можете создать базу данных в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [{#T}](serverless_and_dedicated.md).

{{ ydb-short-name }} предоставляет YDB API и его реализации в виде [YDB CLI](../quickstart/yql-api/ydb-cli.md) и [YDB SDK](../oss/public/reference/ydb-sdk/index.md) для [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) и [Go](https://github.com/yandex-cloud/ydb-go-sdk)
