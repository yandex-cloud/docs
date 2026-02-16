# How to update the {{ mgl-name }} instance software



## Issue description {#case-description}

You need to update the version of the installed {{ GL }} Community Edition or {{ GL }} Enterprise Edition package on your {{ mgl-full-name }} instance.

## Solution {#case-resolution}

You cannot update the software version on your own. {{ mgl-full-name }} instances automatically update their {{ GL }} software as its new released versions are adapted to the {{ yandex-cloud }} environment.

If a {{ GL }} software update is critical, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the {{ GL }} instance for which you need to update the installed software.
1. Target {{ GL }} version you want to install.
1. Date and time of the update.
1. Reason for the update.

{% note alert %}

During this operation, both the {{ mgl-name }} instance under update and any data in it will be inaccessible.

{% endnote %}