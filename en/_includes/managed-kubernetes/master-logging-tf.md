> ```hcl
> resource "yandex_kubernetes_cluster" "<cluster_name>" {
>  ...
>  master {
>    ...
>    master_logging {
>      enabled                    = <log_sending>
>      log_group_id               = "<log_group_ID>"
>      folder_id                  = "<folder_ID>"
>      kube_apiserver_enabled     = <kube-apiserver_log_sending>
>      cluster_autoscaler_enabled = <cluster-autoscaler_log_sending>
>      events_enabled             = <{{ k8s }}_event_sending>
>      audit_enabled              = <audit_event_sending>
>    }
>  }
> }
> ```
