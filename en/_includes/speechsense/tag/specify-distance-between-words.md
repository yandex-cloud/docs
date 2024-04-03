(Optional) In the **Distance between words** field, specify the distance between the keywords acceptable when looking for the key phrase.

{% cut "Example" %}

A tag is assigned to the _poor service_ key phrase. The search for the phrase will be performed differently depending on the **Distance between words**:

| Phrase example | Distance: `0` | Distance: `1` | Distance: `2` |
| ----------- | ----------- | ----------- | ----------- |
| poor service | found | found | found |
| poor customer service | not found | found | found |
| poor and slow service | not found | not found | found |

{% endcut %}
