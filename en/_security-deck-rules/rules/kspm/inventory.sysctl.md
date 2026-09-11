### OS-level sysctl parameter inventory {#sysctl}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.sysctl ||
|#

#### Description

This inventory rule collects data on kernel sysctl parameters across worker nodes using an inventory agent.

Queries:

options. Listing every system control options.

```SELECT * FROM system_controls;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
