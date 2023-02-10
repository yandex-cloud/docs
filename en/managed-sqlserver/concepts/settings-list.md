---
title: "{{ MS }} setup"
description: "For {{ mms-name }} clusters, you can configure settings that relate to {{ MS }}. The label next to the setting name helps determine which interface is used to set the value of this setting for {{ MS }}: the management console, CLI, API, SQL, or {{ TF }}."
keywords:
  - "{{ MS }}"
  - "{{ MS }} setup"
  - ms sql server
---

# {{ MS }} settings

For {{ mms-name }} clusters, you can configure settings that relate to {{ MS }}.

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}, SQL, or {{ TF }}. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented in a different way, for example, **Fill factor percent** has the following counterparts in the management console:
* `fill_factor_percent` in gRPC API, CLI, {{ TF }} and SQL.
* `fillFactorPercent` in the REST API.

You can use the following settings:

{% include [mms-dbms-settings](../../_includes/mdb/mms-dbms-settings.md) %}