### OS-level AppArmor inventory {#apparmor}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apparmor ||
|#

#### Description

This inventory rule collects AppArmor events and profiles across worker nodes using an inventory agent.

Queries:

apparmor_events. AppArmor events.

```SELECT * FROM apparmor_events;```

profiles. AppArmor profiles changes.

```SELECT * FROM apparmor_profiles;```

profiles_s. AppArmor profiles snaphost.

```SELECT * FROM apparmor_profiles;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
