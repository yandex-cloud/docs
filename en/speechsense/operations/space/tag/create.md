# Creating a space tag

To create a space [tag](../../../concepts/tags.md), you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role for the space. You can [create a tag from scratch](#new-tag) or [duplicate](#duplicate) an existing one.

## Create a space tag {#new-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.
1. On the **Tags** tab, click ![icon](../../../../_assets/console-icons/tag.svg) **Create tag**.
1. Enter a tag name.
1. (Optional) Specify the tag description
1. {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
1. {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
1. {% include [specify-keywords](../../../../_includes/speechsense/tag/specify-keywords.md) %}
1. {% include [select-exact-match](../../../../_includes/speechsense/tag/select-exact-match.md) %}
1. {% include [specify-distance-between-words](../../../../_includes/speechsense/tag/specify-distance-between-words.md) %}
1. (Optional) Disable **Available in all space projects**.

   This option is enabled by default, allowing you to manage the tag in all projects within the space.

1. Click **Create tag**.

Now the tag is available in the projects, but it is deactivated by default, so it does not apply to dialogs yet. To assign the tag to dialogs, [activate it](../../project/tag/change.md#activate-tag) in the projects you need and [assign a channel to the tag](../../project/tag/change.md#tag-channel). For more information on how tags work, see [{#T}](../../../concepts/tags.md#attach).

## Duplicating a space tag {#duplicate}

When duplicating, a new tag gets the settings of the original one. Later on, you can change the settings as needed. This is convenient if you want to create a tag set up in the same way as the previously created one.

To duplicate a space tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space in question and then to the **Tags** tab.
1. {% include [duplicate](../../../../_includes/speechsense/tag/duplicate.md) %}
1. {% include [change-settings-when-duplicating](../../../../_includes/speechsense/tag/change-settings-when-duplicating.md) %}
1. Click **Create tag**.
