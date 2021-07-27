---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating clusters {{ k8s }}

Create a {{ k8s }} cluster and then [create a node group](../node-group/node-group-create.md).

## Before you start {#before-you-begin}

To create a {{ k8s }} cluster:

1. Log in to [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.

1. [On the billing page]({{ link-console-billing }}) make sure that you enabled a [billing account](../../../billing/concepts/billing-account.md) and that it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account).

1. If you don't have a folder, [create one](../../../resource-manager/operations/folder/create.md).

1. Install the [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

1. Make sure you have enough [resources available in the cloud](../../concepts/limits.md).

1. If you don't have a network, [create one](../../../vpc/operations/network-create.md).

1. If you don't have any subnets, [create them](../../../vpc/operations/subnet-create.md) in the availability zones where you will create a {{ k8s }} cluster and node group.

1. Create [service accounts](../../../iam/operations/sa/create.md):
    - A service account with the [{{ roles-editor }}](../../../resource-manager/security/#roles-list) role for the folder where the {{ k8s }} cluster will be created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
    - A service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#required-roles) role for the folder containing the Docker image registry. Nodes will download the Docker images they require from the registry on behalf of this account.

    You can use the same service account for both operations.

## Create a cluster {{ k8s }} {#kubernetes-cluster-create}

{% list tabs %}

- Management console

    {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Create a {{ k8s }} cluster:

    ```
    $ yc managed-kubernetes cluster create 
        --name test-k8s \
        --network-name default \
        --zone ru-central1-a \
        --subnet-name default-a \
        --public-ip \
        --release-channel regular \
        --version 1.13 \
        --cluster-ipv4-range 10.1.0.0/16 \
        --service-ipv4-range 10.2.0.0/16 \
        --service-account-name default-sa \
        --node-service-account-name default-sa \
        --daily-maintenance-window start=22:00,duration=10h
    done (5m47s)
    id: cathn0s6qobfa61p3u6k
    folder_id: b1g66jflru0ek1omtsu0
    created_at: "2019-12-02T13:50:26Z"
    name: test-k8s
    status: RUNNING
    health: HEALTHY
    network_id: enpg0laccbrtg80ff9ro
    master:
     zonal_master:
       zone_id: ru-central1-a
       internal_v4_address: 172.23.0.15
       external_v4_address: 84.201.128.175
     version: "1.13"
     endpoints:
       internal_v4_endpoint: https://172.23.0.15/
       external_v4_endpoint: https://84.201.128.175/
     master_auth:
       cluster_ca_certificate: |
         -----BEGIN CERTIFICATE-----
         MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
         ...
         5ojvE6TqXJD5yANkK/eX6KAawlXey02BnNO/c7Ip6ShQdjTrf8OrlpvtDE4=
         -----END CERTIFICATE-----
     version_info:
       current_version: "1.13"
     maintenance_policy:
       auto_upgrade: true
       maintenance_window:
         daily_maintenance_window:
           start_time:
             hours: 22
           duration: 36000s
    ip_allocation_policy:
     cluster_ipv4_cidr_block: 10.1.0.0/16
     service_ipv4_cidr_block: 10.2.0.0/16
    service_account_id: aje3932acd0c5ur7gatp
    node_service_account_id: aje3932acd0c5hg8dagp
    release_channel: REGULAR
    ```

    Where:
    - `--name`: The {{ k8s }} cluster name.
    - `--network-name`: Name of the network.
    - `--zone`: Availability zone.
    - `--subnet-name`: Name of the subnet.
    - `--public-ip`: Flag that is specified if the {{ k8s }} cluster needs a public IP address.
    - `--release-channel`: [Release channel](../../concepts/release-channels-and-updates.md#release-channels).
    - `--version`: {{ k8s }} version.
    - `--cluster-ipv4-range`: Range of IP addresses for allocating pod addresses.
    - `--service-ipv4-range`: Range of IP addresses for allocating service addresses.
    - `--service-account-id`: The unique ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
    - `--node-service-account-id`: The unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
    - `--daily-maintenance-window`: Maintenance window settings.

- API

    To create a {{ k8s }} cluster, use the [create](../../api-ref/Cluster/create.md) method for the [Cluster](../../api-ref/Cluster) resource.

{% endlist %}

