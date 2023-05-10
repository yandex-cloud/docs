>```hcl
>resource "yandex_kubernetes_cluster" "<имя кластера>" {
>  ...
>  master {
>    ...
>    master_logging {
>      enabled                    = <отправка логов: true или false>
>      log_group_id               = "<идентификатор лог-группы>"
>      folder_id                  = "<идентификатор каталога>"
>      kube_apiserver_enabled     = <отправка логов kube-apiserver: true или false>
>      cluster_autoscaler_enabled = <отправка логов cluster-autoscaler: true или false>
>      events_enabled             = <отправка событий {{ k8s }}: true или false>
>    }
>  }
>}
>```