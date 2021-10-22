# Configuring the {{ alb-name }} Ingress controller

[{{ alb-full-name }}](../../application-load-balancer/) is designed for load balancing and traffic distribution across applications. To use it for managing incoming traffic of applications running in a {{ managed-k8s-name }} cluster, you need an [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).

To set up access to the applications running in your cluster via the {{ alb-name }}:

1. [{#T}](#create-namespace-and-secret).
1. [{#T}](#install-alb).
1. [{#T}](#create-ingress-and-apps).
1. [{#T}](#verify-setup).

## Before you start {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Create](../../iam/operations/sa/create.md) a service account required for the Ingress controller to run.

    1. [Assign it the following roles](../../iam/operations/sa/assign-role-for-sa.md):

       * `alb.editor`: To create resources you need.
       * `certificate-manager.certificates.downloader`: To use certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).

    1. Create an [authorized key](../../iam/operations/sa/create-access-key.md) for the service account and save it to the `sa-key.json` file:

        ```text
        yc iam key create \
           --service-account-name <name of the service account for Ingress controller> \
           --output sa-key.json
        ```

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).

1. If you already have a certificate for the domain zone, [add information about it](../../certificate-manager/operations/import/cert-create.md) to the {{ certificate-manager-name }}. If not, [create a new Let's Encrypt certificate](../../certificate-manager/operations/managed/cert-create.md).

1. [Create a {{ managed-k8s-short-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) cluster with the following settings:

    * **Version {{ k8s }}**: 1.19 or higher.
    * **Public address**: `Auto`.

1. [Create a node group](../operations/node-group/node-group-create.md) in any suitable configuration with {{ k8s }} version 1.19 or higher.

1. Configure  [security groups](../../vpc/concepts/security-groups.md) for the cluster.

    [Add rules](../../vpc/operations/security-group-update.md#add-rule):

    {% cut "For incoming traffic" %}

    * For the load balancer:
        * Port range: `{{ port-any }}`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * Destination: `198.18.235.0/24` and `198.18.248.0/24`.

    * To transfer service traffic between the [master](../concepts/index.md#master) and nodes:
        * Port range: `{{ port-any }}`.
        * Protocol: `Any`.
        * Source type: `Security group`.
        * Security group: Current (`Self`).

    * To transfer traffic between [pods](../concepts/index.md#pod) and [services](../concepts/index.md#service):
        * Port range: `{{ port-any }}`.
        * Protocol: `Any`.
        * Source type: `CIDR`.
        * Destination: Specify the IP address ranges of the subnets created along with the cluster, such as:
            * `10.96.0.0/16`.
            * `10.112.0.0/16`.

    * To test the nodes using ICMP requests from the subnets within {{ yandex-cloud }}:
        * Protocol: `ICP`.
        * Source type: `CIDR`.
        * Destination: IP address ranges of the subnets within {{ yandex-cloud }} to perform cluster diagnostics from, such as:
            * `10.0.0.0/8`.
            * `192.168.0.0/16`.
            * `172.16.0.0/12`.

    * To access the {{ k8s }} API and manage the cluster using `kubectl`:
        * Ports: `{{ port-https }}`, and `6443`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * Destination: Specify the IP address range of the subnets that you'll manage the cluster from, such as:
            * `85.23.23.22/32`: For the external network.
            * `192.168.0.0/24`: For the internal network.

    * To access the services running on the nodes from the internet and subnets within {{ yandex-cloud }}:
        * Port range: `30000-32767`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * Destination: `0.0.0.0/0`.

    {% endcut %}

    {% cut "For outgoing traffic" %}

    To connect the cluster hosts to external resources (for example, to download images from Docker Hub or work with [{{ objstorage-full-name }}](../solutions/backup.md)):
    * Port range: `{{ port-any }}`.
    * Protocol: `Any`.
    * Source type: `CIDR`.
    * Destination: `0.0.0.0/0`.

    {% endcut %}

1. [Install the Helm](https://helm.sh/ru/docs/intro/install/) package manager.

1. [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [set it up for working with the cluster](../operations/kubernetes-cluster/kubernetes-cluster-get-credetials.md) created.

1. Check that you can connect to the cluster using `kubectl`:

    ```bash
    kubectl cluster-info
    ```

## Create a namespace and a secret for the {{ alb-name }} Ingress controller {#create-namespace-and-secret}

1. Create a [namespace](../concepts/index.md#namespace):

    ```bash
    kubectl create namespace yc-alb-ingress
    ```

1. Create a secret:

    ```bash
    kubectl create secret generic yc-alb-ingress-controller-sa-key \
            --namespace yc-alb-ingress \
            --from-file=sa-key.json
    ```

    Learn more about secrets in the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/configuration/secret/).

## Install the {{ alb-name }} Ingress controller {#install-alb}

To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/), run the commands:

```bash
export HELM_EXPERIMENTAL_OCI=1
helm chart pull cr.yandex/crpsjg1coh47p81vh2lc/yc-alb-ingress-controller-chart:v0.0.5
helm chart export cr.yandex/crpsjg1coh47p81vh2lc/yc-alb-ingress-controller-chart:v0.0.5
helm install \
     --namespace yc-alb-ingress \
     --set folderId=<folder ID> \
     --set clusterId=<cluster ID> \
     yc-alb-ingress-controller ./yc-alb-ingress-controller/
```

You can find out the cluster ID [in a list of clusters in the folder](../operations/kubernetes-cluster/kubernetes-cluster-list.md).

## Create an Ingress controller and test applications {#create-ingress-and-apps}

1. Get the ID of the [previously added](#before-you-begin) TLS certificate:

    {% list tabs %}

    * Management console

        1. Go to the folder page and select **{{ certificate-manager-name }}**.
        1. Click on the name of the certificate you need.

    * CLI

        Run the command:

        ```bash
        yc certificate-manager certificate list
        ```

        Command execution result:

        ```text
        +----------------------+-----------------+--------------------------------+---------------------+----------+--------+
        |          ID          |      NAME       |            DOMAINS             |      NOT AFTER      |   TYPE   | STATUS |
        +----------------------+-----------------+--------------------------------+---------------------+----------+--------+
        | <ID>                 | <name>          | <domain name>                  | 2022-01-06 17:19:37 | IMPORTED | ISSUED |
        +----------------------+-----------------+--------------------------------+---------------------+----------+--------+
        ```

    * API

        Use the [list](../../certificate-manager/api-ref/Certificate/list.md) API method: pass the ID of the required folder in the `folderId` request parameter.

    {% endlist %}

1. In a separate folder, create a file named `ingress.yaml` and specify the [previously delegated domain name](#before-you-begin) and certificate ID in it:

    ```yaml
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: alb-demo-tls
    spec:
      tls:
        - hosts:
            - <domain name>
          secretName: yc-certmgr-cert-id-<TLS certificate ID>
      rules:
        - host: <domain name>
          http:
            paths:
              - path: /app1
                pathType: Prefix
                backend:
                  service:
                    name: alb-demo-1
                    port:
                      number: 80
              - path: /app2
                pathType: Prefix
                backend:
                  service:
                    name: alb-demo-2
                    port:
                      number: 80
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: alb-demo-2
                    port:
                      number: 80
    ```

1. In the same folder, create `demo-app-1.yaml` and `demo-app-2.yaml` application files:

    {% cut "demo-app1.yaml" %}

    ```yaml
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: alb-demo-1
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
      name: alb-demo-1
      labels:
        app: alb-demo-1
        version: v1
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: alb-demo-1
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 1
          maxUnavailable: 0
      template:
        metadata:
          labels:
            app: alb-demo-1
            version: v1
        spec:
          terminationGracePeriodSeconds: 5
          volumes:
            - name: alb-demo-1
              configMap:
                name: alb-demo-1
    
          containers:
            - name: alb-demo-1
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
                - name: alb-demo-1
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
      name: alb-demo-1
    spec:
      selector:
        app: alb-demo-1
      type: NodePort
      ports:
        - name: http
          port: 80
          targetPort: 80
          protocol: TCP
          nodePort: 30081
    ```

    {% endcut %}

    {% cut "demo-app2.yaml" %}

    ```yaml
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: alb-demo-2
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
              return 200 'Add app#';
            }
            location = /app2 {
              add_header Content-Type text/plain;
              return 200 'This is APP#2';
            }
          }
        }
    
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: alb-demo-2
      labels:
        app: alb-demo-2
        version: v1
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: alb-demo-2
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 1
          maxUnavailable: 0
      template:
        metadata:
          labels:
            app: alb-demo-2
            version: v1
        spec:
          terminationGracePeriodSeconds: 5
          volumes:
            - name: alb-demo-2
              configMap:
                name: alb-demo-2
    
          containers:
            - name: alb-demo-2
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
                - name: alb-demo-2
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
      name: alb-demo-2
    spec:
      selector:
        app: alb-demo-2
      type: NodePort
      ports:
        - name: http
          port: 80
          targetPort: 80
          protocol: TCP
          nodePort: 30082
    ```

    {% endcut %}

1. To create an [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) and applications, run the command:

    ```bash
    kubectl apply -f .
    ```

1. Wait until the Ingress controller is created and assigned a public IP address. This may take several minutes:

    ```bash
    kubectl get ingress alb-demo-tls
    ```

    The expected result is a non-empty value in the `ADDRESS` field for the created Ingress controller:

    ```bash
    NAME           CLASS    HOSTS                  ADDRESS         PORTS     AGE
    alb-demo-tls   <none>   <domain name>          <IP address>    80, 443   15h
    ```

    Based on the Ingress controller configuration, an [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) is deployed automatically.

## Make sure the {{ k8s }} cluster applications are accessible through {{ alb-name }} {#verify-setup}

1. [Add an A record to your domain's zone](../../dns/operations/resource-record-create.md). In the **Value** field, specify the public IP address of the Ingress controller.
1. [Configure the load balancer's security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups).
1. Open the application URI in the browser:

    ```http
    https://<your domain>/app1
    https://<your domain>/app2
    ```

Make sure the applications are accessible via {{ alb-name }} and return pages with `This is APP#1` and `This is APP#2` text, respectively.
