# Reports in {{ speechsense-name }}

With reports in {{ speechsense-name }}, you can analyze agent performance and assess its quality. Reports are based on the [agent-customer call recordings uploaded to the service](../operations/data/upload-data.md). For instance, using reports, you can learn:

* How agents work within different products.
* How often agents use informal language with customers.
* How often a long pause occurs during a conversation.
* How often the agents get negative feedback from the customers.
* How often the call rules are violated as per the report criteria.

## How to build a report {#form}

To generate a report, you need to specify these settings:

* [Parameters](#parameters): Define a list of criteria for the agent performance assessment.
* [Weight](#weight): Indicates how critical a parameter is for performance assessment.
* [Filters](#filters): Applied to dialogs in the report.

Once you have configured the basic settings, you can [build a report](../operations/data/manage-reports.md). It shows the parameter values as a [chart and table](#display).

The value of each parameter in the report is calculated using this formula:

$value = criterion / filters * weight$

Where:

* `value`: Parameter value.
* `criterion`: Number of filtered dialogs that meet the condition specified in the parameter.
* `filters`: Total number of filtered dialogs.
* `weight`: Parameter weight as a percentage.

> For example, let's assume you have the following source data:
>
> * The **Customer tags: Thanks** parameter is enabled. The condition specified is that the customer thanked the agent at least three times during the conversation.
> * The parameter weight is 60%.
> * Among the filtered dialogs, there are seven in which the customer thanked the agent three times or more.
> * The total number of filtered dialogs is 14.
>
> The report will show the following value for the parameter:
>
> $7 / 14 * 60 = $30

### Assessment parameters {#parameters}

_Assessment parameters_ are criteria for the agent performance assessment. For each parameter, one specifies a value or a range of values. {{ speechsense-name }} analyzes the conversation between the agent and the customer for the parameters specified in the report. If the conversation satisfies the criterion specified in the parameter, its data is added to the report.

> For example, the report has the **Operator interrupted the customer, times** parameter enabled. The range specified for it is from two times upward. {{ speechsense-name }} analyzes the conversation recording to determine how many times the agent interrupted the customer. If the value is two or more, the information is added to the report.

There are four types of parameters:

* **Operator**: Defines how well the agent does their job, e.g., how fast they were speaking, whether they interrupted the customer, etc.

* **Customer**: Refers to the customer's behavior during the call, e.g., how fast they were speaking, whether they interrupted the agent, etc.

* **General metada**: Recording data collected using the PBX. The metadata is uploaded to {{ speechsense-name }} along with the call recording and contains its key specifications, such as the agent's and customer's full names, call date and language, etc.

* **Customer tags** and **Agent tags**: Classifiers applied to the call text recognition results. {{ speechsense-name }} determines whether the dialog has certain keywords, phrases, or tones, classifies the dialog, and adds a tag to it. {{ speechsense-name }} has preconfigured tags. For example, you can use them to learn whether the conversation featured an informal greeting or goodbye, whether the agent thanked the customer for waiting, or whether it was the customer's repeat call to support.

### Parameter weight {#weight}

_Parameter weight_ is a setting that indicates how critical a parameter is for the agent performance assessment. You set weight as a percentage for each parameter. The total weight of all parameters must equal 100%. The weight affects the [formula](#form) used to calculate each parameter value.

> For example, let's assume there are two parameters enabled for the report: **Operator speech rate** and **Customer speech rate**. The agent and the customer had the same speech rate, but the first parameter has weight set to 70%, while the second one to 30%. The report will, therefore, display a higher value for the **Operator speech rate** parameter.

You can set different weight for multiple parameters with the same name but different values. For example, let's assume you add two parameters named **Conversation silent time** with the ranges from `0.1` to `0.3` and upward from `0.3`. You can set a different weight for each range. The `0.3` boundary value falls within both ranges and is displayed for both parameters in the report.

### Report filtering {#filters}

You can use filtering to select the dialogs to include in your report. To filter them, use the following settings:

* **Filters**: Use the same fields as for the parameters.

* **Connection**: Upload call recordings here. If you have multiple connections with different recordings in each of them, you can select a connection with a proper set of recordings.

* **Grouping**: Choose how to group data in your report. You can only group data according to metadata fields.

As a result, you will get different data cross-sections. For example, you can:

* Set the analysis period.
* Group data by agents to analyze each agent's performance.
* Group data by product to learn which products the agents make fewer mistakes presenting in conversations.

Data cross-sections depend on the recording metadata. For example, if you want to filter or group data by product, make sure there is a relevant field in the [metadata file](../quickstart.md#set-space). If you need a new set of metadata, prepare conversation recordings with relevant metadata and [upload them](../operations/data/upload-data.md).

## Visualizing and using data in reports {#display}

A report shows the numeric metrics of agent performance. It is only available in the {{ speechsense-name }} web interface as a chart and table:

* **Chart** allows you to visually estimate which operators make fewer mistakes for which products.

   If you need details by a certain parameter, [switch from the chart to a dialog list](../operations/data/manage-reports.md#go-to-a-dialog). Thus you can analyze a mistake that showed up in the report.

* **Table** presents numeric parameter values. Two numbers are displayed for each parameter:

   * Number of dialogs satisfying the specified parameter.
   * Percentage of those out of all filtered dialogs.


Chart parameter labels and table column names are same as the relevant **Report parameter name** field values.
