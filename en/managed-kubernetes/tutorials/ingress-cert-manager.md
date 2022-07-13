# Installing the NGINX Ingress Controller with a Let's Encrypt® certificate manager

To use [{{ k8s }}](https://kubernetes.io) to create an [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) and protect it with a [Let's Encrypt<sup>®</sup>](https://letsencrypt.org/) certificate, perform the following steps.

## Before you start {#before-begin}

1. Install the {{ k8s }} CLI [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl).
1. [Configure](../operations/kubernetes-cluster/kubernetes-cluster-get-credetials.md) kubectl.
1. Install the {{ k8s }} [Helm 3](https://helm.sh/docs/intro/install) package manager.
1. Add a repository for NGINX to Helm:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   ```

   Command output:

   ```bash
   "ingress-nginx" has been added to your repositories
   ```

1. Update the dataset to create an application instance in the {{ k8s }} cluster:

   ```bash
   helm repo update
   ```

   Command output:

   ```bash
   Hang tight while we grab the latest from your chart repositories...
   ...Successfully got an update from the "ingress-nginx" chart repository
   Update Complete. ⎈Happy Helming!⎈
   ```

## Install the NGINX Ingress Controller {#install-controller}

Install the controller in the standard configuration:

```bash
helm install ingress-nginx ingress-nginx/ingress-nginx
```

Command output:

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

To set up the controller configuration yourself, follow the instructions provided in the [Helm documentation](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) and edit a file named [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

## Install the certificate manager {#install-certs-manager}

1. Install certificate manager v. 1.6.1 configured to issue Let's Encrypt<sup>®</sup> certificates (check for the latest version on the [project page](https://github.com/jetstack/cert-manager/releases/)):

   ```bash
   kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.yaml
   ```

   Command output:

   ```bash
   customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
   ...
   validatingwebhookconfiguration.admissionregistration.k8s.io/cert-manager-webhook created
   ```

1. Make sure that the `cert-manager` namespace has three pods, all of them being `1/1` ready and with the `Running` status:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Command output:

   ```bash
   NAME                                       READY   STATUS    RESTARTS   AGE
   cert-manager-69cf79df7f-ghw6s              1/1     Running   0          54s
   cert-manager-cainjector-7648dc6696-gnrzz   1/1     Running   0          55s
   cert-manager-webhook-7746f64877-wz9bh      1/1     Running   0          54s
   ```

## Create an object {#install-objects}

To test the certificate manager, you must create ClusterIssuer, Ingress, Service, and Deployment.
1. Create a YAML file `acme-issuer.yaml` with the manifest of the `ClusterIssuer` object:

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

1. Create a YAML file `app.yaml` with the manifest objects `Ingress`, `Service` and `Deployment`:

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

1. Create an application in {{ k8s }} cluster:

   ```bash
   kubectl apply -f acme-issuer.yaml && \
   kubectl apply -f app.yaml
   ```

## Configure a DNS record for the Ingress controller {#connecting-certs-manager}

1. Get the controller's IP address:

   ```bash
   kubectl get svc
   ```

   Command output:

   ```bash
   NAME                          TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                      AGE
   ...
   nginx-ingress-nginx-ingress    LoadBalancer   10.96.164.252   84.201.153.122   80:31248/TCP,443:31151/TCP   2m19s
   ...
   ```

1. Host an A record with your DNS provider or on your own DNS server:

   ```bash
   <your domain> IN A 84.201.153.122
   ```

{% note info %}

It may take several minutes to register the Let's Encrypt<sup>®</sup> certificate and the A-record.

{% endnote %}

## Test the controller {#test-controller}

```bash
curl https://<your domain>
```

## Delete the resources you created {#clear-out}

If you no longer need these resources, [delete the cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.