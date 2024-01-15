# Работа с базами данных во время трансфера

При работе с трансферами данных необходимо учитывать особенности баз данных.
Во время работы трансфера с репликацией ([типы трансфера](../concepts/index.md#transfer-type) _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_) данные на источнике и приемнике могут различаться, поэтому при чтении из базы-приемника в это время могут возникать ошибки. После [деактивации](./transfer.md#deactivate) трансфера данные на источнике и приемнике будут одинаковы (отложенная согласованность, eventual consistency).

## MySQL {#mysql}

{% include [PG](../../_includes/data-transfer/endpoints/sources/mysql-work-with-db.md) %}

## PostgreSQL {#postgresql}

{% include [PG](../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) %}

## MongoDB {#mongodb}

{% include [PG](../../_includes/data-transfer/endpoints/sources/mongo-work-with-db.md) %}