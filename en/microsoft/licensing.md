---
title: "Microsoft licenses in {{ yandex-cloud }}"
description: "In this tutorial, you'll learn how to manage Microsoft licenses in {{ yandex-cloud }}."
---

# Microsoft licenses in {{ yandex-cloud }}

{% include [ms-licensing-personal-data-note](../_includes/ms-licensing-personal-data-note.md) %}


## Using your own licenses in {{ yandex-cloud }} {#byol}

If you already have corporate Microsoft licenses under Microsoft Software Assurance ([SA](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default?activetab=software-assurance-default-pivot%3aprimaryr3)) or Microsoft Enterprise Agreement ([EA](https://www.microsoft.com/en-us/licensing/licensing-programs/enterprise?activetab=enterprise-tab%3aprimaryr2)) subscription licenses, you can use them in {{ yandex-cloud }}.In this case, you'll be charged under the [BYOL](pricing.md) plan.


You can use your license in a shared infrastructure according to the [License Mobility](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) through Software Assurance program rules and on dedicated hardware under the Microsoft Product Terms.





### License transfer rules under License Mobility through Software Assurance {#rules}

To use your licenses in {{ yandex-cloud }} under the License Mobility through Software Assurance program, fill out the registration form to submit a report to Microsoft. There are some license usage restrictions. Review them in the Microsoft Product Terms and check them with your Licensing Service Provider. The license migration process is described in detail in the [Microsoft documentation](http://download.microsoft.com/download/7/9/b/79bd917e-760b-48b6-a266-796b3e47c47a/License_Mobility_Customer_Verification_Guide.pdf).




### Using existing licenses on a dedicated {{ yandex-cloud }} host {#dedicated-hosts}

A [dedicated host](../compute/concepts/dedicated-host.md) is a physical server that is intended solely for hosting your VMs in {{ yandex-cloud }}.

If you need separate dedicated hardware to support your products, you can use Microsoft software licenses on a dedicated {{ compute-name }} host. To use your licenses on dedicated hardware, you must have a valid agreement with Microsoft perpetual licenses.

Using dedicated hardware with your own licenses will be cheaper than using licenses purchased from {{ yandex-cloud }}.

