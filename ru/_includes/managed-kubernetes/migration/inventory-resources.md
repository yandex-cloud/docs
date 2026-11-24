Команда для выгрузки полного списка ресурсов из исходного кластера:

```bash
for ns in $(kubectl get ns --no-headers -o custom-columns=':metadata.name'); do
  echo "=== Namespace: $ns ==="
  kubectl get deploy,sts,ds,job,cronjob,svc,ingress,pvc,cm,secret,hpa,pdb -n $ns
done
```

Чек-лист инвентаризации:

#|
|| **Ресурсы** | **Что зафиксировать** ||
|| `Deployment`, `StatefulSet`, `DaemonSet`, `Job`, `CronJob` | Количество, пространства имен, образы ||
|| `PersistentVolumeClaim` | Размер, `StorageClass`, режим доступа: RWO или RWX ||
|| `Service` типа `LoadBalancer` | Внешние IP-адреса, DNS-имена ||
|| `Ingress`, `HTTPRoute` | Хосты, TLS, `IngressClass` или `GatewayClass` ||
|| `ConfigMap`, `Secret` | Список ресурсов ||
|| CRD и операторы | Список установленных CRD и операторов ||
|#
