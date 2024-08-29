# Dialog tags

Dialogs are _tagged_ using classifiers. {{ speechsense-name }} scans the dialog for specific key phrases, classifies the dialog, and adds a tag to it. For example, there are tags that show the agent has thanked the customer for waiting or that the customer has contacted support a second time.

You can either list keywords in tags or reuse them from [dictionaries](dictionaries.md). Dictionaries hold a list of keywords prepared in advance which you can use them across multiple tags and manage in a single place.

In the dialog text, you can view a list of tags assigned to agent and customer channels. If you click a tag, the words it refers to will be highlighted with the tag's color.

## How to assign tags {#attach}

For tags to be assigned to dialogs, [activate your tag in the project](../operations/project/tag/change.md#activate-tag) after you create it. {{ speechsense-name }} searches for key phrases and assigns a tag only after its activation. If activation is disabled, tags will remain in the dialogs they are already assigned to and will not be added to new ones.

After a tag is activated, [assign a channel to it](../operations/project/tag/change.md#tag-channel). Depending on the channel, {{ speechsense-name }} looks for keywords in different parts of the dialog:

* **Agent and customer**: Whole dialog
* **Agent**: Agent's utterances or messages only
* **Customer**: Customer's utterances or messages only

For example, if a tag has the **Customer** channel assigned, and the tag's keyword only occurs in the agent's utterances or messages, the tag will not be assigned to the dialog.

The channel must be configured at the [project](resources-hierarchy.md#project) level. This enables flexible tag assignment management across different projects.

## Tag groups in {{ speechsense-name }} {#sets}

{{ speechsense-name }} has two tag groups:

* _System tags_: Preset tags. Each project has the same system tags. For such tags, you can only change the channel and the activation status. You cannot create, edit, or delete system tags.

* _Project tags_: Tags the user creates and configures at the project level. Different projects can have different tags.

To create, edit, or delete tags, follow [this guide](../operations/index.md#tag).

## Where tags are displayed {#display}

* On the **Tags** tab in the project.
* In the [dialog filters](dialogs.md#filters) available on the **Dialogs** tab and in the list of [estimation parameters in reports](reports/evaluation-form.md#parameters).
* On the page of the dialog the tag is assigned to.
