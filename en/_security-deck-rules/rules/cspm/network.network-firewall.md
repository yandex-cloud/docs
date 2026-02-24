### In Virtual Private Cloud, a security group is created; the default security group is not used {#network-firewall}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | network.network-firewall ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for the presence of custom security groups in VPC networks.

{% endnote %}

A security group (SG) is a resource created at the [cloud network level](https://yandex.cloud/en/docs/vpc/concepts/network#network). Once created, a [security group](https://yandex.cloud/en/docs/vpc/concepts/security-groups) can be used in [Yandex Cloud services](https://yandex.cloud/en/docs/vpc/concepts/security-groups#security-groups-apply) to control network access to an object it applies to.

A default security group (DSG) is created automatically while creating a new [cloud network](https://yandex.cloud/en/docs/vpc/concepts/network#network). The default security group has the following properties:

* It will allow any network traffic, both egress and ingress, in the new cloud network.
* It applies to traffic passing through all subnets in the network where the DSG is created.
* It is only used if no security group is explicitly assigned to the object yet.
* You cannot delete the DSG: it is deleted automatically when deleting the network.

The default security group is a convenient but insecure mechanism that automatically allows all network traffic (incoming and outgoing) for your network objects. While simplifying the initial setup, such openness creates significant risks:

* Attackers can get access to resources through public interfaces.
* Uncontrolled traffic makes your network more vulnerable to DDoS attacks and port scanning.
* The DSG remains active until you assign another security group to the object.

We recommend you to [create](https://yandex.cloud/en/docs/vpc/operations/security-group-create) a security group of your own with [rules](https://yandex.cloud/en/docs/vpc/concepts/security-groups#security-groups-rules) explicitly allowing only the traffic you need (e.g., HTTP/HTTPS for web servers or SSH for administration) and assign this group to your [cloud objects](https://yandex.cloud/en/docs/vpc/concepts/security-groups#security-groups-apply) [VMs](https://yandex.cloud/en/docs/compute/concepts/vm), [Kubernetes clusters](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#kubernetes-cluster), etc.) to override the DSG.

This is important because without your rules cloud resources remain open to all and any connections from the internet, whereas security groups of your own enable the principle of [least privilege](https://yandex.cloud/en/docs/iam/best-practices/using-iam-securely#restrict-access), thus reducing the attack surface.

You can combine security groups by assigning up to five groups per object for more flexible access control.

#### Guides and solutions

* [Create](https://yandex.cloud/en/docs/vpc/operations/security-group-create) a security group in each Virtual Private Cloud with restricted access rules, so that it can be assigned to cloud objects.