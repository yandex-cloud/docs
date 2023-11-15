# Reports in {{ speechsense-name }}

With reports in {{ speechsense-name }}, you can get information about operator performance and assess its quality. Reports are based on the [recordings of conversations between operators and customers uploaded to the service](../operations/data/upload-data.md). Samples of data you can get using reports:

* How operators work within different products.
* How often operators communicate with customers informally.
* How often a long pause occurs during a conversation.
* How often they get a negative feedback during a conversation.
* How often violations occur during conversations.

## How a report is generated {#form}

A report is created based on these settings:

* [Parameters](#parameters): Define a list of criteria for operator performance assessment.
* [Weight](#weight): Indicates how critical a parameter is for performance assessment.
* [Filters](#filters): Applied to dialogs in the report.

Once you have configured the basic settings, you can [build a report](../operations/data/manage-reports.md). It shows the parameter values as a [chart and table](#display).

The value of each parameter in the report is calculated using the formula:

$value = criterion / filters * weight$

Where:

* `value`: Parameter value.
* `criterion`: Number of filtered dialogs that meet the condition set in the parameter.
* `filters`: Total number of filtered dialogs.
* `weight`: Parameter weight as a percentage.

> For example, we have the following source data:
>
> * The **Customer tags: Thanks** parameter is enabled. The condition specified is that the customer thanked the operator at least three times during the conversation.
> * The parameter weight is 60%.
> * Among the filtered dialogs, there are seven in which the customer thanked the operator three times or more.
> * The total number of filtered dialogs is 14.
>
> The report will show the following value for the parameter:
>
> $7 / 14 * 60 = $30

### Assessment parameters {#parameters}

_Assessment parameters_ are criteria for operator performance assessment. For each parameter, a value or a range of values is set. {{ speechsense-name }} analyzes the conversation between the operator and the customer for the parameters specified in the report. If the conversation satisfies the criterion specified in the parameter, its data is added to the report.

> For example, the report has the **Operator interrupted the customer, times** parameter enabled. The range specified for it is from two times upward. {{ speechsense-name }} analyzes the conversation recording to determine how many times the operator interrupted the customer. If the value is two or more, the information is added to the report.

There are four types of parameters:

* **Operator**: Operator performance criteria. For example, speech rate, whether or not the customer was interrupted.

* **Customer**: Customer's behavior during the conversation. For example, speech rate, whether or not the operator was interrupted.

* **General metada**: Recorded conversation's data collected using the PBX. The metadata is uploaded to {{ speechsense-name }} along with the conversation recording and contains its key characteristics. For example, operator's name, customer's name, call date, conversation language.

* **Customer tags** and **Operator tags**: Classifiers applied to the conversation recognition results. {{ speechsense-name }} detects certain key words and phrases or intonations in the conversation and classifies and tags it accordingly. {{ speechsense-name }} has a preconfigured set of tags. You can use them, for example, to learn whether the conversation featured an informal greeting or goodbye, whether the operator thanked the customer for waiting, or whether it was the customer's repeat call to support.

### Parameter weight {#weight}

_Parameter weight_ is a setting that indicates how critical a parameter is for operator performance assessment. You set weight as a percentage for each parameter. The total weight of all parameters must equal 100%. The weight affects the [formula](#form) used to calculate each parameter value.

> For example, the following two parameters are enabled for the report: **Operator speech rate** and **Customer speech rate**. The operator and the customer had the same speech rate, but the first parameter has weight set to 70%, while the second one to 30%. The report will, therefore, display a higher value for the **Operator speech rate** parameter.

You can set different weights for multiple parameters with the same name but different values. For example, you add two parameters named **Conversation silent time** with the ranges from `0.1` to `0.3` and upward from `0.3`. You can set a different weight for each range. The boundary value `0.3` falls within both ranges and is displayed for both parameters in the report.

### Report filtering {#filters}

You can use filtering to select the dialogs to be included in your report. To filter them, use the following settings:

* **Filters**: Use the same set of fields as for the parameters.

* **Connection**: You upload conversation recordings to a connection. If you have several connections with different recordings in each of them, you can select a connection with a proper set of recordings.

* **Grouping**: You choose how to group data in your report. You can only group data according to metadata fields.

As a result, you can get different data cross-sections. For example, you can:

* Set the analysis period.
* Group data by operator to analyze each operator's performance.
* Group data by product to learn which products the operators make fewer mistakes presenting in conversations.

Data cross-sections depend on the recordings' metadata. For example, if you want to filter or group data by product, make sure the relevant field is present in the [metadata file](../quickstart.md#set-space). If you need a new set of metadata, prepare conversation recordings with relevant metadata and [upload these recordings](../operations/data/upload-data.md).

## Presenting and using data in reports {#display}

A report shows the quantitative characteristics of operator performance. It is only available in the {{ speechsense-name }} web interface as a chart and table:

* **Chart** allows you to visually compare which operators make fewer mistakes for which products.

   If you need details by a certain parameter, [switch from the chart to a list of dialogs](../operations/data/manage-reports.md#go-to-a-dialog). Thus you can analyze a mistake presented in the report.

* **Table** presents numeric values. Each parameter column displays two numbers:

   * Number of dialogs satisfying the specified parameter.
   * Percentage of those of the total number of all filtered dialogs.


Chart parameter labels and table column names are based on the **Report parameter name** field values.
