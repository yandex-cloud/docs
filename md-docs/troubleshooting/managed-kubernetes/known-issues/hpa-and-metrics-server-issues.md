[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for Kubernetes](../index.md) > Устранение проблем с работой HPA в Managed Service for Kubernetes

# Устранение проблем с работой HPA в Managed Service for Kubernetes


## Описание проблемы {#issue-description}

* Обращения к методам API `metrics.k8s.io` и `custom.metrics.k8s.io` завершаются по таймауту с сообщением об ошибке `nо context deadline exceeded`;
* На узле с запущенным подом сервера метрик наблюдается нехватка оперативной памяти и срабатывания `oom-killer` — сообщения о срабатывании OOM Killer отображаются в серийной консоли узлов Managed Service for Kubernetes;
* В выводе информации о состоянии HPA командой `kubectl describe hpa` в кластере Managed Service for Kubernetes отображаются сообщения следующего вида:
  
```
Warning  FailedGetResourceMetric horizontal-pod-autoscaler  failed to get memory utilization: unable to get metrics for resource memory: unable to fetch metrics from resource metrics API: an error on the server ("Internal Server Error: \"/apis/metrics.k8s.io/v1beta1/namespaces/jaeger/pods: Post net/http: request canceled (Client.Timeout exceeded while awaiting headers)") has prevented the request from succeeding (get pods.metrics.k8s.io)

Warning  FailedGetResourceMetric  horizontal-pod-autoscaler  failed to get cpu utilization: unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: an error on the server ("Internal Server Error: Post: net/http: request canceled (Client.Timeout exceeded while awaiting headers)") has prevented the request from succeeding (get pods.metrics.k8s.io)
```

## Решение {#issue-resolution}

Выполните следующие действия для решения проблемы:

1. Убедитесь, что группы безопасности разрешают доступ к подам  Metrics server. Для этого воспользуйтесь руководством по настройке групп безопасности в кластерах Managed Service for Kubernetes [по этой ссылке](../../../managed-kubernetes/operations/connect/security-groups.md#apply).
1. Вручную перенесите под с сервером метрик на другой, менее загруженный узел кластера Managed Service for Kubernetes.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:

1. Идентификатор проблемного кластера Managed Service for Kubernetes.
1. Идентификатор проблемного пода кластера Managed Service for Kubernetes.
1. Вывод команды `kubectl describe hpa` для проблемного кластера Managed Service for Kubernetes.