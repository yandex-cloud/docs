# Using {{ yandex-cloud }} modules in {{ TF }}

{{ yandex-cloud }} provides a ![](../../_assets/overview/solution-library-icon.svg) [set of modules for Terraform](https://github.com/terraform-yc-modules). {{ TF }} modules combine a number of cloud resources that should work together. Modules simplify the cloud infrastructure configuration, make it easier to reuse its blocks, and allow you to specify any parameters required for creating resources in variables.

This page explains how to enable the modules and use them to create a test infrastructure with a cloud network, three {{ vpc-name }} subnets, and a {{ managed-k8s-name }} cluster.

To create your first infrastructure in {{ yandex-cloud }} using {{ TF }}:
1. [Prepare your cloud](#before-you-begin).
1. [Install {{ TF }}](#install-terraform).
1. [Get the authentication data](#get-credentials)
1. [Create a {{ TF }} configuration file](#configure-terraform).
1. [Configure a provider](#configure-provider).

If you no longer need the resources, [delete them](#delete-resources).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources created with {{ TF }} includes:
* Fee for a [regional master](../../managed-kubernetes/concepts#master) (see [{{ managed-k8s-full-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for continuously running [node VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Install {{ TF }} {#install-terraform}

{% include [terraform_install](../../_tutorials/terraform-install.md) %}

## Get the authentication credentials {#get-credentials}

{% include [terraform-credentials-sa](../../_tutorials/terraform-credentials-sa.md) %}


{% cut "Managing resources on behalf of a Yandex account or a federated account" %}

{% include [terraform-credentials-user](../../_tutorials/terraform-credentials-user.md) %}

{% endcut %}



## Create a {{ TF }} configuration file {#configure-terraform}

{% include [terraform-configure](../../_tutorials/terraform-configure.md) %}

## Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Enable the virtual network management module {#vpc-module}

Add the `terraform-yc-vpc` module to the configuration; you can use it to manage your cloud network infrastructure, including networks, subnets, gateways, and other {{ vpc-name }} objects. Create a test network with three subnets in different availability zones:

```hcl
module "yc-vpc" {
  source              = "git@github.com:terraform-yc-modules/terraform-yc-vpc.git"
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
    zone           = "{{ region-id }}-c"
    v4_cidr_blocks = ["10.12.0.0/24"]
  }
  ]
}
```

## Enable the {{ managed-k8s-name }} module {#k8s-module}

Add the `terraform-yc-vpc` module to the configuration and the {{ managed-k8s-name }} cluster configuration with a regional master and two node groups:

```
module "kube" {
  source     = "git@github.com:terraform-yc-modules/terraform-yc-kubernetes.git"
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
      description   = "Kubernetes nodes group 01"
      fixed_scale   = {
        size = 3
      }
      node_labels   = {
        role        = "worker-01"
        environment = "testing"
      }
    },

    "yc-k8s-ng-02"  = {
      description   = "Kubernetes nodes group 02"
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

{% include [check-resources](../../_tutorials/terraform-check-resources.md) %}

## Create resources {#create-resources}

{% include [create-resources](../../_tutorials/terraform-create-resources.md) %}

## How to delete the resources you created {#delete-resources}

{% include [delete-resources](../../_tutorials/terraform-delete-resources.md) %}