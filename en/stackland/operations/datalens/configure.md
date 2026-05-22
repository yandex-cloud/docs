# Activate {{ datalens-name }}

## Getting started {#before-you-begin}

1. Make sure the {{ datalens-name }} images are uploaded into the cluster’s local registry. For more information, see [{#T}](install-images.md).
1. Make sure the {{ mpg-name }} and {{ iam-name }} components are enabled in the cluster.

## Enabling a component {#enable}

1. Create a manifest file named `datalensconfig.yaml` with the following contents:

   ```yaml
   apiVersion: stackland.yandex.cloud/v1alpha1
   kind: DataLensConfig
   metadata:
     name: main
   spec:
     enabled: true
   ```

1. Apply the manifest:

   ```bash
   kubectl apply -f datalensconfig.yaml
   ```

## Checking the installation status {#check-status}

1. Check the component installation status:

   ```bash
   kubectl get componentinstallation -l component=datalens
   ```

1. Wait until all pods in the `stackland-datalens` namespace are ready:

   ```bash
   kubectl get pods -n stackland-datalens
   ```

   All pods must switch to `Running` status.

## Opening the {{ datalens-name }} console {#open-console}

Once the installation is complete, the {{ datalens-name }} console will be available at `https://datalens.<cluster domain>`. To log in to the console, click **Sign In via SSO** → **Stackland IAM** and sign in to {{ iam-name }}.

## What is created at activation {#created-resources}

Once {{ datalens-name }} is activated, the following resources get automatically created:

* A namespace named `stackland-datalens`.
* A PostgreSQL cluster named `datalens-db` with the following databases:
  * `datalens-auth`: Authentication data.
  * `datalens-compeng`: Computing engine.
  * `datalens-us`: User settings.
  * `datalens-meta-manager`: Metadata.
  * `datalens-demo`: Demo data.
  * `datalens-temporal`: Task scheduler data.
  * `datalens-temporal-visibility`: Task visibility data.
* Secrets with database passwords and authentication keys. The `datalens-secrets` secret contains the default local admin user's password. Use it in case of issues with the IAM federation.
* An OAuthClient named `stackland.datalens` for integration with {{ iam-name }}.
* A group named `stackland-datalens-admins` in {{ iam-name }} with the cluster administrator added.

## Setting up a configuration {#configure}

To edit the component settings, edit the `DataLensConfig` resource:

```bash
kubectl edit datalensconfig main
```

Learn more about the configuration parameters in the [{{ datalens-name }} section](../../concepts/components/datalens.md#configuration).
