>```hcl
>resource "yandex_kubernetes_cluster" "<имя_кластера>" {
>  ...
>  master {
>    ...
>    master_logging {
>      enabled                    = <отправка_логов>
>      log_group_id               = "<идентификатор_лог-группы>"
>      folder_id                  = "<идентификатор_каталога>"
>      kube_apiserver_enabled     = <отправка_логов_kube-apiserver>
>      cluster_autoscaler_enabled = <отправка_логов_cluster-autoscaler>
>      events_enabled             = <отправка_событий_{{ k8s }}>
>    }
>  }
>}
>```