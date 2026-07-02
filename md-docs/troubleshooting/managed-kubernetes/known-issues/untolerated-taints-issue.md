[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for Kubernetes](../index.md) > Устранение ошибки `0/10 nodes are available - node(s) had untolerated taint`

# Устранение ошибки `0/10 nodes are available - node(s) had untolerated taint`


## Описание проблемы {#issue-description}

При выполнении операции запуска подов в кластере Managed Service for Kubernetes возникает ошибка:

```(text)
0/10 nodes are available: X node(s) had untolerated taint
```

где `X` - число проблемных узлов кластера Managed Service for Kubernetes.

## Решение {#issue-resolution}

Такая ошибка возникает, когда в настройках кластера нода имеет пометку *(taint)*, которая не совместима с требованиями запускаемых на нем приложений. *Taint* – это пометка ноды, которая указывает на то, что определенные поды не могут быть на ней запущены, если они не соответствуют определенным критериям.

Чтобы исправить эту ошибку, либо нужно изменить пометку, чтобы поды соответствовали ей, либо изменить настройки запускаемых подов, чтобы они соответствовали пометке на узле.

Также рекомендуем проверить используемые *tolerations* у пода и указанные для ноды `nodeSelector` или `nodeAffinity`. Дополнительно проверьте используемые квоты и лимиты Managed Service for Kubernetes на предмет того, что у нод хватает запрашиваемых ресурсов.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса просим указать следующую информацию:

1. Идентификатор кластера Managed Service for Kubernetes.
1. Журнал событий кластера Managed Service for Kubernetes: вывод `kubectl get events`.
1. Cпецификацию узла кластера: вывод `kubectl describe node $NODE_NAME`, где `$NODE_NAME` - наименование проблемной ноды.
1. Cпецификацию затронутых проблемой подов кластера: вывод `kubectl describe node $POD_NAME` для каждого такого пода, где `$POD_NAME` - наименование пода.