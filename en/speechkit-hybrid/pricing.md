---
editable: false
---

# {{ sk-hybrid-full-name }} pricing


{{ sk-hybrid-full-name }} cost depends on the [licensing model](architecture.md) and [system requirements](system-requirements.md), and we discuss it on case-by-case basis. {{ sk-hybrid-name }} offers two licensing models: Cloud Billing and Yubikey.

### Cloud Billing {#billing}

In the Cloud Billing model, you only pay for speech recognition and synthesis requests. There are no limitations on the number of sessions and requests per second.

If choosing the Cloud Billing licensing model, you need to establish a constant communication channel with {{ yandex-cloud }} servers to deliver request metrics. The content of synthesis and recognition requests is not transmitted and remains within the user's network. All transmitted data is logged, and logs are stored on the user's servers.

### Yubikey {#yubikey}

If choosing the Yubikey licensing model, the user gets from {{ speechkit-full-name }} and connects locally to their server at least one physical hardware authentication device (Yubikey) containing performance data for the services and contract duration info. No data, including request metrics, ever leaves the user's network; therefore, {{ sk-hybrid-name }} services can operate within an offline network.

The Yubikey licensing model uses a hardware authentication device to limit the maximum number of speech recognition sessions and maximum speech synthesis throughput. If looking to increase performance or extend your licenses, order a new hardware authentication device.

## Pricing {#pricing}

You can get the cost info for {{ sk-hybrid-name }} with any licensing model on request.