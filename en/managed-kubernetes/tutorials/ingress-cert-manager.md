# Installing the NGINX Ingress Controller with a Let's Encrypt<sup>®</sup> certificate manager

To use [{{ k8s }}](https://kubernetes.io/) to create the [NGINX Ingress Controller](https://www.nginx.com/products/nginx-ingress-controller/) and protect it with a [Let's Encrypt<sup>®</sup>](https://letsencrypt.org/) certificate, follow these steps.

## Before you start {#before-begin}

1. Install the {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl).

1. Install the {{ k8s }} [Helm 3](https://helm.sh/docs/intro/install/) package manager.

1. Add a repository for NGINX to Helm:

   {% list tabs %}

   - CLI

     Run the command:

     ```bash
     helm repo add nginx-stable https://helm.nginx.com/stable
     ```

     Command execution result:

     ```bash
     "nginx-stable" has been added to your repositories
     ```

   {% endlist %}

1. Update the dataset to create an application instance in the {{ k8s }} cluster:

   {% list tabs %}

   - CLI

     Run the command:

     ```bash
     helm repo update
     ```

     Command execution result:

     ```bash
     Hang tight while we grab the latest from your chart repositories...
     ...Successfully got an update from the "nginx-stable" chart repository
     Update Complete. ⎈Happy Helming!⎈
     ```

   {% endlist %}

## Install the NGINX Ingress Controller {#install-controller}

Install the controller in the standard configuration:

{% list tabs %}

- CLI

  Run the command:

  ```bash
  helm install nginx-ingress nginx-stable/nginx-ingress
  ```

  Command execution result:

  ```bash
  NAME: nginx-ingress
  LAST DEPLOYED: Thu Dec 10 18:33:28 2020
  NAMESPACE: default
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  NOTES:
  The NGINX Ingress Controller has been installed.
  ```

{% endlist %}

The created controller will be installed behind {{ network-load-balancer-full-name }}.

To set up the controller configuration yourself, follow the instructions provided in the [Helm documentation](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) and edit a file named [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

## Install the certificate manager {#install-certs-manager}

1. Install certificate manager v. 1.0.4 configured to issue Let's Encrypt<sup>®</sup> certificates (check for the latest version on the [project page](https://github.com/jetstack/cert-manager/releases/)):

   {% list tabs %}

   - CLI

     Run the command:

     ```bash
     kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.yaml
     ```

     Command execution result:

     ```bash
     customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
     ...
     validatingwebhookconfiguration.admissionregistration.k8s.io/cert-manager-webhook created
     ```

   {% endlist %}

1. Make sure that the `cert-manager` namespace has three pods, all of them being `1/1` ready and with the `Running` status:

   {% list tabs %}

   - CLI

     Run the command:

     ```bash
     kubectl get pods -n cert-manager
     ```

     Command execution result:

     ```bash
     NAME                                       READY   STATUS    RESTARTS   AGE
     cert-manager-69cf79df7f-ghw6s              1/1     Running   0          54s
     cert-manager-cainjector-7648dc6696-gnrzz   1/1     Running   0          55s
     cert-manager-webhook-7746f64877-wz9bh      1/1     Running   0          54s
     ```

   {% endlist %}

## Configure a DNS record for the Ingress controller {#connecting-certs-manager}

1. Get the controller's IP address:

   {% list tabs %}

   - CLI

     Run the command:

     ```bash
     kubectl get svc
     ```

     Command execution result:

     ```bash
     NAME                          TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                      AGE
     ...
     nginx-ingress-nginx-ingress    LoadBalancer   10.96.164.252   84.201.153.122   80:31248/TCP,443:31151/TCP   2m19s
     ...
     ```

   {% endlist %}

1. Host an A record with your DNS provider or on your own DNS server:

   ```bash
   <your domain> IN A 84.201.153.122
   ```

## Test the controller {#test-controller}

Test how TLS works:

{% list tabs %}

- CLI

  Run the command:

  ```bash
  curl https://<your domain>
  ```

{% endlist %}

