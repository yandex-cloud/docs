---
title: "Query language in {{ tracker-full-name }}"
description: "This section describes the query language used in {{ tracker-full-name }}. Using the query language, you can search for issues by name, description, and comment, filter issues by multiple values of a single parameter, use comparison operations and logical operators in filters, set a function as a value to compare, and set the issue sorting order in filtering results."
---

# Query language in {{ tracker-name }}

If you want to do more than simple filters allow, set a filter using a query language.

The query language allows you to:

* Search for issues [by name, description, and comment](#query-text).

* Filter issues [by multiple values of a single field](#query-multiple-values).

* Use the [comparison operators](#query-compare) and [logical operators](#query-multiple-conditions) in filters.

* Specify [functions](#query-functions) as a comparison value.

* Set the [sort order](#query-result-sort) for issues in the filter results.

## Query format {#query-format}

To set up a filter using a query language:

1. Open the [**Issues** page]({{ link-tracker }}issues).

1. Click ![](../../_assets/tracker/svg/query-language.svg) **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}** in the top-right corner of the page.

1. Enter a query and click **Apply**.

General request format:

```no-highlight
"<parameter>": "<value>"
```

To set a parameter, start typing its name and select a relevant one from the suggestion. For the full list of parameters, see [Filter parameters](#filter-parameters).

#### Examples {#format-example}

> - Issues that are in the `TEST` queue:
>    ```no-highlight
>    "Queue": "TEST"
>    ```
> - Issues with Ivan Ivanov as an assignee:
>    ```no-highlight
>    "Assignee": "Ivan Ivanov"
>    ```
> - Issues with the `{{ ui-key.startrek-backend.applinks.samsara.status.open }}` or `{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}` status.
>    ```no-highlight
>    "Status": "{{ ui-key.startrek-backend.applinks.samsara.status.open }}", "{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}"
>    ```
> - Issues created from January 1 to January 30, 2017:
>    ```no-highlight
>    "Created": "2017-01-01".."2017-01-30"
>    ```

## Multiple parameter values {#query-multiple-values}

If you want to filter issues by multiple values of the same parameter, use a comma-separated list:
```no-highlight
<parameter>: "<value_1>", "<value_2>", "<value_3>"
```

#### Example {#multiple-example}

> ```no-highlight
> author: "vpupkin","iivanov"
> ```
> This filter will return all the issues that were reported by `vpupkin` or `iivanov`.

## Filters with multiple conditions {#query-multiple-conditions}

You can combine multiple conditions per filter using logical operators:

- `AND`: Logical **{{ ui-key.startrek-backend.messages.trigger.condition.type.and }}** operator. Conditions combined with this operator must all be met at the same time.

   For example:
   ```no-highlight
   <parameter_1>: "<value_1>" AND <parameter_2>: "<value_2>"
   ```
   This query will return the issues that have `<parameter_1>` set to `<value_1>` **{{ ui-key.startrek-backend.messages.trigger.condition.type.and }}** `<parameter_2>` set to `<value_2>`.

   {% note info %}

   Instead of using the `AND` operator, you can just list the fields separated by a space.

   {% endnote %}

- `OR`: Logical **{{ ui-key.startrek-backend.messages.trigger.condition.type.or }}** operator. At least one of the conditions must be fulfilled.

   For example:
   ```no-highlight
   <parameter_1>: "<value_1>" OR <parameter_2>: "<value_2>"
   ```
   This query will return the issues that have at least one of the conditions met: `<parameter_1>` set to `<value_1>` **{{ ui-key.startrek-backend.messages.trigger.condition.type.or }}** `<parameter_2>` set to `<value_2>`.

You can create complex filters by combining multiple operators in a single request:

```no-highlight
<parameter_1>: "<value_1>" AND <parameter_2>: "<value_2>" OR <parameter_3>: "<value_3>"
```

When complex filters are processed, the `AND` operators are applied first. To change the order of actions, use parentheses:

```no-highlight
<parameter_1>: "<value_1>" AND (<parameter_2>: "<value_2>" OR <parameter_3>: "<value_3>")
```

## Searching by text {#query-text}

In addition to searching by parameters, you can use regular text search. To do this, enter text in the query field and click **Apply**.

All the textual fields of the issue are searchable: name, description, and comments.

* To search only in one of the fields, specify it in the parameter:

   * `Summary`: Issue name.

   * `Description`: Issue description.

   * `Comment`: Text in comments.

   * `History`: Text in the history of changes.

   ```no-highlight
   Description: "This area is familiar to me as the outskirts of China"
   ```

   This filter will return all the issues whose descriptions include the words from the original query and their forms.

* To only find issues with text that exactly matches the query text, use the `#` operator:

   ```no-highlight
   Summary: #"Version 2.0"
   ```

   This filter will only return the issues whose name exactly matches the query text.

* To only find issues that contain text exactly matching the query text and additional text, use the `#` operator and add the `||` operator where the additional text is placed:

   ```no-highlight
   Description`: #"Make ||"
   ```

   This filter will only return the issues with text that contains the word "Make" and some more words after it. For example, "Make lists" or "Make a map".

   The `||` operator can only be used together with the `#` operator.

* To only find issues that have no text fragment in a given field, use the `!` operator:

   ```no-highlight
   Summary: !"UI"
   ```

   This filter will only return the issues whose name does not contain a `UI` text fragment.

* To only find issues whose name does not exactly match the query text, use the `~` operator. This operator only applies to the `Summary` field:

   ```no-highlight
   Summary: ~"UI Update 2.0"
   ```

   This filter will only return the issues whose name does not match the query text.

## Searching by user {#query-user}

You can search issues by names and usernames specified in the issue fields. There are several ways to specify names and usernames in queries.

* Username with `@` at the end: `login@`. Use it to search for an exact match containing the username.

   For example:
   ```no-highlight
   Assignee: user3370@
   ```
   This query will display all issues that have `user3370` specified as the assignee. This is the most accurate way to search by user.

* Full name in quotation marks: `"<full_name>"`. Use it to search for matches containing the user's full name.

   For example:
   ```no-highlight
   Author: "Ivan Ivanov"
   ```
   This query will display all issues that have Ivan Ivanov specified as the reporter. Please note that the output may contain issues of other reporters with the username or name similar to `Ivan Ivanov`. To avoid this, search by username with the `@` character.

* Full name and username. Use it to search for exact matches containing any of these.

   Examples:

   * `Followers: Ivan`. This query will display all issues followed by users whose first name is Ivan no matter what their last name is.

   * `Followers: ivan`. This query will display all issues followed by a user with the `ivan@` username or with the first name Ivan .

## Searching by local field {#local_fields}

To specify a [local issue field](../local-fields.md) in the query, enter the key of the queue to which the field is linked, followed by a dot and the field's name in Russian or English. If the field's name includes several words, enclose the name in double quotes. Examples:

```
DEVS.Test engineer: "Ivan Ivanov"
```
```
DEVS."Lead test engineer": "Ivan Ivanov"
```
```
DEVS.tester: user3370@
```

## Date and time parameters {#query-date-time}

Many issue parameters have the values of date and time. The query language supports several formats for such parameters:

#### Date {#date}

* MM/DD/YYYY

   For example:
   ```
   04/30/2017
   ```

* DD.MM.YYYY

   For example:
   ```
   30.04.2017
   ```

* DD-MM-YYYY

   For example:
   ```
   30-04-2017
   ```

* YYYY-MM-DD

   For example:
   ```
   2017-04-30
   ```

#### Date and time {#date-time}

To specify exact date and time, use the format:
```
"YYYY-MM-DD XXh:XXm:XXs"
```

For example:
```
"2017-04-30 17:25:00"
```


#### Time intervals {#time-intervals}

* You can express time intervals in weeks, days, hours, minutes, and seconds in the format:
   ```
   "XXw XXd XXh XXm XXs"
   ```

   For example, a time interval of 3 days, 5 hours, and 32 minutes can be expressed as:
   ```
   "3d 5h 32m"
   ```

* You can set intervals using acceptable date formats:
   ```
   DD-MM-YYYY .. DD-MM-YYYY
   ```

   For example, a filter for the issues created within a certain interval:
   ```
   Created: 01-01-2017 .. 02-03-2017
   ```

* Time intervals can be set using [functions](#query-functions) as well as comparison, addition, and subtraction operations.

   For example, a filter for the issues created not earlier than a week and one day ago.

   ```
   Created: > today() - "1w 1d"
   ```

## Comparison operators {#query-compare}

Apart from checking for an exact match, the query language supports the following comparison operations:

* **Not equal to**
   ```no-highlight
   <parameter>: !"<value>"
   ```

* **Greater than**, **Less than**, **Less than or equal to**, and **Greater than or equal to**

   The operations accept only numeric and date-and-time parameters.
   ```no-highlight
   <parameter>: ><number>
   <parameter>: <<number>
   <parameter>: >=<number>
   <parameter>: <=<number>
   ```

* **In the range**

   The operation only applies to numeric parameters.
   ```no-highlight
   <parameter>: <number_1> ... <number_2>
   ```

#### Examples {#compare-example}

Search for issues with a deadline in a few days or today:

> - Issues with a deadline in 3 days:
>    ```no-highlight
>    Deadline: <= today() +3d and deadline: >= today()
>    ```

To customize parameters, use [functions](#query-functions) in a query:

> - Issues with a deadline today:
>    ```no-highlight
>    Deadline: today()
>    ```

## Functions {#query-functions}

In addition to exact parameter values, you can use functions. A function is a variable whose value is calculated at the query runtime. For example, the function `today()` takes the value of today's date. To show all issues created today, use the query:

```no-highlight
Created: today()
```

| Function | Result | Example |
----- | ----- | -----
| ```empty()  ``` | Empty value (no parameter specified) | Find issues that have no assignee specified:<br/>``` Assignee: empty() ``` |
| ```notEmpty() ``` | Any non-empty value (parameter specified) | Find issues that have a deadline set:<br/>``` Deadline: notEmpty() ``` |
| ```me()  ``` | Name of the user running the query | Find issues created by you:<br/>``` Author: me() ``` |
| ```now() ``` | Current time with to-the-minute precision | Find issues created in the last 12 hours:<br/>``` Created: >now()-12h ``` |
| ```today() ``` | Time interval corresponding to current date | Find issues created today:<br/>``` Created: today() ``` |
| ```week() ``` | Date interval corresponding to current week | Find issues created this week:<br/>``` Created: week() ``` |
| ```month()  ``` | Date interval corresponding to current month | Find issues created this month:<br/>``` Created: month() ``` |
| ```quarter()  ``` | Date interval corresponding to current quarter | Find issues created in this quarter:<br/>``` Created: quarter() ``` |
| ```year() ``` | Date interval corresponding to current year | Find issues created this year:<br/>``` Created: year() ``` |
| ```unresolved() ``` | Issues without a resolution | Find all issues that have no resolution:<br/>``` Resolution: unresolved() ``` |
| ```group() ``` | List of the department's employees | Find issues that employees of the Sales department are working on:<br/>``` Assignee: group(value: "Sales department")  ```<br/>**Note:** If a group to select from contains more than 1,000 users, the query will only search across 1,000 users. Moreover, it is not known beforehand which users will be selected, as you cannot manage this process. |


## Searching by parameter change {#query-change}

If you know when and how the issue parameter was changed, you can use these criteria in the filter:
```
"<parameter>": changed(from: "<old_value>" to: "<new_value>" by: "<who_changed>" date: "<when_changed>")
```

For example, to get a list of issues that Ivan Ivanov changed to the **In Progress** status over a certain period of time, create the following query:

```
Status: changed(to: "In Progress" by: "Ivan Ivanov" date: 01.09.2017 .. 15.09.2017)
```

To get a list of issues that Ivan Ivanov changed to the **In Progress** status over the last week, use the following [function](#query-functions) in your query:

```
Status: changed(to: "In Progress" by: "Ivan Ivanov" date: >today()-1w)
```

## Sorting results {#query-result-sort}

You can sort filter results by adding `"Sort By"` at the end of the query. Specify the name of the sort field as a value:

```no-highlight
"Sort By": Created
```

If necessary, sort in ascending (`ASC`) or descending (`DESC`) order:

```no-highlight
"Sort By": Created ASC
```

To specify several sort fields, list them through a comma in the priority order:

```no-highlight
"Sort By": Created ASC, Updated DESC
```

## Useful queries {#useful-queries}

Try to run some ready-made queries to get a better idea of how they work:

* Active issues whose reporter you are:
   ```no-highlight
   Author: me() Resolution: empty()
   ```

* Active issues that were assigned to you:
   ```no-highlight
   Assignee: me() Resolution: empty()
   ```

* Active issues that you follow:
   ```no-highlight
   Followers: me() Resolution: empty()
   ```

* Issues where you are an assignee and deadline is due within a week:
   ```no-highlight
   Assignee: me() Deadline: week()
   ```

* Issues with the **Critical** or **Blocker** priority for which you are the reporter, assignee, or follower.
   ```no-highlight
   (Followers: me() OR Assignee: me() OR Author: me()) AND Resolution: empty() AND Priority: Blocker, Critical
   ```

## Filter parameters {#filter-parameters}

| Parameter | Value | Description |
----- | ----- | -----
| ```"Access" ``` | Names or usernames | Searching for issues with certain users specified in the **{{ ui-key.startrek-backend.fields.issue.access }}** field.<br/>For example:<br/>```"Access": user3370@, "Ivan Ivanov" ``` |
| ```"Affected Version" ``` | Version names | Searching for issues that list a specific value in the **{{ ui-key.startrek-backend.fields.issue.affectedVersions-key-value }}** field.<br/>For example:<br/>```"Affected Version": "14.09.1978" ``` |
| ```"Assignee" ``` | Names or usernames | Searching for issues with specific assignees.<br/>For example:<br/>```"Assignee": user3370@, "Ivan Ivanov" ``` |
| ```"Author" ``` | Names or usernames | Searching for issues with specific reporters.<br/>For example:<br/>```"Author": user3370@, "Ivan Ivanov" ``` |
| ```"Block Queue" ``` | Name or key of the queue | Searching for issues that have dependent (blocked) issues in the specified queues.<br/>For example:<br/>``` "Block Queue": TEST ``` |
| ```"Clone" ``` | Issue keys | Searching for issues cloned from specific issues.<br/>For example:<br/>``` "Clone": "TASK-123", "TASK-321" ``` |
| ```"Clones Of Queue" ``` | Name or key of the queue | Searching for issues cloned from issues in specific queues.<br/>For example:<br/>``` "Clones Of Queue": TEST, DEVELOP ``` |
| ```"Comment" ``` | Text string | Searching for issues whose comments include the specified text.<br/>For example:<ul><li>Find the issues whose comments contain words and word forms from the phrase:<br/>    ```"Comment": "good job" ```</li><li>Find issues with comments that contain the exact phrase:<br/>    ```"Comment": #"great job" ```</li></ul> |
| ```"Comment Author" ``` | Names or usernames | Searching for issues with comments made by specific users.<br/>For example:<br/>```"Comment Author": user3370@, "Ivan Ivanov" ``` |
| ```"Component Owner" ``` | Names or usernames | Searching for issues that include components managed by specific users.<br/>For example:<br/>```"Component Owner": user3370@, "Ivan Ivanov" ``` |
| ```"Components" ``` | Component names | Searching for issues that refer to specific components.<br/>For example:<br/>```"Components": "backend", " frontend" ``` |
| ```"Created" ``` | Date or date interval | Searching for issues created on a specific date or within a specific date range.<br/>For example:<br/>```"Created": 2017-01-01..2017-01-30 ``` |
| ```"Deadline" ``` | Date or date interval | Searching for issues with a deadline set for a specific date or date range.<br/>For example:<br/>```"Deadline": 2017-01-30 ``` |
| ```"Depend On Queue" ``` | Name or key of the queue | Searching for issues dependent on (blocked by) issues from specific queues.<br/>For example:<br/>``` "Depend On Queue": TEST ``` |
| ```"Depends On" ``` | Issue keys | Searching for issues that depend on the given issues (are blocked by them).<br/>For example:<br/>``` "Depends On": "TASK-123", "TASK-321" ``` |
| ```"Description" ``` | Text string | Searching for issues that have a description with specific text.<br/>For example:<ul><li>Find issues that have a description containing the words and word forms in the phrase:<br/>    ```"Description": "invent the wheel" ```</li><li>Find issues that contain the exact phrase in their description:<br/>    ```"Description": #"invent the wheel" ```</li></ul> |
| ```"Duplicated In Queue" ``` | Name or key of the queue | Searching for issues that have duplicates in specific queues.<br/>For example:<br/>``` "Duplicated In Queue": TEST ``` |
| ```"Duplicates" ``` | Issue keys | Searching for issues that duplicate specific issues.<br/>For example:"Duplicates":<br/>``` "TASK-123", "TASK-321" ``` |
| ```"Duplicates In Queue" ``` | Name or key of the queue | Searching for issues that are duplicates of issues in the specified queues.<br/>For example:<br/>``` "Duplicates In Queue": TEST ``` |
| ```"End Date" ``` | Date or date interval | Searching for issues whose **{{ ui-key.startrek-backend.fields.issue.end-key-value }}** value matches a specific date or date range.<br/>For example:<br/>```"End Date": 2017-01-30 ``` |
| ```"Epic" ``` | Epic keys | Searching for issues that refer to specific epics.<br/>For example:Epic:<br/>``` "TASK-123", "TASK-321" ``` |
| ```"Epics For Queue" ``` | Name or key of the queue | Searching for epics that include issues from specific queues.<br/>For example:<br/>``` "Epics For Queue": TEST, DEVELOP ``` |
| ```"Favorited by" ``` | Only the [function](#query-functions) `me()` | Searching for your favorite issues.<br/>For example:<br/>```"Favorited by": me() ``` |
| ```"Filter" ``` | IDs or names of filters | Searching for issues that match the filters.<br/>For example:<br/>```"Filter": "Issues of my department" ```<br/>**Note.** If two users create two filters having the same name, they might get different results when running the same query with this filter name because the filter of the user who's running the query is applied. |
| ```"Fix Version" ``` | Version names | Searching for issues that list a specific value in the **{{ ui-key.startrek-backend.fields.issue.fixVersions-key-value }}** field.<br/>For example:<br/>```"Fix Version": "12.11.1986" ``` |
| ```"Followers" ``` | Names or usernames | Searching for issues with specific followers.<br/>For example:<br/>```"Followers": user3370@, "Ivan Ivanov" ``` |
|  |
| ```"Has Epic" ``` | Issue keys | Searching for issues that refer to specific epics.<br/>For example:<br/>``` "Has Epic": TASK-123 ``` |
| ```"Have Links To Queue" ``` | Name or key of the queue | Searching for issues with links of any type (parent, sub-issue, related, duplicate, and so on) with issues from specified queues.<br/>For example:<br/>``` "Have Links To Queue": TEST ``` |
| ```"History" ``` | Text string | Searching for issues with a history that includes the words or forms of words from a specific phrase.<br/>A search is only made by the **Summary** and **Description** field values.<br/>For example:<br/>```"History": "easy as pie" ``` |
| ```"In Epics Of Queue" ``` | Name or key of the queue | Searching for issues related to epics from specific queues.<br/>For example:<br/>``` "In Epics Of Queue": TEST ``` |
| ```"Is Dependent By" ``` | Issue keys | Searching for issues that block specific issues.<br/>For example:<br/>``` "Is Dependent By": "TASK-123", "TASK-321" ``` |
| ```"Is Duplicated By" ``` | Issue keys | Searching for issues that are duplicated by specific issues.<br/>For example:<br/>``` "Is Duplicated By": "TASK-123", "TASK-321" ``` |
| ```"Is Epic Of" ``` | Issue keys | Searching for epics that include specific issues.<br/>For example:<br/>``` "Is Epic Of": "TASK-123", "TASK-321" ``` |
| ```"Is Parent Task For" ``` | Issue keys | Searching for issues that are parents to specific issues.<br/>For example:<br/>```"Is Parent Task For": "TASK-123", "TASK-321" ``` |
| ```"Is Subtask For" ``` | Issue keys | Searching for sub-issues for specified parent issues.<br/>For example:<br/>```"Is Subtask For": "TASK-123", "TASK-321" ``` |
|  |
| ```"Key" ``` | Issue keys | Searching for issues with specific keys.<br/>For example:<br/>```"Key": "TASK-123", "TASK-321" ``` |
| ```"Last comment" ``` | The date and time when the latest comment was added | Searching for issues that didn't receive any new comments during a particular timeframe.<br/>For example:<br/>```"Last Comment": < now()-1h ``` |
| ```"Linked to" ``` | Issue keys | Searching for issues with links of any type (parent, sub-issue, related, duplicate, and so on) with specified issues.<br/>For example:<br/>```"Linked to": "TASK-123", "TASK-321" ``` |
|  |
| ```"Modifier" ``` | Names or usernames | Searching for issues recently updated by specific users.<br/>For example:<br/>```"Modifier": user3370@, "Ivan Ivanov" ``` |
| ```"Old Queue" ``` | Name or key of the queue | Searching for issues moved from the specified queues.<br/>For example:<br/>```"Old Queue": TEST ``` |
| ```"Original" ``` | Issue keys | Searching for clones of specified issues.<br/>For example:<br/>```"Original": "TASK-123", "TASK-321" ``` |
| ```"Original Estimate" ``` | Time range in the format `"XXw XXd XXh XXm XXs"` | Searching for issues with a specific initial estimate.<br/>For example:<br/>```"Original Estimate": "5d 2h 30m" ``` |
| ```"Originals Of Queue" ``` | Name or key of the queue | Searching for issues that have clones in specific queues.<br/>For example:<br/>``` "Originals Of Queue": TEST ``` |
|  |
| ```"Parent Tasks For Queue" ``` | Name or key of the queue | Searching for issues that have sub-issues in specific queues.<br/>For example:<br/>``` "Parent Tasks For Queue": TEST, DEVELOP ``` |
| ```"Pending Reply From" ``` | Names or usernames | Searching for issues that are pending response from a specific user (the user [has been invited to comment](comments.md#call-comment)).<br/>For example, searching for issues pending response from the user with the `user3370` username or from the user named Ivan Ivanov:<br/>```"Pending Reply From": user3370@, "Ivan Ivanov" ``` |
| ```"Priority" ``` | Priority values | Searching for issues with a specific priority.<br/>For example:<br/>```"Priority": "Minor", "Normal" ``` |
| ```"Project" ``` | Project names | Searching for issues from specific projects.<br/>For example:<br/>```"Project": "Perpetuum mobile" ``` |
| ```"Queue" ``` | Name or key of the queue | Searching for issues from specific queues.<br/>For example:<br/>```"Queue": TEST ``` |
| ```"Queue Owner" ``` | Names or usernames | Searching for issues from queues with specific owners.<br/>For example:<br/>```"Queue Owner": user3370@, "Ivan Ivanov" ``` |
| ```"Related" ``` | Names or usernames | Searching for issues with specific reporters, assignees, or followers.<br/>For example:<br/>```"Related": user3370@, "Ivan Ivanov" ``` |
| ```"Related To Queue" ``` | Name or key of the queue | Searching for issues related to issues from specific queues (with a link of the **Related** type).<br/>For example:<br/>``` "Related To Queue": Testing ``` |
| ```"Relates" ``` | Issue keys | Searching for issues related to specific issues (with a link of the **Related** type).<br/>For example:<br/>```"Relates": "TASK-123", "TASK-321" ``` |
| ```"Resolved" ``` | Date or date interval | Searching for issues that were closed (resolved) on a specific date or during a specific date range.<br/>For example:<br/>```"Resolved": 2017-01-01..2017-01-30 ``` |
| ```"Resolver" ``` | Names or usernames | Searching for issues that specific users have closed (resolved).<br/>For example:<br/>```"Resolver": user3370@, "Ivan Ivanov" ``` |
| ```"Sprint" ``` | IDs or names of scripts | Searching for issues from specific sprints.<br/>For example:<br/>```Sprint: "TrackerSprint32" ``` |
| ```"Sprint In Progress By Board" ``` | Issue board ID (you can take it from the board page URL) | Searching for issues related to an active sprint on a specific issue board.<br/>For example:<br/>```"Sprint In Progress By Board": 87 ``` |
| ```"Sprints By Board" ``` | Issue board ID (you can take it from the board page URL) | Searching for issues from specific boards.<br/>For example:<br/>```"Sprints By Board": 87 ``` |
| ```"Start Date" ``` | Date or date interval | Searching for issues whose **{{ ui-key.startrek-backend.fields.issue.start-key-value }}** value matches a specific date or date range.<br/>For example:<br/>```"Start Date": <2017-01-30 ``` |
| ```"Status" ``` | Status names | Searching for issues with specific statuses.<br/>For example:<br/>```"Status": Open, Resolved, Closed ``` |
| ```"Story Points" ``` | Story Points count | Searching for issues with a specific number of Story Points.<br/>For example:<br/>```"Story Points": >=5 ``` |
| ```"Subtasks For Queue" ``` | Name or key of the queue | Searching for sub-issues that have parent issues in the specified queues.<br/>For example:<br/>``` "Subtasks For Queue": TEST ``` |
| ```"Summary" ``` | Text string | Searching for issues that have a name with specific text.<br/>For example:<ul><li>Find issues that have a name containing the words and word forms in the phrase:<br/>    ```"Summary": "invent the wheel" ```</li><li>Find issues whose name completely matches the following phrase:<br/>    ```"Summary": #"invent the wheel" ```</li></ul> |
| ```"Tags" ``` | Issue tags | Searching for issues with specific tags.<br/>For example:<br/>```"Tags": "Support", "wiki" ``` |
| ```"Time Spent" ``` | Time range in the format `"XXw XXd XXh XXm XXs"` | Searching for issues with a specific amount of time spent.<br/>For example:<br/>```"Time Spent": >"5d 2h 30m" ``` |
| ```"Type" ``` | Issue type | Searching for issues of specific types. For example:<br/>```"Type": Epic``` |
| ```"Updated" ``` | Date or date interval | Searching for issues updated on a specific date or within a specific date range.<br/>For example:<br/>```"Updated": >2017-01-30 ``` |
| ```"Voted by" ``` | Names or usernames | Searching for issues that specific users have voted for.<br/>For example:<br/>```"Voted By": user3370@, "Ivan Ivanov" ``` |
| ```"Votes" ``` | Number of votes | Searching for issues with a specific number of votes.<br/>For example:<br/>```"Votes": > 6 ``` |




