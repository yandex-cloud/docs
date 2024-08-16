# Устранение проблем с работой HPA в {{ managed-k8s-name }}


## Описание проблемы {#issue-description}

* Обращения к методам API `metrics.k8s.io` и `custom.metrics.k8s.io` завершаются по таймауту с сообщением об ошибке `nо context deadline exceeded`;
* На узле с запущенным подом сервера метрик наблюдается нехватка оперативной памяти и срабатывания `oom-killer` — сообщения о срабатывании OOM Killer отображаются в серийной консоли узлов {{ managed-k8s-name }};
* В выводе информации о состоянии HPA командой `kubectl describe hpa` в кластере {{ managed-k8s-name }} отображаются сообщения следующего вида:
  
```
Warning  FailedGetResourceMetric horizontal-pod-autoscaler  failed to get memory utilization: unable to get metrics for resource memory: unable to fetch metrics from resource metrics API: an error on the server ("Internal Server Error: \"/apis/metrics.k8s.io/v1beta1/namespaces/jaeger/pods: Post net/http: request canceled (Client.Timeout exceeded while awaiting headers)") has prevented the request from succeeding (get pods.metrics.k8s.io)

Warning  FailedGetResourceMetric  horizontal-pod-autoscaler  failed to get cpu utilization: unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: an error on the server ("Internal Server Error: Post: net/http: request canceled (Client.Timeout exceeded while awaiting headers)") has prevented the request from succeeding (get pods.metrics.k8s.io)
```

## Решение {#issue-resolution}

Выполните следующие действия для решения проблемы:

1. Вручную перенесите под с сервером метрик на другой, менее загруженный узел кластера {{ managed-k8s-name }}.
1. Если это не поможет, измените конфигурацию пода с сервером метрик [по этой инструкции](../../../managed-kubernetes/tutorials/metrics-server.md).

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Идентификатор проблемного кластера {{ managed-k8s-name }}.
1. Идентификатор проблемного пода кластера {{ managed-k8s-name }}.
1. Вывод команды `kubectl describe hpa` для проблемного кластера {{ managed-k8s-name }}.