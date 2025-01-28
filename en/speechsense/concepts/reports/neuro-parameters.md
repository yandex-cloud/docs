---
title: Neuroparameters
description: In reports, a neuroparameter is a dialog property. {{ speechsense-name }} uses it for semantic analysis to determine whether a dialog matches this property.
---

# Neuroparameters

{% include [preview-note](../../../_includes/note-preview.md) %}

In reports, a _neuroparameter_ is a dialog property. {{ speechsense-name }} uses it for semantic analysis to determine whether a dialog matches this property. Let's assume you specified a particular topic as a neuroparameter. {{ speechsense-name }} will check whether that topic was mentioned in the dialog.

As a neuroparameter, you can select a reason, topic, or outcome suggested by {{ speechsense-name }} as a possible option. You can also specify your own property, in which case it will not depend on the choice between reasons, topics, or outcomes.

For reports, {{ speechsense-name }} divides dialogs into two groups: those that match the specified property and those that do not. You choose which group to use in the report.

The neuroparameter application method depends on the report type:

* [Evaluation form](evaluation-form.md): Neuroparameters are available as evaluation parameters and dialog filters.

   If a neuroparameter is used as an evaluation parameter, the report shows the share of dialogs that semantically match or do not match the specified property (based on what you selected). For more info on how evaluation parameter values are calculated, see [{#T}](evaluation-form.md#form).

   In each report, a neuroparameter can only be used once: either as a parameter or as a filter.

* [Comparison](comparison.md) and [Detailing](details.md): Neuroparameters are only available as dialog filters. You can only set a single filter with a neuroparameter.

To use neuroparameters, there must be at least 100 dialogs in the sample for the report. There are no restrictions on the maximum number; however, if the sample contains more than 1,000 dialogs, not all of them will be analyzed. {{ speechsense-name }} will randomly select only 1,000 dialogues for analysis.

To learn how to set neuroparameters, see this [guide](../../operations/data/manage-reports.md#apply-neuro-parameter).
