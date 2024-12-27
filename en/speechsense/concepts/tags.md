# Dialog tags

_Tags_ are created and configured at the project level. Different projects can have different tags.

{{ speechsense-name }} automatically detects whether a dialog contains specific key phrases and adds a tag to it. For example, there are tags that show the agent has thanked the customer for waiting or that the customer has contacted support a second time.

You can either list key phrases in tags or reuse them from [dictionaries](dictionaries.md). Dictionaries contain a list of key phrases prepared in advance which you can use across multiple tags and manage in a single place.

To fine-tune key phrase detection:

* Enable the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** setting. In this case, related phrases will not be considered in key phrase detection.
* Set the distance between words. This setting determines the maximum allowable distance between words in a key phrase.

  > For example, a tag is assigned the _poor service_ key phrase. The search for this phrase will be performed differently depending on the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field value:
  >
  > | Example in a dialog | Distance: `0` | Distance: `1` | Distance: `2` |
  > | ----------- | ----------- | ----------- | ----------- |
  > | _poor service_ | found | found | found |
  > | _poor customer service_ | not found | found | found |
  > | _poor and slow service_ | not found | not found | found |

In the dialog text, you can view a list of tags assigned to agent and customer channels. If you click a tag, the words it refers to will be highlighted with the tag's color.

For more info on creating, updating, and deleting tags, see [these guides](../operations/index.md#tag).

## Where tags are displayed {#display}

* On the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab in the project.
* In reports:
   * In the [dialog filters](dialogs.md#filters) on the **{{ ui-key.yc-ui-talkanalytics.projects.dialogs }}** tab.
   * In the [evaluation parameter](reports/evaluation-form.md#parameters) list.
* On the page of the dialog the tag is assigned to.

## How to assign tags {#attach}

To assign tags to a dialog, they need to be activated. Once you create a tag, it gets activated. After activation, {{ speechsense-name }} searches for key phrases in project dialogs and assigns the tag.

For a tag to work correctly, [assign a channel to it](../operations/project/tag/change.md#tag-channel). Depending on the channel, {{ speechsense-name }} looks for keywords in different parts of the dialog:

* **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator-and-client }}**: Whole dialog.
* **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator }}**: Agent's utterances or messages only.
* **{{ ui-key.yc-ui-talkanalytics.tags.channel.client }}**: Customer's utterances or messages only.

> For example, if a tag has the **{{ ui-key.yc-ui-talkanalytics.tags.channel.client }}** channel assigned, and the tag's keyword only occurs in the agent's utterances or messages, the tag will not be assigned to the dialog.

The channel must be configured at the [project](resources-hierarchy.md#project) level. This enables flexible tag assignment management across different projects.

## Tag search area constraints {#tag-limitations}

With _constraints_ in {{ speechsense-name }}, you can narrow down the search area for keywords from tags. If you set a constraint, a tag will trigger only if {{ speechsense-name }} finds the keyword in the specified part of the dialog.

> For example, you configure a constraint with the following settings:
> * Constraint type: **{{ ui-key.yc-ui-talkanalytics.tags.binding-events.dialog-start-key-value }}**.
> * **{{ ui-key.yc-ui-talkanalytics.tags.search-area-key-value }}**: **{{ ui-key.yc-ui-talkanalytics.tags.search-area.after-key-value }}**.
> * **{{ ui-key.yc-ui-talkanalytics.tags.restrict-search-area-key-value }}**: Up to three utterances.
>
> {{ speechsense-name }} will only search for keywords in the first three utterances from the beginning of the dialog.

Every constraint in {{ speechsense-name }} is associated with a particular event that marks the beginning of the search area. Available events:

* Beginning of the dialog.
* Long pause (pause length is measured in seconds and set manually).
* The agent interrupted the customer.
* The customer interrupted the agent.
* End of the dialog.
* Main tag triggered (for dependent tag).

By default, the maximum search area size is set to 1,000 utterances. To further refine the search area, specify the search direction from the event (forward, backward, or both) and the number of utterances to include in the search.

You can add multiple constraints to a single tag. Constraints are combined using the logical AND operation.

## Dependent tags {#dependent-tags}

You can [create](../operations/project/tag/create.md#create-dependent-tag) a _dependent tag_ for any {{ speechsense-name }} tag. A dependent tag is one that triggers only when the _main_ tag does so. A main tag is one for which a dependent tag was created.

Tag dependency is implemented through the **{{ ui-key.yc-ui-talkanalytics.tags.binding-events.classifier }}** [constraint](#tag-limitations) that is automatically added to the dependent tag. You cannot delete this constraint.

Dependent tags can be nested down to any depth.

When you delete the main tag, all its dependent tags will also be deleted.

## Exclusion phrases {#exclusion-phrases}

To increase tag accuracy, add _exclusion phrases_ to it. If the dialogue contains exclusion phrases, they will not trigger the tag.

You can add exclusion phrases manually or upload a phrase dictionary.

> Let's say we create a tag called `Fire` and add the `flamed` keyword to it.
> The tag will trigger on the phrase `The battle flamed up`; however, such a phrase does not indicate a fire. This is a false positive. To fix it, let's add the `battle flamed up` exclusion phrase.
> Now the tag will not trigger on the phrase `The battle flamed up` but it will on `The stove flamed up`.

To fine-tune the exclusion phrase:

* Enable the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** setting. In this case, related phrases will not be considered in exclusion phrase detection.
* Set the distance between words. This setting determines the maximum allowable distance between words in an exclusion phrase.
