### Не распознается IP-адрес или FQDN внешнего кластера {#cluster-config-issue}

Трансфер завершается с ошибкой:

```text
server selection error: server selection timeout, current topology: { Type: ReplicaSetNoPrimary, Servers: [{ Addr: <неразрешающееся_FQDN>, Type: Unknown, Last error: connection() error occurred during connection handshake: dial tcp: lookup <неразрешающееся_FQDN> on <IP-адрес>: no such host }, ] }"
```

Ошибка трансфера связана с конфигурацией кластера {{ MG }} (Managed Service for MongoDB). Например, когда в описании шардов используются внутренние не разрешающиеся имена.

**Решение:** 

{% include [mondodb cluster requirement](../../../data-transfer/mongodb-cluster-requirement.md) %}

