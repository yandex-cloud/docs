* Tag name, description, and color.

* **Critical tag**: The option highlights the tag when you open a dialog. Tags with this option inform you at a glance whether or not the recording contains any critical or inappropriate language, e.g., expletives.

* **Keywords**: Use a separate line for each trigger phrase. {{ speechsense-name }} will scan the dialog for the keywords and tag the recording if it finds any.

* **Exact match**: Enable this option if looking for particular words in dialogs. Disable to include related words in the search (stemming). For example, if this option is disabled and you put _refuse_ in the **Keywords** field, {{ speechsense-name }} will search for dialogs containing _refuse_, _refused_, _refuser_, etc.

* **Distance between words**: Number of additional words between the words in the key phrase for the conversation to be tagged.

   {% cut "Example" %}

   A tag is assigned the _poor service_ key phrase. The search for the phrase will be performed differently depending on the **Distance between words**:

   | Phrase example | Distance: `0` | Distance: `1` | Distance: `2` |
   | ----------- | ----------- | ----------- | ----------- |
   | _poor service_ | found | found | found |
   | _poor customer service_ | not found | found | found |
   | _poor and slow service_ | not found | not found | found |

   {% endcut %}
