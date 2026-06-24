# Injecting secrets into environment variables (Env mode)

This guide explains how to configure secret injection from Secrets Store into pod environment variables using Secrets Injector.

## Getting started {#before-you-begin}

1. Make sure the Secrets Store component is [installed and active](../../concepts/components/secrets-store.md) in the cluster.
1. Secrets Store contains secrets required by your application.

## Create ServiceAccount {#create-sa}

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

[Configure a Secrets Store role](../../concepts/components/secrets-store.md#openbao-role) with access to the required paths and bind it to the ServiceAccount you created.

## Prepare the deployment {#create-deployment}

Add annotations to `spec.template.metadata.annotations` in the pod template:

{% include notitle [secretsstore-env-example](../../_includes/yamls/components/secretsstore-env-example.md) %}

Key requirements:

* The `secrets.stackland.yandex.cloud/render-configmap: "true"` annotation enables Env mode.
* The `secrets.stackland.yandex.cloud/role` annotation defines the Secrets Store role.
* In the container, you must specify either `command` or `args`, where the first element of `args` is the executable. The injector uses these fields to start the application. If neither of these fields is set, the pod will fail with the `no command is given` error.
* In the `env` field, use the `secrets:<path>#<key>` format for secret references.

## Apply the manifests {#apply}

```bash
kubectl apply -f deployment.yaml
```

## Check the result {#verify}

Make sure the pod has started and the secrets have been injected:

```bash
# Checking the pod status
kubectl get pods -n myapp-namespace

# Checking main container logs (the injector runs as a process wrapper, not as an init-container).
kubectl logs <pod_name> -n myapp-namespace -c app

# Checking the environment variables inside the pod
kubectl exec -n myapp-namespace <pod_name> -- env | grep DB_
```

If the injection is successful, the output should begin with the following lines:

```
level=INFO msg="found secret references" count=2
level=INFO msg="successfully injected secrets" count=2
level=INFO msg="spawning process" binary=...
```

## Using multiple containers {#multi-container}

To inject secrets into specific containers within a multi-container pod, use the `containers` annotation:

```yaml
annotations:
  secrets.stackland.yandex.cloud/render-env: "true"
  secrets.stackland.yandex.cloud/role: "myapp"
  secrets.stackland.yandex.cloud/containers: "app,worker"
```

If the `containers` annotation is not set and there are multiple containers, the webhook will reject pod creation, causing the deployment to fail.

## Diagnostics {#troubleshooting}

If secret injection fails, see [{#T}](troubleshooting.md).
