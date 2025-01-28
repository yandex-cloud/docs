---
title: Secrets in {{ metadata-hub-name }}
description: A secret is a set of versions that store the connection's secure data. A version contains sets of keys and values.
---

# Secret

{% include notitle [preview](../../_includes/note-preview.md) %}

A secret is a set of versions that store the connection's secure data. A version contains sets of _keys_ and _values_. A key is a non-secret name that identifies a value. A value is secret information about a connection.

You can set up access to secrets using [{{ iam-full-name }}](../../iam/index.yaml). The roles available for different use cases are described in the [{#T}](../security/index.md) section.

Secrets are stored in [{{ lockbox-full-name }}](../../lockbox/index.yaml). To see which secrets store the connection information, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** in the list of services in your directory. The **{{ ui-key.yacloud.lockbox.label_section-secrets }}** page will list the secrets whose names match the [connection IDs](../operations/update-connection.md#list-connections).

You can set up access to versions of a secret in addition to access to the secret itself. To do this, you need to assign the `{{ roles-lockbox-admin }}` or `{{ roles-lockbox-payloadviewer }}` role. For more information about managing access, see [{{ lockbox-full-name }} access management: What roles do I need](../security/connection-manager-roles.md#choosing-roles).