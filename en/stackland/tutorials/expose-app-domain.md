# Setting up external access to a pod in a cluster

{{ stackland-name }} allows users to run their own applications in a cluster and create external access to them. In this guide, we will show you an example of creating external access to an HTML page in a cluster.

## Getting started {#before-begin}

1. If the project does not exist yet, create it: `kubectl create namespace <project_name>`.
1. Select a lin for external access, e.g., `test.{{ cluster-domain }}`.

    You can get the cluster domain using `kubectl get platformenvironments main -o jsonpath='{.status.clusterDomain}'`, if required.

## How to create external access {#how-to}

### Step 1: Create an ingress resource {#create-ingress}

1. Create a file of the `Ingress` resource, e.g., using the `touch ingress.yaml` command.
1. Open the file and paste the configuration below into it:

    {% include notitle [YAML-file](../_includes/yamls/tutorials/expose-app-domain/create-ingress.md) %}

1. Provide the following in the parameter:

    * `metadata.namespace`: Project name.
    * `spec.rules[0].host`: External access link.
    * `spec.tls[0].hosts[0]`: External access link.

1. Apply the `kubectl apply -f ingress.yaml` manifest.

### Step 2: Create an HTML page {#create-HTML}

1. Create a file of the `ConfigMap` resource, e.g., using the `touch configmap.yaml` command.
1. Open the file and paste the configuration below into it:

    {% include notitle [YAML-file](../_includes/yamls/tutorials/expose-app-domain/create-configmap.md) %}

1. Provide the project name in the `metadata.namespace` parameter.
1. Apply the manifest: `kubectl apply -f configmap.yaml`.

### Step 3: Create a deployment resource for the HTML page {#create-deployment}

1. Create a file of the `Deployment` resource, e.g., using the `touch deployment.yaml` command.
1. Open the file and paste the configuration below into it:

    {% include notitle [YAML-file](../_includes/yamls/tutorials/expose-app-domain/create-deployment.md) %}

1. Provide the project name in the `metadata.namespace` parameter.
1. Apply the manifest: `kubectl apply -f deployment.yaml`.

### Step 4: Create a service resource for the HTML page {#create-service}

1. Create a file of the `Service` resource, e.g., using the `touch service.yaml` command.
1. Open the file and paste the configuration below into it:

    {% include notitle [YAML-file](../_includes/yamls/tutorials/expose-app-domain/create-service.md) %}

1. Provide the project name in the `metadata.namespace` parameter.
1. Apply the manifest: `kubectl apply -f service.yaml`.

### Step 5: Test access {#check-access}

Use your web browser to open the external access link you selected. You should see the test HTML page there.
