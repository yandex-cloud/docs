---
title: _Evaluation form_ report in {{ speechsense-full-name }}
description: In this article, you will learn about the _Evaluation form_ report in {{ speechsense-name }}, how it is generated, how it displays data, and how to use it.
---

# _Evaluation form_ report in {{ speechsense-name }}

You can analyze and evaluate agent performance using a **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}** report in {{ speechsense-name }}. Reports are based on [audio files](../../operations/data/upload-data.md) or [text chats](../../operations/data/upload-chat-text.md) of conversations between agents and customers uploaded to the service. Here are some examples of what you can learn using reports:

* How agents perform within different products.
* How often agents use informal language with customers.
* How often agents get negative feedback from customers.
* How often dialogs contain the violations selected in the report.

## How to build a report {#form}

To generate a **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}** report, specify these settings:

* [Evaluation parameters](#parameters): Define a list of criteria for agent performance evaluation.
* [Weight](#weight): Indicates how critical an evaluation parameter is for agent performance evaluation.
* [Filters](#filters): Filters applied to dialogs in the report.

With the basic settings configured, you can now [build a report](../../operations/data/manage-reports.md#build-an-evaluation-form). It will present the evaluation parameter values in [chart and table](#display) form.

The value of each evaluation parameter in the report is calculated using this formula:

$value = criterion / filters * weight$

Where:

* `value`: Evaluation parameter value.
* `criterion`: Number of filtered dialogs that meet the condition specified in the evaluation parameter.
* `filters`: Number of all filtered dialogs.
* `weight`: Evaluation parameter weight as a percentage.

> Example. Source data:
>
> * Enabled the **{{ ui-key.yc-ui-talkanalytics.dialogs.client-tags }} evaluation parameter: {{ ui-key.yc-ui-talkanalytics.dialogs.classifier.appreciation-key-value }}**. The condition specified is that the customer has thanked the agent at least three times during the conversation.
> * The parameter weight is 60%.
> * Among the filtered dialogs, there are seven in which the customer thanked the agent three times or more.
> * The total number of filtered dialogs is 14.
>
> As a result, the generated report displays the following value for the evaluation parameter:
>
> $7 / 14 * 60 = $30

### Evaluation parameters {#parameters}

_Evaluation parameters_ are criteria for agent performance evaluation. A value or range of values is specified for each evaluation parameter. {{ speechsense-name }} scans the dialog between the agent and the customer for the parameters specified in the report. If a dialog meets the criteria specified in the evaluation parameter, data about that dialog is added to the report.

> For example, the report has the **Agent interrupted the customer, times** evaluation parameter enabled. The range of values specified for this parameter starts from two times. {{ speechsense-name }} analyzes the conversation recording to find out how many times the agent has interrupted the customer. If the value is two or more, the information is added to the report.

There are several types of evaluation parameters:

* **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**: Agent data.
* **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**: Customer data.
* **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}** (only for chats): Bot data.
* **{{ ui-key.yc-ui-talkanalytics.dialogs.common-metadata }}**: Data on the conversation audio (collected via PBX) or text chat. Metadata is uploaded to {{ speechsense-name }} together with the conversation audio or text chat and contains its key characteristics, e.g., date, topic, and dialog language.

{% include [description-of-parameters](../../../_includes/speechsense/reports/parameters.md) %}

* **Semantic attributes**: Dialog properties, such as reasons, topics, or outcomes. Read more about semantic attributes [here](sense-attributes.md).

   You can only use the semantic attribute once in each report: either as a parameter or as a [filter](#filters).

### Evaluation parameter weight {#weight}

_Evaluation parameter weight_ is a setting that indicates how critical an evaluation parameter is for agent performance. You set weight as a percentage for each parameter. The total weight of all evaluation parameters must equal 100%. The weight affects the value of each evaluation parameter calculated using [this formula](#form).

> For example, there are two evaluation parameters in the report: **Agent speech rate** and **Customer speech rate**. The agent and the customer had the same speech rate, but the first parameter's weight is 70%, while that of the second one is 30%. The report will, therefore, display a higher value for the **Agent speech rate** parameter.

You can set different weights for multiple evaluation parameters with the same name but different values. For example, you add two **{{ ui-key.yc-ui-talkanalytics.dialogs.system-meta.talk.statistics.simultaneous_silence.ratio-key-value }}** parameters with ranges from `0,1` to `0,3` and from `0,3` upwards. You can set a different weight for each range. The `0,3` boundary value falls within both ranges and is displayed in the report for both parameters.

### Filtering in the report {#filters}

{% note info %}

You can only use the semantic attribute once in each report: either as a filter or as a [parameter](#parameters).

{% endnote %}

{% include notitle [filters](../../../_includes/speechsense/reports/filters.md) %}

## Visualizing and using the report data {#display}

{% include notitle [display](../../../_includes/speechsense/reports/display.md) %}

The available **{{ ui-key.yc-ui-talkanalytics.reports.rating-key-value }}** report formats include:

* **{{ ui-key.yc-ui-talkanalytics.reports.barchart }}**: Allows you to visually compare what agents make fewer mistakes for which products.

   If you need details for a certain evaluation parameter, [switch from the chart to a dialog list](../../operations/data/manage-reports.md#go-to-a-dialog). Thus you can analyze a mistake that showed up in the report.

* **{{ ui-key.yc-ui-talkanalytics.reports.table-key-value }}**: Lists values of numeric evaluation parameters. There are two numbers displayed for each evaluation parameter:

   * Number of dialogs satisfying the specified evaluation parameter.
   * Percentage of those out of all the filtered dialogs.


* **XLSX file**: Contains the same table as in the {{ speechsense-name }} web interface. Use the XLSX format to save the report locally.

Evaluation parameter captions on the chart and column names in the table and XLSX file match the appropriate **{{ ui-key.yc-ui-talkanalytics.reports.parameter.description }}** field value.
