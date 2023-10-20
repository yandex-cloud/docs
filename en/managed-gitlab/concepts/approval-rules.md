---
title: "Code review rules in {{ mgl-name }}"
description: "With {{ mgl-name }}, you can flexibly set up mandatory code review rules before any code can be added to the target branch of the project. This feature is an alternative to the Approval Rules Enterprise Edition tool built in {{ GL }} and is available regardless of the {{ GL }} version."
---

# Code review rules in {{ mgl-name }}

{% include [preview note](../../_includes/note-preview.md) %}

With {{ mgl-name }}, you can flexibly set up mandatory code review rules before any code can be added to the target branch of the project. This feature is an alternative to the [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) Enterprise Edition tool built in {{ GL }} and is available regardless of the {{ GL }} [version](https://about.gitlab.com/pricing).

If a {{ GL }} instance has the code review rules enabled, {{ mgl-name }} analyzes approvals by reviewers for compliance with the set rules. If the number of approvals is insufficient, a thread is created in a merge request that locks its push to the target branch. When the merge request is updated, a comment with the current rule compliance status is created or updated in the thread. Once all the required approvals are obtained, the thread is closed.

If you close a thread manually, it will be created again. If a merge request is incorporated bypassing the set rules, users with at least the `Maintainer` role will receive an email notifying them of a violation of the established code review procedure.

For more information about working with review rules, see [Setting up code review rules](../operations/approval-rules.md).

At the [Preview](../../overview/concepts/launch-stages.md) stage, the feature can be used free of charge.

## Available configurations {#packages}

You can choose a suitable configuration based on your team's objectives:

* **Basic**: Includes the ability to create a single rule with no additional conditions. It is suitable for small teams (up to 10 people).
* **Standard**: Allows configuring multiple rules and assigning [code owners](../operations/approval-rules.md#code-ownership) to individual files or directories (up to 10 records). It is suitable for medium-sized teams (10 to 30 people).
* **Advanced**: Includes all the features of the Standard configuration with no limit on the number of Code Ownership records and setting up different review rules for different project branches. It is suitable for large teams (over 30 people).

See the table below for a more detailed comparison of what different configurations provide:

| Functionality | Description | Basic<br>configuration | Standard<br>configuration | Advanced<br>configuration |
|:----------------------------------|:---------|:------------------------------------:|:---------------------------------------:|:------------------------------------:|
| One review rule | Ability to assign reviewers, one of whom must review new commits before merging branches. | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Protected branches | Ability to select the branches for which the review rules will apply. | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Code ownership | Ability to assign individual files and directories (including by mask) to specific users. These users become code owners and can participate in code review if commits in the merge request affect their files. | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Multiple review rules | Ability to set more than one review rule. | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Branch-specific rules | Ability to set different review rules for different branches, e.g., `release` and `master`. | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
