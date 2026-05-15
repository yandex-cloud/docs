# Secrets Store

{{ stackland-name }} uses two main tools for safe storage of secrets and their injection:

* Secrets Injector: Uploads secrets via a [Vault](https://developer.hashicorp.com/vault/docs)-compatible API and injects them into cluster resources.
* [Vault](https://developer.hashicorp.com/vault/docs)-compatible secrets storage.

If you use the default Secrets Injector configuration, the cluster's secret storage will be [OpenBao](https://openbao.org/), a fork of [Vault](https://developer.hashicorp.com/vault/docs).

You can change the default settings using the [`SecretsStoreConfig` custom resource](#configuration) properties.

## Access to OpenBao {#openbao}

The OpenBao interface and API access are disabled by default.

* To open access to the OpenBao API from outside the cluster, you need to set the `server.ingress.enabled = true` flag.
* To open access to the OpenBao interface from outside the cluster, you need to set the `server.ingress.enabled = true` and `ui.enabled = true` flag.

The interface and API will be available at `https://secrets.sys.<cluster domain>`. If `ui.enabled` is set to `true`, and `server.ingress.enabled`, to `false`, accessing the interface will only be available within the cluster.

## Using Secrets Injector {#secretsInjector}

Secrets Injector is ready to work right after cluster deployment and does not require any additional configuration. Secrets Injector uses OpenBao storage in {{ stackland-name }}. If required, you can configure the use of your own secret storage in a custom resource using the `secretsAddr` [property](#secretsInjector-settings).

Secrets Injector uses the OpenBao API to authenticate service accounts that inject secrets into manifests. By default, the `auth/kubernetes` endpoint is used; however, you can change it by modifying the `authPath` [property](#secretsInjector-settings).

## Configuration {#configuration}

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/secretsstoreconfig.md) %}

### Secrets Injector settings {#secretsInjector-settings}

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

* `authPath`: Specifies the OpenBao API endpoint for authentication and authorization via Kubernetes. The default value is `auth/kubernetes`.
* `enabled`: Enables the use of Secrets Injector.
* `resources`: Limits resources (CPU and memory) for the pod.
* `secretsAddr`: Specifies the HTTPS address of the OpenBao API.
* `skipTLSVerify`: Allows you to skip checking the TLS certificate if it is not in the list of trusted certificates.
* `webhookTimeout`: Determines the time to wait for a response from Secrets Injector.

### OpenBao pod settings {#server}

```yaml
server:
  dataStorage:
    size: 2Gi
    storageClass: stackland-default
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

* `enabled`: Enables the OpenBao interface at `https://secrets.sys.<cluster domain>`.

