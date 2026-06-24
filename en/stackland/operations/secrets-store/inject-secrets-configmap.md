# Secret injection via ConfigMap (ConfigMap mode)

This guide explains how to configure secret injection from Secrets Store into configuration files using ConfigMap mode in Secrets Injector.

In ConfigMap mode, the injector runs as an init container. It processes the pod's ConfigMap, replaces secret references with actual values, and writes the resulting files to the `/secrets` directory. The main container then reads the fully populated configuration files from this location.

## Getting started {#before-you-begin}

1. Make sure the Secrets Store component is [installed and active](../../concepts/components/secrets-store.md) in the cluster.
1. In Secrets Store, secrets required by your application are already created.

## Create a namespace and ServiceAccount {#create-sa}

Create a namespace for your application (if not already created):

```bash
kubectl create namespace myapp-namespace
```

Create a ServiceAccount:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: myapp-sa
  namespace: myapp-namespace
```

```bash
kubectl apply -f serviceaccount.yaml
```

## Configure a role in Secrets Store {#configure-role}

[Configure a Secrets Store role](../../concepts/components/secrets-store.md#openbao-role) with access to the required paths and bind it to the created ServiceAccount.

## Create a ConfigMap with secret references {#create-configmap}

In the ConfigMap key values, specify secret references in `secrets:<path>#<key>` format.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: myapp-namespace
data:
  database.yaml: |
    host: postgres.example.com
    port: 5432
    username: myapp
    password: secrets:secret/data/myapp/database#password
  app.yaml: |
    log_level: info
    api_token: secrets:secret/data/myapp/api#token
```

```bash
kubectl apply -f configmap.yaml
```

## Prepare the deployment {#create-deployment}

{% include notitle [secretsstore-configmap-example](../../_includes/yamls/components/secretsstore-configmap-example.md) %}

Key requirements:

* The `secrets.stackland.yandex.cloud/render-configmap: "true"` annotation enables ConfigMap mode.
* The `secrets.stackland.yandex.cloud/role` annotation specifies the Secrets Store role.
* The annotations must be placed under `spec.template.metadata.annotations` (in the pod template).
* The ConfigMap is mounted to the directory specified in `configmap-mounts` (which is `/config` by default).
* The volume for final secret-populated files is automatically added by the webhook and mounted to `/secrets`.

## Apply the manifests {#apply}

```bash
kubectl apply -f deployment.yaml
```

## Check the result {#verify}

```bash
# Check the pod status
kubectl get pods -n myapp-namespace

# Check the injector's init container logs
kubectl logs <pod_name> -n myapp-namespace -c stackland-secrets-injector

# Inspect the contents of `/secrets` inside the pod
kubectl exec -n myapp-namespace <pod_name> -- ls /secrets
kubectl exec -n myapp-namespace <pod_name> -- cat /secrets/database.yaml
```

The `/secrets` directory will contain files named after the ConfigMap keys, with the secrets' values fetched. File access permissions are set to `0600`.

## Multiple ConfigMap directories {#multiple-mounts}

If multiple ConfigMap volumes are mounted across a number of directories, provide a comma-separated list of their mount paths:

```yaml
annotations:
  secrets.stackland.yandex.cloud/configmap-mounts: "/config/app,/config/db,/etc/config"
```

{% note warning %}

The `name:/path` format is not supported; specify only directory paths.

{% endnote %}

## Diagnostics {#troubleshooting}

If secrets are not injected, see [{#T}](troubleshooting.md).
