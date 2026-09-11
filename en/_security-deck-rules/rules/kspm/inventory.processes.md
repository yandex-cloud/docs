### OS process inventory {#processes}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.processes ||
|#

#### Description

This inventory rule collects data on running processes across worker nodes using an inventory agent.

Queries:

executions_lite. All processes in the system (without tree).

```SELECT ps.pid pid, ps.path path, ps.cmdline cmdline, ps.cwd cwd, ps.parent parent, ps.time time, ps.uid uid, ps.auid auid FROM process_events ps WHERE ps.syscall IN ('execve', 'execveat');```

running. Changes in running processes.

```SELECT pid, parent, uid, euid, path, cmdline, on_disk FROM processes;```

running_s. Running processes snapshot.

```SELECT pid, parent, uid, euid, path, cmdline, on_disk FROM processes;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
