### Как исправить ошибку `failed to get connection to any shard host within` при подключении к хостам кластера? {#failed-to-get-connection}

Пример ошибки:

```bash
failed to get connection to any shard host within: host {rc1d-cofs7cre********.mdb.yandexcloud.net:6432 rc1d}: dial tcp 10.151.25.35:6432: i/o timeout, host {rc1b-49796b52********.mdb.yandexcloud.net:6432 rc1b}: dial tcp 10.149.25.23:6432: i/o timeout, host {rc1a-kdm7v4qm********.mdb.yandexcloud.net:6432 rc1a}: dial tcp 10.148.25.15:6432: i/o timeout
```

Ошибка появляется, если [роутер](../../managed-spqr/concepts/index.md#router) не может подключиться к хостам [шарда](../../managed-spqr/concepts/index.md#shard).

**Решение**:

1. Убедитесь, что кластер {{ mspqr-name }} и шарды находятся в одной сети и в одной [группе безопасности](../../vpc/concepts/security-groups.md).
1. В группу безопасности [добавьте правила](../../vpc/operations/security-group-add-rule.md) для входящего и исходящего трафика, разрешающие TCP-подключение на порт `6432`:
  
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — укажите CIDR кластера, например `10.96.0.0/16`.    