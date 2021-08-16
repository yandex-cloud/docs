# Getting information about existing clusters {{ k8s }}

To find out the {{ k8s }} cluster `ID` or `NAME`, get a list of {{ k8s }} clusters from the folder or detailed information about the {{ k8s }} cluster.

## Getting a list of {{ k8s }} clusters in a folder {#list}

Get a list of [{{ k8s }} clusters](../../concepts/index.md#kubernetes-cluster) in the default folder.

{% list tabs %}

- Management console

    To get a list of Kubernetes clusters go to the folder page and select **{{ managed-k8s-name }}**.

- CLI

    Run the command:

    ```
    $ yc managed-kubernetes cluster list
    +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    |          ID          |       NAME       |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    | INTERNAL ENDPOINT |
    +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    | cata9ertn6tcr09bh9rm | test-k8s-cluster | 2019-04-12 10:00:27 | HEALTHY | RUNNING | https://84.201.150.176/ | https://10.0.0.3/ |
    +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    ```

- API

    To get the list of {{ k8s }} clusters in the default folder, use the [list](../../api-ref/Cluster/list.md) method for the [Cluster](../../api-ref/Cluster/) resource.

{% endlist %}

## Getting detailed information about a cluster {{ k8s }} {#get}

To access a {{ k8s }} cluster, use the `ID` or `NAME` parameters from the [previous](kubernetes-cluster-list.md#list) section.

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ managed-k8s-name }}**.
    1. Click on the name of the {{ k8s }} cluster you.

- CLI

    Get detailed information about the {{ k8s }} cluster:

    ```
    $ yc managed-kubernetes cluster get test-k8s-cluster
    id: cata9ertn6tcr09bh9rm
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-04-12T10:00:27Z"
    name: test-k8s-cluster
    status: RUNNING
    health: HEALTHY
    network_id: enpg0laccbrtg60hh9ro
    master:
      zonal_master:
        zone_id: ru-central1-c
        internal_v4_address: 10.0.0.3
        external_v4_address: 84.201.150.176
      version: 1.13.3
      endpoints:
        internal_v4_endpoint: https://10.0.0.3/
        external_v4_endpoint: https://84.201.150.176/
      master_auth:
        cluster_ca_certificate: |
          -----BEGIN CERTIFICATE-----
          MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
          ...
          wF/FFl2tcdh/0gUE9SBvTDyzebJhJp5zHIVa8brUflr1oA5XlN+licDRurY=
          -----END CERTIFICATE-----
    ip_allocation_policy:
      cluster_ipv4_cidr_block: 10.13.0.0/16
      service_ipv4_cidr_block: 10.14.0.0/16
    ```

- API

  You can get detailed information about the {{ k8s }} cluster using the [get](../../api-ref/Cluster/get.md) method for the [Cluster](../../api-ref/Cluster/) resource.

{% endlist %}

