# Dialog tags

_Tags_ are created and configured at the project level. Different projects can have different tags.

{{ speechsense-name }} automatically detects whether the dialog contains specific key phrases or phrases with similar meaning and tags it. For example, there are tags that show the agent has thanked the customer for waiting or that the customer has contacted support for a second time.

To be assigned to a dialog, tags need to be activated. The activation takes place automatically as soon as you create a tag. With the tag activated, {{ speechsense-name }} analyses the dialogs and assigns the tag if the dialog meets the specified conditions.

{% note info %}

To get analyzed for dictionary and semantic tagging, dialogs must be 60 days old or less, starting from the current day. The period is counted starting from the current day.

To get analyzed for semantic Pro tagging, dialogs must be new, i.e., uploaded after the tag creation or activation.

{% endnote %}

There are the following tag types in {{ speechsense-name }}:

* [Semantic tags](#sense-tags) rely on dialog analysis with the help of [semantic attributes](reports/sense-attributes.md) you provide search queries for.
* [Semantic Pro tags](#sense-pro-tags) rely on dialog analysis with the use of complex search queries. They are an improved version of semantic tags.
* [Dictionary tags](#dictionary-tags) are based on searching for specific words and phrases in the dialogs.

For more info on creating, updating, and deleting tags, see [these guides](../operations/index.md#tag).

## Where tags are displayed {#display}

* On the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab in the project.
* In reports:
   * In the [dialog filters](dialogs.md#filters) on the **{{ ui-key.yc-ui-talkanalytics.projects.dialogs }}** tab.
   * In the [evaluation parameter](reports/evaluation-form.md#parameters) list.
* On the page of the dialog the tag is assigned to.

## Semantic tags {#sense-tags}

Semantic tags rely on dialog analysis with the help of [semantic attributes](reports/sense-attributes.md). When creating a [semantic tag](../operations/project/tag/create-sense-tag.md#new-tag), you select one of the semantic attributes and provide a search query. {{ speechsense-name }} analyses the dialogs and tags them if the dialog is semantically relevant to the search query in the context of the selected semantic attribute. 

To manage tagging with more accuracy, set the minimum probability of the dialog satisfying the specified conditions. Only the dialogs for which that probability equals or exceeds the specified level will be tagged.

> For example, you select **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}** as the semantic attribute, `Vacation in Sochi` as your search query, and set `90%` probability. {{ speechsense-name }} will tag the dialogs with topics semantically related to `Vacation in Sochi` with a probability of at least 90%.

{{ speechsense-name }} operates the following semantic attributes:

* **{{ ui-key.yc-ui-talkanalytics.neuro-tags.themes-key-value }}**.
* **{{ ui-key.yc-ui-talkanalytics.neuro-tags.reasons-key-value }}**.
* **{{ ui-key.yc-ui-talkanalytics.neuro-tags.results-key-value }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.problems }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.operator_keywords }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.client_keywords }}**.
* **{{ ui-key.yc-ui-talkanalytics.statements.common_question }}**: Preset questions of universal applicability.

By default, semantic tags get the `Agent` and `Customer` channels assigned at the same time, and this cannot be changed.

### Suggestions {#suggestions}

When [creating a semantic tag](../operations/project/tag/create-sense-tag.md#new-tag), you can either enter your search query yourself or use suggestions. The available suggestions depend on the selected semantic attribute:

* For general questions, suggestions are preset and do not depend on what dialogs are selected for analysis.
* For all the other attributes, suggestions are dynamically generated for the selected dialogs. If you change your selection of dialogs for analysis, suggestions will be regenerated.

When generating suggestions, {{ speechsense-name }} analyzes the selection and generates possible key phrases for the specified semantic attribute. This requires at least 100 dialogs; otherwise, {{ speechsense-name }} will not be able to conduct a reliable analysis. There are no restrictions on the maximum number; however, if your selection contains more than 1,000 dialogs, {{ speechsense-name }} will randomly select only 1,000 dialogs for analysis.

If there are more than 1,000 dialogs in the selection and you are not satisfied with the suggestions that were generated, click **{{ ui-key.yc-ui-talkanalytics.neuro-tags.refresh-suggestions }}** for {{ speechsense-name }} to re-select 1,000 dialogs at random and generate new suggestions.

### Testing semantic tags {#test-sense-tags}

When creating or editing a semantic tag, you can test it on a selection of dialogs. During the test, {{ speechsense-name }} analyzes whether or not the dialog matches the conditions specified in the tag. The output will list the dialogs in descending order of match probability. If there are more than 1,000 dialogs in the selection, {{ speechsense-name }} will select 1,000 dialogs covering the whole match probability range. During the test, you can change the semantic attribute, search query, or match probability value depending on the test results for more accurate tagging.

For more information about tag testing, see [this guide](../operations/project/tag/test.md).

### Using semantic tags for dialog evaluation {#use-sense-tags-for-dialog-evaluation}

You can use semantic tags to evaluate the agent's performance or the client's behavior, e.g., whether the agent was polite, whether the client was rude, etc. To do this, create a semantic tag with the relevant semantic attribute and search query. {{ speechsense-name }} will assign this tag to the dialogs that meet this criterion.

> For example, if looking for dialogs where the customer was rude with the agent, select the following when creating the tag:
> * Semantic attribute: **{{ ui-key.yc-ui-talkanalytics.statements.common_question }}**.
> * Search query: **Was the client rude or aggressive at least once during the conversation?**
>
> {{ speechsense-name }} will tag dialogs where the customer was rude or aggressive during the conversation.

Such use of semantic tags allows you to [filter dialogs](../operations/data/manage-dialogs.md#filter-dialogs) based on the agent's performance criteria and the client’s behavior, and use the same data as a filter or parameter in your [reports](../operations/data/manage-reports.md).

## Semantic Pro tags {#sense-pro-tags}

Semantic Pro tags rely on dialog analysis with the use of complex search queries. You provide a search query that may include mutliple topics. {{ speechsense-name }} analyses the dialogs and tags them if the dialog is semantically relevant to the search query.


### Testing semantic Pro tags {#test-sense-pro-tags}

{% include [note-pro](../../_includes/speechsense/tag/note-pro.md) %}

When creating or editing a semantic Pro tag, you can test it on a selection of dialogs. During the test, {{ speechsense-name }} analyzes whether or not the dialog matches the search query specified in the tag.

{% include [note-pro](../../_includes/speechsense/tag/test-pro-additional.md) %}

During the test, you can change the search query depending on the test results for more accurate tagging.

For more information about tag testing, see [this guide](../operations/project/tag/test.md).

### Using semantic Pro tags for dialog evaluation {#use-sense-pro-tags-for-dialog-evaluation}

You can use semantic Pro tags to evaluate the agent's performance and the customer's behavior against complex semantic criteria, e.g., whether the agent was able to sell a travel package without offering a discount to the customer. To do this, create a semantic Pro tag with the relevant search query. {{ speechsense-name }} will assign this tag to the matching dialogs.

> For example, if looking for dialogs where a client bought a tour to the Maldives with no discount offered, specify the search query as follows when creating the tag: **tour to the Maldives purchased without a discount**.
>
> {{ speechsense-name }} will assign this tag to the dialogs where a client bought a tour to the Maldives with no discount offered.

Such use of semantic Pro tags allows you to [filter dialogs](../operations/data/manage-dialogs.md#filter-dialogs) based on the agent's performance criteria and the client’s behavior, and use the same data as a filter or parameter in your [reports](../operations/data/manage-reports.md).

### Comparing semantic Pro tags and basic semantic tags {#sense-pro-tag-vs-sense-tag}

#|
|| **Function** | **Semantic tag** | **Semantic Pro tag** | **Example** ||
|| Context | Individual phrase | Entire dialog | — ||
|| Dependency search | No | Yes | — ||
|| Dialog analysis | Simple query within a single [semantic attribute](reports/sense-attributes.md) | Complex query with multiple topics or conditions | 
* Simple query: `Topics` for the attribute, `Vacation in Sochi` for the query.
* Complex query: `tour to the Maldives purchased without a discount`.  ||
|| Recalculation based on historical data | Automatic recalculation within two months from the dialog upload date | No | — ||
|#

## Dictionary tags {#dictionary-tags}

Dictionary tags are based on scanning dialogs for specified key phrases. You can either list the key phrases for tags or reuse them from [dictionaries](dictionaries.md). Dictionaries contain a ready-made list of key phrases which you can use across multiple tags and manage from the same place.

{% include [key-phrases-restrictions](../../_includes/speechsense/data/key-phrases-restrictions.md) %}

To fine-tune key phrase detection:

* Enable the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** setting. In this case, related phrases will not be considered in key phrase detection.
* Set the distance between words. This setting determines the maximum allowable distance between words in a key phrase. Here is an example:

  > {% include [tag-distance-ex.md](../../_includes/speechsense/tag/tag-distance-ex.md) %}

In the dialog text, you can see the list of tags assigned for the agent and customer [channels](#dictionary-tags-channel). If you click a tag, the words it refers to will be highlighted with the tag's color.

For more information about dictionary tags, see [this guide](../operations/project/tag/create-dictionary-tag.md).

### Dictionary tag channel {#dictionary-tags-channel}

_Channel_ sets the part of the dialog {{ speechsense-name }} will search for keywords in. You can use the following channels:

* **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator-and-client }}**: Whole dialog.
* **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator }}**: Agent's utterances or messages only.
* **{{ ui-key.yc-ui-talkanalytics.tags.channel.client }}**: Customer's utterances or messages only.

Depending on the channel, {{ speechsense-name }} looks for keywords in different parts of the dialog.

> For example, the tag will not be assigned if it has the **{{ ui-key.yc-ui-talkanalytics.tags.channel.client }}** channel assigned, and its keyword only occurs in the agent's speech or messages.

The channel must be configured at the [project](resources-hierarchy.md#project) level. This enables flexible tag assignment management across different projects. For more information about assigning a channel to a dictionary tag, see [this guide](../operations/project/tag/change-dictionary-tag.md#tag-channel).

### Tag search area constraints {#tag-limitations}

In {{ speechsense-name }}, you can use _constraints_ to narrow down the search area for dictionary tag keywords. If you set a constraint, a tag will trigger only if {{ speechsense-name }} finds the keyword in the specified part of the dialog.

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

You can add multiple constraints to a single tag. The constraints sum up as per the logical `AND` operator.

### Exclusion phrases {#exclusion-phrases}

To increase a dictionary tag's accuracy, add _exclusion phrases_ to it. If the dialog contains exclusion phrases, these will not trigger the tag.

You can add exclusion phrases manually or upload a phrase dictionary.

> Let's say we create a tag called `Fire` and add the `flamed` keyword to it.
> The tag will trigger on the phrase `The battle flamed up`; however, such a phrase does not indicate a fire. This is a false positive. To fix it, let's add the `battle flamed up` exclusion phrase.
> Now the tag will not trigger on the phrase `The battle flamed up` but it will on `The stove flamed up`.

To fine-tune the exclusion phrase:

* Enable the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** setting. In this case, related phrases will not be considered in exclusion phrase detection.
* Set the distance between words. This setting determines the maximum allowable distance between words in an exclusion phrase.

### Testing dictionary tags {#test-dictionary-tags}

When creating or editing a dictionary tag, you can test it on a selection of dialogs. During the test, {{ speechsense-name }} will analyze the dialogs from the specified selection and list the dialogs eligible for the tag.

For more information about tag testing, see [this guide](../operations/project/tag/test.md).

## Dependent tags {#dependent-tags}

You can [create](../operations/project/tag/create-dependent-tag.md) a _dependent tag_ for any {{ speechsense-name }} tag. A dependent tag is one that triggers only if the _main_ tag has done so. A main tag is one for which a dependent tag was created. 

Dictionary, semantic, and semantic Pro tags can act as basic and dependent tags, in any combination. Dependent tags can be nested down to any depth.

Dictionary tag dependency is implemented through the **{{ ui-key.yc-ui-talkanalytics.tags.binding-events.classifier }}** [constraint](#tag-limitations) automatically added to the dependent tag. You cannot delete this constraint. If you create a dependent dictionary tag for a semantic tag, you cannot set a constraint for this dictionary tag.

You can edit dependent tags in accordance with their type as basic [semantic](../operations/project/tag/change-sense-tag.md), [semantic Pro](../operations/project/tag/change-sense-pro-tag.md), or [dictionary](../operations/project/tag/change-dictionary-tag.md) tags.

When you delete the main tag, all its dependent tags will also be deleted.
