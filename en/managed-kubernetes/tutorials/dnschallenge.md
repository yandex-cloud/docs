# Checking DNS Challenge for Let's Encrypt® certificates

To add an option to run DNS Challenge when issuing [Let's Encrypt® certificates](../../certificate-manager/concepts/managed-certificate.md):
1. [{#T}](#install-certs-manager).
1. [{#T}](#install-webhook).
1. [{#T}](#install-objects).
1. [{#T}](#check-result).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `dns.editor` [role](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create a [domain zone](../../dns/concepts/dns-zone.md).
1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../operations/node-group/node-group-create.md) in any suitable configuration.
1. [Configure cluster security groups and node groups](../operations/connect/security-groups.md).

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).
1. [Create an authorized key](../../iam/operations/authorized-key/create.md) for the [service account](../../iam/concepts/users/service-accounts.md) and save it to JSON file:

   ```bash
   yc iam key create \
     --service-account-name <name of the service account> \
     --format json \
     --output iamkey.json
   ```

1. Create the [cert-manager](../concepts/index.md#namespace) `namespace`:

   ```bash
   kubectl create namespace cert-manager
   ```

1. Create a [secret](../../certificate-manager/concepts/index.md#types) in the `cert-manager` namespae:

   ```bash
   kubectl create secret generic cert-manager-secret \
     --from-file=iamkey.json \
     --namespace=cert-manager
   ```

## Install the certificate manager {#install-certs-manager}

1. Install the certificate manager:

   ```bash
   kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
   ```

1. Make sure that the `cert-manager` namespace has three [pods](../concepts/index.md#pod), all of them being `1/1` ready and with the `Running` status:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Result:

   ```text
   NAME                                      READY  STATUS   RESTARTS  AGE
   cert-manager-69cf79df7f-ghw6s             1/1    Running  0         54s
   cert-manager-cainjector-7648dc6696-gnrzz  1/1    Running  0         55s
   cert-manager-webhook-7746f64877-wz9bh     1/1    Running  0         54s
   ```

## Install Webhook {#install-webhook}

1. {% include [k8s-ingress-controller-install-helm](../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with an NGINX Ingress Controller, run the command:

   ```bash
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git && \
   helm install -n cert-manager yandex-webhook \
     cert-manager-webhook-yandex/deploy/cert-manager-webhook-yandex
   ```

## Create test objects {#install-objects}

1. Create a file named `issuer.yaml` and add the `ClusterIssuer` object manifest to it:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
     name: clusterissuer
     namespace: default
   spec:
     acme:
       # You must replace this email address with your own.
       # Let's Encrypt will use this to contact you about expiring
       # certificates, and issues related to your account.
       email: <your email>
       server: https://acme-staging-v02.api.letsencrypt.org/directory
       privateKeySecretRef:
         # Secret resource that will be used to store the account's private key.
         name: secret-ref
       solvers:
         - dns01:
             webhook:
               config:
                 # ID of the folder where dns-zone is located
                 folder: <folder ID>
                 # This is the secret used to access the service account
                 serviceAccountSecretRef:
                   name: cert-manager-secret
                   key: iamkey.json
               groupName: acme.cloud.yandex.com
               solverName: yandex-cloud-dns
   ```

1. Create a file named `certificate.yaml`:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: example-com
     namespace: default
   spec:
     secretName: example-com-secret
     issuerRef:
       # The issuer created previously
       name: clusterissuer
       kind: ClusterIssuer
     dnsNames:
       - <domain name>
   ```

1. Create objects in a {{ managed-k8s-name }} cluster:

   ```bash
   kubectl apply -f issuer.yaml && \
   kubectl apply -f certificate.yaml
   ```

## Check the results {#check-result}

To make sure that the certificate is in the `READY` status, run the command:

```bash
kubectl get certificate example-com
```

Result:

```text
NAME         READY  SECRET              AGE
example-com  True   example-com-secret  24h
```

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete the public domain zone](../../dns/operations/zone-delete.md).
1. [Delete the service account](../../iam/operations/sa/delete.md).