### Ошибка при репликации из внешнего источника {#external-replication}

Текст ошибки:

```text
[XX000] ERROR: could not connect to the publisher:
SSL error: certificate verify failed FATAL:
no pg_hba.conf entry for replication connection
from host "<IP-адрес_хоста_{{ PG }}>", user "postgres", SSL off
```

**Решение:** подготовьте источник в соответствии с разделом [Подготовка к трансферу](../../../../data-transfer/operations/prepare.md#source-pg).
