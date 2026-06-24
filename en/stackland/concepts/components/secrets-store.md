# Secrets Store

{{ stackland-name }} uses two main tools for secure secret storage and injection:

* Secrets Injector: Uploads secrets via a [Vault](https://developer.hashicorp.com/vault/docs)-compatible API and injects them into cluster resources.
* [Vault](https://developer.hashicorp.com/vault/docs)-compatible secrets storage.

If you use the default Secrets Injector configuration, the cluster's secret storage will be [OpenBao](https://openbao.org/), a fork of [Vault](https://developer.hashicorp.com/vault/docs).

You can change the default settings using the [`SecretsStoreConfig` custom resource](#configuration) properties.

## Architecture {#architecture}

Secrets Store is comprised of three components:

1. **Mutation Webhook**: Processes the creation and updates of `Deployment`, `StatefulSet`, `DaemonSet`, `Job`, and `CronJob`. For these resources, the webhook injects an init container with the `stackland-secrets-injector` binary. The webhook does not process pods directly. It runs automatically in namespaces where injection is not [explicitly disabled](#namespace-selector).
1. **Secrets Injector** (`stackland-secrets-injector`): Injector binary. It authenticates to Secrets Store and retrieves secrets via URLs in the following format: `secrets:<path>#<key>`. In Env mode, the injector runs as a wrapper of the main container process, while in ConfigMap mode it runs as an init container.
1. **OpenBao**: Secret storage compatible with the Vault API. Deployed in the `stackland-secrets-store` namespace and accessible from within the cluster at `https://openbao.stackland-secrets-store.svc.cluster.local:8200`.

In Env mode, the webhook adds an init container named `copy-stackland-secrets-injector` and `emptyDir` volume named `stackland-secrets-injector`. This volume is used to provide the injector binary to the main container. In ConfigMap mode, the webhook adds an init container named `stackland-secrets-injector` and `emptyDir` volume named `stackland-secrets`: the init container reads the mounted ConfigMaps, retrieves secrets from OpenBao, and writes the processed files to this volume. The main container reads the result from the `/secrets` directory. Dual mode uses both mechanisms at the same time.

## Operating modes {#modes}

### Env mode {#env-mode}

In this mode, the injector runs as a **process wrapper**. It injects secrets into environment variables and then runs the main container command with already populated variables.

Env mode prerequisites:

1. Specify the `secrets.stackland.yandex.cloud/render-env: "true"` annotation in the pod template.
1. Set the `secrets.stackland.yandex.cloud/role` annotation with the role name in Secrets Store.
1. In the `env` field of the container, use secret references in `secrets:<path>#<key>` format.
1. Set an explicit start command: `command` or `args`, where the first element of `args` is an executable. The injector uses these fields to start the application.

{% note warning %}

In Env mode, specify container `command` or `args`, where the first element is an executable. If neither of these fields is set, the injector will exit with the `no command is given` error, and the main container will not start. Image ENTRYPOINT is not used automatically.

{% endnote %}

In Env mode, we recommend placing annotations in `spec.template.metadata.annotations` (on the pod template). For `Deployment`, `StatefulSet`, `DaemonSet`, and `Job`, the webhook can also copy annotations from the resource’s `metadata.annotations` if they are not specified in the pod template. If the same annotation is specified in both places, the value from the pod template is used.

For details, see [{#T}](../../operations/secrets-store/inject-secrets-env.md).

### ConfigMap mode {#configmap-mode}

In this mode, the injector runs as an init container and processes ConfigMaps mounted into the pod. It finds secret references in the ConfigMap values and retrieves them from Secrets Store. The result gets written to the `/secrets` directory as a flat file structure with permissions set to `0600` The main container then reads the files from `/secrets`.

ConfigMap mode prerequisites:

1. Specify the `secrets.stackland.yandex.cloud/render-configmap: "true"` annotation.
1. Set the `secrets.stackland.yandex.cloud/role` annotation.
1. Use secret references in ConfigMap values.
1. Mount a ConfigMap to the container.

For details, see [{#T}](../../operations/secrets-store/inject-secrets-configmap.md).

### Dual mode {#dual-mode}

Simultaneous use of Env mode and ConfigMap mode. To enable, set both flags:

```yaml
annotations:
  secrets.stackland.yandex.cloud/render-env: "true"
  secrets.stackland.yandex.cloud/render-configmap: "true"
  secrets.stackland.yandex.cloud/role: "myapp"
```

Full manifest example:

{% include notitle [secretsstore-dual-example](../../_includes/yamls/components/secretsstore-dual-example.md) %}

## Secret reference format {#secret-references}

Secret references are used either in the container’s `env[].value` fields (Env mode) or ConfigMap key values (ConfigMap mode).

Basic format:

```
secrets:<vault_path>#<key>
```

Where:

* `<vault_path>`: Path to the secret in Secrets Store, e.g., `secret/data/myapp/database`.
* `<key>`: Key inside the Secret, e.g., `password`.

Here is an example:

```yaml
env:
  - name: DB_PASSWORD
    value: "secrets:secret/data/myapp/database#password"
  - name: API_KEY
    value: "secrets:secret/data/myapp/api#key"
```

## Namespace-selector {#namespace-selector}

Mutation Webhook applies to all namespaces in the cluster except those where injection has been explicitly disabled. The webhook processes the creation and update of `Deployment`, `StatefulSet`, `DaemonSet`, `Job`, and `CronJob`, but does not process pods created directly.

To disable injection of secrets for a specific namespace, add the following label to it:

```yaml
kubectl label namespace <namespace_name> secrets.stackland.yandex.cloud/injection=disabled
```

## Mutation Webhook annotations {#annotations}

The annotations are specified in the pod template: `spec.template.metadata.annotations` for `Deployment`, `StatefulSet`, `DaemonSet`, and `Job`, and `spec.jobTemplate.spec.template.metadata.annotations` for `CronJob`.

### Basic annotations

* `secrets.stackland.yandex.cloud/role` (required): Secrets Store role for pod authentication.
* `secrets.stackland.yandex.cloud/mutate`: Fully disables pod mutation if set to `skip`.
* `secrets.stackland.yandex.cloud/addr`: Secrets Store server address. The default value is `https://openbao.stackland-secrets-store.svc.{{ cluster-domain }}:8200`.
* `secrets.stackland.yandex.cloud/auth-path`: Authentication path in Secrets Store. The default value is `kubernetes`.
* `secrets.stackland.yandex.cloud/namespace`: OpenBao namespace (only for Vault Enterprise).

### Selecting a mode

* `secrets.stackland.yandex.cloud/render-env`: Enables Env mode. The default value is `false`.
* `secrets.stackland.yandex.cloud/render-configmap`: Enables ConfigMap mode. The default value is `false`.

### ConfigMap mode settings

* `secrets.stackland.yandex.cloud/configmap-mounts`: Comma-separated paths to directories where the injector searches for mounted ConfigMaps. The default value is `/config`. The `name:/path` format is **not supported**, only paths to directories.

### Additional parameters

* `secrets.stackland.yandex.cloud/containers`: Comma-separated list of containers for mutation. If not set, and the pod has multiple containers, the webhook rejects the pod.
* `secrets.stackland.yandex.cloud/skip-tls-verify`: Disables TLS certificate verification when connecting to Secrets Store. The default value is `false`.
* `secrets.stackland.yandex.cloud/ignore-missing-secrets`: Allows to continue if some secrets are missing (instead of emergency termination). The default value is `false`.
* `secrets.stackland.yandex.cloud/injector-image`: Overrides the injector image.
* `secrets.stackland.yandex.cloud/injector-image-tag`: Overrides the injector image tag. The default value is `latest`.
* `secrets.stackland.yandex.cloud/secrets-volume-name`: Name of volume for files with secrets. The default value is `stackland-secrets`.

## Configuring a role in Secrets Store {#openbao-role}

To enable the injector to retrieve secrets, configure Secrets Store authentication. Kubernetes auth is activated by the component automatically.

1. Create ServiceAccount in the cluster:

   ```bash
   kubectl create serviceaccount myapp-sa -n myapp-namespace
   ```

1. Create a policy with access to required paths:

   ```hcl
   # myapp-policy.hcl
   path "secret/data/myapp/*" {
     capabilities = ["read"]
   }
   ```

   ```bash
   bao policy write myapp-policy myapp-policy.hcl
   ```

1. Create a role and assign it to the pod's ServiceAccount:

   ```bash
   bao write auth/kubernetes/role/myapp \
     bound_service_account_names=myapp-sa \
     bound_service_account_namespaces=myapp-namespace \
     policies=myapp-policy \
     ttl=1h
   ```

For a detailed description of configuring Kubernetes auth in OpenBao, see [OpenBao official guides](https://openbao.org/docs/auth/kubernetes/).

## Access to Secrets Store {#openbao}

The Secrets Store interface and API access are disabled by default.

* To open access to the Secrets Store API from outside the cluster, set `server.ingress.enabled = true`.
* To open access to the Secrets Store interface from outside the cluster, set `server.ingress.enabled = true` and `ui.enabled = true`.

The interface and API will be available at `https://secrets.sys.<cluster domain>`. If `ui.enabled` is set to `true`, and `server.ingress.enabled`, to `false`, accessing the interface will only be available within the cluster.

## Using Secrets Injector {#secrets-injector}

After the Secrets Store component is enabled, no separate injector deployment is required. Secrets Injector uses Secrets Store in {{ stackland-name }}. For your app to retrieve secrets, configure secrets, policy, and role in Secrets Store. If required, you can configure the use of your own secret storage in a custom resource using the `secretsAddr` [property](#secrets-injector-settings).

Secrets Injector uses the Secrets Store API to authenticate service accounts. The default endpoint is `auth/kubernetes`. If your application requires a different authentication path, set the `secrets.stackland.yandex.cloud/auth-path` annotation in the pod template.

## Configuration {#configuration}

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/secretsstoreconfig.md) %}

### Secrets Injector settings {#secrets-injector-settings}

```yaml
stacklandSecretsInjector:
  authPath: kubernetes
  enabled: true
  resources:
    limits:
      cpu: 100m
      memory: 128Mi
    requests:
      cpu: 50m
      memory: 64Mi
  secretsAddr: ''
  skipTLSVerify: false
  webhookTimeout: 30
```

* `authPath`: Specifies the Kubernetes auth backend path the component configures in Secrets Store. The default value is `kubernetes`, which corresponds to the `auth/kubernetes` API endpoint. For applications that use a different authentication path, specify the same path in the `secrets.stackland.yandex.cloud/auth-path` annotation.
* `enabled`: Enables the use of Secrets Injector.
* `resources`: Reserved parameter for configuring Secrets Injector pod resources (CPU and memory). The current version uses the default values.
* `secretsAddr`: Specifies the HTTPS address of the Secrets Store API.
* `skipTLSVerify`: Reserved parameter. To disable TLS certificate verification for a specific application, use `secrets.stackland.yandex.cloud/skip-tls-verify: "true"`.
* `webhookTimeout`: Determines the time to wait for a response from Secrets Injector.

### Secrets Store pod settings {#server}

```yaml
server:
  dataStorage:
    size: 2Gi
    storageClass: stackland-other
  enabled: true
  ingress:
    clusterIssuer: stackland-default
    enabled: false
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 100m
      memory: 256Mi
  updateStrategyType: RollingUpdate
```

* `dataStorage`: Sets advanced settings for the storage.
* `enabled`: Enables the use of a pod.
* `ingress`: Specifies the settings of the Ingress object.
* `resources`: Limits resources (CPU and memory) for the pod.
* `updateStrategyType`: Determines the type of update.

### Using the interface {#ui}

```yaml
ui:
  enabled: true
```

* `enabled`: Enables the Secrets Store interface in OpenBao. To allow external access to the interface, enable `server.ingress.enabled` as well.
