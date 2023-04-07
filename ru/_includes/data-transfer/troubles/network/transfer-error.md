### Ошибка доступа к кластеру {#transfer-error}

Текст ошибки, возникающей при создании трансфера:

```text
Cannot retrieve table information from the source database: failed to resolve storage: failed to create a PostgreSQL storage: unable to get master host: unable to create postgres service client: All hosts are unavailable:
```
**Решение:** проверьте доступность кластера в вашей [подсети](../../../../data-transfer/concepts/network.md).
Чаще всего проблема заключается в отсутствии необходимых правил в группе безопасности.