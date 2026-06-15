---
title: Limits
description: '{{ monium-logs-name }} limits: logging and validation of incoming data.'
---

# Limits

There are [configurable quotas](../concepts/limits.md) and permanent limits in {{ monium-logs-name }}.

{% include [limits-logs.md](../../_includes/monium/limits-logs.md) %}

Before it is written, each batch of logs has to be validated. {{ monium-logs-name }} checks timestamps, compliance with limits, and validity of formats.

If the metadata value exceeds the limit, {{ monium-logs-name }} truncates it to a valid size.

If some logs fail to appear in the interface, check the sending parameters and check the data for compliance with specified limits.