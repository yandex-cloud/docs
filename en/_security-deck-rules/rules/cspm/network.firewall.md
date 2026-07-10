### Cloud resources are protected by a firewall or security groups {#firewall}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.firewall ||
|#

#### Description

{% note info %}

This control automatically checks if each network interface connected to the VM has other than a default security group assigned.

If an external firewall is used, please manually change the rule status.

{% endnote %}

With built-in security groups, you can manage VM access to resources and security groups in Yandex Cloud or resources on the internet. A security group is a set of rules for incoming and outgoing traffic that can be assigned to a VM's network interface. Security groups work like a stateful firewall: they monitor the status of sessions and, if a rule allows a session to be created, they automatically allow response traffic. For a guide on how to set up security groups, see [Creating a security group](https://yandex.cloud/en/docs/vpc/operations/security-group-create). You can specify a security group in the VM settings.

You can use security groups to protect:

* VMs * [Managed databases](https://yandex.cloud/en/services#data-platform) * Yandex Application Load Balancer [L7 load balancers](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer) * Yandex Managed Service for Kubernetes [clusters](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#kubernetes-cluster)

You can manage network access without security groups, e.g., by using a separate VM as a firewall based on an [NGFW](https://yandex.cloud/en/marketplace/products/usergate/ngfw) image from Yandex Cloud Marketplace or a custom image. Using the NGFW can be critical to customers if they need the following features:

* Logging network connections. * Streaming traffic analysis for malicious content. * Detecting network attacks by signature. * Other features of conventional NGFW solutions.

Make sure that your [clouds](https://yandex.cloud/en/docs/resource-manager/concepts/resources-hierarchy#cloud) use any of the following:

* Security groups in each cloud object. * A separate NGFW VM from Cloud Marketplace. * [BYOI](https://en.wikipedia.org/wiki/Bring_your_own_operating_system) principle, e.g., [your own disk image](https://yandex.cloud/en/docs/compute/operations/image-create/upload).

#### Instructions and solutions

* Apply security groups to any objects that have no group. * To apply security groups through Terraform, [set up](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation) security groups (dev/stage/prod) using Terraform. * To use the NGFW, [install](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM) the NGFW on your VM: Check Point. * Refer to [this guide](https://docs.google.com/document/d/1yYwHorzkwXwIUGeG3n_K6Zo-07BVYowZJL7q2bAgVR8/edit?usp=sharing) on using the UserGate NGFW in the cloud. * Use NGFW in [active-passive](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/network-sec/checkpoint-2VM_active-active/README.md) mode.
