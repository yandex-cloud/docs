Optionally, in the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field, specify the distance between the keywords acceptable for a key phrase search.

{% cut "Example" %}

A tag is assigned the _poor service_ key phrase. The search for this phrase will be performed differently depending on the **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** field value:

| Phrase example | Distance: `0` | Distance: `1` | Distance: `2` |
| ----------- | ----------- | ----------- | ----------- |
| _poor service_ | found | found | found |
| _poor customer service_ | not found | found | found |
| _poor and slow service_ | not found | not found | found |

{% endcut %}
