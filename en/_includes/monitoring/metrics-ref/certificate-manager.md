All {{ certificate-manager-name }} metrics share the `service=certificate-manager` label.

Service metrics:

| Metric name<br>Type, units of measurement | Description |
| --- | --- |
| `certificate.days_until_expiration`<br>`DGAUGE`, days | Number of days before certificate expiration. Special `certificate` label: [Certificate](../../../certificate-manager/concepts/index.md#types) ID. |
| `certificate.is_out_of_order`<br>`DGAUGE`, 0/1 | Certificate availability to provide a TLS connection.</br>The possible values include:<ul><li>`1`: Certificate cannot be used to provide a TLS connection, i.e., the certificate status is `Invalid`, `Revoked`, or its validity period expired.</li><li>`0`: In all other cases, including when the certificate status is `Validating`.</li></ul>Special `certificate` label: [Certificate](../../../certificate-manager/concepts/index.md#types) ID. |
| `quota.certificates_count.limit`<br>`DGAUGE`, number | Limit on the number of certificates per cloud |
| `quota.certificates_count.usage`<br>`DGAUGE`, number | Current usage of the [quota]({{ link-console-quotas }}) for the number of certificates per cloud |