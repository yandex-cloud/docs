# Поды кластера слишком долго находятся в состоянии `PENDING`


## Описание проблемы {#issue-description}

* При попытке запустить новые поды в кластере Managed Service for Kubernetes, создаваемые поды имеют статус `PENDING` и не переходят в состояние `RUNNING` спустя длительное время;
* Вновь создаваемые поды зависают в состоянии `PENDING`;
* Состояние одного или нескольких подов кластера Managed Service for Kubernetes не изменяется на `RUNNING`.

## Решение {#issue-resolution}

Одной из причин зависания подов в состоянии `PENDING` может быть то, что выполнение процессов в контейнере инициализации одного или нескольких создаваемых подов не смогло завершиться корректно. Например, внутри проблемных подов может постоянно завершаться с ошибкой демон kubelet. При этом kubelet в таких подах будет сразу же перезапускаться из-за политики `restartPolicy: Always`.

Подробнее про Init Containers – [в официальной документации Kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/#detailed-behavior).

## Если проблема осталась {#if-issue-still-persists}

Для более подробной диагностики проблем с выполнением kubelet во вновь создаваемых подах потребуется [создать запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:
1. Идентификатор проблемного кластера Managed Service for Kubernetes 
1. Журналы с syslog-тегами `kubelet/kernel/system` с одного или нескольких узлов кластера Managed Service for Kubernetes, на которых возникают проблемы с запуском новых подов.

Также вы можете воспользоваться [нашим скриптом для автоматического сбора диагностических журналов Managed Service for Kubernetes](https://github.com/yandex-cloud/yc-architect-solution-library/tree/main/yc-k8s-capture-nodes-logs).