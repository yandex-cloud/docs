# Secrets Store diagnostics

This section describes typical issues when using Secrets Injector and how to solve them.

## Secrets are not injected into environment variables {#env-not-injected}

### Symptom

The pod starts, but the environment variables contain the original reference values ​​(`secrets:secret/data/...`) instead of the actual values.

### Causes and solutions

#### Annotations were not included in the pod template {#wrong-annotations-place}

The primary location for configuring injection is in the pod template's annotations. For `Deployment`, `StatefulSet`, `DaemonSet`, and `Job`, we recommend specifying annotations in `spec.template.metadata.annotations`. For `CronJob`, use `spec.jobTemplate.spec.template.metadata.annotations`.

For `Deployment`, `StatefulSet`, `DaemonSet`, and `Job`, the webhook can also copy annotations from the resource’s `metadata.annotations` if they are not specified in the pod template. If the same annotation is specified in both places, the value from the pod template is used. However, the pod template remains the most understandable and portable location to set up injection.

Here are some examples:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  template:
    metadata:
      annotations:
        secrets.stackland.yandex.cloud/render-env: "true"
        secrets.stackland.yandex.cloud/role: "myapp"
```

#### Namespace excluded from injection {#namespace-disabled}

Check namespace labels:

```bash
kubectl get namespace <namespace_name> --show-labels
```

If the namespace is labeled as `secrets.stackland.yandex.cloud/injection=disabled`, the webhook will not mutate pods in it. Delete the label:

```bash
kubectl label namespace <namespace_name> secrets.stackland.yandex.cloud/injection-
```

#### No `role` annotation specified {#missing-role}

The `secrets.stackland.yandex.cloud/role` annotation is required. Without it, the injector will not be able to authenticate in Secrets Store.

#### Incorrect secret link format {#wrong-secret-format}

Make the format is correct: `secrets:<path>#<key>`. You do not need a slash before `#`, but the `#` character is required.

Here are some examples:

* Correct: `secrets:secret/data/myapp/database#password`.
* Incorrect: `vault:secret/data/myapp/database#password` (the `vault:` prefix is obsolete).
* Incorrect: `secrets:secret/data/myapp/database` (no `#key`).

## The pod will not start: `no command is given` {#no-command}

### Symptom

```
level=ERROR msg="no command is given, stackland-secrets-injector can't determine the entrypoint"
```

The main container does not start. In Env mode, the injector replaces the container command with itself, retrieves secrets, and then replaces itself with the application process. If neither `command` nor `args` are specified, the injector does not know what to run.

### Solution:

Explicitly specify `command` in the container specification or `args`, where the first element is the executable. The ENTRYPOINT from the Docker image is not automatically used.

Example for a Java application:

```yaml
containers:
  - name: app
    image: myapp:latest
    command:
      - /bin/sh
      - -c
      - "java -jar app.jar"
    env:
      - name: DB_PASSWORD
        value: "secrets:secret/data/myapp/database#password"
```

Example for a Go/binary application:

```yaml
containers:
  - name: app
    image: myapp:latest
    command:
      - /app/myapp
    args:
      - --config=/config/app.yaml
    env:
      - name: API_KEY
        value: "secrets:secret/data/myapp/api#key"
```

## Injection does not occur for some containers {#multi-container}

### Symptom

There are multiple containers in the pod, but the mutation is not applied to any of them.

### Solution:

If a pod contains multiple containers and the `containers` annotation is not specified, the webhook rejects the pod creation and the deployment fails. Specify an explicit list of containers:

```yaml
annotations:
  secrets.stackland.yandex.cloud/render-env: "true"
  secrets.stackland.yandex.cloud/role: "myapp"
  secrets.stackland.yandex.cloud/containers: "app,worker"
```

## Secret not found in Secrets Store {#secret-not-found}

### Symptom

In **ConfigMap mode**: the injector (init container) terminates with an error that the secret was not found, and the pod switches to `Init:Error`.

In **Env mode**: the main container terminates with an error, and the pod switches to `Error` or `CrashLoopBackOff`.

### Causes and solutions

#### The path to the secret is incorrect {#wrong-secret-path}

Check the path. In Secrets Store KV v2, data is located at `secret/data/<name>`, not `secret/<name>`:

* KV v2: `secrets:secret/data/myapp/database#password`
* KV v1: `secrets:secret/myapp/database#password`

#### The role does not have access to this path {#role-no-access}

Check the policy linked to the role. It should allow `read` for the path:

```hcl
path "secret/data/myapp/*" {
  capabilities = ["read"]
}
```

#### The role is not linked to the pod's ServiceAccount {#role-not-bound}

Check the role link:

```bash
bao read auth/kubernetes/role/myapp
```

The output should include the ServiceAccount and the pod's namespace.

#### Continue operation despite unavailable secrets {#ignore-missing}

If unavailability of some secrets is acceptable, use:

```yaml
annotations:
  secrets.stackland.yandex.cloud/ignore-missing-secrets: "true"
```

## Checking the webhook's operation {#check-webhook}

Make sure the webhook is running and processing requests:

```bash
# Checking for webhook pods
kubectl get pods -n stackland-secrets-store -l app.kubernetes.io/name=stackland-secrets-webhook

# Checking webhook logs when creating a pod
kubectl logs -n stackland-secrets-store -l app.kubernetes.io/name=stackland-secrets-webhook --tail=50
```

If the webhook was processed successfully, the following line should appear in the logs:

```
level=INFO msg="Admission review request handled" ... duration=...ms
```

If the webhook is unavailable and you see `failurePolicy: Fail`, which is the default value, pods in injection-enabled namespaces will not start. Check the status of the webhook and pods in the `stackland-secrets-store` namespace.

## TLS error connecting to Secrets Store {#tls-error}

### Symptom

```
level=ERROR msg="failed to connect to vault" error="x509: certificate signed by unknown authority"
```

### Solution

If the Secrets Store certificate is not trusted, use the `skip-tls-verify` annotation:

```yaml
annotations:
  secrets.stackland.yandex.cloud/skip-tls-verify: "true"
```

{% note warning %}

Using `skip-tls-verify: "true"` in production is not secure.

{% endnote %}
