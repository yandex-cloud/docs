---
title: "How to create an NGINX Ingress controller and protect it with a Let's Encrypt® certificate in {{ managed-k8s-full-name }}"
description: "Follow this guide to create an NGINX Ingress controller and protect it with a Let's Encrypt® certificate."
---

# Installing an NGINX Ingress controller with a Let's Encrypt® certificate manager

To use [{{ k8s }}](https://kubernetes.io) to create an [NGINX Ingress controller](https://kubernetes.github.io/ingress-nginx/) and protect it with a certificate, follow these steps:
1. [{#T}](#install-controller)
1. [{#T}](#install-certs-manager)
1. [{#T}](#install-objects)
1. [{#T}](#connecting-certs-manager)
1. [{#T}](#test-controller)

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `editor`, `container-registry.images.puller`, and `load-balancer.admin` [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). The `load-balancer.admin` role is required to create a [network load balancer](../../network-load-balancer/concepts/index.md).
1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

   {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../operations/node-group/node-group-create.md) in any suitable configuration. In the cluster settings, specify the service account and the security groups created earlier.
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).
1. If you already have a certificate for the domain zone, [add its details](../../certificate-manager/operations/import/cert-create.md) to the [{{ certificate-manager-full-name }}](../../certificate-manager/) service. Alternatively, you can [add a new Let's Encrypt® certificate](../../certificate-manager/operations/managed/cert-create.md).
1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}

## Install an NGINX Ingress controller using a Helm chart {#install-controller}

1. [Install the {{ k8s }} Helm package manager](https://helm.sh/docs/intro/install).
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the NGINX Ingress controller, run this command:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
   helm repo update && \
   helm install ingress-nginx ingress-nginx/ingress-nginx
   ```

The created controller will be installed behind [{{ network-load-balancer-full-name }}](../../network-load-balancer/).

To set up the controller configuration yourself, follow the guidelines provided in the [Helm documentation](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) and edit the [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml) file.

For specific port forwarding at NGINX Ingress controller installation, follow [this guide](../operations/create-load-balancer-with-ingress-nginx.md#port-forwarding).

## Install the certificate manager {#install-certs-manager}

{% list tabs group=instructions %}

- {{ marketplace-full-name }} {#marketplace}

   Install the cert-manager app with the {{ dns-full-name }} ACME webhook plugin [by following the guide](../operations/applications/cert-manager-cloud-dns.md).

- Manually {#manual}

   1. Install the [latest version](https://github.com/cert-manager/cert-manager/releases) of the certificate manager configured to issue Let's Encrypt® certificates. For example, run the following command for version 1.21.1:

      ```bash
      kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
      ```

   1. Make sure that the `cert-manager` [namespace](../concepts/index.md#имен-namespace) has three [pods](../concepts/index.md#pod), all of them being `1/1` ready and with the `Running` status:

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

   1. Create the `acme-issuer.yaml` YAML file with the `ClusterIssuer` object manifest:

      ```yaml
      apiVersion: cert-manager.io/v1
      kind: ClusterIssuer
      metadata:
        name: yc-clusterissuer
        namespace: cert-manager
      spec:
        acme:
          server: https://acme-v02.api.letsencrypt.org/directory
          email: <your email address>
          privateKeySecretRef:
            name: domain-name-secret
          solvers:
          - http01:
              ingress:
                class: nginx
      ```

   1. Create an object in the {{ managed-k8s-name }} cluster:

      ```bash
      kubectl apply -f acme-issuer.yaml
      ```

{% endlist %}

## Create objects {#install-objects}

To test the certificate manager, create the `Ingress`, `Service`, and `Deployment` objects.
1. Create the `app.yaml` YAML file with the `Ingress`, `Service`, and `Deployment` object manifests:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: minimal-ingress
     annotations:
       kubernetes.io/ingress.class: "nginx"
       cert-manager.io/cluster-issuer: "yc-clusterissuer"
   spec:
     tls:
       - hosts:
         - <your_domain_URL>
         secretName: domain-name-secret
     rules:
       - host: <your_domain_URL>
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

## Configure a DNS record for the Ingress controller {#connecting-certs-manager}

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

1. Add an [A record](../../dns/concepts/resource-record.md#a-a) pointing to the Ingress controller's public IP to your DNS provider or to your own DNS server:

   ```text
   <your_domain> IN A <Ingress_controller_IP_address>
   ```

## Test how TLS works {#test-controller}

1. If you used a Let's Encrypt® certificate, make sure the [domain rights verification](../../certificate-manager/operations/managed/cert-validate.md) was successful and the certificate got the `Issued` status.

   ```bash
   kubectl describe certificate domain-name-secret
   ```

   {% include [cert-manager-events-explained](../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

   {% note info %}

   The verification of domain rights for a Let's Encrypt® certificate may take several hours.

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

   {% include [Configuring security groups if resource is unavailable](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete the public domain zone](../../dns/operations/zone-delete.md).
1. [Delete the certificate](../../certificate-manager/operations/managed/cert-delete.md).