# Variables

When using macros, triggers, and auto actions, you can insert values from the issue filled to the [comment](set-action.md#create-comment), [formula](set-action.md#section_calc_field), or [HTTP request](set-action.md#create-http) using variables

## Add variable {#add-variable}

1. Create a [macro](../manager/create-macroses.md), [trigger](trigger.md) or [auto action](autoactions.md).

1. Click **Add variable** in the action block of the trigger or auto action. In the case of a macro, add a variable to the message section.

1. Choose the field from the list. When the action is executed, the field value will replace the variable in the text. You can also insert issue parameters that are missing in the variable list. For this, [enter](#variable-type) the variable name into the text.

   {% note info %}

   The list shows variables for all the fields available in {{ tracker-name }}. If you select, for some field, a variable that is not used in a queue or issue, the value won't be inserted.

   {% endnote %}

## Variable types {#variable-type}

The names of variables that correspond to their issue fields follow the format: `{{issue.<field_key>}}`. To get a specific parameter for the issue field, use the following format: `{{issue.<field_key>.<parameter>}}`.

### User attributes {#users-data}

You can get a user's first and last name using default variables. To get specific user attributes, specify a variable using the format `{{issue.<role>.<attribute>}}`, where `<role>` is the role and name used for the user field and `<attribute>` is the attribute indicator.

User roles:
* `assignee`: Issue's assignee.
* `author`: Issue's reporter.
* `followers`: Followers of the issue.
* `access`: Users from the **Access** field.

User attributes:
* `login`: The user's login.
* `firstName`: First name.
* `lastname`: Last name.
* `uid`: ID.
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

The names of variables that correspond to their local issue fields follow the format: `{{issue.local.<field_ID>}}`.

### Date and time modifiers {#date-time}

By default, the date and time is transmitted in the format: `DD month YYYY`, for example: `07 december 2021`. To express other formats of date and time, use modifiers:
* `iso8601`: ISO 8601 format.
* `unixEpoch`: Unix Time format.
* `date`: Writing only date for the fields transmitting date and time.

Here are the examples of variables with date and time modifiers:

| Variable | Value | Notation format |
----- | ----- | -----
| `not_var{{currentDateTime.iso8601}}` | Current date and time in the ISO 8601 format | `YYYY-MM-DDThh:mm:ss.sssZ` |
| `not_var{{currentDateTime.unixEpoch}}` | The current time in Unix Time format | `1638735223` |
| `not_var{{currentDateTime.date}}` | The current date | `06 december 2021` |
| `not_var{{issue.start.iso8601}}` | Issue start date in the ISO 8601 format | `YYYY-MM-DD` |
| `not_var{{issue.start.unixEpoch}}` | Issue start date in the Unix Time format | `1638855321` |

### JSON modifiers {#json-variable}

Some fields can accept multiple values. To get or transmit values from such fields, for example, in [HTTP requests](set-action.md#create-http), convert time to JSON format. For this, add `.json` to the variable name.

Examples of variables in JSON format:

| Variable | Value | Notation format |
----- | ----- | -----
| `not_var{{issue.summary.json}}` | Issue name | `"Issue name"` |
| `not_var{{issue.description.json}}` | Issue description | `"Description"` |
| `not_var{{issue.tags.json}}` | Tags | `["tag1","tag2"]` |
| `{{issue.<role>.login.json}}` | User Login (used in the `author` and `assignee` fields) | `"john-johnson"` |
| `{{issue.<role>.uid.json}}` | User ID (used in the `author` and `assignee` fields) | `1120000000211495` |
| `{{issue.<role>.login.json}}` | User logins (used in the `followers` and `access` fields) | `["john-johnson", "user3993"]` |
| `{{issue.<role>.uid.json}}` | User IDs (used in the `followers` and `access` fields) | `[1120000000211495, 1120000000011060]` |

{% note warning %}

{{ tracker-name }} supports transmitting values in JSON format for simple field types that have such formats as string, number, and arrays of strings or numbers. The "Object" field type isn't supported: for example, the `not_var{{issue.author.json}}` variable won't work. Instead of it, you can use a variable to get a simple field attribute: `not_var{{issue.author.login.json}}`.

{% endnote %}
