---
title: How to write metrics
description: Follow this guide to write metrics.
---

# Writing metrics



If your environment has a {{ prometheus-name }} installation that [collects](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config) metrics, you can connect {{ managed-prometheus-name }} as your [remote storage](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations). To do this, set up [writing](remote-write.md) metrics via the Remote API. 

Otherwise, use any metric collection agent that supports the [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) protocol, such as {{ prometheus-name }} run in [agent mode](https://prometheus.io/docs/prometheus/latest/feature_flags/#prometheus-agent).

Also, when deploying a Linux VM, you can [install {{ unified-agent-full-name }}](prometheus-agent.md) to collect metrics in {{ prometheus-name }} format.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
