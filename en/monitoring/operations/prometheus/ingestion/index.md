---
title: "How to write metrics"
description: "Follow this guide to write metrics."
---

# Writing metrics

If your environment has a {{ prometheus-name }} installation that [collects](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config) metrics, to connect {{ managed-prometheus-name }} as [remote storage](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations), set up metric [writes](remote-write.md) via the Remote API. Otherwise, use any metric collection agent that supports the [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) protocol, such as {{ prometheus-name }} run in [agent mode](https://prometheus.io/docs/prometheus/latest/feature_flags/#prometheus-agent).

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
