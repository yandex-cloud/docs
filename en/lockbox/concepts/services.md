---
title: Integrating {{ lockbox-full-name }} with {{ yandex-cloud }} services
description: In this tutorial, you will learn which {{ yandex-cloud }} services support {{ lockbox-name }} secrets.
---

# Integration with {{ yandex-cloud }} services


You can use {{ lockbox-name }} [secrets](./secret.md) in the following {{ yandex-cloud }} services:
* [{{ sf-full-name }}](#functions).
* [{{ connection-manager-full-name }}](#conn-manager).
* [{{ managed-k8s-full-name }}](#managed-kubernetes).
* [{{ serverless-containers-full-name }}](#containers).

## {{ sf-full-name }} {#functions}

If a {{ sf-name }} [function](../../functions/concepts/function.md) requires sensitive data to operate, e.g., database passwords, [static access keys](../../iam/concepts/authorization/access-key.md), or an [OAuth token](../../iam/concepts/authorization/oauth-token.md), use {{ lockbox-name }} secrets to transfer such data to the function. This will prevent unauthorized third-party access to sensitive data.

For a {{ sf-name }} function to access the data stored in a {{ lockbox-name }} secret, assign the `lockbox.payloadViewer` [role](../security/index.md#lockbox-payloadViewer) for the relevant secret to the [service account](../../iam/concepts/users/service-accounts.md) you will use to invoke the function.

## {{ connection-manager-full-name }} {#conn-manager}

{{ connection-manager-name }} [connections](../../metadata-hub/concepts/connection-manager.md) and {{ lockbox-name }} secrets are created automatically when you create a new managed database cluster in {{ yandex-cloud }}, if support for {{ connection-manager-name }} is configured at cloud level.

You cannot edit or delete any secret created automatically together with a new cluster: they are updated automatically when editing user settings in a managed database cluster. The names of such secrets match the IDs of the respective connections.

## {{ managed-k8s-full-name }} {#managed-kubernetes}

By default, {{ k8s }} stores secrets in an open format. If your [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) uses [secrets](../../managed-kubernetes/concepts/encryption.md), set up syncing cluster secrets with {{ lockbox-name }} secrets using [External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/). This will prevent unauthorized third-party access to sensitive data.

For External Secrets Operator to access the data stored in a {{ lockbox-name }} secret, assign the `lockbox.payloadViewer` [role](../security/index.md#lockbox-payloadViewer) for the relevant secret to the [service account](../../iam/concepts/users/service-accounts.md) created while installing External Secrets Operator.

## {{ serverless-containers-full-name }} {#containers}

To prevent unauthorized access to [API keys](../../iam/concepts/authorization/api-key.md), tokens, database passwords, and other sensitive data used by {{ serverless-containers-name }} [containers](../../serverless-containers/concepts/container.md), store such data in {{ lockbox-name }} secrets.

For a {{ serverless-containers-name }} container to access the data stored in a {{ lockbox-name }} secret, assign the `lockbox.payloadViewer` [role](../security/index.md#lockbox-payloadViewer) for the relevant secret to the [service account](../../iam/concepts/users/service-accounts.md) you will use to run the container.


#### See also {#see-also}

* [{#T}](../../functions/operations/function/lockbox-secret-transmit.md)
* [Creating a {{ connection-manager-name }} connection](../../metadata-hub/operations/create-connection.md)
* [Syncing with {{ lockbox-name }} secrets in {{ managed-k8s-name }}](../../managed-kubernetes/tutorials/kubernetes-lockbox-secrets.md)
* [{#T}](../../serverless-containers/operations/lockbox-secret-transmit.md)
* [{#T}](../../managed-gitlab/tutorials/gitlab-lockbox-integration.md)
