# Using {{ yandex-cloud }} modules in {{ TF }}


{{ yandex-cloud }} provides a ![](../../_assets/overview/solution-library-icon.svg)[set of modules for Terraform](https://github.com/terraform-yc-modules). {{ TF }} modules combine a number of cloud resources that should work together. Modules simplify the cloud infrastructure configuration, make it easier to reuse its blocks, and allow you to specify any parameters required for creating resources in variables. 

This page explains how to enable the modules and use them to create a test infrastructure with a [cloud network](../../vpc/concepts/network.md#network), three [{{ vpc-full-name }}](../../vpc/) [subnets](../../vpc/concepts/network.md#subnet), and a [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

To create your first infrastructure in {{ yandex-cloud }} using {{ TF }}:
1. [Get your cloud ready](#before-you-begin).
1. [Install {{ TF }}](#install-terraform).
1. [Get the authentication data](#get-credentials).
1. [Create a {{ TF }} configuration file](#configure-terraform).
1. [Configure your provider](#configure-provider).

If you no longer need the resources, [delete them](#delete-resources).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of support for the infrastructure deployed through {{ TF }} in this tutorial includes:
* Fee for a [{{ managed-k8s-name }} regional master](../../managed-kubernetes/concepts/index.md#master) (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for continuously running [VMs](../../compute/concepts/vm.md) in the [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using dynamic [public IP addresses](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).

## Install {{ TF }} {#install-terraform}

{% include [terraform_install](../../_tutorials/_tutorials_includes/terraform-install.md) %}

## Get the authentication credentials {#get-credentials}

{% include [terraform-credentials-sa](../../_tutorials/_tutorials_includes/terraform-credentials-sa.md) %}

{% cut "Managing resources on behalf of a Yandex account or a federated account" %}

{% include [terraform-credentials-user](../../_tutorials/_tutorials_includes/terraform-credentials-user.md) %}

{% endcut %}

## Create a {{ TF }} configuration file {#configure-terraform}

{% include [terraform-configure](../../_tutorials/_tutorials_includes/terraform-configure.md) %}

## Configure your provider {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/_tutorials_includes/terraform-configure-provider.md) %}

## Enable the virtual network management module {#vpc-module}

Add the `terraform-yc-vpc` module to the configuration. You can use this module to manage your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) network infrastructure, including networks, subnets, [gateways](../../vpc/concepts/gateways.md), and other {{ vpc-name }} objects. Create a test network with three subnets in different [availability zones](../../overview/concepts/geo-scope.md):

```hcl
module "yc-vpc" {
  source              = "github.com/terraform-yc-modules/terraform-yc-vpc.git"
  network_name        = "test-module-network"
  network_description = "Test network created with module"
  private_subnets = [{
    name           = "subnet-1"
    zone           = "{{ region-id }}-a"
    v4_cidr_blocks = ["10.10.0.0/24"]
  },
  {
    name           = "subnet-2"
    zone           = "{{ region-id }}-b"
    v4_cidr_blocks = ["10.11.0.0/24"]
  },
  {
    name           = "subnet-3"
    zone           = "{{ region-id }}-d"
    v4_cidr_blocks = ["10.12.0.0/24"]
  }
  ]
}
```

## Enable {{ managed-k8s-name }} {#k8s-module}

Add the `terraform-yc-vpc` module to the configuration. Add the {{ managed-k8s-name }} cluster configuration with a regional master and two node groups as well:

```hcl
module "kube" {
  source     = "github.com/terraform-yc-modules/terraform-yc-kubernetes.git"
  network_id = "${module.yc-vpc.vpc_id}"

  master_locations  = [
    for s in module.yc-vpc.private_subnets:
      {
        zone      = s.zone,
        subnet_id = s.subnet_id
      }
    ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  ]

  node_groups = {
    "yc-k8s-ng-01"  = {
      description   = "{{ k8s }} nodes group 01"
      fixed_scale   = {
        size = 3
      }
      node_labels   = {
        role        = "worker-01"
        environment = "testing"
      }
    },

    "yc-k8s-ng-02"  = {
      description   = "{{ k8s }} nodes group 02"
      auto_scale    = {
        min         = 2
        max         = 4
        initial     = 2
      }
      node_labels   = {
        role        = "worker-02"
        environment = "dev"
      }

      max_expansion   = 1
      max_unavailable = 1
    }
  }
}
```

## Check and format the configuration files {#check-resources}

{% include [check-resources](../../_tutorials/_tutorials_includes/terraform-check-resources.md) %}

## Create resources {#create-resources}

{% include [create-resources](../../_tutorials/_tutorials_includes/terraform-create-resources.md) %}

## How to delete the resources you created {#delete-resources}

{% include [delete-resources](../../_tutorials/_tutorials_includes/terraform-delete-resources.md) %}

## See also {#see-also}

* [Getting started with {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Uploading {{ TF }} states to {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Locking {{ TF }} states using {{ ydb-name }}](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [{{ TF }} data sources](../../tutorials/infrastructure-management/terraform-data-sources.md).