### OS-level shared memory inventory {#shared-memory}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.shared-memory ||
|#

#### Description

This inventory rule collects data on shared memory segments across worker nodes using an inventory agent.

Queries:

shm_s. Shared-memory events pack.

```SELECT sm.shmid, sm.owner_uid, o.username AS owner_username, sm.size, sm.permissions, sm.atime, sm.attached, sm.creator_pid, pe_c.path AS creator_path_bin, pe_c.cmdline AS creator_cmdline, sm.creator_uid, c.username AS creator_username, sm.ctime, sm.dtime, sm.locked, sm.pid, pe.path AS path_bin, pe.cmdline, sm.status FROM shared_memory sm LEFT JOIN users o ON sm.owner_uid = o.uid LEFT JOIN users c ON sm.creator_uid = c.uid LEFT JOIN process_events pe_c ON sm.creator_pid = pe_c.pid LEFT JOIN process_events pe ON sm.pid = pe.pid;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
