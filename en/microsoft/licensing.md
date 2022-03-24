# Microsoft licenses in {{ yandex-cloud }}

## Using Microsoft software in {{ yandex-cloud }} {#images}

{{ yandex-cloud }} provides ready-to-use images with pre-installed Microsoft Windows Server Datacenter Edition and Microsoft SQL Server. The software licenses in these images are fully compliant with Microsoft requirements. When using ready-made {{ yandex-cloud }} images, you pay for the required licenses and {{ compute-name }} resources. You'll be charged depending on your [service plan](pricing.md).

Purchasing images with a pre-installed Microsoft software license from {{ yandex-cloud }} has a number of advantages:

* {{ yandex-cloud }} monitors for compliance with the license requirements and license usage reports.
* {{ marketplace-name }} supports different versions of Windows Server and SQL Server.
* Client licenses for Windows Server are pre-installed. You don't need to buy them separately.
* Windows Server images include two RDS licenses for system administration.

By using Microsoft software in {{ yandex-cloud }}, you agree to the {{ marketplace-full-name }} [Terms of use](https://yandex.com/legal/cloud_terms_marketplace/) and the [Microsoft License Terms](https://www.microsoft.com/licensing/contracts).

### Features of using {{ MS }} licenses in {{ compute-full-name }} {#sql-server-compute-licensing}

You are charged in advance for using {{ MS }} licenses in {{ compute-full-name }}. This means that payment is collected at the start of a billing period even before you actually use the resource. In the list below, references to virtual machines are references to virtual machines with a {{ MS }} image.

* The billing period is one calendar month.
* If you create a new virtual machine during a billing cycle (including creating one by restoring it from a [disk snapshot](../compute/concepts/backups.md)), you pay the full licensing cost for the entire billing period.
* If you shut down or delete a virtual machine during a billing cycle, license costs for this cycle are not refunded.
* The first time a virtual machine, which was stopped prior to the current billing cycle, is restarted, you will be charged the full cost of the licenses for the entire billing cycle. If you stop and restart a virtual machine multiple times within one cycle, you will only need to pay the license fees the first time.
* If you change a virtual machine configuration and reduce resource usage during a billing cycle, the cost of the licenses released in this cycle is not subject to refund. The new pricing will take effect on the first day of the following billing cycle.
* If you change your virtual machine configuration and increase resource usage during a billing cycle, you will need additional licenses. If this is the case, you will be charged the full cost of these licenses for the entire billing cycle regardless of the date you made the changes.

## Using your own licenses in {{ yandex-cloud }} {#byol}

If you already have Microsoft enterprise licenses under Microsoft Software Assurance ([SA]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-default?activetab=software-assurance-default-pivot%3aprimaryr3){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default?activetab=software-assurance-default-pivot%3aprimaryr3){% endif %}) agreements or a Microsoft Enterprise Agreement ([EA]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/enterprise?activetab=enterprise-tab%3aprimaryr2){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/enterprise?activetab=enterprise-tab%3aprimaryr2){% endif %}), you can use them in {{ yandex-cloud }}. In this case, you'll be charged under the [BYOL](pricing.md) plan.

You can use your license in the shared infrastructure according to the [License Mobility through Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) program rules and as part of the dedicated hardware under the Microsoft Product Terms.

### Using existing licenses under the License Mobility through Software Assurance program {#mobility}

License Mobility is provided to customers with Microsoft enterprise licenses for eligible software covered by active Microsoft Software Assurance (SA) agreements. An active Software Assurance agreement is a requirement for participating in the License Mobility through Software Assurance program in {{ compute-name }}. License Mobility makes it easier for users to migrate to {{ yandex-cloud }} and lets users with lifetime licenses continue using them without additional licensing costs.

A number of restrictions apply to the License Mobility through Software Assurance program:

1. The License Mobility through Software Assurance program does not cover Windows client and server operating systems or applications.
1. The terms of the program do not apply to applications that are part of {{ compute-name }} images. For instance, the program does not cover Microsoft SQL Server as part of {{ marketplace-name }} images. You can depoy licenses on your VMs without using ready-made {{ marketplace-name }} images.
1. Server applications must be on the list of eligible products including:
    * Exchange Server
    * SharePoint Server
    * SQL Server Standard Edition
    * SQL Server Enterprise Edition
    * SQL Server Business Intelligence Edition
    * Skype for Business Server
    * System Center Server
    * Dynamics CRM Server
    * Dynamics AX Server
    * Project Server
    * Visual Studio Team Foundation Server
    * BizTalk Server
    * Forefront Identity Manager
    * Forefront Unified Access Gateway
    * Remote Desktop Services

    For the full terms of the License Mobility through Software Assurance program, see the official [Microsoft]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/product-licensing/products){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/product-licensing/products){% endif %} documentation.

#### License Mobility through Software Assurance program requirements for Microsoft SQL Server {#SQLmobility}

The number of licenses required to run Microsoft SQL Server in a virtual environment depends on the SQL Server version and the resources you use. However, Microsoft requires a minimum of 4 licenses to enable licensing of 4 vCPUs. The minimum number of licenses required does not depend on the licensing model.

When running Microsoft software under the License Mobility support program, you are responsible for compliance with the licensing rules. For more information about the [License Mobility through Software Assurance program requirements](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=2) for Microsoft SQL Server, go to the Microsoft website.

### License transfer rules under License Mobility through Software Assurance {#rules}

To use your licenses in {{ yandex-cloud }} under the License Mobility through Software Assurance program, fill out the registration form to submit a report to Microsoft. There are some license usage restrictions. Review them in the Microsoft Product Terms and check them with your Licensing Service Provider. For a detailed description of how to deploy licenses, see the [Microsoft documentation](http://download.microsoft.com/download/7/9/b/79bd917e-760b-48b6-a266-796b3e47c47a/License_Mobility_Customer_Verification_Guide.pdf).

### Using existing licenses on a dedicated {{ yandex-cloud }} host {#dedicated-hosts}

[A dedicated host](../compute/concepts/dedicated-host.md) is a physical server that is intended solely for hosting your VMs in {{ yandex-cloud }}.

If you need separate dedicated hardware to support your products, you can use Microsoft software licenses on a dedicated {{ compute-name }} host. To use your licenses on dedicated hardware, you must have a valid agreement with Microsoft perpetual licenses.

Using dedicated hardware with your own licenses will be cheaper than using licenses purchased from {{ yandex-cloud }}.

