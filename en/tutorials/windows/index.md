---
title: Tutorials for working with Windows in {{ yandex-cloud }}
description: 'Various Windows use cases. Deploying Active Directory, deploying Microsoft Exchange, deploying Microsoft Remote Desktop Services.'
---

# Tutorials for working with Windows in {{ yandex-cloud }}

* [Deploying Active Directory](active-directory.md)
{% if product == "yandex-cloud" %}
{% if product == "cloud-il" %}* [Deploying Microsoft Exchange](exchange.md){% endif %}
* [Deploying Remote Desktop Services](rds.md)
{% endif %}
* [Deploying Remote Desktop Gateway](rds-gw.md)
{% if product == "yandex-cloud" %}
* [Deploying an Always On availability group with an internal network load balancer](mssql-alwayson-lb.md)
{% endif %}
