>```hcl
>resource "yandex_kubernetes_cluster" "<имя_кластера>" {
>  ...
>  master {
>    ...
>    master_logging {
>      enabled                    = <отправка_логов:_true_или_false>
>      log_group_id               = "<идентификатор_лог-группы>"
>      folder_id                  = "<идентификатор_каталога>"
>      kube_apiserver_enabled     = <отправка_логов_kube-apiserver:_true_или_false>
>      cluster_autoscaler_enabled = <отправка_логов_cluster-autoscaler:_true_или_false>
>      events_enabled             = <отправка_событий_{{ k8s }}:_true_или_false>
>      audit_enabled              = <отправка_событий_аудита:_true_или_false>
>    }
>  }
>}
>```