Manage the TLS certificate for the NGINX Ingress controller via {{ certificate-manager-name }}.

The [External Secrets Operator](https://external-secrets.io/v0.5.8/provider-yandex-certificate-manager/) syncs the certificate with the [{{ k8s }} secret](../managed-kubernetes/concepts/encryption.md). This helps control the deployed application's certificate via {{ certificate-manager-name }} by importing a self-signed certificate and updating it on your own or by issuing a Let's Encrypt<sup>®</sup> certificate that will update automatically.

## Before you begin {#before-you-begin}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. [Install the Helm package manager]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/install/){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/install/){% endif %}.
1. Install the `jq` utility:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. [Create a service account](../iam/operations/sa/create.md) named `eso-service-account`. You'll need it to work with the External Secrets Operator.
1. Create an [authorized key](../iam/concepts/authorization/access-key.md) for the service account and save it to the file `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name eso-service-account \
     --output authorized-key.json
   ```

1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.

1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Using the master and outgoing {{ managed-k8s-name }} traffic (see [{{ managed-k8s-name }} pricing](../managed-kubernetes/pricing.md)).
* Using {{ managed-k8s-name }} cluster nodes (see [{{ compute-name }} pricing](../compute/pricing.md)).
* Using public IPs (see [{{ vpc-name }} pricing](../vpc/pricing.md)).
* Incoming traffic (processed by the load balancer) and using a network load balancer (see [{{ network-load-balancer-short-name }} pricing](../network-load-balancer/pricing.md)).

## Create a certificate in {{ certificate-manager-name }}

1. [Create](../certificate-manager/operations/managed/cert-create.md) a Let's Encrypt<sup>®</sup> certificate or import your own.
1. For the Let's Encrypt<sup>®</sup> certificate, have your [rights checked](../certificate-manager/operations/managed/cert-validate.md) for the domain named in the certificate.
1. Grant the `certificate-manager.certificates.downloader` role to the `eso-service-account` service account for it to be able to read the certificate contents:

   ```bash
   yc cm certificate add-access-binding \
     --id <certificate_ID> \
     --service-account-name eso-service-account \
     --role certificate-manager.certificates.downloader
   ```

1. Check to see that the rights have been granted:

   ```bash
   yc cm certificate list-access-bindings --id <certificate_ID>
   ```

   Command result:

   ```
   +---------------------------------------------+----------------+-------------------------------------+
   |                   ROLE ID                   |  SUBJECT TYPE  |              SUBJECT ID             |
   +---------------------------------------------+----------------+-------------------------------------+
   | certificate-manager.certificates.downloader | serviceAccount | <service_account_ID> |
   +---------------------------------------------+----------------+-------------------------------------+
   ```

## Install the External Secrets Operator {#install-eso}

1. Add a Helm repository named `external-secrets`:

   ```bash
   helm repo add external-secrets https://charts.external-secrets.io
   ```

1. Install the External Secrets Operator in the {{ k8s }} cluster:

   ```bash
   helm install external-secrets \
     external-secrets/external-secrets \
     --namespace external-secrets \
     --create-namespace
   ```

   This command creates a new `external-secrets namespace` required for using the External Secrets Operator.

   Command result:

   ```text
   NAME: external-secrets
   LAST DEPLOYED: Sun Sep 19 11:20:58 2021
   NAMESPACE: external-secrets
   STATUS: deployed
   REVISION: 1
   TEST SUITE: None
   NOTES:
   external-secrets has been deployed successfully!
   ...
   ```

## Configure the {{ k8s }} cluster {#configure-cluster}

1. Create a [namespace](../managed-kubernetes/concepts/index.md#namespace) called `ns` for External Secrets Operator objects:

   ```bash
   kubectl create namespace ns
   ```

1. Create a `yc-auth` secret with the `eso-service-account` key:

   ```
   kubectl --namespace ns create secret generic yc-auth \
     --from-file=authorized-key=authorized-key.json
   ```

1. Create a [SecretStore](https://external-secrets.io/v0.5.8/api-secretstore/) called `secret-store` containing a secret named `yc-auth`:

   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1beta1
   kind: SecretStore
   metadata:
     name: secret-store
   spec:
     provider:
       yandexcertificatemanager:
         auth:
           authorizedKeySecretRef:
             name: yc-auth
             key: authorized-key'
   ```

## Create an ExternalSecret {#create-externalsecret}

1. Create an [ExternalSecret](https://external-secrets.io/v0.5.8/api-externalsecret/) object named `external-secret` pointing to the certificate from {{ certificate-manager-name }}:

   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1beta1
   kind: ExternalSecret
   metadata:
     name: external-secret
   spec:
     refreshInterval: 1h
     secretStoreRef:
       name: secret-store
       kind: SecretStore
     target:
       name: k8s-secret
       template:
         type: kubernetes.io/tls
     data:
     - secretKey: tls.crt
       remoteRef:
         key: <certificate_ID>
         property: chain
     - secretKey: tls.key
       remoteRef:
         key: <certificate_ID>
         property: privateKey'
   ```

   Where:

   * `k8s-secret`: Name of the secret to be used by the External Secret Operator to contain the certificate from {{ certificate-manager-name }}.
   * `tls.crt`: Parameter of the `k8s-secret` secret that will contain the certificate.
   * `tls.key`: Parameter of the `k8s-secret` secret that will contain the certificate's private key.

   The following are the legal values of the `property` parameter:

   * `chain`: Retrieve a chain of certificates in PEM format.
   * `privateKey`: Retrieve the private key in PEM format.
   * `chainAndPrivateKey` or null value: Retrieve both the certificate chain and the private key.

   The External Secrets Operator will get a certificate from {{ certificate-manager-name }} and place it in the `k8s-secret` secret.

2. Make sure the certificate was placed in the `k8s-secret` secret:

   ```bash
   kubectl -n ns get secret k8s-secret -ojson \
     | jq '."data"."tls.crt"' -r \
     | base64 --decode
   ```

   Result example:

   ```text
   -----BEGIN CERTIFICATE-----
   MIIFKTCCBBGgAwIBAgISBAlQtxTUnXa75N1TnPYRWbSLMA0GCSqGSIb3DQEBCwUA
   MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
   EwJSMzAeFw0yMjA3MTMxNDMxNTVaFw0yMjEwMTExNDMxNTRaMB0xGzAZBgNVBAMT
   EmRkb3Mtd2ViLm5yay5tZS51azCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC…
   ```

To view the certificate in human-readable format, run the following commands:

```bash
kubectl -n ns get secret k8s-secret -ojson | jq '."data"."tls.crt"' -r \
  | base64 --decode > cert.pem
```

```bash
openssl x509 -in cert.pem -text
```

Result example:

```text
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            04:09:50:b7:14:d4:9d:76:bb:e4:dd:53:9c:f6:11:59:b4:8b
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C = US, O = Let's Encrypt, CN = R3
        Validity
            Not Before: Jul 13 14:31:55 2022 GMT
            Not After : Oct 11 14:31:54 2022 GMT
        Subject: CN = example.com
...
```

## Install the NGINX Ingress controller {#install-nginx-ingress}

1. Add a repository for NGINX to Helm:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   ```

   Command result:

   ```text
   "ingress-nginx" has been added to your repositories
   ```

1. Update the dataset to create an application instance in the {{ k8s }} cluster:

   ```bash
   helm repo update
   ```

   Command result:

   ```text
   Hang tight while we grab the latest from your chart repositories...
   ...Successfully got an update from the "ingress-nginx" chart repository
   Update Complete. ⎈Happy Helming!⎈
   ```

1. Install the controller in the standard configuration. The controller will be installed with {{ network-load-balancer-full-name }}:

   ```bash
   helm install ingress-nginx ingress-nginx/ingress-nginx
   ```

   Command result:

   ```text
   NAME: ingress-nginx
   LAST DEPLOYED: Sun Jul 18 22:35:37 2021
   NAMESPACE: default
   STATUS: deployed
   REVISION: 1
   TEST SUITE: None
   NOTES:
   The ingress-nginx controller has been installed.
   It may take a few minutes for the LoadBalancer IP to be available.
   You can watch the status by running 'kubectl --namespace default get services -o wide -w ingress-nginx-controller'
   ...
   ```

To be able to install the controller on your own, review the [Helm documentation](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) and edit the [file](https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml) `values.yaml`.

## Create a web resource in your cluster {#create-web-app}

Create a Deployment [object](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) with NGINX and its corresponding [service](https://kubernetes.io/docs/concepts/services-networking/service/):

```bash
kubectl --namespace ns apply -f - <<< '
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
        - containerPort: 80'
```

## Configure a DNS record for the Ingress controller {#configure-dns-record}

1. Find out the IP address of the Ingress controller (the value in the `EXTERNAL-IP` column):

   ```bash
   kubectl get svc
   ```

   Command result:

   ```text
   NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP     PORT(S)                     AGE
   ...
   ingress-nginx-controller  LoadBalancer  10.96.164.252  84.201.153.122  80:31248/TCP,443:31151/TCP  2m19s
   ...
   ```

1. Host an A record with your DNS provider or on your own DNS server that will indicate the public IP address of the Ingress controller:

   ```bash
   <domain_name> IN A 84.201.153.122
   ```

{% note info %}

Registering the Let's Encrypt<sup>®</sup> certificate and an A record may take a few minutes.

{% endnote %}

## Create an Ingress resource {#create-ingress}

Create an [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resource that uses the `k8s-secret` certificate for HTTPS:

```bash
kubectl --namespace ns apply -f - <<< '
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-test
  namespace: ns
spec:
  tls:
    - hosts:
      - <domain_name>
      secretName: k8s-secret
  ingressClassName: nginx
  rules:
    - host: <domain_name>
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: app
              port:
                number: 80'
```

Where `<domain_name>` is the name of the domain for which the certificate is issued.

## Check resource availability {#check-service-availability}

Send a GET request to the resource via HTTS, for example by using this command:

    ```bash
    curl <domain_name> -vv  
    ```

    Example output:

    ```text
    *   Trying 51.250.64.86:443...
    * Connected to <domain_name> (51.250.64.86) port 443 (#0)
    ...
    * SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
    * ALPN, server accepted to use h2
    * Server certificate:
    *  subject: CN=<domain_name>
    *  start date: Jul 13 14:31:55 2022 GMT
    *  expire date: Oct 11 14:31:54 2022 GMT
    *  subjectAltName: host "<domain_name>" matched cert's "<domain_name>"
    ...
    *  SSL certificate verify ok.
    ```

The Let's Encrypt<sup>®</sup> certificate must update automatically after the [certificate update](https://cloud.yandex.ru/docs/certificate-manager/operations/managed/cert-update) in {{ certificate-manager-name }}.

You can specify a sync timeout in the `refreshInterval` parameter of the [ExternalSecret](#create-externalsecret) object.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

1. [Delete](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ k8s }} cluster.
1. [Delete](../network-load-balancer/operations/load-balancer-delete.md) {{ network-load-balancer-short-name }}.
1. [Delete](../certificate-manager/operations/managed/cert-delete.md) the certificate.
1. If static public IP addresses were used for cluster and node access, release and [delete](../vpc/operations/address-delete.md) them.
