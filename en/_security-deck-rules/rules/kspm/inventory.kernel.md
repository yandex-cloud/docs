### OS kernel inventory {#kernel}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.kernel ||
|#

#### Description

This inventory rule collects data on kernel versions, loaded modules, and untrusted address blocklists across worker nodes using an inventory agent.

Queries:

kernel. Kernel version and cmdline.

```SELECT * FROM kernel_info;```

kernel_s. Kernel version and cmdline.

```SELECT * FROM kernel_info;```

kernel_modules. Loaded modules and changes.

```SELECT name, status, size, used_by FROM kernel_modules;```

kernel_modules_s. Loaded modules snapshot.

```SELECT name, status, size, used_by FROM kernel_modules;```

algif_aead_disable. CVE-2026-31431 blacklist check.

```SELECT node, label, value FROM augeas WHERE path='/etc/modprobe.d/disable-algif.conf' AND label != 'disable-algif.conf';```

modules_lpe_check. LPE vulnerabilities module check.

```SELECT node, label, value FROM augeas WHERE path='/etc/modprobe.d/blacklist-lpe.conf' AND label != 'blacklist-lpe.conf';```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
