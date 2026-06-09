# Устранение ошибки `One of the targets already a part of the another target group`


## Описание проблемы {#issue-description}

При создании нового Network Load Balancer, например, для развертывания NGINX Ingress Controller балансировщику не назначается действительный внешний IP-адрес.

В логах появляются ошибки вида:

```
Error syncing load balancer: failed to ensure load balancer: failed to ensure cloud target group: failed to start lb target group creation: request-id = <request_id> rpc error: code = FailedPrecondition desc = One of the targets already a part of the another target group: <ip_address>#<subnet_id> -> [<target_group_id>]
```

## Решение {#issue-resolution}

Ошибка говорит о том, что узлы вашего кластера уже входят в состав целевой группы с идентификатором `<target_group_id>`. Из-за этого Network Load Balancer не может создаться, так как к каждому балансировщику может быть подключена только одна целевая группа с целевыми ресурсами, определяемыми идентификатором подсети и внутренним IP-адресом.

Для решения проблемы следует удалить узлы из проблемной группы. Это можно сделать в ее настройках.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса просим указать следующую информацию:

1. Идентификтор балансировщика Network Load Balancer, затронутого проблемой.
1. Дату и время запуска операции создания балансировщика.
1. Скриншот или текстовый вывод с сообщением об ошибке из журналов Ingress-контроллера.