### Cloud resources are protected by a firewall or security groups {#firewall}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.firewall ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks security groups availability for the following types of resources:
`enum <resource-type>`

{% endnote %}

{% note warning "**Manual verification**" %}

This rule requires manual check. After checking and update, please change the rule status.

{% endnote %}

With built-in security groups, you can manage VM access to resources and security groups in Yandex Cloud or resources on the internet. A security group is a set of rules for incoming and outgoing traffic that can be assigned to a VM's network interface. Security groups work like a stateful firewall: they monitor the status of sessions and, if a rule allows a session to be created, they automatically allow response traffic. For a guide on how to set up security groups, see [Creating a security group](https://yandex.cloud/en/docs/vpc/operations/security-group-create). You can specify a security group in the VM settings.

You can use security groups to protect:

* VM
* Managed databases: <https://yandex.cloud/en/services#data-platform>
* Yandex Application Load Balancer: <https://yandex.cloud/en/docs/application-load-balancer>
* Yandex Managed Service for Kubernetes: <https://yandex.cloud/en/docs/managed-kubernetes>

You can manage network access without security groups, e.g., by using a separate VM as a firewall based on an NGFW image from Yandex Cloud Marketplace or a custom image. Using the NGFW can be critical to customers if they need the following features:

* Logging network connections.
* Streaming traffic analysis for malicious content.
* Detecting network attacks by signature.
* Other features of conventional NGFW solutions.

Make sure that your clouds use any of the following:

* Security groups in each cloud object.
* A separate NGFW VM from Cloud Marketplace.
* BYOI principle, e.g., your own disk image: <https://yandex.cloud/en/docs/compute/operations/image-create/upload>

#### Guides and solutions

* Apply security groups to any objects that have no group.
* To apply security groups through Terraform, set up security groups (dev/stage/prod) using Terraform: <https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation>
* To use the NGFW, install the NGFW on your VM: Check Point: <https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM>
* Refer to this guide on using the UserGate NGFW in the cloud: <https://docs.google.com/document/d/1yYwHorzkwXwIUGeG3n_K6Zo-07BVYowZJL7q2bAgVR8/edit?usp=sharing>
* Use NGFW in active-passive mode: <https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/network-sec/checkpoint-2VM_active-active/README.md>