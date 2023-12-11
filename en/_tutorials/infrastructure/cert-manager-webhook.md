# Creating an ACME resolver webhook for responses to DNS01 checks

To pass checks for [domain rights](../../certificate-manager/concepts/challenges.md) automatically using the [cert-manager](https://cert-manager.io/docs/) utility, add a webhook with a DNS01 resolver to the utility configuration.

Below is an example of creating a `ClusterIssuer` object with a DNS01 resolver webhook for a domain registered in {{ dns-full-name }}.

To run a webhook in a {{ managed-k8s-name }} cluster:

1. [Install a webhook](#install-yandex-webhook).
1. [Prepare configuration files](#prepare-files).
1. [Run a certificate manager with the webhook](#run-webhook).

## Getting started {#before-you-begin}

1. [Set up the {{ managed-k8s-name }} cluster](../../managed-kubernetes/quickstart.md).
1. [Install the certificate manager](../../managed-kubernetes/tutorials/ingress-cert-manager.md#install-certs-manager) of the latest version.
1. [Install the Helm package manager](https://helm.sh/docs/intro/install/).
1. [Configure the CLI](../../cli/operations/authentication/service-account.md) to work on behalf of a service account.

## Install a webhook {#install-yandex-webhook}

1. Clone the webhook's repository:

   ```
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git
   ```

1. Install the webhook using Helm:

   ```
   helm install -n cert-manager yandex-webhook ./deploy/cert-manager-webhook-yandex
   ```

## Prepare configuration files {#prepare-files}

1. Create an [authorized key](../../iam/operations/sa/create-access-key.md) and save it to a file named `iamkey.json`:

   ```
   yc iam key create iamkey \
       --service-account-id=<your service account ID> \
       --format=json \
       --output=iamkey.json
   ```

   {% note warning %}

   The service account must have the `dns.editor` role in the folder with the public zone.

   {% endnote %}

1. Create a secret with the key of the service account:

   ```
   kubectl create secret generic cert-manager-secret --from-file=iamkey.json -n cert-manager
   ```

1. Create a file named `cluster-issuer.yml` with the `ClusterIssuer` object manifest:

   ```
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
     email: your@email.com
     server: https://acme-v02.api.letsencrypt.org/directory
     privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: secret-ref
     solvers:
      - dns01:
         webhook:
           config:
             # The ID of the folder where dns-zone located in
             folder: <your folder ID>
             # This is the secret used to access the service account
             serviceAccountSecretRef:
               name: cert-manager-secret
               key: iamkey.json
           groupName: acme.cloud.yandex.com
           solverName: yandex-cloud-dns
   ```

1. Create a file named `cluster-certificate.yml` with the `Certificate` object manifest:

   ```
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
    name: your-site-com
    namespace: default
   spec:
    secretName: example-com-secret
    issuerRef:
     # The issuer created previously
     name: clusterissuer
     kind: ClusterIssuer
    dnsNames:
      - your-site.com
   ```

## Run the certificate manager with the webhook {#run-webhook}

1. Create objects in a Kubernetes cluster:

   ```
   kubectl apply -f cluster-issuer.yml && \
   kubectl apply -f cluster-certificate.yaml
   ```

2. Check that the webhook is running:

   ```
   kubectl get pods -n cert-manager –watch
   ```

   Make sure the records contain the ACME webhook for {{ dns-full-name }}:

   ```
   NAME                                                         READY   STATUS    RESTARTS   AGE
   ...
   yandex-webhook-cert-manager-webhook-yandex-5578cfb98-tw4mq   1/1     Running   1          43h
   ```

## Delete the resources you created {#clear-out}

If you no longer need the resources you created, [delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
