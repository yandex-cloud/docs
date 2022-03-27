# Windows Licensing

Terms of use of Microsoft software are governed by the terms and conditions of the license agreement with Microsoft that you enter into when purchasing Microsoft products. The user is responsible for compliance with the Microsoft licensing terms. Licensing recommendations are provided below. You don't have to rely on them as they are not legally binding. If you have any questions about Microsoft software licensing and rights to use Microsoft products, please consult your Legal Department or Microsoft reseller. The information on this page complies with the [current Microsoft Product Terms]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/product-licensing/products){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/product-licensing/products){% endif %}.

## General questions {#common}

#### What is the relationship between Microsoft and {{ yandex-cloud }}? {#status}

{{ yandex-cloud }} is licensed to distribute Microsoft software products under the Services Provider License Agreement (SPLA) for providing software services. {{ yandex-cloud }} is also an authorized Microsoft partner under the [License Mobility through Software Assurance]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %} program.

#### Does {{ yandex-cloud }} provide extended support for Microsoft products? {#expanded-support}

No, it doesn't. The {{ yandex-cloud }} team does not currently provide consulting on Microsoft products.

#### What Microsoft software can be run on the {{ yandex-cloud }} platform? {#supported-soft}

The {{ yandex-cloud }} platform supports server software provided under the [License Mobility through Software Assurance]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %} program.

#### What is License Mobility? {#license-mobility}

License Mobility is a benefit that is available to customers with Microsoft corporate licenses to use the appropriate server software under a current Microsoft Software Assurance (SA) agreement in place. With License Mobility, customers can use eligible Microsoft software when working with third-party cloud solution providers such as {{ yandex-cloud }}. To learn more, go to the [Microsoft website]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}.

#### How can I find out whether a certain Microsoft product is eligible for License Mobility? {#check-license-mobility}

This information is included in the terms of use for a specific Microsoft product. Whether or not a product is eligible for the License Mobility through Software Assurance program is indicated in the corresponding section of the Software Assurance agreement. Products that are eligible for the License Mobility through Software Assurance program include Remote Desktop Services, System Center, Exchange, and SharePoint.

#### Do I need to have an active Software Assurance agreement and participate in the License Mobility through Software Assurance program to deploy my own Microsoft licenses in {{ yandex-cloud }}? {#sa-for-license-mobility}

When transferring your licensed software to Compute Cloud, it is a must to have a current Software Assurance agreement in place and participate in the License Mobility through Software Assurance program. An active Software Assurance agreement is always a requirement for participating in the License Mobility through Software Assurance program.

#### Can I import my own image with the Windows OS to {{ yandex-cloud }}? {#import-os-windows}

No, you cannot currently upload your own image with the Windows OS.

## Licensing: Windows Server {#windows-server}

#### Can I purchase Windows Server from {{ yandex-cloud }}? {#buy-windows-server}

Yes, you can purchase a VM with a pre-installed Windows Server 2012 or Windows Server 2016 image from {{ yandex-cloud }}. The Windows Server license is included in the cost of using {{ yandex-cloud }}.

#### How do I activate Windows Server {#activate-windows-server}

You may have activation issues if the VM doesn't have internet access.
1. Make sure that the VM has internet access.
1. Run the following commands in PowerShell as an administrator:

   ```powershell
   Test-NetConnection kms.cloud.yandex.net -Port 1688
   cscript.exe C:\Windows\System32\slmgr.vbs /dli
   cscript.exe C:\Windows\System32\slmgr.vbs /skms kms.cloud.yandex.net:1688
   cscript.exe C:\Windows\System32\slmgr.vbs /ato
   Get-Date
   Get-TimeZone
   ```

1. If activation was not successful, send us the output of these commands.

#### Can I deploy my own licenses Windows Server in {{ compute-name }}? {#custom-windows-server}

No. You currently can't deploy your own Windows Server licenses.

#### Does license mobility cover Windows Server? {#lm-windows-server}

No, it doesn't. According to the terms of use for Microsoft products, license mobility does not extend to the Windows Server family of operating systems.

## Licensing: other Microsoft products {#other-products}

#### Can I purchase other Microsoft products with licenses that can be deployed in Compute Cloud? {#buy-other-products}

No, you can't. Currently, {{ yandex-cloud }} only provides Windows Server licenses, as well as enables license transfer to server software under the [License Mobility through Software Assurance]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %} program. Licensing of MSDN, Windows OS, Microsoft Office, and other products is not yet available.