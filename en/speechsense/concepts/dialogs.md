# {{ speechsense-name }} dialogs

A _dialog_ is a {{ speechsense-name }} object that includes a recording of a call between a call center agent and a customer, as well as various metadata, such as the agent and customer full names, call date and language, etc. Calls are recorded with a phone exchange (PBX) and then [uploaded](../operations/data/upload-data.md) to {{ speechsense-name }}.

For each call, {{ speechsense-name }} automatically separates the agent's speech and the customer's speech, applying different [tags](tags.md) to their respective phrases. For instance, this may help to determine whether the agent greeted the customer or whether the latter was polite.

All dialogs break down into two categories:

* Outgoing: Those initiated by an agent.
* Incoming: Those initiated by a customer.

With {{ speechsense-name }}, you can:

* View dialog specifications.
* Listen to the call recording.
* Understand how well an agent does their job.
* View the call transcript.
* See how the text is marked up with tags.

There are various ways to work with dialogs:

* [Find a dialog and view it](../operations/data/manage-dialogs.md) in the dialog list.
* [Generate a report](../operations/data/manage-reports.md) and [go to the dialogs](../operations/data/manage-reports.md#go-to-a-dialog) from it. In this case, the dialog list will be filtered as per the report criteria.

## Dialog filtering {#filters}

Filters define the conditions for [dialog search](../operations/data/manage-dialogs.md#filters-dialogs).

There are four types of filters:

* **Operator**: Defines how well the agent does their job, e.g., how fast they were speaking, whether they interrupted the customer, etc.
* **Customer**: Refers to the customer's behavior during the call, e.g., how fast they were speaking, whether they interrupted the agent, etc.
* **General metadata**: Recording data.
* **Customer tags** and **Operator tags**: Classifiers applied to the call text recognition results. You can learn more about tags [here](tags.md).

For each filter, you can specify one or more values, which are the filtering conditions. Such values fall into these three categories:

* Date: Select a date range from the calendar.
* Text: Enter some text. The search will only return exact matches.
* Number: Specify a range of numbers. You can specify either both range boundaries or just one of them. To find a certain value, specify it as both the higher and the lower boundary. The boundaries are included into the range being filtered.

You can use multiple filters at a time to find the dialogs that match all specified conditions.

## Detailed info on dialogs {#detail}

For each dialog, you have the following information [available](../operations/data/manage-dialogs.md#view-dialog):

* General info, e.g., who initiated the call and how long it lasted.
* Information on the agent and customer.
* Call recording.
* Summary that [{{ yagpt-full-name }}](../../yandexgpt/) generates automatically based on full semantic analysis. Technically, it provides {{ yagpt-full-name }}'s **Yes**/**No** answers to questions.
* Recording transcript [{{ speechkit-full-name }}](../../speechkit/) provides automatically.

   Using a transcript, you can [search through a text fragment](../operations/data/manage-dialogs.md#find-dialogs) in the agent's or customer's channel. The search will return exact matches. Found fragments are highlighted in yellow.

   The transcript is automatically marked up with agent and customer tags.
