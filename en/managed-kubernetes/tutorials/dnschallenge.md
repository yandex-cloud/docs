---
title: How to add a DNS Challenge when issuing Let's Encrypt® certificates in {{ managed-k8s-full-name }}
description: Follow this guide to add a DNS Challenge when issuing Let's Encrypt® certificates.
---

# DNS Challenge for Let's Encrypt® certificates


To add a DNS Challenge when issuing [Let's Encrypt® certificates](../../certificate-manager/concepts/managed-certificate.md):

1. [Create a certificate](#create-cert).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `dns.editor` [role](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the [domain zone](../../dns/concepts/dns-zone.md) will be in.

1. [Create an authorized key](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the [service account](../../iam/concepts/users/service-accounts.md) and save it to JSON file:

   ```bash
   yc iam key create \
     --service-account-name <service_account_name> \
     --format json \
     --output key.json
   ```

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md). A Let's Encrypt® certificate will be issued for the domain in this zone after you pass the [DNS-01 challenge](https://letsencrypt.org/ru/docs/challenge-types/#проверка-dns-01).

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared earlier.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Create a certificate {#create-cert}

1. Install the cert-manager app with the {{ dns-full-name }} ACME webhook plugin [by following this guide](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).

    During the installation, specify the service account and the authorized key created at the [Getting started](#before-begin) step.

1. Create the `certificate.yaml` file:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: example-com
     namespace: default
   spec:
     secretName: example-com-secret
     issuerRef:
       # The issuer created previously
       name: yc-clusterissuer
       kind: ClusterIssuer
     dnsNames:
       - <domain_name>
   ```

1. Provide the certificate to the {{ managed-k8s-name }} cluster:

   ```bash
   kubectl apply -f certificate.yaml
   ```

## Check the result {#check-result}

1. Check if the certificate is available:

    ```bash
    kubectl get certificate example-com
    ```

    Result:

    ```text
    NAME         READY  SECRET              AGE
    example-com  True   example-com-secret  24h
    ```

    The `True` status in the `READY` column means that the certificate was issued successfully.

1. (Optional) Get detailed information about the certificate:

    ```bash
    kubectl -n default describe certificate example-com
    ```

    {% include [cert-manager-events-explained](../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete the public domain zone](../../dns/operations/zone-delete.md).
1. [Delete the service account](../../iam/operations/sa/delete.md).
