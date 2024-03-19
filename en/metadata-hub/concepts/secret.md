# Secret

{% include notitle [preview](../../_includes/note-preview.md) %}

A secret consists of a set of versions that store secure connection data. A version contains sets of _keys_ and _values_. A key is an unclassified name for a value by which it can be identified. The value is the connection secret information.

You can configure access to secrets using the [{{ iam-full-name }}](../../iam/index.yaml) service. Available roles for different use cases are described in section [{#T}](../security/index.md).

Secrets are stored in the [{{ lockbox-full-name }}](../../lockbox/index.yaml) service. To see which secrets store information about connections, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** in your directory in the list of services. The **{{ ui-key.yacloud.lockbox.label_section-secrets }}** page will list the secrets whose names match the [connection IDs](../operations/update-connection.md#list-connections).

You can configure access to secret versions in addition to access to the secret itself. To do this, you need to assign the role `{{ roles-lockbox-admin }}` or `{{ roles-lockbox-payloadviewer }}`. Read more about access control in the section [Access management {{ lockbox-full-name }} - What roles do I need](../security/index.md#choosing-roles).