# Deploying and load testing a gRPC service with scaling in {{ managed-k8s-full-name }}


Follow this tutorial to deploy an autoscaling [gRPC](https://grpc.io/docs/) service in a [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) using an [{{ alb-full-name }}](../../application-load-balancer/) [Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md) to load test the service.

To deploy the service and perform load testing:

1. [Get your cloud ready](#before-you-begin).
1. [Prepare a test target](#prepare-target).
1. [Register your domain](#prepare-domain).
1. [Install Ingress](#install-ingress).
1. [Configure horizontal pod autoscaling](#configure-autoscaling).
1. [Load test the gRPC service](#load-testing).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

1. Register a [domain name](../../dns/concepts/resource-record.md) for your website.
1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Prepare](../../managed-kubernetes/quickstart.md) your {{ managed-k8s-name }} cluster.
1. [Install](../../managed-kubernetes/operations/applications/metrics-provider.md) Metrics Provider in the `kube-public` namespace.
1. [Install](../../application-load-balancer/operations/k8s-ingress-controller-install.md) ALB Ingress Controller.


1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}



### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for using the [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master) and outgoing traffic  (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using the computing resources of the [L7 load balancer](../../application-load-balancer/concepts/index.md) (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for public DNS queries and [DNS zones](../../dns/concepts/dns-zone.md) if using [{{ dns-full-name }}](../../dns/) (see [{{ dns-name }} pricing](../../dns/pricing.md)).



## Prepare a test target {#prepare-target}

This tutorial will use a gRPC service as a test target.

1. Save the following specification to create an application in the `grpc-server.yaml` file:

   ```yaml
   ### Deployment.
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: grpc-app
     labels:
       app: grpc-app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: grpc-app
     template:
       metadata:
         name: grpc-app
         labels:
           app: grpc-app
       spec:
         affinity:
           podAntiAffinity:
             requiredDuringSchedulingIgnoredDuringExecution:
               - labelSelector:
                   matchExpressions:
                     - key: app
                       operator: In
                       values:
                         - grpc-app
                 topologyKey: "kubernetes.io/hostname"

         containers:
           - name: grpc-app
             image: {{ registry }}/crp6a9o7k9q5rrtt2hoq/grpc-test-server
             resources:
               requests:
                 memory: "256Mi"
                 cpu: "500m"
               limits:
                 memory: "500Mi"
                 cpu: "1"

   ### Service.
   apiVersion: v1
   kind: Service
   metadata:
     name: grpc-service
   spec:
     selector:
       app: grpc-app
     type: NodePort
     ports:
       - name: grpc
         port: 80
         targetPort: 8080
         protocol: TCP
         nodePort: 30085
   ```

1. Create an app:

   ```bash
   kubectl apply -f grpc-server.yaml
   ```


## Register your domain {#prepare-domain}

1. [Create](../../dns/operations/zone-create-public.md) a public DNS zone and delegate a domain.

   {% note info %}

   For the `example.com` domain, the zone must be named `example.com.` (with a trailing dot).

   {% endnote %}

1. [Add](../../certificate-manager/operations/managed/cert-create.md) a `Let's Encrypt®` [certificate](../../certificate-manager/concepts/managed-certificate.md).
1. [Check](../../certificate-manager/operations/managed/cert-validate.md) the rights for the domain.


## Install Ingress {#install-ingress}

1. Create an [Ingress](../../managed-kubernetes/alb-ref/ingress.md) resource manifest in the `ingress.yaml` file:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: grpc-demo
     annotations:
       ingress.alb.yc.io/subnets: <subnet_IDs>
       ingress.alb.yc.io/external-ipv4-address: auto 
       ingress.alb.yc.io/protocol: grpc
       ingress.alb.yc.io/security-groups: <security_group_ID>
   spec:
     tls:
       - hosts:
           - <website_name>
         secretName: yc-certmgr-cert-id-<certificate_ID> 
     rules:
       - host: <website_name>
         http:
           paths:
             - pathType: Prefix
               path: "/api.Adder/Add"
               backend:
                 service:
                   name: grpc-service
                   port:
                     number: 80
             - pathType: Prefix
               path: "/grpc.reflection.v1alpha.ServerReflection"
               backend:
                 service:
                   name: grpc-service
                   port:
                     number: 80
   ```

   Where:

   * `ingress.alb.yc.io/subnets`: List of comma-separated [subnet](../../vpc/concepts/network.md#subnet) IDs.
   * `ingress.alb.yc.io/external-ipv4-address`: Providing public access to {{ alb-name }} from the internet.

     If set to `auto`, the Ingress controller will get a [public IP address](../../vpc/concepts/address.md#public-addresses) automatically. Deleting the Ingress controller also deletes the IP address from the cloud.

   * `ingress.alb.yc.io/security-groups`: ID of the security group you created when [getting your cloud ready](#before-you-begin). If security groups are not enabled in your cloud, delete this annotation.
   * `secretName`: Reference to a [TLS certificate](../../certificate-manager/concepts/index.md) from [{{ certificate-manager-full-name }}](../../certificate-manager/) in `yc-certmgr-cert-id-<certificate_ID>` format.
   * `hosts`, `host`: Domain name mapping the TLS certificate.

   For more information, see [Ingress fields and annotations](../../managed-kubernetes/alb-ref/ingress.md).

1. Create an `Ingress` resource:

   ```bash
   kubectl apply -f ingress.yaml
   ```

1. Check that the resource was created and got a public IP address:

   ```bash
   kubectl get ingress grpc-demo
   ```

   Result:

   ```text
   NAME       CLASS   HOSTS        ADDRESS     PORTS    AGE
   grpc-demo  <none>  <website_name>  <IP_address>  80, 443  2m
   ```

   Where:

   * `<website_name>`: Domain name mapping the TLS certificate.
   * `<IP_address>`: IP address of the website.

   The IP address should appear in the `ADDRESS` column. Otherwise, the load balancer was not created or it was created with an error. Check the logs for the `yc-alb-ingress-controller-*` [pod](../../managed-kubernetes/concepts/index.md#pod).

1. If you have no [ExternalDNS with a plugin for {{ dns-name }}](/marketplace/products/yc/externaldns) installed, [create](../../dns/operations/resource-record-create.md) an [A record](../../dns/concepts/resource-record.md#a-a) in {{ dns-name }} pointing to the load balancer's public IP address. If you are using ExternalDNS with a plugin for {{ dns-name }}, this record will be created automatically.


## Configure horizontal pod autoscaling {#configure-autoscaling}

1. Create a file named `hpa.yaml` with the {{ k8s-hpa }} specification:

   ```yaml
   ### HPA.
   apiVersion: autoscaling/v2
   kind: HorizontalPodAutoscaler
   metadata:
     name: grpc-app
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: grpc-app
     minReplicas: 1
     maxReplicas: 10
     metrics:
       - type: External
         external:
         metric:
           name: "load_balancer.requests_count_per_second"
           selector:
             matchLabels:
               service: "application-load-balancer"
               load_balancer: <load_balancer_ID>
               code: "total"
               backend_group: <backend_group_IDs>
         target:
           type: AverageValue
           averageValue: 2
   ```

   Where:

   * `load_balancer`: L7 load balancer ID.
   * `backend_group`: [Backend group](../../application-load-balancer/concepts/backend-group.md) ID.

   You can find them in the {{ alb-name }} console or by running these commands:

   ```bash
   yc alb load-balancer list
   yc alb backend-group list
   ```

1. Create {{ k8s-hpa }}:

   ```bash
   kubectl apply -f hpa.yaml
   ```


## Load test the gRPC service {#load-testing}

1. Create a service account:

   1. [Create](../../iam/operations/sa/create.md) a service account named `sa-loadtest` in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) that will host the [agent](../../load-testing/concepts/agent.md) to generate the [load](../../load-testing/concepts/index.md).
   1. [Assign](../../iam/operations/roles/grant.md) [roles](../../iam/concepts/access-control/roles.md) to the service account:

      * `loadtesting.generatorClient`: Enables you to run agents and tests on agents and upload test results to the storage.
      * `compute.admin`: Enables you to manage a [VM](../../compute/concepts/vm.md) in [{{ compute-full-name }}](../../compute/).
      * `vpc.user`: Enables you to connect to [{{ vpc-full-name }}](../../vpc/) network resources and use them.

1. [Create and configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet hosting your test target and where the agent will reside. This will enable the agent to access [{{ load-testing-full-name }}](../../load-testing/).
1. [Create](../../load-testing/tutorials/loadtesting-grpc.md#create-agent) a test agent.
1. Prepare a file with [test data](../../load-testing/concepts/payload.md) named `ammo.json`:

   ```json
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   ```

1. Prepare the `load.yaml` configuration file:

   ```yaml
   phantom:
     enabled: false
     package: yandextank.plugins.Phantom
   pandora:
     enabled: true
     package: yandextank.plugins.Pandora
     config_content:
       pools:
       - id: Gun
         gun:
           type: grpc
           target: <your_website_name>:<port>
           tls: true
         ammo:
           type: grpc/json
           file: ammo.json
         result:
           type: phout
           destination: ./phout.log
         rps:
           - duration: 60s
             type: line
             from: 1
             to: 10
         startup:
           - type: once
             times: 1000
       log:
         level: debug
       monitoring:
         expvar:
         enabled: true
         port: 1234
   autostop:
       enabled: true
       package: yandextank.plugins.Autostop
       autostop:
         - limit (5m)
   uploader:
     enabled: true
     package: yandextank.plugins.DataUploader
     job_name: '[pandora][grpc][tls]'
     job_dsc: ''
     ver: ''
     api_address: loadtesting.{{ api-host }}:443
   ```

1. [Run the test](../../load-testing/tutorials/loadtesting-grpc.md#run-test):

   * Under **{{ ui-key.yacloud.load-testing.test-data-section }}**, click **{{ ui-key.yacloud_portal.component.file-input.button_choose-multiple }}** and select the previously saved `ammo.json` file.
   * Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

     * In the **{{ ui-key.yacloud.load-testing.field_settings-type }}** field, select `{{ ui-key.yacloud.load-testing.label_settings-type-config }}`.
     * In the **{{ ui-key.yacloud.load-testing.field_config-file }}** field, click **{{ ui-key.yacloud_portal.component.file-input.button_choose-multiple }}** and upload the `load.yaml` file you prepared.

1. Monitor the test:

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Select your {{ managed-k8s-name }} test cluster.
   1. Navigate to the **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** tab.
   1. Monitor the changes in the number of application pods as the load increases and decreases.
   1. After the test is complete, in the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Select the created L7 load balancer.
   1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. View the test load charts.

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. If you had set up [CNAME records](../../dns/concepts/resource-record.md#cname) in {{ dns-name }}, [delete the DNS zone](../../dns/operations/zone-delete.md).
1. [Delete the L7 load balancer](../../application-load-balancer/operations/application-load-balancer-delete.md).
1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete the route table](../../vpc/operations/delete-route-table.md).
1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
