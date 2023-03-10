# Deploying and load testing a gRPC service with scaling

Use this tutorial to deploy an autoscalable gRPC service in a {{ managed-k8s-name }} cluster using an {{ alb-name }} Ingress controller to perform load testing of the service.

To deploy the service and perform load testing:

1. [Prepare your cloud](#prepare-cloud).
1. [Prepare a test target](#prepare-target).
1. [Prepare a domain](#prepare-domain).
1. [Install Ingress](#install-ingress).
1. [Configure horizontal pod autoscaling](#configure-autoscaling).
1. [Perform load testing of a gRPC service](#load-testing).

When testing is complete, [delete the created resources](#clear-out) if you no longer need them.

## Prepare your cloud {#prepare-cloud}

1. Register a domain name for your website.

1. If [security groups](../../vpc/concepts/security-groups.md) are enabled for your cloud, [create](../../vpc/operations/security-group-create.md) a group according to the rules described in [{#T}](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

   If security groups are not available in your cloud, all incoming and outgoing traffic will be enabled for the resources and no additional setup is required.

1. [Set up the {{managed-k8s-name}} cluster](../../managed-kubernetes/quickstart.md).

1. [Install Metrics Provider](../../managed-kubernetes/operations/applications/metrics-provider.md).

1. Install the Ingress controller:

   1. [Create](../../application-load-balancer/tools/k8s-ingress-controller/service-account.md) a service account for the Ingress controller.

   2. [Install](../../application-load-balancer/operations/k8s-ingress-controller-install.md) the {{alb-name}} Ingress controller for {{managed-k8s-name}}.


### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* A fee for using the master and outgoing {{managed-k8s-name}} traffic (see [Pricing for {{managed-k8s-name}}](../../managed-kubernetes/pricing.md)).
* A fee for using computing resources of the L7 load balancer (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* A fee for public DNS queries and DNS zones if you use {{ dns-full-name }} (see [{{ dns-name }} pricing](../../dns/pricing.md)).


## Prepare a test target {#prepare-target}

This instruction will use a gRPC service as a test target.

1. Save the following specification to create an application in the `grpc-server.yaml` file:

   ```
   ### Deployment
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

   ### Service
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

2. Create an application:

   ```
   kubectl apply -f grpc-server.yaml
   ```

## Prepare a domain {#prepare-domain}

1. [Create](../../dns/operations/zone-create-public) a public DNS zone and delegate the domain.

   {% note info %}

   For the domain example.com, the zone must be named `example.com.` (with a dot at the end)

   {% endnote %}

2. [Create](../../certificate-manager/operations/managed/cert-create.md) a `Let's Encrypt®` certificate.

3. [Check](../../certificate-manager/operations/managed/cert-validate.md) the rights for the domain.


## Install Ingress {#install-ingress}

1. Create an [Ingress](../../application-load-balancer/k8s-ref/ingress.md) resource manifest in the `ingress.yaml` file:

   ```
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

   * `ingress.alb.yc.io/subnets`: A list of comma-separated subnet IDs.
   * `ingress.alb.yc.io/security-groups`: ID of the security group created when [preparing your cloud](#prepare-cloud). If security groups are not enabled in your cloud, delete this annotation.
   * `secretName`: A reference to a TLS certificate from {{certificate-manager-full-name}} as `yc-certmgr-cert-id-<certificate ID>`.
   * `hosts`, `host`: The domain name the TLS certificate corresponds to.

   For more information, see [Ingress fields and annotations](../../application-load-balancer/k8s-ref/ingress).

2. Create an `Ingress` resource:

   ```
   kubectl apply -f ingress.yaml
   ```

3. Check that the resource was created and given a public IP address:

   ```
   kubectl get ingress grpc-demo
   ```

   Expected result:

   ```
   NAME        CLASS    HOSTS            ADDRESS         PORTS     AGE
   grpc-demo   <none>   <website_name>   <IP_address>    80, 443   2m
   ```

   Where:

   * `<website_name>` is the domain name the TLS certificate corresponds to.
   * `<IP address>` is the IP address of the website.

   The ADDRESS column must contain an IP address. Otherwise, the load balancer was not created or was created with an error. Check the logs for the `yc-alb-ingress-controller-*` pod.

4. In {{dns-name}}, [create](../../dns/operations/resource-record-create.md) an A record referring to the load balancer's public address.


## Configure horizontal pod autoscaling {#configure-autoscaling}

1. Create the `hpa.yaml` file with the {{k8s-hpa}} specification:

   ```
   ### HPA
   apiVersion: autoscaling/v2beta2
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

   * `load_balancer` is the L7 load balancer ID.
   * `backend_group` is the backend group ID.

   You can find them in the {{alb-name}} console or by running the commands:

   ```
   yc alb load-balancer list
   yc alb backend-group list
   ```

2. Create the {{k8s-hpa}}:

   ```
   kubectl apply -f hpa.yaml
   ```

## Perform load testing of the gRPC service {#load-testing}

1. Create a service account:
   1. [Create](../../iam/operations/sa/create.md) a `sa-loadtest` service account in the folder to host the agent that will generate the load.
   2. [Assign](../../iam/operations/roles/grant.md) a role to a service account.
      * `loadtesting.generatorClient`: Enables you to run agents and tests on agents and upload test results to the storage.
      * `compute.admin`: Enables you to manage a VM in {{compute-name}}.
      * `vpc.user`: Enables you to connect to {{vpc-name}} network resources and use them.

2. [Enable](../../vpc/operations/enable-nat.md) NAT to the internet on the subnet where the test target is and the agent will be located. This ensures the agent has access to {{load-testing-name}}.

3. [Create](../../load-testing/tutorials/loadtesting-grpc#create-agent.md) a test agent.

4. Prepare the `ammo.json` file with test data:

   ```
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   ```

5. Prepare the `load.yaml` configuration file:

   ```
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
           target: <your-site-name>:<port>
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
   uploader:
     enabled: true
     package: yandextank.plugins.DataUploader
     job_name: '[pandora][grpc][tls]'
     job_dsc: ''
     ver: ''
     api_address: loadtesting.{{ api-host }}:443
   ```

   Where:

   * `target` is the name of your website and port (for HTTPS: 443).

6. [Run a test](../../load-testing/tutorials/loadtesting-grpc#run-test):

   * Upload the `ammo.json` file to the **File with test data** field.
   * Upload the `load.yaml` file to the **Configuration file** field.

7. Monitor the test:

   1. In the [management console]({{ link-console-main }}), select {{managed-k8s-name}}.
   1. Select your test cluster.
   1. Go to the **Workload** tab.
   1. Monitor the change in the number of application pods as the load increases and decreases.
   1. After testing is complete, in the [management console]({{ link-console-main }}), select {{alb-name}}.
   1. Select the created L7 load balancer.
   1. Go to the **Monitoring** tab.
   1. View the test load chart.

## How to delete created resources {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. If you set up CNAME records in {{ dns-name }}, [delete](../../dns/operations/zone-delete.md) the DNS zone.
1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the L7 load balancer.
1. [Delete](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ managed-k8s-name }} cluster.
