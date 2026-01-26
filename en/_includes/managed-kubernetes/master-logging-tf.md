>```hcl
>resource "yandex_kubernetes_cluster" "<cluster_name>" {
>  ...
>  master {
>    ...
>    master_logging {
>      enabled                    = <send_logs>
>      log_group_id               = "<log_group_ID>"
>      folder_id                  = "<folder_ID>"
>      kube_apiserver_enabled     = <send_kube-apiserver_logs>
>      cluster_autoscaler_enabled = <send_cluster-autoscaler_logs>
>      events_enabled             = <send_{{ k8s }}_events>
>      audit_enabled              = <send_audit_events>
>    }
>  }
>}
>```