# Решения для {{ managed-k8s-name }}

## Примеры конфигураций и сценариев {{ managed-k8s-name }} {#configuration-examples}

* [Как выдать узлам {{ k8s }} доступ в интернет](how-to/providing-internet-access-for-mk8s-nodes.md)
* [Как создать внутренний Ingress-контроллер](how-to/create-internal-ingress-balancer.md)
* [Как настроить автоматическое удаление старых образов с узлов {{ managed-k8s-name }}](how-to/configuring-automatic-image-deletion.md)
* [Как выяснить размер эфемерного хранилища узла {{ managed-k8s-name }}](how-to/finding-out-ephemeral-storage-size.md)
* [Как узнать внешний IP-адрес узла {{ managed-k8s-name }}](how-to/finding-out-node-external-ip.md)
* [Как изменить часовой пояс на узлах кластера {{ managed-k8s-name }}](how-to/setting-timezone-on-mk8s-worker-nodes.md)
* [Как использовать сертификаты из {{ certificate-manager-name }} в балансировщиках нагрузки или в {{ managed-k8s-name }}](how-to/uploading-cert-from-yc-certmgr-to-k8s.md)

## Решения для известных проблем {{ managed-k8s-name }} {#known-issues-resolving}

* [Хосты группы узлов {{ managed-k8s-name }} долго находятся в статусе `RECONCILING`](known-issues/node-group-hosts-are-in-reconciling-status-for-a-long-time.md)
* [Устранение ошибки `Timed out waiting for the condition` при монтировании тома с большим количеством файлов](known-issues/unable-to-mount-volume-with-a-large-number-of-files.md)
* [Устранение ошибки `Timed out waiting for the condition` при монтировании PVC](known-issues/error-unable-to-attach-or-mount-volumes-timed-out-waiting-for-the-condition.md)
* [Устранение ошибки `Multi-Attach error for volume`](known-issues/multi-attach-error-for-volume.md)
* [Не уменьшается количество узлов в группе {{ managed-k8s-name }}](known-issues/cannot-reduce-the-number-of-nodes.md)
* [Устранение ошибки `DEADLINE_EXCEEDED`](known-issues/error-504.md)
* [Не увеличивается количество узлов в группе {{ managed-k8s-name }}](known-issues/autoscaler-node-enlarging-issues.md)
* [Кластер слишком долго находится в состоянии `STARTING`](known-issues/cluster-stuck-in-starting-state.md)
* [Устранение проблем с разрешением DNS-имен в {{ managed-k8s-name }}](known-issues/dns-name-resolving-issues.md)
* [Устранение проблем с работой HPA в {{ managed-k8s-name }}](known-issues/hpa-and-metrics-server-issues.md)
* [Устранение ошибок с синхронизацией времени на узлах кластера {{ managed-k8s-name }}](known-issues/ntp-time-sync-issues.md)
* [Поды кластера слишком долго находятся в состоянии `PENDING`](known-issues/pods-stuck-in-pending-state.md)
* [Устранение проблем с монтированием томов к подам кластера {{ managed-k8s-name }} средствами Container Storage Interface для S3](known-issues/unable-to-mount-volume-to-pods-via-csi-s3.md)
* [Устранение ошибки `0/10 nodes are available - node(s) had untolerated taint`](known-issues/untolerated-taints-issue.md)