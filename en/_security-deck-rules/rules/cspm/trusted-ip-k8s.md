### Access to Kubernetes components through control ports is only allowed for trusted IPs {#trusted-ip-k8s}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | trusted-ip-k8s ||
|#

#### Description

We recommend that you allow access to Kubernetes components in your cloud infrastructure through control ports for trusted IP addresses only.

This check displays a list of all [security groups](https://yandex.cloud/en/docs/vpc/concepts/security-groups) containing broad rules that allow access through control ports:

* **Port range**: `22`, `3389`, or `21`.
* **Protocol**: `TCP`.
* **Source**: `CIDR`.
* **CIDR blocks**: IPv4 `0.0.0.0/0` or IPv6 `::/0` (access allowed from any address).

#### Guides and solutions to use

Make sure your security groups' rules allow access to Kubernetes components through control ports for trusted IP addresses only.

**Guides and solutions to use**:

If such access is allowed for a broad range of addresses, specify the trusted IP addresses in the relevant access rules:

1. In the [management console](https://console.yandex.cloud/), select the folder where your security group resides.
2. [Go](https://yandex.cloud/en/docs/console/operations/select-service#select-service) to Virtual Private Cloud.
3. In the left-hand panel, select **Security groups** and in the list that opens, click the line with the group in question.
4. In the top-right corner, click **Edit**.
5. In the **Rules** section, in the line with the rule allowing access through control ports for a broad range of addresses, click **...** and select **Edit**.
6. In the **CIDR blocks** field, enter only the trusted address for which access will be allowed, e.g., `198.51.100.17/32`.

    To add several trusted addresses to a rule, click **Add**.
7. Click **Save** to save the rule settings.
8. Click **Save** to save the security group settings.