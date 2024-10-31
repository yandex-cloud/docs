* `data_lens` — разрешить доступ из {{ datalens-name }}: `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из {{ datalens-name }}](../../../../managed-clickhouse/operations/datalens-connect.md).

* `web_sql` — разрешить [выполнять SQL-запросы](../../../../managed-clickhouse/operations/web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}: `true` или `false`. Значение по умолчанию — `false`.


* `metrika` — разрешить [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html): `true` или `false`. Значение по умолчанию — `false`.

* `serverless` — разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../../../functions/concepts/index.md): `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../../../functions/operations/database-connection.md).

* `data_transfer` — разрешить доступ к кластеру из сервиса [{{ data-transfer-full-name }}](../../../../data-transfer/concepts/index.md) в Serverless-режиме: `true` или `false`. Значение по умолчанию — `false`.

    Это позволит через специальную сеть подключаться к {{ data-transfer-full-name }}, запущенному в {{ k8s }}. В результате будут быстрее выполняться, например, запуск и деактивация трансфера.


* `yandex_query` — разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../../../query/concepts/index.md): `true` или `false`. Функциональность находится на стадии [Preview](../../../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.
