# Устранение ошибки Permission denied to create UDP listener in folder при создании NLB-балансировщика


## Описание проблемы {#issue-description}

При попытке создания нового балансировщика нагрузки сетевого уровня отображается сообщение об ошибке:

```text
Error syncing load balancer: failed to ensure load balancer: failed to ensure cloud loadbalancer: failed to start cloud lb creation: rpc error: code = PermissionDenied desc = Permission denied to create UDP listener in folder b1gXXXXXXXXXXXXXXXXX
```

## Решение {#issue-resolution}

Опция включения UDP порта в балансировщике находится на стадии тестирования и требует отдельного доступа, который выдаётся по запросу.
Для того, чтобы получить доступ к этой функциональности, понадобится [создать запрос в техническую поддержку](https://console.cloud.yandex.ru/support?section=contact).
В запросе укажите следующую информацию:

1. Идентификатор облака, для которого необходимо активировать возможность использования протокола UDP в Network Level Balancer.
2. Описание сценария использования, в котором необходимо использование этой функциональности, и какие задачи она поможет решить.

{% note info %}

Обратите внимание, что UDP в Network Level Balancer работает в режиме `round robin per-packet`. Соответственно для протоколов, в которых важен параметр `sticky sessions`, не гарантируется доставка пакетов одной сессий на один и тот же целевой сервер.

{% endnote %}