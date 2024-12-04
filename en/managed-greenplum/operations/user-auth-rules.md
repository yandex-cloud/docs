# User authentication rules

[User authentication](../concepts/user-authentication.md) rules determine which users and from which addresses are allowed to connect to a cluster, as well as which databases they can access.

You can:

* [Add rules](#add-rules)
* [Edit rules](#edit-rules)
* [Move a rule](#replace-rule)
* [Delete a rule](#delete-rule)

{% note warning %}

The rule priority depends on the order of lines: rules are read from top to bottom with the first suitable rule applied. If authentication based on the first suitable rule fails, other rules are not applied.

{% endnote %}

## Adding rules {#add-rules}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** and specify its parameters:

        {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

    1. To add another rule, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** once again.
    1. Click **{{ ui-key.yacloud.common.save }}**.

    {% note info %}

    The default rule is added automatically at the end of the list; it allows authentication for all users in all databases and from all hosts using the `md5` method (password-based authentication).

    {% endnote %}

{% endlist %}

## Editing rules {#edit-rules}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}** and update the rule parameters:

        {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Moving a rule {#replace-rule}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Click ![image](../../_assets/console-icons/grip.svg) for the rule and move it up or down.
    1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Deleting a rule {#delete-rule}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the rule and select **{{ ui-key.yacloud.common.delete }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
