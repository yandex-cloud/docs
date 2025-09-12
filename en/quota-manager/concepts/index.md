# {{ quota-manager-name }} concepts

{% include [preview-quota](../../_includes/quota-manager/preview-quota.md) %}

{% include [about-quota](../../_includes/quota-manager/about-quota.md) %}

For example, your quota of VMs in the cloud is 12. Quota usage will range from 0 to 12, representing the number of currently used VMs. If you need more VMs than that, you need to increase the quota, e.g., to 25. Quota usage will thus range from 0 to 25.

Potentially, you can increase your quotas up to the _limits_.

**Limits** are technical constraints due to the {{ yandex-cloud }} architecture, physical characteristics of the hardware, or external limitations. For example, the {{ certificate-manager-name }} limits are dictated by the Let's Encrypt certification rules in place.

The diagram below illustrates the relationship between quotas and limits.

![image](../../_assets/quota-manager/quotas-limits.svg)

Quotas are allocated and applied at the {{ yandex-cloud}} cloud level; they are distributed between all the folders and services.

{{ quota-manager-name }} helps you monitor your quota values and usage automatically. Employ the API methods to get notified as soon as your consumption hits the threshold values. It means you will never be late to increase your quota or prevent an abnormal situation and overconsumption of resources.

Currently, you can use the following quota management interfaces: 

* [Console]({{ link-console-quotas }}) and [API](../../quota-manager/api-ref/authentication.md): Getting info and submitting a quota update request.
* [CLI](cli-ref/): Getting quota info.

Going forward, quotas will be updatable via the CLI.

## Quota allocation {#quotas-allocation}

When you create a cloud, the default quotas are allocated automatically. When you update a quota, its default value is not saved. You cannot reset a quota to its default value.

There are no quotas for some resources. You will see **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-empty }}** next to these resources in the console.

Quotas can potentially be increased up to the limit values. Quotas do not guarantee that resources are available.

Quota management via the CLI and API relies on quota ID in `<service_name>.<resource_name>.<unit_of_measurement>` format, e.g., `dns.zones.count`, `serverless.networkPackets.rate`, or `mdb.memory.size`. 

See [{#T}](../../overview/concepts/quotas-limits.md#quotas-limits-default) for quota IDs and default quotas for all {{ yandex-cloud}} services.

You can look up quota usage info in the console on the [{{ quota-manager-name }}]({{ link-console-quotas }}) page or via an [API request](../operations/list-quotas.md).

## Why quotas are needed {#quotas-need}

Quotas serve as a soft constraint for requesting resources and allow you to manage cloud service usage: with quotas, new users cannot take up too much resources for testing purposes.

## Resource types {#resources-types}

In {{ yandex-cloud }}, quota management is based on the [resource hierarchy](../../resource-manager/concepts/resources-hierarchy.md). Therefore, you will need to specify the resource type in the CLI command or API request:

* `resource-manager.cloud`
* `organization-manager.organization`
* `billing.account`