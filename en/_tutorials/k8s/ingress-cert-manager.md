# Installing an NGINX Ingress controller with a {{ lets-encrypt }} certificate manager

To use [{{ k8s }}](https://kubernetes.io) to create an [NGINX Ingress controller](https://kubernetes.github.io/ingress-nginx/) and protect it with a certificate, follow these steps:

1. [Install the NGINX Ingress controller](#install-controller).
1. [Configure a DNS record for the Ingress controller](#connecting-certs-manager).
1. [Install the certificate manager](#install-certs-manager).
1. [Create a ClusterIssuer](#create-issuer).
1. [Create objects to test cert-manager](#install-objects).
1. [Test TLS](#test-controller).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for a DNS zone and DNS requests (see [{{ dns-name }} pricing](../../dns/pricing.md)).
* Fee for using the master and outbound traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for an NLB (see [{{ network-load-balancer-name }} pricing](../../network-load-balancer/pricing.md)).
* Fee for public IP addresses, if assigned to cluster nodes, and a public IP address for an NLB (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `load-balancer.admin` [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). The `load-balancer.admin` role is required to create a [network load balancer](../../network-load-balancer/concepts/index.md).
1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [configure-cert-manager](../../_includes/managed-kubernetes/security-groups/configure-cert-manager.md) %}
1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. In the cluster settings, specify the service account and the security groups created earlier.
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).


1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}


## Install the NGINX Ingress Controller {#install-controller}

{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

  Install [Ingress NGINX](/marketplace/products/yc/ingress-nginx) from {{ marketplace-name }} by following [this guide](../../managed-kubernetes/operations/applications/ingress-nginx.md).


- Manually {#manual}

  1. [Install the {{ k8s }} Helm package manager](https://helm.sh/docs/intro/install).
  1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the NGINX Ingress controller, run this command:

     ```bash
     helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
     helm repo update && \
     helm install ingress-nginx ingress-nginx/ingress-nginx
     ```

  The created controller will be installed behind [{{ network-load-balancer-full-name }}](../../network-load-balancer/).

  To set up the controller configuration yourself, follow the guidelines provided in the [Helm documentation](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) and edit the [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml) file.

{% endlist %}

For configure specific port forwarding during NGINX Ingress Controller installation, follow [this guide](../../managed-kubernetes/operations/create-load-balancer-with-ingress-nginx.md#port-forwarding).

## Configure a DNS record for the ingress controller {#connecting-certs-manager}

If you are using [ExternalDNS with a plugin for {{ dns-name }}](/marketplace/products/yc/externaldns), you do not need to configure a DNS record: it is created automatically. Otherwise:
1. Find out the [IP address](../../vpc/concepts/address.md) of the Ingress controller (the value in the `EXTERNAL-IP` column):

   ```bash
   kubectl get svc
   ```

   Result:

   ```text
   NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP     PORT(S)                     AGE
   ...
   ingress-nginx-controller  LoadBalancer  10.96.164.252  84.201.153.122  80:31248/TCP,443:31151/TCP  2m19s
   ...
   ```

1. Add an [A record](../../dns/concepts/resource-record.md#a) pointing to the ingress controller's public IP to your DNS provider or to your own DNS server:

   ```text
   <your_domain> IN A <Ingress_controller_IP_address>
   ```

## Install the certificate manager {#install-certs-manager}


You can install the certificate manager in one of the following ways:
* Using [{{ marketplace-full-name }}](../../marketplace/): To install cert-manager [integrated with {{ dns-name }}](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).

  This will create in the cluster a `ClusterIssuer` object configured to pass the [DNS-01 challenge](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge) using {{ dns-name }}.

  If required, you can manually create and configure other objects: `Issuer` or `ClusterIssuer`. For more information about these objects, see the [cert-manager documentation](https://cert-manager.io/docs/configuration/).
* Manually: To install cert-manager with no additional integrations.

  You will need to create and configure any `Issuer` and `ClusterIssuer` objects manually.


{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

  Install the cert-manager app with the {{ dns-name }} ACME webhook plugin [by following this guide](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).


- Manually {#manual}

  1. Install the [latest version](https://github.com/cert-manager/cert-manager/releases) of cert-manager. For example, run the following command for version 1.21.1:

     ```bash
     kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
     ```

  1. Make sure the `cert-manager` [namespace](../../managed-kubernetes/concepts/index.md#namespace) has three [pods](../../managed-kubernetes/concepts/index.md#pod), all of them being `1/1` ready and with the `Running` status:

     ```bash
     kubectl get pods -n cert-manager --watch
     ```

     Result:

     ```text
     NAME                                      READY  STATUS   RESTARTS  AGE
     cert-manager-69********-ghw6s             1/1    Running  0         54s
     cert-manager-cainjector-76********-gnrzz  1/1    Running  0         55s
     cert-manager-webhook-77********-wz9bh     1/1    Running  0         54s
     ```

{% endlist %}

## Create a ClusterIssuer {#create-issuer}

Create a [ClusterIssuer](https://cert-manager.io/docs/configuration/) object you can use to issue {{ lets-encrypt }} certificates.

Certificates will be issued after you pass the [HTTP-01 challenge](https://letsencrypt.org/docs/challenge-types/#http-01-challenge) using the Ingress controller you [installed earlier](#install-controller).

Create an object with the required parameters:

1. Create the `http01-clusterissuer.yaml` file with the object manifest:

    ```yaml
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: http01-clusterissuer
    spec:
      acme:
        server: https://acme-v02.api.letsencrypt.org/directory
        email: <your_email>
        privateKeySecretRef:
          name: http01-clusterissuer-secret
        solvers:
        - http01:
            ingress:
              class: nginx
    ```

1. Create an object in the {{ managed-k8s-name }} cluster:

    ```bash
    kubectl apply -f http01-clusterissuer.yaml
    ```

## Create objects to test cert-manager {#install-objects}

To test the certificate manager, create the `Ingress`, `Service`, and `Deployment` objects:

1. Create the `app.yaml` file with manifests for the `Ingress`, `Service`, and `Deployment` objects:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: minimal-ingress
     annotations:
       cert-manager.io/cluster-issuer: "http01-clusterissuer"
   spec:
     ingressClassName: nginx
     tls:
       - hosts:
         - <your_domain_URL_address>
         secretName: domain-name-secret
     rules:
       - host: <your_domain_URL_address>
         http:
           paths:
           - path: /
             pathType: Prefix
             backend:
               service:
                 name: app
                 port:
                   number: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: app
   spec:
     selector:
       app: app
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: app-deployment
     labels:
       app: app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: app
     template:
       metadata:
         labels:
           app: app
       spec:
         containers:
         - name: app
           image: nginx:latest
           ports:
           - containerPort: 80
   ```

1. Create objects in a {{ managed-k8s-name }} cluster:

   ```bash
   kubectl apply -f app.yaml
   ```

## Test TLS {#test-controller}

1. Make sure the [domain rights verification](../../certificate-manager/operations/managed/cert-validate.md) was successful and the certificate has changed its status to `Issued`:

   ```bash
   kubectl describe certificate domain-name-secret
   ```

   {% include [cert-manager-events-explained](../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

   {% note info %}

   The verification of domain rights for a {{ lets-encrypt }} certificate may take several hours.

   {% endnote %}

1. Run this command:

   ```bash
   curl https://<your_domain>
   ```

   Result:

   ```text
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   <style>
   html { color-scheme: light dark; }
   body { width: 35em; margin: 0 auto;
   font-family: Tahoma, Verdana, Arial, sans-serif; }
   </style>
   </head>
   <body>
   <h1>Welcome to nginx!</h1>
   <p>If you see this page, the nginx web server is successfully installed and
   working. Further configuration is required.</p>

   <p>For online documentation and support please refer to
   <a href="http://nginx.org/">nginx.org</a>.<br/>
   Commercial support is available at
   <a href="http://nginx.com/">nginx.com</a>.</p>

   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>
   ```

   {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid unnecessary charges, delete the resources you no longer need:
1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete the public domain zone](../../dns/operations/zone-delete.md).
