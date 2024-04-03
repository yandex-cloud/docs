# Changing a space tag

When managing a space [tag](../../../concepts/tags.md), you can:

* [Edit it](#edit).
* [Change tag availability in projects](#change-availability).

You can change system tags at space level only in terms of their availability in projects. To change a project tag, follow [this guide](../../project/tag/change.md).

To change a project tag, you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role for the project.

{% note warning %}

Changes to the tag apply only to the dialogs uploaded after the changes are made.

{% endnote %}

## Editing a project tag {#edit}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.
1. On the **Tags** tab, click the line with the tag.
1. In the window that opens, set the following configuration:

   {% include [tag-settings](../../../../_includes/speechsense/tag/tag-settings.md) %}

1. Click **Save**.

## Change tag availability in projects {#change-availability}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space in question and then to the **Tags** tab.
1. In the line with the tag you need, enable **Tag availability in projects** to activate the tag and manage it in all the projects of this space. Disable to deactivate the tag and remove it from projects.

{% include [changes-after-activation](../../../../_includes/speechsense/tag/changes-after-activation.md) %}
