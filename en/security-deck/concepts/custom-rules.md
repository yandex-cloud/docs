---
title: Custom rules in {{ sd-full-name }}
description: Custom rules in the {{ cspm-name }} and {{ kspm-name }} modules allow you to customize standard security rules for the in-house requirements.
---

# Custom rules

Custom rules allow you to customize [{{ cspm-name }}](cspm.md) and [{{ kspm-name }}](kspm.md) standard security rules for the in-house requirements.

To work with custom rules, you need the `security-deck.rules.editor` [role](../security/index.md) or higher.

{% include [add-rule-to-set](../../_includes/security-deck/add-rule-to-set.md) %}

## Custom rules in {{ cspm-name }} {#cspm-rules}

Custom rules in {{ cspm-name }} are created based on a basic standard rule. A basic rule defines the verification logic you can supplement or modify.

The following settings are available:

* Editing a name and description.
* Changing severity.
* Supplementing or editing resolution guidelines.
* Editing configurable parameters specific to a basic rule.

## Custom rules in {{ kspm-name }} {#kspm-rules}

Custom rules in {{ kspm-name }} are created from scratch based on the internal security policies. As opposed to {{ cspm-name }} rules, they do not require a basic rule.

The following settings are available:

* Rule name and description.
* Check type: sets when to apply a rule. Currently, only the Admission option is supported: a rule applies when creating or changing a {{ k8s }} object.
* Rule severity.
* Guidelines on fixing violations.
* Policy rule YAML code.

By default, a new rule is created in the `Audit` mode. After creating a rule, you can [change the mode](../operations/kspm/manage-rule-modes.md).

#### Useful links {#see-also}

* [Creating a custom rule in {{ cspm-name }}](../operations/cspm/create-custom-rule.md)
* [Creating a custom rule in {{ kspm-name }}](../operations/kspm/create-custom-rule.md)
* [How to work with custom rule sets](../operations/custom-rules-sets/index.md)
