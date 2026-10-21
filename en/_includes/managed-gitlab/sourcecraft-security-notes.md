{% note warning %}

For integration, you need the paid _{{ src-name }} Security_ add-on. The cost is based on the [{{ src-name }} pricing policy]({{ link-src-docs }}/sourcecraft/pricing#security).

Repositories are created in the same [{{ yandex-cloud }} organization](../../organization/concepts/organization.md) where the {{ GL }} instance is located. This organization may be different from the [personal organization]({{ link-src-docs }}/sourcecraft/concepts/#org) created automatically during your sign-up to {{ src-name }}. Make sure the add-on is enabled exactly for the organization the instance is in.

By enabling the integration, you confirm sending the source code to {{ src-name }}. All repositories of the {{ GL }} instance are mirrored, regardless of their visibility settings. In {{ src-name }}, mirrored repositories are created as [private]({{ link-src-docs }}/sourcecraft/concepts/#repo-visibility).

{% endnote %}
