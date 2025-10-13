# Installing the Gwin controller

Gwin is a tool for managing {{ alb-full-name }} in {{ managed-k8s-full-name }} clusters.

Follow this guide to install the Gwin controller in a {{ managed-k8s-full-name }} cluster. Based on the Ingress or Gateway API resource configurations, the controller automatically deploys an {{ alb-name }} that:

  * Automatically gets a dynamic public IP address.
  * Accepts HTTP traffic on port `80`.
  * Accepts HTTPS traffic on port `443` using a certificate in {{ certificate-manager-name }}.
  * Sends GET requests to a test service named `example-service`.

## Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for the {{ managed-k8s-name }} master (see [{{ managed-k8s-name }} pricing](../../../managed-kubernetes/pricing.md)).
* Fee for {{ managed-k8s-name }} cluster nodes, specifically using computing resources and storage (see [{{ compute-name }} pricing](../../../compute/pricing.md)).
* Fee for public IP addresses for {{ managed-k8s-name }} cluster hosts and {{ managed-k8s-name }} cluster nodes if public access is enabled for them (see [{{ vpc-name }} pricing](../../../vpc/pricing.md#prices-public-ip)).
* Fee for using the load balancer's computing resources (see [{{ alb-name }} pricing](../../../application-load-balancer/pricing.md)).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../cli-install.md) %}

   {% include [default-catalogue](../../default-catalogue.md) %}

1. {% include [configure-sg-manual](../security-groups/configure-sg-manual-lvl3.md) %}

   {% include [configure-sg-alb-manual](../security-groups/configure-sg-alb-manual.md) %}

   {% include [sg-common-warning](../security-groups/sg-common-warning.md) %}

1. [Create](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster. When creating it, specify the preconfigured security groups.

1. {% include [create-node-group](../../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. {% include [kubectl-install](../kubectl-install.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) the controller will use to create {{ alb-name }} resources and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the following roles for the folder:

   * [alb.editor](../../../application-load-balancer/security/index.md#alb-editor): To create the {{ alb-name }} resources.
   * [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin): To manage external network connectivity.
   * [certificate-manager.certificates.downloader](../../../certificate-manager/security/index.md#certificate-manager-certificates-downloader): If you use cloud certificates registered with [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * [certificate-manager.editor](../../../certificate-manager/security/index.md#certificate-manager.editor): If you use {{ managed-k8s-name }} cluster certificates. In this case, the controller creates the relevant cloud certificates.
   * [compute.viewer](../../../compute/security/index.md#compute-viewer): To use {{ managed-k8s-name }} cluster nodes in the L7 load balancer [target groups](../../../application-load-balancer/concepts/target-group.md).
   *  [k8s.viewer](../../../managed-kubernetes/security/index.md#k8s-viewer): To enable the controller to determine the network for deploying the L7 load balancer.
   * [smart-web-security.editor](../../../smartwebsecurity/security/index.md#smart-web-security-editor): To connect a {{ sws-full-name }} [profile](../../../smartwebsecurity/concepts/profiles.md) to an L7 load balancer's virtual host. This role is optional.

1. Create a service account [authorized access key](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) in JSON format and save it to the `sa-key.json` file:

    ```bash
    yc iam key create \
      --service-account-name <service_account_name> \
      --output sa-key.json
    ```

## Install Gwin using a Helm chart {#helm-install}

1. {% include [helm-install](../helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Gwin controller, run this command:

    ```bash
    helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gwin/gwin-chart \
      --version v1.0.0 \
      --untar \
    helm install \
      --namespace <namespace> \
      --create-namespace \
      --set controller.folderId=<folder_ID> \
      --set-file controller.ycServiceAccount.secret.value=./sa-key.json \
      gwin ./gwin-chart
    ```

      If you set `namespace` to its default, Gwin may work incorrectly. We recommend specifying a value different from all existing namespaces, e.g., `gwin-space`.

      You can get the folder ID with the [list of folders in the cloud](../../../resource-manager/operations/folder/get-id.md).

## Create a test app {#create-test-app}

To test the Gwin controller, create a test application named `example-app`:

1. Create a [custom certificate](../../../certificate-manager/concepts/imported-certificate.md) for your application's domain:

    ```bash
    openssl req -x509 -newkey rsa:4096 -keyout example-com.key -out example-com.crt -days 365 -nodes -subj \
    "/C=RU/ST=Moscow/L=Moscow/O=Example/OU=IT/CN=example.com"
    ```

    This command generates a self-signed certificate along with a matching private key. As a result, you will have two files:
    
      * `example-com.crt` with the certificate.
      * `example-com.key` with the private key.

1. Add the certificate to {{ certificate-manager-name }}:

    ```bash
    yc certificate-manager certificate create \
      --folder-id <folder_ID> \
      --name example-certificate \
      --chain example-com.crt \
      --key example-com.key
    ```

    Check the result and save the certificate ID (the `id` field):

    ```bash
    id: fpqmg47avvim********
    folder_id: b1g7gvsi89m3********
    created_at: "2020-09-15T06:54:44.916325Z"
    ...
    issued_at: "2020-09-15T06:54:44.916325Z"
    not_after: "2021-09-15T06:48:26Z"
    not_before: "2020-09-15T06:48:26Z"
    ```

1. Create a namespace for the app:

    ```bash
    kubectl create namespace example-ns
    ```

1. In a separate directory, create a configuration file named `example-app.yaml` for your application:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: example-deployment
      namespace: example-ns
      labels:
        app: example-app
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: example-app
      template:
        metadata:
          labels:
            app: example-app
        spec:
          containers:
          - name: nginx
            image: nginx:alpine
            ports:
            - containerPort: 80
            volumeMounts:
            - name: config-volume
              mountPath: /etc/nginx/conf.d
          volumes:
          - name: config-volume
            configMap:
              name: example-html
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: example-html
      namespace: example-ns
    data:
      default.conf: |
        server {
            listen 80;
            server_name _;
            
            location / {
                return 200 'Hello World';
                add_header Content-Type text/plain;
            }
        }
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: example-service
      namespace: example-ns
      labels:
        app: example-app
    spec:
      type: NodePort
      ports:
      - port: 80
        targetPort: 80
        nodePort: 30080
        protocol: TCP
        name: http
      selector:
        app: example-app
    ```

1. In the same directory, create a configuration file named `resources.yaml` for the Gateway API or Ingress resources:

    {% list tabs group=instructions %}

    - Gateway API {#gw}

      ```yaml
      apiVersion: gateway.networking.k8s.io/v1
      kind: Gateway
      metadata:
        name: example-gateway
        namespace: example-ns
      spec:
        gatewayClassName: gwin-default
        listeners:
          - name: http
            protocol: HTTP
            port: 80
            hostname: "example.com"
            allowedRoutes:
              namespaces:
                from: Same
          - name: https
            protocol: HTTPS
            port: 443
            hostname: "example.com"
            allowedRoutes:
              namespaces:
                from: Same
            tls:
              certificateRefs:
                - group: gwin.yandex.cloud
                  kind: YCCertificate
                  name: example-certificate
        addresses:
          - type: gwin.yandex.cloud/autoIPv4
            value: auto
      ---
      apiVersion: gateway.networking.k8s.io/v1
      kind: HTTPRoute
      metadata:
        name: example-redirect-httproute
        namespace: example-ns
      spec:
        hostnames:
          - "example.com"
        parentRefs:
          - name: example-gateway
            sectionName: http
        rules:
          - filters:
              - type: RequestRedirect
                requestRedirect:
                  scheme: https
                  statusCode: 301
      ---
      apiVersion: gateway.networking.k8s.io/v1
      kind: HTTPRoute
      metadata:
        name: example-httproute
        namespace: example-ns
      spec:
        hostnames:
          - "example.com"
        parentRefs:
          - name: example-gateway
            sectionName: https
        rules:
          - matches:
              - path:
                  value: /api
                  type: PathPrefix
                method: GET
            backendRefs:
              - kind: Service
                name: example-service
                port: 80
      ---
      apiVersion: gwin.yandex.cloud/v1
      kind: YCCertificate
      metadata:
        name: example-certificate
        namespace: example-ns
      spec:
        certificateRef:
          certificateID: "<certificate_ID>"
      ```

    - Ingress {#ingress}

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: example-ingress
        namespace: example-ns
        annotations:
          gwin.yandex.cloud/groupName: example
          gwin.yandex.cloud/externalIPv4Address: auto
          gwin.yandex.cloud/rules.allowedMethods: "GET"
      spec:
        ingressClassName: gwin-default
        rules:
          - host: example.com
            http:
              paths:
                - pathType: Prefix
                  path: "/api"
                  backend:
                    service:
                      name: example-service
                      port:
                        number: 80
        tls:
          - hosts:
              - example.com
            secretName: "yc-certmgr-cert-id-<certificate_ID>"
      ```

    {% endlist %}

    {% note info %}

    In our configuration examples, the load balancer is set up with a dynamic public IP address. Deleting the load balancer from the cloud will also delete its IP address. To avoid IP address changes in a production environment, [reserve](../../../vpc/operations/get-static-ip.md) and use a static IP address.

    {% endnote %}

1. Apply the configuration files:

    ```bash
    kubectl apply -f example-app.yaml && \
    kubectl apply -f resources.yaml
    ```

## Check the result

1. Make sure the {{ alb-name }} was created.

    {% list tabs group=instructions %}

    - Gateway API {#gw}

      1. Run this command:

          ```bash
          kubectl get gateway -n example-ns example-gateway
          ```

      1. Make sure the command outputs the load balancer's IP address in the `ADDRESS` field:

          ```bash
          NAME              CLASS           ADDRESS      PROGRAMMED      AGE
          example-gateway   gwin-default    <IP_address>                   32h
          ```

    - Ingress {#ingress}

      1. Run this command:

          ```bash
          kubectl get ingress -n example-ns example-ingress
          ```

      1. Make sure the command outputs the load balancer's IP address in the `ADDRESS` field:

          ```bash
          NAME              CLASS         HOSTS         ADDRESS       PORTS       AGE
          example-ingress   gwin-default  example.com   <IP_address>  80, 443     31h
          ```

    {% endlist %}

1. Make sure HTTP requests to the test application get redirected to HTTPS:

    ```bash
    curl -I <load_balancer_IP_address> -H "Host:example.com"
    ```

    Expected result:

    ```bash
    HTTP/1.1 301 Moved Permanently
    location: https://example.com:443/
    date: Sat, 06 Sep 2025 23:09:19 GMT
    server: ycalb
    transfer-encoding: chunked
    ```

1. Make sure the test application receives HTTPS requests:

    ```bash
    curl --resolve example.com:443:<load_balancer_IP_address> \
      --cacert example-com.crt \
      https://example.com/api/hello
    ```

    Expected result:

    ```bash
    Hello World
    ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ managed-k8s-name }} cluster.

1. [Delete](../../../application-load-balancer/operations/application-load-balancer-delete.md) the {{ alb-name }}:

