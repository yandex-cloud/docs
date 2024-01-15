# Устранение ошибки «One of the targets already a part of the another target group» в {{ network-load-balancer-name }}


## Описание проблемы {#issue-description}

При создании нового {{ network-load-balancer-name }} (например, для развертывания NGINX Ingress Controller), балансировщику не назначается действительный внешний IP-адрес.

В логах контроллера есть ошибки вида:

```

Error syncing load balancer: failed to ensure load balancer: failed to ensure cloud target group: failed to start lb target group creation: request-id = <request_id> rpc error: code = FailedPrecondition desc = One of the targets already a part of the another target group: <ip_address>#<subnet_id> -> [<target_group_id>]

```

## Решение {#issue-resolution}

Ошибка говорит о том, что узлы вашего кластера уже входят в состав целевой группы с идентификатором `<target_group_id>`.

Из-за этого {{ network-load-balancer-name }} не может создаться, так как к каждому балансировщику может быть подключена только одна целевая группа с целевыми ресурсами, определяемыми идентификатором подсети и внутренним IP-адресом.

Для решения проблемы следует удалить узлы из проблемной целевой группы. Это можно сделать в настройках целевой группы.


## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса просим указать следующую информацию:

1. Идентификтор балансировщика {{ network-load-balancer-name }}, затронутого проблемой.
1. Дата и время запуска операции создания балансировщика.
1. Скриншот или текстовый вывод с сообщением об ошибке из журналов Ingress-контроллера.
