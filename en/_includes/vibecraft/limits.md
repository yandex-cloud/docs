#### Quotas {#vc-quotas}

{{ vc-name }} is based on {{ src-name }} and {{ yandex-cloud }} components that are subject to the following limitations:
* [Quotas in {{ ca-full-name }}]({{ link-src-docs }}/code-assistant/concepts/limits).
* [{{ src-full-name }}]({{ link-src-docs }}/sourcecraft/concepts/limits) quotas and limits.
* [{{ container-registry-full-name }}](../../container-registry/concepts/limits) quotas and limits.
* [{{ serverless-containers-full-name }}](../../serverless-containers/concepts/limits) quotas and limits.
* [{{ lockbox-full-name }}](../../lockbox/concepts/limits) quotas and limits.
* [{{ ydb-full-name }}](../../ydb/concepts/limits) quotas and limits.
* [{{ api-gw-full-name }}](../../api-gateway/concepts/limits) quotas and limits.
* [{{ dns-full-name }}](../../dns/concepts/limits) quotas and limits.

#### Limits {#vc-limits}

Type of limit | Value
--- | ---
Number of projects edited at the same time | 3
Number of published projects | 10

{% note tip %}

Aside from the limits, consider the {{ src-name }} and {{ yandex-cloud }} quotas as well.

With a paid {{ src-name }} subscription, you can [increase your neurocredit quota]({{ link-src-docs }}/sourcecraft/operations/increase-neurocredit-quota) or the [quotas for CI process runtime and private repository storage]({{ link-src-docs }}/sourcecraft/operations/increase-resource-quotas) on your own. Actual consumption exceeding the volume under your active subscription is [billable on a separate basis]({{ link-src-docs }}/sourcecraft/pricing#payg).

To increase quotas for public repositories of educational and open-source projects, contact [support]({{ link-console-support }}?createTicket=true).

If you need more {{ yandex-cloud }} resources, you can increase your quotas in one of the following ways:
* [Make a request to increase your quotas]({{ link-console-quotas }}).
* Contact [support]({{ link-console-support }}) and specify which quotas you want increased and by how much.

You can manage your {{ yandex-cloud }} quotas with [{{ quota-manager-full-name }}](../../quota-manager/quickstart).

{% endnote %}
