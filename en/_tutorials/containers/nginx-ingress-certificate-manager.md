# Installing an NGINX Ingress controller with a {{ certificate-manager-full-name }} certificate

Manage the [TLS certificate](../../certificate-manager/concepts/index.md) for the NGINX Ingress controller via [{{ certificate-manager-full-name }}](../../certificate-manager/).

The [External Secrets Operator](https://external-secrets.io/v0.5.8/provider-yandex-certificate-manager/) syncs the certificate with the [{{ k8s }} secret](../../managed-kubernetes/concepts/encryption.md). This allows you to manage the deployed application's certificate through {{ certificate-manager-name }} by adding a self-signed certificate and updating it on your own or by issuing an automatically renewable Let's Encrypt® certificate.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Install the Helm package manager](https://helm.sh/docs/intro/install/).
1. Install the `jq` utility:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. [Create service accounts](../../iam/operations/sa/create.md):
   * `eso-service-account` for interaction between the External Secrets Operator and {{ certificate-manager-name }}.
   * `k8s-sa` with the `editor`, `container-registry.images.puller`, and `load-balancer.admin` [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) resources and pull [Docker images](../../container-registry/concepts/docker-image.md). The `load-balancer.admin` role is required to create a [network load balancer](../../network-load-balancer/concepts/index.md).
1. Create an [authorized key](../../iam/concepts/authorization/access-key.md) for the [service account](../../iam/concepts/users/service-accounts.md) and save it to a file named `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name eso-service-account \
     --output authorized-key.json
   ```

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. In the {{ managed-k8s-name }} cluster settings, specify the `k8s-sa` service account and the security groups prepared earlier.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Fee for using the [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master) and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using {{ managed-k8s-name }} cluster [nodes](../../managed-kubernetes/concepts/index.md#node-group) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using [public IPs](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for incoming traffic (processed by the load balancer) and using a [network load balancer](../../network-load-balancer/concepts/index.md) (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).

## Add a certificate to {{ certificate-manager-name }}

1. Issue a Let's Encrypt® certificate and [add](../../certificate-manager/operations/managed/cert-create.md) it to {{ certificate-manager-name }} or [upload](../../certificate-manager/operations/import/cert-create.md) your own certificate.
1. For a Let's Encrypt® certificate, have your [rights checked](../../certificate-manager/operations/managed/cert-validate.md) for the domain specified in the certificate.
1. Assign the `certificate-manager.certificates.downloader` [role](../../iam/concepts/access-control/roles.md) to the [service account](../../iam/concepts/users/service-accounts.md) named `eso-service-account` to enable it to read the content of the certificate:

   ```bash
   yc cm certificate add-access-binding \
     --id <certificate_ID> \
     --service-account-name eso-service-account \
     --role certificate-manager.certificates.downloader
   ```

1. Check that the rights have been granted:

   ```bash
   yc cm certificate list-access-bindings --id <certificate_ID>
   ```

   Result:

   ```text
   +---------------------------------------------+----------------+-------------------------------------+
   |                   ROLE ID                   |  SUBJECT TYPE  |              SUBJECT ID             |
   +---------------------------------------------+----------------+-------------------------------------+
   | certificate-manager.certificates.downloader | serviceAccount | <service_account_ID> |
   +---------------------------------------------+----------------+-------------------------------------+
   ```

## Install the External Secrets Operator {#install-eso}

{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

    Follow this [guide](../../managed-kubernetes/operations/applications/external-secrets-operator.md#marketplace-install) to install the [External Secrets Operator with {{ lockbox-name }} support](/marketplace/products/yc/external-secrets) from {{ marketplace-name }} with the following parameters:

    * **Namespace**: Create a new [namespace](../../managed-kubernetes/concepts/index.md#namespace), `external-secrets`.
    * **Service account key**: Paste the contents of the `authorized-key.json` file created [earlier](#before-you-begin).


- Manually {#manual}

    1. Add a Helm repository named `external-secrets`:

        ```bash
        helm repo add external-secrets https://charts.external-secrets.io
        ```

    1. Install the External Secrets Operator in the {{ managed-k8s-name }} cluster:

        ```bash
        helm install external-secrets \
          external-secrets/external-secrets \
          --namespace external-secrets \
          --create-namespace
        ```

        This command creates a new [namespace](../../managed-kubernetes/concepts/index.md#namespace) named `external-secrets` required for the External Secrets Operator.

        Result:

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

{% endlist %}

## Configure the {{ managed-k8s-name }} cluster {#configure-cluster}

1. Create a namespace named `ns` for External Secrets Operator objects:

   ```bash
   kubectl create namespace ns
   ```

1. Create a secret named `yc-auth` containing the [key](../../iam/concepts/authorization/key.md) of the service account named `eso-service-account`:

   ```bash
   kubectl --namespace ns create secret generic yc-auth \
     --from-file=authorized-key=authorized-key.json
   ```

1. Create a [secret storage (SecretStore)](https://external-secrets.io/v0.5.8/api-secretstore/) named `secret-store` containing the `yc-auth` secret:


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

1. Create an [ExternalSecret](https://external-secrets.io/v0.5.8/api-externalsecret/) object named `external-secret` referring to a certificate from {{ certificate-manager-name }}:

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
   * `k8s-secret`: Name of the secret the External Secret Operator will place the certificate it gets from {{ certificate-manager-name }} into.
   * `tls.crt`: Parameter of the `k8s-secret` secret to contain the certificate.
   * `tls.key`: Parameter of the `k8s-secret` secret to contain the certificate's private key.

   The following are the possible values for `property`:
   * `chain`: Get the certificate chain in PEM format.
   * `privateKey`: Get the private key in PEM format.
   * `chainAndPrivateKey` or null value: Get both the certificate chain and the private key.

   The External Secrets Operator will get a certificate from {{ certificate-manager-name }} and place it into `k8s-secret`.
1. Check that the certificate ends up in `k8s-secret`:

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

   To view the certificate in a user-friendly format, run the following commands:

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

{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

  Install the [Ingress NGINX](/marketplace/products/yc/ingress-nginx) application from {{ marketplace-name }} [using this guide](../../managed-kubernetes/operations/applications/ingress-nginx.md).

  The SSL certificate will only be available in the `ns` namespace, where the secret with this certificate was created. To allow Ingress to use this certificate in any namespace, add the `--default-ssl-certificate` parameter to the controller configuration:

  1. Run this command:

     ```bash
     kubectl edit deployment ingress-nginx-controller
     ```

  1. In the window that opens, add the `--default-ssl-certificate` parameter:

     ```bash
     spec:
       template:
         spec:
           containers:
           - args:
             - /nginx-ingress-controller
             ...
             - --default-ssl-certificate=ns/k8s-secret
     ```

  If you modify the `--default-ssl-certificate` parameter, restart the NGINX Ingress controller.


- Manually {#manual}

  1. Add the following to the Helm repository for NGINX:

     ```bash
     helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
     ```

     Result:

     ```text
     "ingress-nginx" has been added to your repositories
     ```

  1. Update the dataset to create an application instance in the {{ managed-k8s-name }} cluster:

     ```bash
     helm repo update
     ```

     Result:

     ```text
     Hang tight while we grab the latest from your chart repositories...
     ...Successfully got an update from the "ingress-nginx" chart repository
     Update Complete. ⎈Happy Helming!⎈
     ```

  1. Install the controller. It will be installed along with {{ network-load-balancer-name }}:

     ```bash
     helm install ingress-nginx ingress-nginx/ingress-nginx
     ```

     The SSL certificate will only be available in the `ns` namespace, where the secret with this certificate was created. To allow Ingress to use this certificate in any namespace, install the controller with the `default-ssl-certificate` parameter:

     ```bash
     helm install ingress-nginx ingress-nginx/ingress-nginx \
       --set controller.extraArgs.default-ssl-certificate="ns/k8s-secret"
     ```

     Result:

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

     If you modify the `default-ssl-certificate` parameter, restart the NGINX Ingress controller.

  To set up the controller configuration yourself, follow the guidelines provided in the [Helm documentation](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) and edit the [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml) file.

{% endlist %}

For specific port forwarding at NGINX Ingress controller installation, follow [this guide](../../managed-kubernetes/operations/create-load-balancer-with-ingress-nginx.md#port-forwarding).

## Create a web resource in your {{ managed-k8s-name }} cluster {#create-web-app}

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

   Result:

   ```text
   NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP     PORT(S)                     AGE
   ...
   ingress-nginx-controller  LoadBalancer  10.96.164.252  84.201.153.122  80:31248/TCP,443:31151/TCP  2m19s
   ...
   ```

1. Add an [A record](../../dns/concepts/resource-record.md#a-a) pointing to the Ingress controller's public IP to your DNS provider or to your own DNS server:

   ```bash
   <domain_name> IN A 84.201.153.122
   ```

{% note info %}

Registering the Let's Encrypt® certificate and an A record may take a few minutes.

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

Where `<domain_name>` is the name of the domain the certificate is issued for.

## Check resource availability {#check-service-availability}

Issue a GET request to the resource via HTTPS, for example, by this command:

```bash
curl https://<your_domain> -vv
```

Result example:

```text
* Trying 51.250.64.86:443...
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
* SSL certificate verify ok.
```

{% include [Configuring security groups if resource is unavailable](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

The Let's Encrypt® certificate must update automatically after the [certificate update](../../certificate-manager/operations/managed/cert-update.md) in {{ certificate-manager-name }}.

You can specify a sync timeout in the [ExternalSecret](#create-externalsecret) object's `refreshInterval` parameter.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. [Delete](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ managed-k8s-name }} cluster.
1. [Delete](../../network-load-balancer/operations/load-balancer-delete.md) {{ network-load-balancer-name }}.
1. [Delete](../../certificate-manager/operations/managed/cert-delete.md) the certificate.
1. If static public IP addresses were used for {{ managed-k8s-name }} cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.
