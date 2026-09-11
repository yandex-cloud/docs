### OS-level seccomp event inventory {#seccomp}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.seccomp ||
|#

#### Description

This inventory rule collects seccomp events across worker nodes using an inventory agent.

Queries:

seccomp_events. Seccomp events.

```SELECT * FROM seccomp_events;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
