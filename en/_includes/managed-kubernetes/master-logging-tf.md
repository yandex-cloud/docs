> ```hcl
> resource "yandex_kubernetes_cluster" "<cluster name>" {
>  ...
>  master {
>    ...
>    master_logging {
>      enabled                    = <log sending: true or false>
>      log_group_id               = "<log group ID>"
>      folder_id                  = "<folder ID>"
>      kube_apiserver_enabled     = <kube-apiserver log sending: true or false>
>      cluster_autoscaler_enabled = <cluster-autoscaler log sending: true or false>
>      events_enabled             = <{{ k8s }} event sending: true or false>
>    }
>  }
> }
> ```