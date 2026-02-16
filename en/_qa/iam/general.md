
# General questions about {{ iam-name }}

#### What is the service used for {{ iam-full-name }}? {#usage}

{% include notitle [iam-def](../../_includes/iam-def.md) %}

{{ iam-short-name }} allows you to:
* Manage access permissions for resources by assigning and revoking roles.
* Create [service accounts](../../iam/concepts/users/service-accounts.md). This is a special account used for managing resources {{ yandex-cloud }} via the API.
* Get an IAM token for API authentication.

Other {{ yandex-cloud }} services use the API {{ iam-short-name }} to give you more control over access to their resources. For example, {{ compute-full-name }} additionally provides the `compute.images.user` role to control access to disk images.

#### How do I get started with {{ iam-short-name }}? {#start}

To start working with {{ iam-short-name }}, you need to register with {{ yandex-cloud }}. After registration, you will be able to use the features {{ iam-short-name }}.

#### How much does it cost to use the service{{ iam-short-name }}? {#price}

Using {{ iam-short-name }} is free of charge.

{% include [logs](../logs.md) %}
