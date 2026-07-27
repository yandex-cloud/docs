# Recovering Loki in standalone mode if PVC is full

In `standalone` mode, Loki stores data on a single PVC. If the PVC is full, the Loki pod may go `CrashLoopBackOff`, and logs will trow errors like `no space left on device`.

Do not remove the PVC as your first recovery step. In standalone, this will result in the loss of local log storage.

## Checking status

1. Find a namespace with Loki. For the `logging` component, use `stackland-logging`, for bootstrap installation, you may use `loki`.

   ```bash
   kubectl get pods,pvc -A | grep -E 'loki|stackland-logging'
   ```

1. Check the pod and PVC:

   ```bash
   NS=stackland-logging
   kubectl -n "$NS" get pods,pvc
   kubectl -n "$NS" describe pod -l app.kubernetes.io/name=loki
   kubectl -n "$NS" describe pvc
   ```

1. Check free space on the PVC based on kubelet metrics or inside the pod if the pod is still starting:

   ```bash
   POD=$(kubectl -n "$NS" get pod \
     -l app.kubernetes.io/name=loki,app.kubernetes.io/component=single-binary \
     -o jsonpath='{.items[0].metadata.name}')
   kubectl -n "$NS" exec -it "$POD" -- df -h /var/loki
   ```

## Preferred method: expand PVC

1. Find out the PVC name and `StorageClass`:

   ```bash
   NS=stackland-logging
   kubectl -n "$NS" get pvc
   PVC=<PVC_NAME>
   SC=$(kubectl -n "$NS" get pvc "$PVC" -o jsonpath='{.spec.storageClassName}')
   kubectl get storageclass "$SC" -o jsonpath='{.allowVolumeExpansion}{"\n"}'
   ```

1. If `allowVolumeExpansion=true`, increase the PVC. The new value must be greater than the current one:

   ```bash
   kubectl -n "$NS" patch pvc "$PVC" --type merge \
     -p '{"spec":{"resources":{"requests":{"storage":"100Gi"}}}}'
   ```

1. Wait for the resize to complete:

   ```bash
   kubectl -n "$NS" get pvc "$PVC" -w
   ```

1. Restart Loki if the pod does not recover by itself:

   ```bash
   STS=$(kubectl -n "$NS" get statefulset \
     -l app.kubernetes.io/name=loki,app.kubernetes.io/component=single-binary \
     -o jsonpath='{.items[0].metadata.name}')
   kubectl -n "$NS" rollout restart statefulset/"$STS"
   kubectl -n "$NS" rollout status statefulset/"$STS"
   ```

1. Fix the new size in `LoggingConfig` or else the next reconcile may return the old value:

   ```yaml
   apiVersion: stackland.yandex.cloud/v1alpha1
   kind: LoggingConfig
   metadata:
     name: main
   spec:
     settings:
       logStorage:
         storage:
           enabled: true
           size: 100Gi
   ```

## If PVC cannot be expanded

If StorageClass does not support expansion or `VolumeGroup` has no free space left, begin by freeing or adding capacity at the disk subsystem level. With that done, repeat PVC expansion.

If you cannot add space quickly, you can delete some of Loki's old local data. This is an emergency method that involves losing some of the logs.

1. Stop Loki:

   ```bash
   NS=stackland-logging
   STS=$(kubectl -n "$NS" get statefulset \
     -l app.kubernetes.io/name=loki,app.kubernetes.io/component=single-binary \
     -o jsonpath='{.items[0].metadata.name}')
   kubectl -n "$NS" scale statefulset/"$STS" --replicas=0
   ```

1. Attach the PVC to a temporary pod and delete the oldest data from `/var/loki/chunks`. Before deleting, check which directories are taking up space:

   ```bash
   kubectl -n "$NS" run loki-pvc-debug --image=busybox:1.37 --restart=Never \
     --overrides='{"spec":{"containers":[{"name":"debug","image":"busybox:1.37","command":["sleep","1d"],"volumeMounts":[{"name":"storage","mountPath":"/var/loki"}]}],"volumes":[{"name":"storage","persistentVolumeClaim":{"claimName":"<PVC_NAME>"}}]}}'

   kubectl -n "$NS" exec -it loki-pvc-debug -- sh
   du -h /var/loki | sort -h | tail -20
   find /var/loki/chunks -type f -mtime +30 -exec rm -f {} \;
   exit
   ```

1. Remove the temporary pod and start Loki:

   ```bash
   kubectl -n "$NS" delete pod loki-pvc-debug
   kubectl -n "$NS" scale statefulset/"$STS" --replicas=1
   kubectl -n "$NS" rollout status statefulset/"$STS"
   ```

## After the restoration

Make sure retention and compactor are enabled for standalone:

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

If Loki fills up PVC regularly even with retention on, decrease `loki.singleBinary.limitsConfig.retentionPeriod`, increase `loki.singleBinary.storage.size`, check the incoming log volume, and consider migrating to `loki.simpleScalable` with S3 storage.
