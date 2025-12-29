### Creating new resources in the cluster {#create-resources}

1. Apply the updated YAML manifests using the following command: `kubectl apply -f <YAML_file_or_folder>`.
    
    This will create a new load balancer without removing the existing one.

1. Make sure all resources were successfully created by checking their status with the `kubectl get` command.

### Checking that your load balancing is correct {#check-load-balancing}

Test the new load balancer to ensure it functions correctly:

1. Get the IP address of your new load balancer:
    * Retrieve the `Ingress` resource status using the `kubectl get Ingress` command.
    * In the [management console]({{ link-console-main }}), do the following:
      * Go to the {{ managed-k8s-name }} cluster page.
      * In the left-hand panel, select ![image](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**.
      * Navigate to the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab.
1. Make sure routing behaves as expected by testing the availability of your app's HTTP/HTTPS endpoints.
1. Make sure backend health checks report all backends as healthy.
1. Check the [logs](../../../application-load-balancer/operations/application-load-balancer-get-logs.md) for errors and review the [load balancer metrics](../../../application-load-balancer/metrics.md) for any signs of performance issues.

### Redirecting traffic to the new load balancer {#dns-switch}

1. Update your domain DNS records to point to the new load balancer's IP address, thereby redirecting traffic.
1. Monitor app metrics during the traffic switchover.
1. Make sure the app's features remain fully accessible after the traffic redirection.

### Deleting the resources you no longer need {#clear-out}

1. Delete your old NGINX Ingress resources, i.e., original ingress controllers, backend groups, etc.
1. Remove any unused load balancers or TLS certificates.