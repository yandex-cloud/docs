The `{{ roles-auditor }}` role grants permission to read service configurations and metadata with no access to data.

For example, the `{{ roles-auditor }}` role allows you to perform the following operations:
* View information about a resource.
* View resource metadata.
* View a list of operations with a resource.

{% note info %}

The `{{ roles-auditor }}` role is currently not supported in the following services:
* {{ yds-full-name }}.
* {{ ydb-full-name }}.
* {{ yq-full-name }}.

{% endnote %}
