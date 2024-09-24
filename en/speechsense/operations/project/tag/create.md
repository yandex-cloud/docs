# Creating a tag

You can only create a [tag](../../../concepts/tags.md) in a [project](../../../concepts/resources-hierarchy.md#project). To do this, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the project.

When creating a tag, the following options are available:

* [Create a new tag](#new-tag).
* [Duplicate an existing tag](#duplicate).
* [Add a dependent tag](#create-dependent-tag) for an existing tag.

## Creating a tag {#new-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab, click ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Name the tag.
1. (Optional) Describe the tag.
1. (Optional) Specify a [channel](../../../concepts/tags.md#attach) based on where you want {{ speechsense-name }} to look for the tag keywords:

   * **{{ ui-key.yc-ui-talkanalytics.connections.fields.operator }}**: Agent's utterances or messages.
   * **{{ ui-key.yc-ui-talkanalytics.connections.fields.client }}**: Customer's utterances or messages.

   You can select one channel or both channels.

1. {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
1. {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
1. Under **{{ ui-key.yc-ui-talkanalytics.tags.conditions }}**:

   1. In the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, list trigger phrases. Use a separate line for each each trigger phrase. If a conversation contains one of these phrases, it will get a tag.

      Along with the listed keywords, you can also specify [dictionaries](../../../concepts/dictionaries.md). They contain a set of trigger phrases prepared in advance. Tags will be assigned to dialogs that contain phrases from the list in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field and from the dictionaries you specify. To use dictionaries, click ![icon](../../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** and select the dictionaries you need from the drop-down list.

   1. {% include [select-exact-match](../../../../_includes/speechsense/tag/select-exact-match.md) %}
   1. {% include [specify-distance-between-words](../../../../_includes/speechsense/tag/specify-distance-between-words.md) %}

1. Under **{{ ui-key.yc-ui-talkanalytics.tags.exceptions }}**:

   1. In the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, list [exclusion phrases](../../../concepts/tags.md#exclusion-phrases). Use a separate line for each each trigger phrase. If the dialog contains an exclusion phrase, the tag will not trigger.

      {% cut "Example" %}

      Let's say we create a tag called `Fire` and add the `flamed` keyword to it.
      The tag will trigger on the phrase `Flamed up in reddening shame`; however, this phrase does not indicate a fire. This is a false positive. To fix it, let's add `flamed up in reddening shame` as an exclusion phrase.
      Now the tag will not trigger on `Flamed up in reddening shame` but it will on `House flamed up`.

      {% endcut %}

      Along with the listed phrases, you can also specify dictionaries. Tags will not be assigned to dialogs that contain phrases from the list and from the specified dictionaries. To use dictionaries, click ![icon](../../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** and select the dictionaries you need from the drop-down list.

   1. (Optional) Select the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** option.

      When searching through a dialog, {{ speechsense-name }} finds both the key phrase and related words. For example, if you type _refuse_ in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, {{ speechsense-name }} will not tag dialogs with the words _refused_, _refuser_, etc. If you want to ignore only specific phrases, enable the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** option.

   1. (Optional) In the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field, specify the distance between words in an exclusion phrase acceptable for a search.

1. Under **{{ ui-key.yc-ui-talkanalytics.tags.binding-events-key-value }}**, add and customize [tag restrictions](../../../concepts/tags.md#tag-limitations).

   If the **{{ ui-key.yc-ui-talkanalytics.tags.binding-events.silence-key-value }}** restriction is selected, set pause duration in seconds.

   For each restriction, you can specify search direction and limit the search area. By default, the search area is set to its maximum (1,000 phrases).

1. Click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

Once created, the tag is activated automatically.

## Duplicating a tag {#duplicate}

When duplicating, a new tag gets the settings of the original one. Later on, you can change the settings as needed. This is convenient if you want to create a tag set up in the same way as the previously created one.

To duplicate a tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab.
1. {% include [duplicate](../../../../_includes/speechsense/tag/duplicate.md) %}
1. {% include [change-settings-when-duplicating](../../../../_includes/speechsense/tag/change-settings-when-duplicating.md) %}
1. Click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

## Creating a dependent tag {#create-dependent-tag}

For any tag in your project, you can create a [dependent tag](../../../concepts/tags.md#dependent-tags):

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab, select a tag and click ![icon](../../../../_assets/console-icons/ellipsis.svg).
1. From the drop-down list, select ![icon](../../../../_assets/console-icons/link.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-dependent-tag }}**.
1. [Configure](#new-tag) the tag and click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
