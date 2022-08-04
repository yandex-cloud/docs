# Variables

If you're using macros, triggers, and auto actions, you can paste values from issue fields into [your comment](set-action.md#create-comment), [formula](set-action.md#section_calc_field), or [HTTP request](set-action.md#create-http) using variables.

## Add a variable {#add-variable}

1. Create [a macro](../manager/create-macroses.md), [trigger](trigger.md), or [auto action](autoactions.md).

1. Click **Add variable** in the auto action or trigger section. For the macro, add a variable to the message section.

1. Select a field from the list. When performing an action, the variable will be swapped for the field value. You can also insert issue parameters missing from the variable list. To do this, [enter](#variable-type) the name of the variable in the text body.

    {% note info %}

    The list shows variables for all fields available in {{ tracker-name }}. If you select a variable for a field not used in the queue or issue, no value will be inserted.

    {% endnote %}

## Variable types {#variable-type}

The names of variables that correspond to their issue fields follow the format: `{{issue.<field_key>}}`. To get a specific parameter for the issue field, use the following format: `{{issue.<field_key>.<parameter>}}`.

### User Attributes {#users-data}

You can get a user's first and last name using default variables. To get specific user attributes, specify a variable using the format `{{issue.<role>.<attribute>}}`, where `<role>` is the role and name used for the user field and `<attribute>` is the attribute indicator.


User roles:

* `assignee` — the assignee.
* `author` — the reporter.
* `followers` — followers.
* `access` — users listed in the **Access** field.

User attributes:

* `login` — login.
* `firstName` — first name.
* `lastName` — last name.
* `uid` — ID.
* `email` — email address.

For example, the variable `not_var{{issue.followers.email}}` lets you receive email addresses of all of users following an issue.

### Additional issue parameters {#extra-data}

Some issue parameters are not displayed in any fields, but you can still get their values using the following variables:

| Variable | Value |
| ----- | ----- |
| `not_var{{issue.parent}}` | Parent issue |
| `not_var{{issue.previousStatus}}` | Previous issue status |
| `not_var{{issue.previousQueue}}` | Previous issue queue |
| `not_var{{issue.checklistDone}}` | Number of completed checklist items |
| `not_var{{issue.votes}}` | Number of votes for the issue |

### Local fields {#local-fields}

The names of variables that correspond to their local issue fields follow the format: `{{issue.local.<field_ID>}}`.

### Date and time modifiers {#date-time}

By default, the date and time follow the format of `DD month YYYY`. Example: `07 December 2021`. You can enable modifiers to display date and time in other formats:

* `iso8601` — the ISO 8601 standard.
* `unixEpoch` — the Unix Time standard.
* `date` —  only display the date in the date and time fields.

Examples of formatting used for variables with date and time modifiers:

| Variable | Value | Record format |
| ----- | ----- | ----- |
| `not_var{{currentDateTime.iso8601}}` | Current date and time in the ISO 8601 format | `YYYY-MM-DDThh:mm:ss.sssZ` |
| `not_var{{currentDateTime.unixEpoch}}` | Current time in Unix Time format | `1638735223` |
| `not_var{{currentDateTime.date}}` | Current date | `06 December 2021` |
| `not_var{{issue.start.iso8601}}` | The issue start date in the ISO 8601 format | `YYYY-MM-DD` |
| `not_var{{issue.start.unixEpoch}}` | Issue start date in the Unix Time format | `1638855321` |

### JSON Modifiers {#json-variable}

Fields can include multiple values. To receive or send the values used for such fields (such as [HTTP requests](set-action.md#create-http)), you first need to convert them to JSON. To do this, add `.json` to the variable's name.

Examples of JSON formatting in variables:

| Variable | Value | Record format |
| ----- | ----- | ----- |
| `not_var{{issue.summary.json}}` | Issue name | `"Issue name"` |
| `not_var{{issue.description.json}}` | Issue description | `"Description"` |
| `not_var{{issue.tags.json}}` | Tags | `["tag1","tag2"]` |
| `{{issue.<role>.login.json}}` | User Login (used in the `author` and `assignee` fields) | `"john-johnson"` |
| `{{issue.<role>.uid.json}}` | User ID (used in the `author` and `assignee` fields) | `1120000000211495` |
| `{{issue.<role>.login.json}}` | User logins (used in the `followers` and `access` fields) | `["john-johnson", "user3993"]` |
| `{{issue.<role>.uid.json}}` | User IDs (used in the `followers` and `access` fields) | `[1120000000211495, 1120000000011060]` |

{% note warning %}

{{ tracker-name }} supports sending values as JSON for simple field types, which use strings and numbers as well as number and string arrays. The "Object" field type is not supported: for example, the variable `not_var{{issue.author.json}}` won't work. Instead, you can use a variable that gets you a simple field attribute: `not_var{{issue.author.login.json}}`.

{% endnote %}

