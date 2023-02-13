# Installing an NGINX Ingress controller with a Let's Encrypt® certificate manager

To use [{{ k8s }}](https://kubernetes.io) to create an [NGINX Ingress controller](https://kubernetes.github.io/ingress-nginx/) and protect it with a [Let's Encrypt®](https://letsencrypt.org/) certificate, follow these steps:
1. [{#T}](#install-controller).
1. [{#T}](#install-certs-manager).
1. [{#T}](#install-objects).
1. [{#T}](#connecting-certs-manager).
1. [{#T}](#test-controller).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `editor` and `container-registry.images.puller` [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../operations/node-group/node-group-create.md) in any suitable configuration.
1. [Configure cluster security groups and node groups](../operations/connect/security-groups.md).

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).
1. If you already have a certificate for the domain zone, [add information about it](../../certificate-manager/operations/import/cert-create.md) to the [{{ certificate-manager-full-name }}](../../certificate-manager/) service. Or [create a new Let's Encrypt® certificate](../../certificate-manager/operations/managed/cert-create.md).

## Install an NGINX Ingress controller using a Helm chart {#install-controller}

1. [Install the {{ k8s }} Helm package manager](https://helm.sh/docs/intro/install).
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the NGINX Ingress controller, run the command:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
   helm repo update && \
   helm install ingress-nginx ingress-nginx/ingress-nginx
   ```

The created controller will be installed behind [{{ network-load-balancer-full-name }}](../../network-load-balancer/).

To set up the controller configuration yourself, follow the instructions provided in the [Helm documentation](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) and edit the file named [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

## Install the certificate manager {#install-certs-manager}

1. Install the [latest version](https://github.com/jetstack/cert-manager/releases/) of the certificate manager configured to issue Let's Encrypt® certificates. For example, run the following command for version 1.9.1:

   ```bash
   kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.9.1/cert-manager.yaml
   ```

1. Make sure that the `cert-manager` namespace has three [pods](../concepts/index.md#pod), all of them being `1/1` ready and with the `Running` status:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Result:

   ```bash
   NAME                                      READY  STATUS   RESTARTS  AGE
   cert-manager-69cf79df7f-ghw6s             1/1    Running  0         54s
   cert-manager-cainjector-7648dc6696-gnrzz  1/1    Running  0         55s
   cert-manager-webhook-7746f64877-wz9bh     1/1    Running  0         54s
   ```

## Create objects {#install-objects}

To test the certificate manager, create `ClusterIssuer`, `Ingress`, `Service`, and `Deployment` objects.
1. Create the `acme-issuer.yaml` YAML file with the `ClusterIssuer` object manifest:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
     name: letsencrypt
     namespace: cert-manager
   spec:
     acme:
       server: https://acme-v02.api.letsencrypt.org/directory
       email: <your email>
       privateKeySecretRef:
         name: letsencrypt
       solvers:
       - http01:
           ingress:
             class: nginx
   ```

1. Create the `app.yaml` YAML file with the `Ingress`, `Service`, and `Deployment` object manifests:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: minimal-ingress
     annotations:
       kubernetes.io/ingress.class: "nginx"
       cert-manager.io/cluster-issuer: "letsencrypt"
   spec:
     tls:
       - hosts:
         - <your domain URL>
         secretName: letsencrypt
     rules:
       - host: <your domain URL>
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

1. Create objects in a {{ k8s }} cluster:

   ```bash
   kubectl apply -f acme-issuer.yaml && \
   kubectl apply -f app.yaml
   ```

## Configure a DNS record for the Ingress controller {#connecting-certs-manager}

1. Find out the [IP address](../../vpc/concepts/address.md) of the Ingress controller (the value in the `EXTERNAL-IP` column):

   ```bash
   kubectl get svc
   ```

   Result:

   ```bash
   NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP     PORT(S)                     AGE
   ...
   ingress-nginx-controller  LoadBalancer  10.96.164.252  84.201.153.122  80:31248/TCP,443:31151/TCP  2m19s
   ...
   ```

1. Host an A record with your DNS provider or on your own DNS server that will indicate the public IP address of the Ingress controller:

   ```text
   <your domain> IN A <Ingress controller IP>
   ```

{% note info %}

Registering the Let's Encrypt® certificate and an A record may take a few minutes.

{% endnote %}

## Test how TLS works {#test-controller}

```bash
curl https://<your domain>
```

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete the public domain zone](../../dns/operations/zone-delete.md).
1. [Delete the certificate](../../certificate-manager/operations/managed/cert-delete.md).