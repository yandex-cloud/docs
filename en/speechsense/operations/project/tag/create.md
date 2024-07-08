# Creating a project tag

To create a project [tag](../../../concepts/tags.md), you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role in the project. You can [create a tag from scratch](#new-tag) or [duplicate](#duplicate) an existing one.

## Creating a project tag {#new-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of interest and select a project.
1. On the **Tags** tab, click ![icon](../../../../_assets/console-icons/tag.svg) **Create tag**.
1. Enter a tag name.
1. (Optional) Specify the tag description
1. {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
1. {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
1. {% include [specify-keywords](../../../../_includes/speechsense/tag/specify-keywords.md) %}
1. {% include [select-exact-match](../../../../_includes/speechsense/tag/select-exact-match.md) %}
1. {% include [specify-distance-between-words](../../../../_includes/speechsense/tag/specify-distance-between-words.md) %}
1. (Optional) Disable **Activate tag**. This option is enabled by default.

   An activated tag applies to all new dialogs uploaded to the project after the tag is activated.

1. Click **Create tag**.

You can search for key phrases in the whole dialog or a particular channel: agent or customer. For {{ speechsense-name }} to look for keywords and assign tags in the correct channel, specify it for the new tag:

1. In the line with the tag, click ![icon](../../../../_assets/console-icons/ellipsis.svg) and then ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **Change channel**.
1. Specify the channel based on where you want {{ speechsense-name }} to search for the tag keywords:

   * **Agent and customer**: Whole dialog
   * **Agent**: Agent's utterances or messages only
   * **Customer**: Customer's utterances or messages only

1. Click **Save**.

## Duplicating a project tag {#duplicate}

When duplicating, a new tag gets the settings of the original one. Later on, you can change the settings as needed. This is convenient if you want to create a tag set up in the same way as the previously created one.

To duplicate a project tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of interest and select a project.
1. Go to the **Tags** tab.
1. {% include [duplicate](../../../../_includes/speechsense/tag/duplicate.md) %}
1. {% include [change-settings-when-duplicating](../../../../_includes/speechsense/tag/change-settings-when-duplicating.md) %}
1. Click **Create tag**.
1. [Specify the tag channel](change.md#tag-channel).
