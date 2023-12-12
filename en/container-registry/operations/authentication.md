---
title: "Authentication in {{ container-registry-full-name }}"
description: "Before you start using {{ container-registry-name }}, you need to authenticate for the corresponding interface."
---

# Authentication in {{ container-registry-name }}

Before you start using {{ container-registry-name }}, you need to authenticate for the corresponding interface:
* In the **Management console**, the minimum required [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) [role](../../iam/concepts/access-control/roles.md) is `viewer`.
* In the **Docker CLI** or **{{ managed-k8s-full-name }}**, the minimum required role for the [registry](../concepts/registry.md) or [repository](../concepts/repository.md) is `container-registry.images.puller`.

Assign the proper role to a {{ yandex-cloud }} user or [service account](../../iam/concepts/users/service-accounts.md). Read about [authentication methods](#method) and choose the appropriate one.

For more information about roles, see [{#T}](../security/index.md).

## Authentication methods {#method}

You can authenticate:


* As a user:
  * [Using an OAuth token](#user-oauth) (lifetime is **one year**).
  * [Using an {{ iam-full-name }} token](#user-iam) (maximum lifetime is **{{ iam-token-lifetime }}**).



* As a service account:
  * [Using authorized keys](#sa-json) (unlimited lifetime).
  * [Using an {{ iam-name }} token](#sa-iam) (maximum lifetime is **{{ iam-token-lifetime }}**).
  * [Using a secret of the service account](#k8s-secret) of the [external {{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) or external [node group](../../managed-kubernetes/concepts/index.md#node-group) managed by {{ managed-k8s-name }}.
* [Using a Docker credential helper credential store](#cred-helper).

The authentication command looks like this:

```bash
docker login \
  --username <token_type> \
  --password <token> \
  {{ registry }}
```

Where:
* `username`: Token type. Acceptable values: `oauth`, `iam`, or `json_key`.
* `password`: Token body.
* `{{ registry }}`: The endpoint that Docker will access when working with the image registry. If it not specified, the request will be sent to [Docker Hub](https://hub.docker.com) as the default service.

## Authenticate as a user {#user}


### Authentication using an OAuth token {#user-oauth}

{% note info %}

{% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

{% endnote %}

1. If you do not have an OAuth token yet, get one by following [this link]({{ link-cloud-oauth }}).
1. Run this command:

   ```bash
   docker login \
     --username oauth \
     --password <OAuth token> \
     {{ registry }}
   ```


### Authentication using an {{ iam-name }} token {#user-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Get an {{ iam-name }} token](../../iam/operations/iam-token/create.md).
1. Run this command:

   ```bash
   docker login \
     --username iam \
     --password <{{ iam-name }} token> \
     {{ registry }}
   ```

## Authenticate as a service account {#sa}

### Authentication using authorized keys {#sa-json}

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

Your programs can get access to {{ yandex-cloud }} resources using service accounts. Get a file with [authorized keys](../../iam/concepts/users/service-accounts.md#sa-key) for your service account through the [{{ yandex-cloud }} CLI](../../cli/).

{% include [cli-install](../../_includes/cli-install.md) %}

1. Get authorized keys for your service account and save them to the `key.json` file:

   ```bash
   yc iam key create --service-account-name default-sa -o key.json
   ```

   Result:

   ```text
   id: aje8a87g4e...
   service_account_id: aje3932acd...
   created_at: "2019-05-31T16:56:47Z"
   key_algorithm: RSA_2048
   ```

1. Run this command:

   ```bash
   cat key.json | docker login \
     --username json_key \
     --password-stdin \
     {{ registry }}
   ```

   Where:
   * The `cat key.json` command writes the contents of the key file to the output stream.
   * The `--password-stdin` flag allows the password to be read from the input stream.

   Result:

   ```text
   Login succeeded
   ```

### Authentication using an {{ iam-name }} token {#sa-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Get an {{ iam-name }} token](../../iam/operations/iam-token/create-for-sa.md).
1. Run this command:

   ```bash
   docker login \
     --username iam \
     --password <{{ iam-name }} token> \
     {{ registry }}
   ```

### Authentication using a {{ k8s }} secret {#k8s-secret}

{% note info %}

These instructions only apply to external {{ k8s }} clusters and [external nodes](../../managed-kubernetes/concepts/external-nodes.md) managed by {{ managed-k8s-name }}.

For a node placed in [{{ compute-full-name }}](../../compute/) to pass authentication, [assign the `container-registry.images.puller` role](../../iam/operations/roles/grant.md) to this node's service account.

{% endnote %}

{% include [cli-install](../../_includes/cli-install.md) %}

{{ k8s }} resources can get access to {{ container-registry-name }} objects using [{{ k8s }} secrets](../../managed-kubernetes/concepts/encryption.md) created based on keys of [service accounts](../../iam/concepts/users/service-accounts.md).

To prepare this secret:
1. Get an [authorized key](../../iam/concepts/users/service-accounts.md#sa-key) for your service account and save it to the `key.json` file:

   ```bash
   yc iam key create --service-account-name <service_account_name> -o key.json
   ```

1. Run the authentication command:

   ```bash
   cat key.json | docker login \
     --username json_key \
     --password-stdin \
     {{ registry }}
   ```

   Result:

   ```text
   Login succeeded
   ```

   If any errors occur, see [{#T}](../error/index.md).
1. Make sure that the key is in the correct format. To do this, open the Docker configuration file:

   ```bash
   cat $HOME/.docker/config.json
   ```

   Result:

   ```json
   {
     "auths": {
       "{{ registry }}": {
         "auth": "anNvbl9rZXk
         ...
         tXG4iCn0="
       }
     }
   }
   ```

   {% note info %}

   Previously configured access to Docker may prevent a key from being received in the correct format. To get the correct key, [disable a credential helper](#ch-not-use) or delete the existing `$HOME/.docker/config.json` file.

   {% endnote %}

1. Create a secret in your {{ k8s }} cluster:

   ```bash
   kubectl create secret generic <secret_name> \
     --namespace=<namespace> \
     --from-file=.dockerconfigjson=$HOME/.docker/config.json \
     --type=kubernetes.io/dockerconfigjson
   ```

   You can specify, for example, `kube-system` as a [namespace](../../managed-kubernetes/concepts/index.md#namespace). {{ managed-k8s-name }} will use this namespace after you create a node group.
1. Use the secret to create [pods](../../managed-kubernetes/concepts/index.md#pod) or Deployment controllers, for example:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: <pod_name>
     namespace: <namespace>
   spec:
     containers:
       - name: <name_of_your_container>
         image: <container_image_name>
     imagePullSecrets:
     - name: <secret_name>
   ```

   When creating secrets and pods, make sure to specify the same namespace for them in the `namespace` parameter; otherwise, an authentication error will occur.

For more information, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/).

## Authenticate using a Docker credential helper {#cred-helper}

The Docker Engine can keep user credentials in an external credentials store. This is more secure than storing credentials in the Docker configuration file. To use a credential store, you need external [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers) software.

The {{ yandex-cloud }} CLI uses `docker-credential-yc` as a Docker credential helper for {{ yandex-cloud }}. It stores user credentials and allows you to use private {{ yandex-cloud }} registries without running the `docker login` command. This authentication method supports operations on behalf of a user and service account.

### Configuring a credential helper {#ch-setting}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Configure Docker to use `docker-credential-yc`:

   ```bash
   yc container registry configure-docker
   ```

   Result:

   ```text
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   Settings are saved in the current user's profile.

   {% note warning %}

   Credential helper only works when using Docker without `sudo`. You can learn how to configure Docker to run under current user without `sudo` in the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

   {% endnote %}

1. Make sure that Docker is configured.

   The `${HOME}/.docker/config.json` configuration file must include the following line:

   ```json
   "{{ registry }}": "yc"
   ```

1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md).

### Additional credential helper features {#ch-feature}

#### Using a credential helper for a different {{ yandex-cloud }} CLI profile {#ch-profile}

You can use the credential helper for another profile, without switching from the current one, by running the following command:

```bash
yc container registry configure-docker --profile <profile_name>
```

For more information about {{ yandex-cloud }} CLI profile management, see the [step-by-step instructions](../../cli/operations/index.md#profile).

#### Disabling a credential helper {#ch-not-use}

To avoid using a credential helper for authentication, edit the `${HOME}/.docker/config.json` configuration file to remove the `{{ registry }}` domain line under `credHelpers`.