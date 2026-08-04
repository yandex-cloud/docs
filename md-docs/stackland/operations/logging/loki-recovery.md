[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Логирование > Восстановить Loki в standalone-режиме при заполнении PVC

# Восстановить Loki в standalone-режиме при заполнении PVC

В режиме `standalone` Loki хранит данные на одном PVC. Если PVC заполнен, pod Loki может перейти в `CrashLoopBackOff`, а в логах появляются ошибки вида `no space left on device`.

Не удаляйте PVC как первый шаг восстановления. В standalone это приведет к потере локального хранилища логов.

## Проверить состояние

1. Найдите namespace с Loki. Для компонента `logging` используется `stackland-logging`, для bootstrap-установки может использоваться `loki`.

   ```bash
   kubectl get pods,pvc -A | grep -E 'loki|stackland-logging'
   ```

2. Проверьте pod и PVC:

   ```bash
   NS=stackland-logging
   kubectl -n "$NS" get pods,pvc
   kubectl -n "$NS" describe pod -l app.kubernetes.io/name=loki
   kubectl -n "$NS" describe pvc
   ```

3. Проверьте свободное место на PVC по метрикам kubelet или внутри pod, если pod еще стартует:

   ```bash
   POD=$(kubectl -n "$NS" get pod \
     -l app.kubernetes.io/name=loki,app.kubernetes.io/component=single-binary \
     -o jsonpath='{.items[0].metadata.name}')
   kubectl -n "$NS" exec -it "$POD" -- df -h /var/loki
   ```

## Предпочтительный способ: расширить PVC

1. Узнайте имя PVC и StorageClass:

   ```bash
   NS=stackland-logging
   kubectl -n "$NS" get pvc
   PVC=<PVC_NAME>
   SC=$(kubectl -n "$NS" get pvc "$PVC" -o jsonpath='{.spec.storageClassName}')
   kubectl get storageclass "$SC" -o jsonpath='{.allowVolumeExpansion}{"\n"}'
   ```

2. Если `allowVolumeExpansion=true`, увеличьте PVC. Новое значение должно быть больше текущего:

   ```bash
   kubectl -n "$NS" patch pvc "$PVC" --type merge \
     -p '{"spec":{"resources":{"requests":{"storage":"100Gi"}}}}'
   ```

3. Дождитесь завершения resize:

   ```bash
   kubectl -n "$NS" get pvc "$PVC" -w
   ```

4. Узнайте имя StatefulSet и удалите только его объект, оставив pod и PVC работающими. Это необходимо, потому что Kubernetes не позволяет изменять размер в `volumeClaimTemplates` существующего StatefulSet:

   ```bash
   STS=$(kubectl -n "$NS" get statefulset \
     -l app.kubernetes.io/name=loki,app.kubernetes.io/component=single-binary \
     -o jsonpath='{.items[0].metadata.name}')
   kubectl -n "$NS" delete statefulset "$STS" --cascade=orphan
   ```

   Не удаляйте orphaned pod и PVC.

5. Сразу укажите новый размер в `LoggingConfig`. Контроллер пересоздаст StatefulSet с обновленным `volumeClaimTemplates` и подхватит существующие pod и PVC:

   ```bash
   kubectl patch loggingconfig main --type merge \
     -p '{"spec":{"settings":{"logStorage":{"loki":{"singleBinary":{"storage":{"size":"100Gi"}}}}}}}'
   ```

6. Убедитесь, что StatefulSet пересоздан и Loki готов:

   ```bash
   kubectl -n "$NS" get statefulset "$STS"
   kubectl -n "$NS" rollout status statefulset/"$STS"
   ```

## Если PVC нельзя расширить

Если StorageClass не поддерживает expansion или в VolumeGroup нет свободного места, сначала освободите или добавьте емкость на уровне дисковой подсистемы. После этого повторите расширение PVC.

Если быстро добавить место невозможно, можно удалить часть старых локальных данных Loki. Это аварийный способ с потерей части логов.

1. Остановите Loki:

   ```bash
   NS=stackland-logging
   STS=$(kubectl -n "$NS" get statefulset \
     -l app.kubernetes.io/name=loki,app.kubernetes.io/component=single-binary \
     -o jsonpath='{.items[0].metadata.name}')
   kubectl -n "$NS" scale statefulset/"$STS" --replicas=0
   ```

2. Подключите PVC к временному pod и удалите самые старые данные из `/var/loki/chunks`. Перед удалением проверьте, какие директории занимают место:

   ```bash
   kubectl -n "$NS" run loki-pvc-debug --image=busybox:1.37 --restart=Never \
     --overrides='{"spec":{"containers":[{"name":"debug","image":"busybox:1.37","command":["sleep","1d"],"volumeMounts":[{"name":"storage","mountPath":"/var/loki"}]}],"volumes":[{"name":"storage","persistentVolumeClaim":{"claimName":"<PVC_NAME>"}}]}}'

   kubectl -n "$NS" exec -it loki-pvc-debug -- sh
   du -h /var/loki | sort -h | tail -20
   find /var/loki/chunks -type f -mtime +30 -exec rm -f {} \;
   exit
   ```

3. Удалите временный pod и запустите Loki:

   ```bash
   kubectl -n "$NS" delete pod loki-pvc-debug
   kubectl -n "$NS" scale statefulset/"$STS" --replicas=1
   kubectl -n "$NS" rollout status statefulset/"$STS"
   ```

## После восстановления

Проверьте, что для standalone включены retention и compactor:

```yaml
spec:
  settings:
    logStorage:
      loki:
        singleBinary:
          enabled: true
          storage:
            size: 50Gi
          limitsConfig:
            retentionPeriod: 30d
          compactor:
            retentionEnabled: true
            retentionDeleteDelay: 2h
```

Если Loki регулярно заполняет PVC даже с retention, уменьшите `loki.singleBinary.limitsConfig.retentionPeriod`, увеличьте `loki.singleBinary.storage.size`, проверьте объем входящих логов и рассмотрите переход на `loki.simpleScalable` с S3-хранилищем.