* Tag name, description, and color.

* **{{ ui-key.yc-ui-talkanalytics.tags.important-tag-key-value }}**: If this option is enabled, the tag will be highlighted when you open a dialog. Tags with this option inform you at a glance whether or not the recording contains any critical or inappropriate language, e.g., expletives.

* **{{ ui-key.yc-ui-talkanalytics.tags.conditions }}**:

   * In the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, use a separate line for each trigger phrase. {{ speechsense-name }} will scan the dialog for the keywords and tag the recording if it finds any.

      Along with the listed keywords, you can also specify [dictionaries](../../../speechsense/concepts/dictionaries.md). They contain a set of trigger phrases prepared in advance. Tags will thus be assigned to dialogs containing phrases from the list in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field and from the specified dictionaries. To use dictionaries, click ![icon](../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** and select the dictionaries you need from the drop-down list.

   * **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}**: Enable this option if looking for particular words in dialogs. Disable to include related words in the search (stemming). For example, if this option is disabled and you put _refuse_ in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, {{ speechsense-name }} will search for dialogs containing _refuse_, _refused_, _refuser_, etc.

   * **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}**: Number of additional words between the words in the key phrase for the conversation to be tagged.

      {% cut "Example" %}

      A tag is assigned the _poor service_ key phrase. The search for this phrase will be performed differently depending on the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field value:

      | Example in a dialog | Distance: `0` | Distance: `1` | Distance: `2` |
      | ----------- | ----------- | ----------- | ----------- |
      | _poor service_ | found | found | found |
      | _poor customer service_ | not found | found | found |
      | _poor and slow service_ | not found | not found | found |

      {% endcut %}

* **{{ ui-key.yc-ui-talkanalytics.tags.exceptions }}**:

   * In the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, list [exclusion phrases](../../../speechsense/concepts/tags.md#exclusion-phrases). Use a separate line for each trigger phrase. If the dialogue contains an exclusion phrase, the tag will not trigger.

      {% cut "Example" %}

      Let's say we create a tag called `Fire` and add the `flamed` key phrase to it.
      The tag will trigger on the phrase `The battle flamed up`; however, such a phrase does not indicate a fire. This is a false positive. To fix it, let's add the `battle flamed up` exclusion phrase.
      Now the tag will not trigger on the phrase `The battle flamed up` but it will on `The stove flamed up`.

      {% endcut %}


   * (Optional) Select the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** option.

      If this option is disabled, the tag will not trigger on specified exclusion phrases or related phrases. If you need to ignore only the exclusion phrases, enable this option.

   * (Optional) In the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field, specify the distance between words in an exclusion phrase acceptable for a search.

* **{{ ui-key.yc-ui-talkanalytics.tags.restrictions }}**: Add or delete [constraints](../../../speechsense/concepts/tags.md#tag-limitations).

   When selecting the **{{ ui-key.yc-ui-talkanalytics.tags.binding-events.silence-key-value }}** constraint, specify the pause length in seconds.

   For each constraint, you can set the search direction and limit the search area. By default, the search area size is set to its maximum (1,000 utterances).
