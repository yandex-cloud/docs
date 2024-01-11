# Variables

When using macros, triggers, and auto actions, you can insert values from the issue filled to the [comment](set-action.md#create-comment), [formula](set-action.md#section_calc_field), or [HTTP request](set-action.md#create-http) using variables

## Add variable {#add-variable}

1. Create a [macro](../manager/create-macroses.md), [trigger](trigger.md) or [auto action](autoactions.md).

1. Click **Add variable** in the action block of the trigger or auto action. In the case of a macro, add a variable to the message section.

1. Choose the field from the list. When the action is executed, the field value will replace the variable in the text. You can also insert issue parameters that are missing in the variable list. For this, [enter](#variable-type) the variable name into the text.

   {% note info %}

   The list shows variables for all the fields available in {{ tracker-name }}. If you select a variable not used in a queue or issue for a field, the value will not be substituted.

   {% endnote %}

## Variable types {#variable-type}

The variable names assigned to issue fields, have the format: `{{issue.<field_key>}}`. To get a specific parameter of an issue field, use the following format: `{{issue.<field_key>.<parameter>}}`.

### User attributes {#users-data}

You can use default variables to get the user's first and last name. To obtain specific user attributes, use a variable in the format `{{issue.<role>.<attribute>}}`, where `<role>` is the role and name of the field in which the user is specified, and `<attribute>` is the attribute.

User roles:
* `assignee`: Issue essignee
* `author`: Author
* `followers`: Followers
* `access`: Users from the **{{ ui-key.startrek-backend.fields.issue.access }}** field

User attributes:
* `login`: Login
* `firstName`: First name
* `lastname`: Last name
* `uid`: ID
* `email`: Email address.

For example, by using the `not_var{{issue.followers.email}}` variable, you can get email addresses for all the issue's followers.

{% note info %}

Usernames that only contain numbers may be interpreted incorrectly when executing requests to {{ tracker-name}}. In the event of an error, we recommend using the `uid` attribute instead of the `login` one.

{% endnote %}

### Additional issue parameters {#extra-data}

Some issue parameters aren't displayed in fields, but you can get their values using variables as well:

| Variable | Value |
----- | -----
| `not_var{{issue.parent}}` | Parent issue |
| `not_var{{issue.previousStatus}}` | Previous issue status |
| `not_var{{issue.previousQueue}}` | Previous issue queue |
| `not_var{{issue.checklistDone}}` | Number of completed items from the checklist |
| `not_var{{issue.votes}}` | Number of votes for the issue |

### Local fields {#local-fields}

The variable names assigned to local issue fields, have the format: `{{issue.local.<field_ID>}}`.

### Date and time modifiers {#date-time}

By default, the date and time is transmitted in the format: `DD month YYYY`, for example: `07 december 2021`. To express other formats of date and time, use modifiers:
* `iso8601`: ISO 8601 format.
* `unixEpoch`: Unix Time format.
* `date`: Writing only date for the fields transmitting date and time.

Here are the examples of variables with date and time modifiers:

| Variable | Value | Notation format |
----- | ----- | -----
| `not_var{{currentDateTime.iso8601}}` | Current date and time in the ISO 8601 format | `YYYY-MM-DDThh:mm:ss.sssZ` |
| `not_var{{currentDateTime.unixEpoch}}` | Current time in Unix Time format | `1638735223` |
| `not_var{{currentDateTime.date}}` | Current date | `06 december 2021` |
| `not_var{{issue.start.iso8601}}` | Issue start date in ISO 8601 format | `YYYY-MM-DD` |
| `not_var{{issue.start.unixEpoch}}` | Issue start date in Unix Time format | `1638855321` |

### JSON modifiers {#json-variable}

Some fields can accept multiple values. To get or transmit values from such fields, for example, in [HTTP requests](set-action.md#create-http), convert time to JSON format. For this, add `.json` to the variable name.

Examples of variables in JSON format:

| Variable | Value | Notation format |
----- | ----- | -----
| `not_var{{issue.summary.json}}` | Issue name | `"Issue name"` |
| `not_var{{issue.description.json}}` | Problem description | `"Description"` |
| `not_var{{issue.tags.json}}` | Tags | `["tag1","tag2"]` |
| `{{issue.<role>.login.json}}` | User's login (for the `author` and `assignee` fields). | `"ivan-ivanov"` |
| `{{issue.<role>.uid.json}}` | User ID (for the `author` and `assignee` fields). | `1120000000211495` |
| `{{issue.<role>.login.json}}` | Logins of users (for the `followers` and `access` fields). | `["ivan-ivanov", "user3993"]` |
| `{{issue.<role>.uid.json}}` | User IDs (for the `followers` and `access` fields). | `[1120000000211495, 1120000000011060]` |
| `not_var{{issue.components.display.json}}` | Components | `["component1","component2"]` |

{% note warning %}

{{ tracker-name }} supports transmitting values in JSON format for simple field types that have such formats as string, number, and arrays of strings or numbers. The "Object" field type is not supported: for example, the `not_var{{issue.author.json}}` variable will not work. Instead of it, you can use a variable to get a simple field attribute: `not_var{{issue.author.login.json}}`.

{% endnote %}

## Comments {#comment-variables}

Using variables, you can get some attributes of issue comments. These variables have the `{{<comment type>.<attribute>}}` format, where `<comment type>` is selected depending on the author (user or robot), and `<attribute>` is the comment's parameter.

The possible <comment type> values include:
* `userComment`: Comment from the current edit operation. If a user has made more than one comment, the first one will be considered.
* `generatedComment`: Comment generated automatically as a result of a fired trigger or auto action.

Use the parameters below to get comment details:

| Variable | Value |
----- | -----
| `not_var{{<comment type>.id}}` | Comment ID |
| `not_var{{<comment type>.text}}` | Text of the comment |
| `not_var{{<comment type>.author}}` | Comment author |
