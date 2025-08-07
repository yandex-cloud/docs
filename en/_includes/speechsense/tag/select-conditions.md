* Under **{{ ui-key.yc-ui-talkanalytics.tags.conditions }}**:

    * In the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, list trigger phrases. Use a separate line for each one. If a conversation contains one of these phrases, it will get a tag.

        {% include [key-phrases-restrictions](../data/key-phrases-restrictions.md) %}

        Along with the listed keywords, you can also specify [dictionaries](../../../speechsense/concepts/dictionaries.md). They contain a set of trigger phrases prepared in advance. If you specify multiple dictionaries, their contents will be added together as if by the "OR" logical operator. Tags will thus be assigned to dialogs containing phrases from the list in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field and from the specified dictionaries. To use dictionaries, click ![icon](../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** and select the dictionaries you need from the drop-down list.

    * Optionally, select **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}**.

        When searching through a dialog, {{ speechsense-name }} finds both the key phrase and related words. For example, if you put _refuse_ in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, {{ speechsense-name }} will also be looking for _refused_, _refuser_, etc. If you want to tag only records with exact matches, enable the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** option.

    * (Optional) In the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field, specify the number of additional words between the key phrase words for the conversation to be tagged.

        {% cut "Example" %}

        {% include [tag-distance-ex.md](tag-distance-ex.md) %}

        {% endcut %}

* Under **{{ ui-key.yc-ui-talkanalytics.tags.exceptions }}**:

    * In the **{{ ui-key.yc-ui-talkanalytics.tags.exceptions-keywords }}** field, list [exclusion phrases](../../../speechsense/concepts/tags.md#exclusion-phrases). Use a separate line for each one. If the dialog contains an exclusion phrase, the tag will not trigger.

        {% cut "Example" %}

        Let's say we create a tag called `Fire` and add the `flamed` key phrase to it.
        The tag will trigger on the phrase `The battle flamed up`; however, such a phrase does not indicate a fire. This is a false positive. To fix it, let's add the `battle flamed up` exclusion phrase.
        Now the tag will not trigger on the phrase `The battle flamed up` but it will on `The stove flamed up`.

        {% endcut %}

        Along with the listed phrases, you can also specify dictionaries. Tags will not be assigned to dialogs that contain phrases from the list and from the specified dictionaries. To use dictionaries, click ![icon](../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** and select the dictionaries you need from the drop-down list.

    * Optionally, select **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}**.

        When searching through a dialog, {{ speechsense-name }} finds both the key phrase and related words. For example, if you type _refuse_ in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, {{ speechsense-name }} will not tag dialogs with the words _refused_, _refuser_, etc. If you want to ignore only specific phrases, enable the **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}** option.

    * (Optional) In the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field, specify the distance between words in an exclusion phrase acceptable for a search.

* Under **{{ ui-key.yc-ui-talkanalytics.tags.binding-events-key-value }}**, add and customize [tag restrictions](../../../speechsense/concepts/tags.md#tag-limitations).

    When selecting the **{{ ui-key.yc-ui-talkanalytics.tags.binding-events.silence-key-value }}** constraint, specify the pause length in seconds.

    For each constraint, you can set the search direction and limit the search area. By default, the search area size is set to its maximum (1,000 utterances).

    To delete a constraint, click ![icon](../../../_assets/console-icons/trash-bin.svg) on the right side of it.
