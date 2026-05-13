# Решения для Managed Service for Kubernetes

## Примеры конфигураций и сценариев Managed Service for Kubernetes {#configuration-examples}

* [Как выдать узлам Kubernetes доступ в интернет](how-to/providing-internet-access-for-mk8s-nodes.md)
* [Как создать внутренний Ingress-контроллер](how-to/create-internal-ingress-balancer.md)
* [Как настроить автоматическое удаление старых образов с узлов Managed Service for Kubernetes](how-to/configuring-automatic-image-deletion.md)
* [Как выяснить размер эфемерного хранилища узла Managed Service for Kubernetes](how-to/finding-out-ephemeral-storage-size.md)
* [Как узнать внешний IP-адрес узла Managed Service for Kubernetes](how-to/finding-out-node-external-ip.md)
* [Как изменить часовой пояс на узлах кластера Managed Service for Kubernetes](how-to/setting-timezone-on-mk8s-worker-nodes.md)
* [Как использовать сертификаты из Certificate Manager в балансировщиках нагрузки или в Managed Service for Kubernetes](how-to/uploading-cert-from-yc-certmgr-to-k8s.md)

## Решения для известных проблем Managed Service for Kubernetes {#known-issues-resolving}

* [Хосты группы узлов Managed Service for Kubernetes долго находятся в статусе `RECONCILING`](known-issues/node-group-hosts-are-in-reconciling-status-for-a-long-time.md)
* [Устранение ошибки `Timed out waiting for the condition` при монтировании тома с большим количеством файлов](known-issues/unable-to-mount-volume-with-a-large-number-of-files.md)
* [Устранение ошибки `Timed out waiting for the condition` при монтировании PVC](known-issues/error-unable-to-attach-or-mount-volumes-timed-out-waiting-for-the-condition.md)
* [Устранение ошибки `Multi-Attach error for volume`](known-issues/multi-attach-error-for-volume.md)
* [Не уменьшается количество узлов в группе Managed Service for Kubernetes](known-issues/cannot-reduce-the-number-of-nodes.md)
* [Устранение ошибки `DEADLINE_EXCEEDED`](known-issues/error-504.md)
* [Не увеличивается количество узлов в группе Managed Service for Kubernetes](known-issues/autoscaler-node-enlarging-issues.md)
* [Кластер слишком долго находится в состоянии `STARTING`](known-issues/cluster-stuck-in-starting-state.md)
* [Устранение проблем с разрешением DNS-имен в Managed Service for Kubernetes](known-issues/dns-name-resolving-issues.md)
* [Устранение проблем с работой HPA в Managed Service for Kubernetes](known-issues/hpa-and-metrics-server-issues.md)
* [Устранение ошибок с синхронизацией времени на узлах кластера Managed Service for Kubernetes](known-issues/ntp-time-sync-issues.md)
* [Поды кластера слишком долго находятся в состоянии `PENDING`](known-issues/pods-stuck-in-pending-state.md)
* [Устранение проблем с монтированием томов к подам кластера Managed Service for Kubernetes средствами Container Storage Interface для S3](known-issues/unable-to-mount-volume-to-pods-via-csi-s3.md)
* [Устранение ошибки `0/10 nodes are available - node(s) had untolerated taint`](known-issues/untolerated-taints-issue.md)