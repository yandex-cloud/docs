# Installing the NGINX Ingress Controller with a Let's Encrypt® certificates manager

To create [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) using [{{ k8s }}]{% if lang == "ru" %}(https://kubernetes.io/ru/){% endif %}{% if lang == "en" %}(https://kubernetes.io){% endif %} and protect it with a [Let's Encrypt®]{% if lang == "ru" %}(https://letsencrypt.org/ru/){% endif %}{% if lang == "en" %}(https://letsencrypt.org/){% endif %} certificate, follow these steps.

## Before you begin {#before-begin}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the {{ k8s }} [Helm 3]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/install){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/install){% endif %} package manager.
1. Add a repository for NGINX to Helm:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   ```

   Result:

   ```text
   "ingress-nginx" has been added to your repositories
   ```

1. Update the dataset to create an application instance in the {{ k8s }} cluster:

   ```bash
   helm repo update
   ```

   Result:

   ```text
   Hang tight while we grab the latest from your chart repositories...
   ...Successfully got an update from the "ingress-nginx" chart repository
   Update Complete. ⎈Happy Helming!⎈
   ```

## Install the NGINX Ingress Controller {#install-controller}

Install the controller in the standard configuration:

```bash
helm install ingress-nginx ingress-nginx/ingress-nginx
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

The created controller will be installed behind {{ network-load-balancer-full-name }}.

To set up the controller configuration yourself, follow the instructions provided in the [Helm documentation]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/using_helm/#настройка-chart-а-перед-установкой){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing){% endif %} and edit the file named [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

## Install the certificate manager {#install-certs-manager}

1. Install certificate manager v. 1.6.1 configured to issue Let's Encrypt<sup>®</sup> certificates (check for the latest version on the [project page](https://github.com/jetstack/cert-manager/releases/)):

   ```bash
   kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml
   ```

   Result:

   ```bash
   customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
   ...
   validatingwebhookconfiguration.admissionregistration.k8s.io/cert-manager-webhook created
   ```

1. Make sure that the `cert-manager` namespace has three pods, all of them being `1/1` ready and with the `Running` status:

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

To test the certificate manager, create the ClusterIssuer, Ingress, Service, and Deployment objects.
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

1. Find out the IP address of the Ingress controller (the value in the `EXTERNAL-IP` column):

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

   ```bash
   <your domain> IN A 84.201.153.122
   ```

{% note info %}

Registering the Let's Encrypt<sup>®</sup> certificate and an A record may take a few minutes.

{% endnote %}

## Test how TLS works {#test-controller}

```bash
curl https://<your domain>
```

## Delete the resources you created {#clear-out}

If you no longer need these resources, [delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).