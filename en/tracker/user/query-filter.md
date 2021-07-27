---
title: "Query language in Yandex Tracker"
description: "This section describes the Yandex Tracker query language. The query language allows you to search for tasks by name, description and comments, filter tasks by several values of one parameter, use comparison operations and logical operators in filters, specify functions as a value for comparison, and also set the sort order of tasks in the filter results. "

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Query language

If the basic filters don&apos;t give you enough options, use the query language to define a filter.

The query language allows you to:

- Search for issues [by name, description, and comment](#section_qsz_glk_lz).

- Filter issues [by multiple values in a single field](#section_pf4_slk_lz).

- Use [comparison operators](#section_kws_ylk_lz) and [logical operators](#section_yqw_fmk_lz) in filters.

- Specify [functions](#section_pmb_kmk_lz) as a comparison value.

- Set the [sorting order](#section_f3y_kpk_lz) for issues in the filter results.

## Query format {#section_pgq_xjk_lz}

To define a filter using the query language:

1. On the top panel in {{ tracker-name }}, choose **Issues** → **Find issues**.

1. Click **Query language** in the upper-right corner.

1. Enter a query and click **Apply**.

The basic format of the query is:

```no-highlight
"parameter": "value"
```

To set the parameter, start typing its name and choose the appropriate one from the suggestions. For the full list of parameters, see [Filter parameters](#section_d5p_d4n_jdb).

#### Examples

- Issues that are in the `TEST` queue:

    ```no-highlight
    "Queue": "TEST"
    ```
- Issues that are assigned to Alice Little:

    ```no-highlight
    "Assignee": "Alice Little"
    ```
- Issues with the status `Open` or `In progress`.

    ```no-highlight
    "Status": "Open", "In progress"
    ```
- Issues created from January 1 to January 30, 2017:

    ```no-highlight
    "Created": "2017-01-01".."2017-01-30"
    ```

## Multiple parameter values {#section_pf4_slk_lz}

If you want to filter issues by multiple values for the same parameter, separate them with commas:

```no-highlight
parameter: "value1", "value2", " value3"
```

#### Example

```no-highlight
author: "vpupkin","iivanov"
```

This filter outputs all issues that were reported by `vpupkin` or `iivanov`.

## Filters with multiple conditions {#section_yqw_fmk_lz}

You can combine multiple conditions in a single filter using Boolean operators:

- `AND`: The logical **AND** operator. Conditions combined with this operator must all be met at the same time.

    Example:

    ```no-highlight
    parameter1: "value1" AND parameter2: "value2"
    ```

    This query outputs issues where `parameter1` is set to `value1` **and** `parameter2` is set to `value2`.

    {% note info %}

    Instead of using the `AND` operator, you can just list the fields separated by a space.

    {% endnote %}

- `OR`: The logical **OR** operator. At least one of the conditions combined with this operator must be met.

    Example:

    ```no-highlight
    parameter1: "value1" OR parameter2: "value2"
    ```

    This query outputs issues where `parameter1` is set to `value1` **or** `parameter2` is set to `value2`.

You can create complex filters by combining multiple operators in a single query:

```no-highlight
parameter1: "value1" AND parameter2: "value2" OR parameter3: "value3"
```

When complex filters are processed, the `AND` operators are applied first. Use parentheses to change the order of actions:

```no-highlight
parameter1: "value1" AND (parameter2: "value2" OR parameter3: "value3")
```

## Text search {#section_qsz_glk_lz}

In addition to searching by parameters, you can also use the familiar text search. To do this, enter text in the query field and click **Apply**.

The search is performed across all the text fields in the issue: name, description, and comments.

- To search in only one of the fields, use the parameter to specify it:

    - `Summary`: The issue name.

    - `Description`: The issue description.

    - `Comment`: Text in comments.

    - `History`: Text in the history of changes.

    ```no-highlight
    Description: "Off with her head"
    ```

    This filter outputs all the issues that have a description containing the words and close forms of the words in the query.

- To only find issues with text that exactly matches the query text, use the `#` operator:

    ```no-highlight
    Summary: #"Lorem ipsum dolor sit amet"
    ```

    This filter only outputs the issues whose name exactly matches the query text.

- To only find issues that have no text specified in the query, use the `~` operator:

    ```no-highlight
    Comment: ~"Consectetur adipiscing elit"
    ```

    This filter only outputs the issues whose comments don't match the query text.

## Searching by user {#section_search_by_user}

You can search for issues by users' real names and usernames specified in issue fields. There are multiple ways to specify a real name or a username in your query:

- Putting the first and last name in quotation marks: `"first_name last_name"`. Used to search for an exact match with the user's first and last name.

    Example:

    ```no-highlight
    Author: "Alice Little"
    ```

    Entering this query will display all issues where the author is specified as Alice Little.

- Entering a username and putting `@` at the end: `login@`. Used to search for an exact match containing this username.

    Example:

    ```no-highlight
    Assignee: user3370@ 
    ```

    This query will display all issues that have `user3370` specified as the assignee.

- Entering a user's first name, last name, or username. Used for searching for exact matches containing either of those.

    Examples:

    - `Followers: Alice`. This query will display all issues followed by users with the first name Alice no matter what their last name is.

    - `Followers: alice`. This query will display all issues followed by the user with the username `alice@` or any user named Alice .

## Searching by local field {#local_fields}

To specify the value of an [issue local field](../local-fields.md) in a query, enter the key of the queue that the field is linked to and then the field name or key after a dot. Examples:

```
DEVS."Tester": "Alice Little"
```

```
DEVS.tester: user3370@
```

## Date and time parameters {#section_lyr_qjj_nz}

Many issue parameters have date and time values. The query language supports several formats for these parameters:

#### Date

- MM/DD/YYYY

    Example:

    ```
    04/30/2017
    ```

- DD.MM.YYYY

    Example:

    ```
    30.04.2017
    ```

- DD-MM-YYYY

    Example:

    ```
    30-04-2017
    ```

- YYYY-MM-DD

    Example:

    ```
    2017-04-30
    ```

#### Date and time

To specify the exact date and time, use this format:

```
"YYYY-MM-DD XXh:XXm:XXs"
```

Example:

```
"2017-04-30 17:25:00"
```

#### Time intervals

- You can set time intervals in weeks, days, hours, minutes and seconds in the format:

    ```
    "XXw XXd XXh XXm XXs"
    ```

    For example, a time interval of 3 days, 5 hours, and 32 minutes can be written as:

    ```
    "3d 5h 32m"
    ```

- You can set intervals using valid date formats:

    ```
    DD-MM-YYYY .. DD-MM-YYYY
    ```

    Here's an example of a filter for issues that were created in a certain period of time:

    ```
    Created: 01-01-2017 .. 02-03-2017
    ```

- Time intervals can be set using [functions](#section_pmb_kmk_lz) as well as comparison, addition, and subtraction operations.

    Here is an example of a filter for issues created no earlier than eight days ago:

    ```
    Created: > today() - "1w 1d"
    ```

## Comparison operations {#section_kws_ylk_lz}

In addition to looking for exact matches, the query language supports comparisons:

- **Not equal to**

    ```no-highlight
    parameter: !"value"
    ```

- **Greater than**, **Less than**, **Less than or equal to**, **Greater than or equal to**

    These operations are only applied to numeric parameters and date and time parameters.

    ```no-highlight
    parameter: >number
    parameter: <number
    parameter: >=number
    parameter: <=number
    ```

- **In the range**

    This operation is only applied to numeric parameters.

    ```no-highlight
    parameter: number1 .. number2
    ```

## Functions {#section_pmb_kmk_lz}

In addition to explicit parameter values, you can use functions. A function is a variable with a value that is calculated when the request is executed. For example, the function `today()` takes the value of today's date. To show all issues created today, use the query:

```no-highlight
Created: today()
```

| Function | Result | Example |
| ----- | ----- | ----- |
| ```empty()  ``` | Empty value (parameter omitted) | Find issues that don't have an assignee:<br/>``` Assignee: empty()``` |
| ```notEmpty() ``` | Any non-empty value (parameter set) | Find issues that have a deadline set:<br/>``` Deadline: notEmpty()``` |
| ```me()``` | Name of the user who made the request | Find issues that you created:<br/>``` Author: me()``` |
| ```now() ``` | Current time to the minute | Find issues created in the last 12 hours:<br/>``` Created: >now()-12h ``` |
| ```today() ``` | Time interval corresponding to the current date | Find issues created today:<br/>``` Created: today() ``` |
| ```week() ``` | Date range corresponding to the current week | Find issues created this week:<br/>``` Created: week() ``` |
| ```month()  ``` | Date range corresponding to the current month | Find issues created this month:<br/>``` Created: month() ``` |
| ```quarter()  ``` | Date range corresponding to the current quarter | Find issues created in this quarter:<br/>``` Created: quarter() ``` |
| ```year() ``` | Date range for the current year | Find issues created this year:<br/>``` Created: year() ``` |
| ```unresolved() ``` | No resolution | Find all issues that do not have a resolution set:<br/>``` Resolution: unresolved() ``` |
| ```group() ``` | List of department employees | Find issues that employees of the Sales department are working on:<br/>``` Assignee: group(value: "Sales department") ``` |

## Search for parameter changes {#section_i1y_lgr_3bb}

If you know when and how a parameter was changed for an issue, you can create a filter for it:

```
"parameter": changed(from: "old value" to: "new value" by: "who changed" date: "when changed")
```

For example, to get a list of issues that user Alice Little switched to the <q>In progress</q> status in a certain period of time, you need to make a request:

```
Status: changed(to: "In progress" by: "Alice Little" date: 01.09.2017 .. 15.09.2017)
```

For example, to get a list of issues that user Alice Little switched to the <q>In progress</q> status during the last week, use a [function](#section_pmb_kmk_lz) in your request:

```
Status: changed(to: "In progress" by: "Alice Little" date: >today()-1w)>
```

## Sort results {#section_f3y_kpk_lz}

You can sort the filter results by setting the `"Sort By"` parameter at the end of the query. For the value, specify the name of the field to sort by:

```no-highlight
"Sort By": Created
```

If necessary, sort by ascending (`ASC`) or descending (`DESC`) order:

```no-highlight
"Sort By": Created ASC
```

To specify multiple fields to sort by, separate them with commas in order of priority:

```no-highlight
"Sort By": Created ASC, Updated DESC
```

## Useful queries {#section_rv3_zr1_mz}

Try a few ready-made queries to learn how they work:

- Active issues that you created:

    ```no-highlight
    Author: me() Resolution: empty()
    ```

- Active issues that you are assigned to:

    ```no-highlight
    Assignee: me() Resolution: empty()
    ```

- Active issues that you are following:

    ```no-highlight
    Followers: me() Resolution: empty()
    ```

- Issues that you are assigned to that have a deadline during the current week:

    ```no-highlight
    Assignee: me() Deadline: week()
    ```

- Issues with **Critical** or **Blocker** priority that you are the reporter, assignee, or follower for.

    ```no-highlight
    (Followers: me() OR Assignee: me() OR Author: me()) AND Resolution: empty() AND Priority: Blocker, Critical
    ```

## Filter parameters {#section_d5p_d4n_jdb}

| Parameter | Value | Description |
| ----- | ----- | ----- |
| ```"Access" ``` | User logins and names | Search for issues that list specific users in the **Access** field.<br/>For example:<br/>```"Access": user3370@, "Alice Little" ``` |
| ```"Affected Version" ``` | Version names | Search for issues that list a specific value in the **Affected version** field.<br/>For example:<br/>```"Affected Version": "14.09.1978" ``` |
| ```"Assignee" ``` | User logins and names | Search for issues that list specific users as the assignee.<br/>For example:<br/>```"Assignee": user3370@, "Alice Little" ``` |
| ```"Author" ``` | User logins and names | Search for issues that list specific users as the reporter.<br/>For example:<br/>```"Author": user3370@, "Alice Little" ``` |
| ```"Block Queue" ``` | Queue names or keys | Search for issues that have dependent (blocked) issues in specific queues.<br/>For example:<br/>``` "Block Queue": TEST ``` |
| ```"Clone" ``` | Issue keys | Search for issues cloned from specific issues.<br/>For example:<br/>``` "Clone": "TASK-123", "TASK-321" ``` |
| ```"Clones Of Queue" ``` | Queue names or keys | Search for issues cloned from issues in specific queues.<br/>For example:<br/>``` "Clones Of Queue": TEST, DEVELOP ``` |
| ```"Comment" ``` | Text string | Search for issues that include a comment with a specific text.<br/>For example:<ul><li>Find issues with comments that contain the words and forms of words in a phrase:<br/>    ```"Comment": "great job" ```</li><li>Find issues with comments that contain the exact phrase:<br/>    ```"Comment": # " great job" ```</li></ul> |
| ```"Comment Author" ``` | User logins and names | Search for issues that include comments left by specific users.<br/>For example:<br/>```"Comment Author": user3370@, "Alice Little" ``` |
| ```"Component Owner" ``` | User logins and names | Search for issues that include components managed by specific users.<br/>For example:<br/>```"Component Owner": user3370@, "Alice Little" ``` |
| ```"Components" ``` | Component names | Search for issues related to specific components.<br/>For example:<br/>```"Components": "backend", "frontend"``` |
| ```"Created" ``` | Date or date range | Search for issues created on a specific date or within a specific date range.<br/>For example:<br/>```"Created": 2017-01-01..2017-01-30 ``` |
| ```"Deadline" ``` | Date or date range | Search for issues with a deadline set for a specific date or date range.<br/>For example:<br/>```"Deadline": 2017-01-30 ``` |
| ```"Depend On Queue" ``` | Queue names or keys | Search for issues dependent on (blocked by) issues from specific queues.<br/>For example:<br/>``` "Depend On Queue": TEST ``` |
| ```"Depends On" ``` | Issue keys | Search for issues dependent on (blocked by) specific issues.<br/> For example:<br/>``` "Depends On": "TASK-123", "TASK-321" ``` |
| ```"Description" ``` | Text string | Search for issues with a description that contains specific text.<br/>For example:<ul><li>Find issues that have a description containing the words and word forms in the phrase:<br/>    ```"Description": "invent the wheel" ```</li><li>Find issues that contain the exact phrase in the description:<br/>    ```"Description": # " invent the wheel" ```</li></ul> |
| ```"Duplicated In Queue" ``` | Queue names or keys | Search for issues that have duplicates in specific queues.<br/>For example:<br/>``` "Duplicated In Queue": TEST ``` |
| ```"Duplicates" ``` | Issue keys | Search for issues that are duplicates of specific issues.<br/>For example:<br/>```"Duplicates": "TASK-123", "TASK-321" ``` |
| ```"Duplicates In Queue" ``` | Queue names or keys | Search for issues that are duplicates of issues in specific queues.<br/>For example:<br/>``` "Duplicates In Queue": TEST ``` |
| ```"End Date" ``` | Date or date range | Search for issues whose **End date** value matches a specific date or date range.<br/>For example:<br/>```"End Date": 2017-01-30 ``` |
| ```"Epic" ``` | Epic keys | Search for issues related to specific epics.<br/>For example:<br/>```Epic: "TASK-123", "TASK-321" ``` |
| ```"Epics For Queue" ``` | Queue names or keys | Search for epics that include issues from specific queues.<br/>For example:<br/>``` "Epics For Queue": TEST, DEVELOP ``` |
| ```"Favorited by" ``` | You can only set the parameter value to the [function](#section_pmb_kmk_lz) `me()` | Search for your favorite issues.<br/>For example:<br/>```"Favorited by": me() ``` |
| ```"Filter" ``` | Filter names or IDs | Search for issues that match specific filters.<br/>For example:<br/>```"Filter": "Issues in my department" ```<br/>**Note.** If different users set filters with the same names, they may get different results when running the same query with the filter name specified, because a search is performed using the filter created by the user who initiates the query. |
| ```"Fix Version" ``` | Version names | Search for issues that list a specific value in the **Fix Version** field.<br/>For example:<br/>```"Fix Version": "12.11.1986" ``` |
| ```"Followers" ``` | User logins and names | Search for issues that list specific users as followers.<br/>For example:<br/>```"Followers": user3370@, "Alice Little" ``` |
|  |
| ```"Has Epic" ``` | Issue keys | Search for issues related to specific epics.<br/>For example:<br/>``` "Has Epic": TASK-123 ``` |
| ```"Have Links To Queue" ``` | Queue names or keys | Search for issues that are somehow linked with issues from specific queues (parent, related, duplicate, sub-issue, and so on).<br/>For example:<br/>``` "Have Links To Queue": TEST ``` |
| ```"History" ``` | Text string | Search for issues with a history that includes the words or word forms from a specific phrase.<br/>The search is only performed on the **Issue name** and **Issue description** field values.<br/>For example:<br/>```"History": "easy as pie" ``` |
| ```"In Epics Of Queue" ``` | Queue names or keys | Search for issues related to epics from specific queues.<br/>For example:<br/>``` "In Epics Of Queue": TEST ``` |
| ```"Is Dependent By" ``` | Issue keys | Search for issues that block specific issues.<br/>For example:<br/>``` "Is Dependent By": "TASK-123", "TASK-321" ``` |
| ```"Is Duplicated By" ``` | Issue keys | Search for issues that are duplicated by specific issues.<br/>For example:<br/>``` "Is Duplicated By": "TASK-123", "TASK-321" ``` |
| ```"Is Epic Of" ``` | Issue keys | Search for epics that include specific issues.<br/>For example:<br/>``` "Is Epic Of": "TASK-123", "TASK-321" ``` |
| ```"Is Parent Task For" ``` | Issue keys | Search for parent issues of specific sub-issues.<br/>For example:<br/>```"Is Parent Task For": "TASK-123", "TASK-321" ``` |
| ```"Is Subtask For" ``` | Issue keys | Search for sub-issues of specific parent issues.<br/>For example:<br/>```"Is Subtask For": "TASK-123", "TASK-321" ``` |
|  |
| ```"Key" ``` | Issue keys | Search for issues with specific keys.<br/>For example:<br/>```"Key": "TASK-123", "TASK-321" ``` |
| ```"Last comment" ``` | Date and time when the last comment was posted | Search for issues that didn't receive any new comments during a particular timeframe.<br/>For example:<br/>```"Last Comment": < now()-1h ``` |
| ```"Linked to" ``` | Issue keys | Search for issues that are linked to specific issues (parent, related, duplicate, sub-issue, and so on).<br/>For example:<br/>```"Linked to": "TASK-123", "TASK-321" ``` |
|  |
| ```"Modifier" ``` | User logins and names | Search for issues recently updated by specific users.<br/>For example:<br/>```"Modifier": user3370@, "Alice Little" ``` |
| ```"Old Queue" ``` | Queue names or keys | Search for issues moved from specific queues.<br/>For example:<br/>```"Old Queue": TEST ``` |
| ```"Original" ``` | Issue keys | Search for clones of specific issues.<br/>For example:<br/>```"Original": "TASK-123", "TASK-321" ``` |
| ```"Original Estimate" ``` | Time range in the format `"XXw XXd XXh XXm XXs"` | Search for issues with a specific initial estimate.<br/>For example:<br/>```"Original Estimate": "5d 2h 30m" ``` |
| ```"Originals Of Queue" ``` | Queue names or keys | Search for issues that have clones in specific queues.<br/>For example:<br/>``` "Originals Of Queue": TEST ``` |
|  |
| ```"Parent Tasks For Queue" ``` | Queue names or keys | Search for issues that have sub-issues in specific queues.<br/>For example:<br/>``` "Parent Tasks For Queue": TEST, DEVELOP ``` |
| ```"Pending Reply From" ``` | User logins and names | Search for issues pending a reply from a specific user (the user has been [invited to comment](comments.md#section_nl2_1qv_tz)).<br/> Let's say you need to find issues pending a reply from a user with the username `user3370` or from a user with the first and last name Alice Little:<br/>```"Pending Reply From": user3370@, "Alice Little" ``` |
| ```"Priority" ``` | Priority value | Search for issues that have specific priority values.<br/>For example:<br/>```"Priority": "Minor", "Medium" ``` |
| ```"Project" ``` | Project titles | Search for issues for specific projects.<br/>For example:<br/>```"Project": "Perpetuum mobile" ``` |
| ```"Queue" ``` | Queue names or keys | Search for issues from specific queues.<br/>For example:<br/>```"Queue": TEST ``` |
| ```"Queue Owner" ``` | User logins and names | Search for issues that list specific users as queue owners.<br/>For example:<br/>```"Queue Owner": user3370@, "Alice Little" ``` |
| ```"Related" ``` | User logins and names | Search for issues that list specific users as assignees, reporters, or followers.<br/>For example:<br/>```"Related": user3370@, "Alice Little" ``` |
| ```"Related To Queue" ``` | Queue names or keys | Search for issues that are related to issues from specific queues (the <q>Related</q> type link).<br/> For example:<br/>``` "Related To Queue": TEST``` |
| ```"Relates" ``` | Issue keys | Search for issues related to specific issues (the <q>Related</q> type link).<br/> For example:<br/>```"Relates": "TASK-123", "TASK-321" ``` |
| ```"Resolved" ``` | Date or date range | Search for issues that were closed (resolved) on a specific date or during a specific date range.<br/>For example:<br/>```"Resolved": 2017-01-01..2017-01-30 ``` |
| ```"Resolver" ``` | User logins and names | Search for issues that were closed (resolved) by specific users.<br/>For example:<br/>```"Resolver": user3370@, "Alice Little" ``` |
| ```"Sprint" ``` | Sprint names or IDs | Search for issues from specific sprints.<br/>For example:<br/>```Sprint: "TrackerSprint32" ``` |
| ```"Sprint In Progress By Board" ``` | Issue Board ID (can be found in the Board page URL) | Search for issues related to an active sprint on a specific issue board.<br/>For example:<br/>```"Sprint In Progress By Board": 87 ``` |
| ```"Sprints By Board" ``` | Issue Board ID (can be found in the Board page URL) | Search for issues from specific boards.<br/>For example:<br/>```"Sprints By Board": 87 ``` |
| ```"Start Date" ``` | Date or date range | Search for issues whose **Start date** value matches a specific date or falls within a date range.<br/>For example:<br/>```"Start Date": <2017-01-30 ``` |
| ```"Status" ``` | Status names | Search for issues with specific statuses.<br/>For example:<br/>```"Status": Open, Resolved, Closed ``` |
| ```"Story Points" ``` | Story Points score | Search for issues with a specific number of Story Points.<br/>For example:<br/>```"Story Points": >=5 ``` |
| ```"Subtasks For Queue" ``` | Queue names or keys | Search for sub-issues that have parent issues in specific queues.<br/>For example:<br/>``` "Subtasks For Queue": TEST ``` |
| ```"Summary" ``` | Text string | Search for issues with a specific title.<br/>For example:<ul><li>Find issues that have a title containing the words and word forms in the phrase:<br/>    ```"Summary": "invent the wheel" ```</li><li>Find issues whose name completely matches the following phrase:<br/>    ```"Summary": # " invent the wheel" ```</li></ul> |
| ```"Tags" ``` | Issue tags | Search for issues with specific tags.<br/>For example:<br/>```"Tags": "Support", "wiki" ``` |
| ```"Time Spent" ``` | Time range in the format `"XXw XXd XXh XXm XXs"` | Search for issues that took a specific amount of time to complete.<br/>For example:<br/>```"Time Spent": >"5d 2h 30m" ``` |
| ```"Type" ``` | Issue type | Search for issues with the specified type. For example:<br/>```"Type": Epic``` |
| ```"Updated" ``` | Date or date range | Search for issues that were changed on a specific date or during a specific date range.<br/>For example:<br/>```"Updated": >2017-01-30 ``` |
| ```"Voted by" ``` | User logins and names | Search for issues voted on by specific users.<br/>For example:<br/>```"Voted By": user3370@, "Alice Little" ``` |
| ```"Votes" ``` | Number of votes | Search for issues with a specific number of votes.<br/>For example:<br/>```"Votes": > 6 ``` |

