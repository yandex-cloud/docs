# Microsoft licensing

The terms of use for Microsoft software are governed by the terms and conditions of the Microsoft license agreement that you enter into when purchasing a Microsoft product. The user is responsible for complying with the Microsoft licensing terms. Licensing recommendations are provided below. You are in no way obligated to follow such recommendations as they are not legally binding. If you have any questions about Microsoft software licensing and product usage rights, please consult your legal department or Microsoft reseller. The information on this page complies with the current [Microsoft Product Terms]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/product-licensing/products){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/product-licensing/products){% endif %}.

### General questions {#common}

{% if product == "cloud-il" %}

#### What is the relationship between Microsoft and {{ yandex-cloud }}? {#status}

{{ yandex-cloud }} is licensed to distribute Microsoft software products under the Services Provider License Agreement (SPLA) for providing software services.

#### Does {{ yandex-cloud }} provide extended support for Microsoft products? {#expanded-support}

No, the {{ yandex-cloud }} team does not currently offer support for Microsoft products.

{% endif %}

{% if product == "yandex-cloud" %}

#### What is License Mobility? {#license-mobility}

{% include [ms-license-mobility-desc](../../_includes/ms-license-mobility-desc.md) %}


#### What Microsoft software can I run on the {{ yandex-cloud }} platform? {#supported-soft}

On {{ yandex-cloud }}, you can run server software available under the [License Mobility through Software Assurance]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %} program.


#### How can I find out whether a Microsoft product is eligible for License Mobility? {#check-license-mobility}

This information is included in the terms of use for the Microsoft product. Whether or not a product is eligible for the License Mobility through Software Assurance program is indicated in the corresponding [section of the Software Assurance agreement]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}. Products that are eligible for the License Mobility through Software Assurance program include Remote Desktop Services, System Center, Exchange, and SharePoint.

#### Do I need to have a current Software Assurance agreement in place and participate in the License Mobility through Software Assurance program to deploy my own Microsoft licenses in {{ yandex-cloud }}? {#sa-for-license-mobility}

Yes. When using licensed Microsoft software in {{ compute-name }}, you must have a current Software Assurance agreement in place and participate in the License Mobility through Software Assurance program.

{% endif %}


#### Why do I need to specify the address when using Microsoft products? {#ms-licensing-address}

{% if product == "yandex-cloud" %}As of January 24, 2022, to use Microsoft products{% endif %}{% if product == "cloud-il" %}To use Microsoft products{% endif %}, you need to specify user names, names and tax IDs of legal entities, and addresses of individuals and legal entities. These are the requirements of the Microsoft licensing policy. The data **might be reported to Microsoft**. If the data isn't provided, you can't run Microsoft products.

#### Can I deploy Microsoft products with my own licenses in {{ compute-name }}? {#custom}

You can find detailed answers to questions about Windows Server licensing in the {% if product == "yandex-cloud" %}[{#T}](../../microsoft/byol.md){% endif %}{% if product == "cloud-il" %}[Windows Server licensing section](#windows-server){% endif %}.

In the case of other software that you want to use inside the VM, read the license you purchased or contact Microsoft to check if it's possible to use the product with this license in {{ yandex-cloud }}.


{% if product == "cloud-il" %}

#### Does {{ yandex-cloud }} support License Mobility? {#license-mobility}

{% include [ms-license-mobility-desc](../../_includes/ms-license-mobility-desc.md) %}

{{ yandex-cloud }} does not support License Mobility at the moment.

{% endif %}


{% if product == "cloud-il" %}

### Windows Server licensing {#windows-server}

#### Can I purchase Windows Server from {{ yandex-cloud }}? {#buy-windows-server}

Yes, you can purchase a virtual machine with a pre-installed Windows Server image. See the [list of available products](/marketplace?type=COMPUTE_IMAGE&operationSystems=WINDOWS&sortBy=name-a-z&categories=os&search=Windows+Server) in {{ marketplace-full-name }}.

#### How do I activate Windows Server? {#activate-windows-server}

You may have activation issues if the VM doesn't have internet access.

1. Make sure that the VM has internet access.
1. Run the following commands in PowerShell as an administrator:

   ```powershell
   Test-NetConnection {{ ms-kms-host }} -Port {{ ms-kms-port }}
   cscript.exe C:\Windows\System32\slmgr.vbs /dli
   cscript.exe C:\Windows\System32\slmgr.vbs /skms {{ ms-kms-host }}:{{ ms-kms-port }}
   cscript.exe C:\Windows\System32\slmgr.vbs /ato
   Get-Date
   Get-TimeZone
   ```

   If activation was not successful, send us the output of these commands.

#### Can I deploy my own Windows Server licenses in {{ compute-name }}? {#custom-windows-server}

You can deploy your own Windows Server licenses using your own images and adhering to the licensing requirements.

{% endif %}

{% if product == "cloud-il" %}

### Licensing of other Microsoft products {#other-products}

#### Can I purchase other Microsoft products with licenses that can be deployed in {{ compute-name }}? {#buy-other-products}

All Microsoft products that are available on {{ yandex-cloud }} are [listed in the {{ marketplace-full-name }}](/marketplace?type=COMPUTE_IMAGE&search=Microsoft&operationSystems=WINDOWS).

{% endif %}