---
title: Auditing processes and applications on {{ k8s }} worker nodes
description: This rule set covers the inventory and audit of various OS-level properties, components, and process executions across {{ k8s }} worker nodes.
---

# Auditing processes and applications on {{ k8s }} worker nodes

This rule set covers the inventory and audit of various OS-level properties and components across {{ k8s }} worker nodes. 

Intended only for collection of information, the rule set is not security standard compliant. For information analysis, you can use [{{ at-full-name }}](../../../audit-trails/) followed by export to SIEM/SOC systems.

Rule | Check ID
--- | ---
OS-level sysctl parameter inventory | [kspm.inventory.sysctl](../../rules-reference/kspm.md#sysctl)
OS user login inventory | [kspm.inventory.logins](../../rules-reference/kspm.md#logins)
OS-level network settings inventory | [kspm.inventory.network](../../rules-reference/kspm.md#network)
OS-level shared memory inventory | [kspm.inventory.shared-memory](../../rules-reference/kspm.md#shared-memory)
Base OS property inventory | [kspm.inventory.general](../../rules-reference/kspm.md#general)
OS process inventory | [kspm.inventory.processes](../../rules-reference/kspm.md#processes)
OS-level installed package inventory | [kspm.inventory.apps](../../rules-reference/kspm.md#apps)
OS-level user inventory | [kspm.inventory.users](../../rules-reference/kspm.md#users)
OS-level APT repository inventory | [kspm.inventory.apt-sources](../../rules-reference/kspm.md#apt-sources)
OS-level AppArmor inventory | [kspm.inventory.apparmor](../../rules-reference/kspm.md#apparmor)
Osquery agent self-monitoring inventory | [kspm.inventory.selfmon](../../rules-reference/kspm.md#selfmon)
OS-level seccomp event inventory | [kspm.inventory.seccomp](../../rules-reference/kspm.md#seccomp)
OS kernel inventory | [kspm.inventory.kernel](../../rules-reference/kspm.md#kernel) 
