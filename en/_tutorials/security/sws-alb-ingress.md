With [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md), you can protect apps in a {{ managed-k8s-full-name }} cluster from DDoS attacks and bots. To do this, publish your apps through an Ingress resource that has an assigned [security profile](../../smartwebsecurity/concepts/profiles.md) in {{ sws-name }} and uses the {{ alb-name }} Ingress controller.

Based on the Ingress resource, an L7 load balancer will be deployed with a security profile connected to the load balancer virtual hosts. {{ sws-name }} will be protecting the application backends specified in the Ingress resource: all HTTP requests to the backends [will be processed](../../smartwebsecurity/concepts/rules.md#rule-action) according to the security profile rules.

To create an L7 load balancer with a connected security profile using an Ingress:

1. [Install the {{ alb-name }} Ingress controller](#deploy-controller).
1. [Create a test application](#deploy-app).
1. [Create a security profile](#create-security-profile).
1. [Create an Ingress resource](#deploy-ingress).
1. [Create a DNS record for the domain](#create-dns-record).
1. [Check the result](#check-the-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for a DNS zone and DNS requests (see [{{ dns-name }} pricing](../../dns/pricing.md)).
* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using the computing resources of the L7 load balancer (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for public IP addresses for cluster nodes and L7 load balancer (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for the number of requests to {{ sws-name }} (see [{{ vpc-name }} pricing](../../smartwebsecurity/pricing.md)).


## Getting started {#before-you-begin}

1. Prepare the required infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a service account](../../iam/operations/sa/create.md) for the {{ alb-name }} Ingress controller to use.

            Assign the following [roles](../../application-load-balancer/operations/k8s-ingress-controller-install.md#before-you-begin) to the account for the folder to create the cluster in:

            * [alb.editor](../../application-load-balancer/security/index.md#alb-editor)
            * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin)
            * [compute.viewer](../../compute/security/index.md#compute-viewer)
            * [smart-web-security.editor](../../smartwebsecurity/security/index.md#smart-web-security-editor)

                {% note warning %}

                You will need this role to correctly integrate the {{ alb-name }} L7 load balancer with the security profile.

                {% endnote %}

        1. Create a service account for the cluster and node group to use.

            Assign the following [roles](../../managed-kubernetes/security/index.md#sa-annotation) to the account for the folder to create the cluster in:
            * [{{ roles.k8s.clusters.agent }}](../../managed-kubernetes/security/index.md#k8s-clusters-agent)
            * [{{ roles-vpc-public-admin }}](../../vpc/security/index.md#vpc-public-admin)

        1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

            {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        1. [Create a cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md). When creating a cluster, select:

            * Service account you created earlier to use for resources and nodes.
            * Security groups you created earlier to assign to the cluster.
            * Option for assigning a public address to the cluster. This address enables using the {{ k8s }} API from the internet.

        1. [Create a node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in the cluster. When creating the node group, select:

            * Security groups you created earlier to assign to the node group.
            * Option for assigning a public address to the nodes. This address enables downloading images from the internet.

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [alb-ready-k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-alb-mk8s-with-sws-profile/blob/main/alb-ready-k8s-cluster.tf) cluster configuration file to the same working directory. This file describes:
            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * {{ k8s }} cluster.
            * [Service account](../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and node group.
            * Service account required for the {{ alb-name }} Ingress controller.
            * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

                {% include [configure-sg-alb-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-tf.md) %}

                {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}
                
            * [Security profile](../../smartwebsecurity/concepts/profiles.md) in {{ sws-name }} with a [Smart Protection rule](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) and a simple rule to [test](#check-the-result) the profile; this rule will only allow traffic from a specific IP address.
              
              The default [basic rule](../../smartwebsecurity/concepts/rules.md#base-rules) is not specified in the manifest and is created automatically.

        1. Specify the following in the configuration file:

            * [Folder ID](../../resource-manager/operations/folder/get-id.md).
            * {{ k8s }} version for the {{ k8s }} cluster and node groups.
            * {{ k8s }} cluster CIDR; CIDR of services.
            * Name of the {{ managed-k8s-name }} cluster service account.
            * {{ alb-name }} service account name.
            * {{ sws-name }} security profile name.
            * IP address to allow traffic from.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}
            
        {% note info %}

        If you deployed the infrastructure with {{ TF }}, skip the [Creating a security profile](#create-security-profile) step.

        {% endnote %}

    {% endlist %}

1. Make sure you have a domain and you can manage resource records in the DNS zone for that domain. Your test app will be available through Ingress on this domain’s subdomain.

    If you do not have a domain yet, register one with any domain name registrar. To manage your domain’s resource records with {{ dns-full-name }}, [create a public DNS zone and delegate the domain](../../dns/operations/zone-create-public.md).

    {% note info %}

    In this example, we will use `example.com` as a domain and `demo.example.com` as its subdomain.

    Use your own domains as you go through this tutorial.

    {% endnote %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install the {{ alb-name }} Ingress controller {#deploy-controller}

1. [Install the {{ alb-name }} Ingress controller](../../application-load-balancer/operations/k8s-ingress-controller-install.md) to the `yc-alb` namespace.

    When installing it, specify the service account [you created earlier for the controller](#before-you-begin).

    Using the separate `yc-alb` namespace, you isolate the controller resources from those of your [test application](#deploy-app) and [Ingress](#deploy-ingress).

1. Make sure you successfully installed the controller:

    ```bash
    kubectl logs deployment.apps/yc-alb-ingress-controller -n yc-alb
    ```

    Logs should contain messages saying the Ingress controller successfully started.

    {% cut "Example of partial command result" %}

    ```text
    ...    INFO    Starting EventSource    {"controller": "ingressgroup", ...}
    ...    INFO    Starting Controller     {"controller": "ingressgroup"}
    ...    INFO    Starting EventSource    {"controller": "grpcbackendgroup", "controllerGroup": "alb.yc.io", ...}
    ...    INFO    Starting Controller     {"controller": "grpcbackendgroup", "controllerGroup": "alb.yc.io", ...}
    ...    INFO    Starting EventSource    {"controller": "httpbackendgroup", "controllerGroup": "alb.yc.io", ...}
    ...    INFO    Starting Controller     {"controller": "httpbackendgroup", "controllerGroup": "alb.yc.io", ...}

    ...

    ...    INFO    Starting workers        {"controller": "ingressgroup", ...}
    ...    INFO    Starting workers        {"controller": "grpcbackendgroup", "controllerGroup": "alb.yc.io", ...}
    ...    INFO    Starting workers        {"controller": "httpbackendgroup", "controllerGroup": "alb.yc.io", ...}
    ```

    {% endcut %}

## Create a test application {#deploy-app}

Create an application and an associated service for Ingress to expose:

1. Create a `demo-app1.yaml` manifest for deploying your application:

    {% cut "`demo-app1.yaml`" %}

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: demo-app1
      labels:
        tutorial: sws
    data:
      nginx.conf: |
        worker_processes auto;
        events {
        }
        http {
          server {
            listen 80 ;
            location = /_healthz {
              add_header Content-Type text/plain;
              return 200 'ok';
            }
            location / {
              add_header Content-Type text/plain;
              return 200 'Index';
            }
            location = /app1 {
              add_header Content-Type text/plain;
              return 200 'This is APP#1';
            }
          }
        }
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: demo-app1
      labels:
        app: demo-app1
        tutorial: sws
        version: v1
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: demo-app1
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 1
          maxUnavailable: 0
      template:
        metadata:
          labels:
            app: demo-app1
            version: v1
        spec:
          terminationGracePeriodSeconds: 5
          volumes:
            - name: demo-app1
              configMap:
                name: demo-app1
          containers:
            - name: demo-app1
              image: nginx:latest
              ports:
                - name: http
                  containerPort: 80
              livenessProbe:
                httpGet:
                  path: /_healthz
                  port: 80
                initialDelaySeconds: 3
                timeoutSeconds: 2
                failureThreshold: 2
              volumeMounts:
                - name: demo-app1
                  mountPath: /etc/nginx
                  readOnly: true
              resources:
                limits:
                  cpu: 250m
                  memory: 128Mi
                requests:
                  cpu: 100m
                  memory: 64Mi
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: demo-app1
      labels:
        tutorial: sws
    spec:
      selector:
        app: demo-app1
      type: NodePort
      ports:
        - name: http
          port: 80
          targetPort: 80
          protocol: TCP
    ```

    {% endcut %}

1. Deploy the application:

    ```bash
    kubectl apply -f demo-app1.yaml
    ```

    This will create the `ConfigMap`, `Deployment`, and `Service` objects for the `demo-app1` app.

1. Make sure all objects were successfully created:

    ```bash
    kubectl get configmap,deployment,svc -l tutorial=sws
    ```

    {% cut "Command result example" %}

    ```text
    NAME                  DATA   AGE
    configmap/demo-app1   1      ...

    NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-app1   2/2     2            2           ...

    NAME                TYPE       CLUSTER-IP   EXTERNAL-IP   PORT(S)      AGE
    service/demo-app1   NodePort   ...          <none>        80:.../TCP   ...
    ```

    {% endcut %}

## Create a security profile {#create-security-profile}

Create a security profile with a simple rule so you can easily [test](#check-the-result) the profile. The rules in the profile will only allow traffic from a specific IP address.

Create a security profile:

1. In the [management console]({{ link-console-main }}), select the folder you want to create a profile in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

    The profile will contain a number of preconfigured security rules:

    * [Smart Protection rule](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) providing full protection for all traffic. This rule takes priority over the default basic rule.
    * Default [basic rule](../../smartwebsecurity/concepts/rules.md#base-rules) denying all traffic that does not satisfy higher-priority rules.

        {% include [smart-protection-tip](../../_includes/smartwebsecurity/smart-protection-tip.md) %}

1. Set up the profile:

    * **{{ ui-key.yacloud.common.name }}**: Profile name, e.g., `test-sp1`.
    * **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}**: Action for the basic rule to effect.

        Leave `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` for the basic rule to deny all traffic.

1. Add a security rule:

    1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.

    1. Specify the main rule settings:

        * **{{ ui-key.yacloud.common.name }}**: Name for the rule, e.g., `test-rule1`.

        * **Priority**: Specify a value to give the rule priority over the preconfigured rules, e.g., `999800`.

            {% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

        * **Rule type**: Select `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.

        * **Action**: Select `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}`.

    1. Under **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**, configure the conditions to only allow traffic from a specific IP address:

        1. Select the traffic scope for the rule: `On condition`.
        1. Select the `IP` condition.
        1. For IP, select the condition: `Matches or falls within the range`.
        1. Specify a public IP address, e.g., `203.0.113.200`.

    1. Click **{{ ui-key.yacloud.common.add }}**.

    The new rule will appear in the list of security rules.

1. Click **{{ ui-key.yacloud.common.create }}**.

The new profile will appear in the list of security profiles. Write down the ID of your new security profile as you will need it later.

## Create an Ingress resource {#deploy-ingress}

This Ingress resource will describe the {{ alb-name }} parameters. The Ingress controller [you installed earlier](#deploy-controller) will deploy the load balancer with the specified parameters after the Ingress resource is created.

According to Ingress rules, traffic to the `demo.example.com` virtual host at the `/app1` path will be routed to the [service/demo-app1](#deploy-app) backend. The [security profile you created earlier](#create-security-profile) will be used to protect this backend.

To create an Ingress resource:

1. Create a file named `demo-ingress.yaml` with the Ingress resource description:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: demo-ingress
      annotations:
        ingress.alb.yc.io/subnets: "<list_of_subnet_IDs>"
        ingress.alb.yc.io/security-groups: "<security_group_ID>"
        ingress.alb.yc.io/external-ipv4-address: "auto"
        ingress.alb.yc.io/group-name: "demo-sws"
        ingress.alb.yc.io/security-profile-id: "<security_profile_ID>"
    spec:
      rules:
        - host: demo.example.com
          http:
            paths:
              - path: /app1
                pathType: Exact
                backend:
                  service:
                    name: demo-app1
                    port:
                      number: 80
    ```

    Where:

    * [ingress.alb.yc.io/subnets](../../application-load-balancer/k8s-ref/ingress.md#annot-subnets): List of IDs for subnets where the load balancer will reside.

        If you [have created the infrastructure using {{ TF }}](#before-you-begin), use the ID of the subnet named `subnet-a`.

    * [ingress.alb.yc.io/security-groups](../../application-load-balancer/k8s-ref/ingress.md#annot-security-groups): ID of the group [you created](#before-you-begin) for the load balancer.

        If you have created the infrastructure with {{ TF }}, specify the ID of the group named `alb-traffic`.

    * [ingress.alb.yc.io/security-profile-id](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id): ID of the [previously created](#create-security-profile) security profile from {{ sws-name }}.

        {% note info %}

        The security profile will only apply to the [virtual hosts](../../application-load-balancer/tools/k8s-ingress-controller/principles.md#mapping) of the Ingress resource in which the annotation is configured. For the Ingress resource described above, the profile will apply to a single virtual host, `demo.example.com`.

        This is the only Ingress resource in the `demo-sws` Ingress group. The security profile will not apply to virtual hosts of other Ingress resources if you add such resources to the group later.

     {% endnote %}

    To learn more about annotations, see [Ingress resource fields and annotations](../../application-load-balancer/k8s-ref/ingress.md).

1. Create an Ingress resource:

    ```bash
    kubectl apply -f demo-ingress.yaml
    ```

    The {{ alb-name }} Ingress controller will start creating target groups, backend groups, HTTP routers, and the load balancer.

1. Remember to regularly check the status of the Ingress resource until the `ADDRESS` column displays the load balancer IP address:

    ```bash
    kubectl get ingress demo-ingress
    ```

    This means the load balancer has been successfully created and can accept traffic.

    {% cut "Command result example" %}

    ```bash
    NAME             CLASS    HOSTS              ADDRESS         PORTS   AGE
    demo-ingress     <none>   demo.example.com   <IP_address>      80      ...
    ```

    {% endcut %}

### Create a DNS record for the domain {#create-dns-record}.

1. Create an A record for the `demo.example.com` domain in the `example.com` zone. Specify the IP address of the previously created load balancer in its value.

1. Wait until the DNS propagation is finished.

    To check that the propagation is successful, use relevant online tools or manual requests to different DNS servers:

    ```bash
    nslookup -type=a demo.example.com <DNS_server_IP_address>
    ```

## Check the result {#check-the-result}

Requests to the application deployed in the {{ k8s }} cluster go through an {{ alb-name }}. The virtual hosts to which those requests are directed are protected using the security profile. The profile [configuration](#create-security-profile) only allows traffic from a specific IP address, e.g., `203.0.113.200`.

Check that the load balancer works correctly given the security profile settings.

1. Use a host with an allowed IP address (`203.0.113.200`) to check that traffic is routed according to the rule defined in the Ingress resource:

    ```bash
    curl http://demo.example.com/app1
    ```

    Expected result:

    ```text
    This is demo-app1
    ```

1. Use a host with an IP address that is not on the list of allowed ones (e.g., `203.0.113.100`) to check that traffic is not routed:

    ```bash
    curl http://demo.example.com/app1
    ```

    The load balancer should return the [HTTP 403 Forbidden](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/403) code and a message saying access to the resource is restricted.

If traffic routing does not work as expected, make sure everything is configured correctly:

* The service account for the Ingress controller [must have the required roles](#before-you-begin) including those for using {{ sws-name }}.
* Make sure the security groups for the {{ managed-k8s-name }} cluster and its node groups [are configured correctly](../../managed-kubernetes/operations/connect/security-groups.md). If a rule is missing, [add it](../../vpc/operations/security-group-add-rule.md).
* The security profile [must be configured correctly](#create-security-profile) to allow traffic from the relevant address.

{% note tip %}

After confirming the profile works properly, add more rules if required.

{% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. Delete the Ingress resource you created:

    ```bash
    kubectl delete ingress demo-ingress
    ```

    This will delete the load balancer and the associated HTTP router.

    The {{ sws-name }} security profile will be disconnected from the virtual hosts specified in the Ingress resource.

1. Delete the {{ managed-k8s-name }} cluster and its associated infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        [Delete the {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) cluster.

        If you need to, delete the service account and security groups [created before you started](#before-you-begin).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
