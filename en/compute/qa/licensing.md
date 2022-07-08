# Windows licensing

The terms of use for Microsoft software are governed by the terms and conditions of the Microsoft license agreement that you enter into when purchasing a Microsoft product. The user is responsible for complying with the Microsoft licensing terms. Licensing recommendations are provided below. You are in no way obligated to follow such recommendations as they are not legally binding. If you have any questions about Microsoft software licensing and product usage rights, please consult your legal department or Microsoft reseller. The information on this page complies with the current [Microsoft Product Terms]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/product-licensing/products){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/product-licensing/products){% endif %}.

#### What is the relationship between Microsoft and {{ yandex-cloud }}? {#status}

{{ yandex-cloud }} is licensed to distribute Microsoft software products under the Services Provider License Agreement (SPLA) for providing software services. {{ yandex-cloud }} is also an authorized Microsoft partner under the [License Mobility]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %} through Software Assurance.

#### Does {{ yandex-cloud }} provide extended support for Microsoft products? {#expanded-support}

No, the {{ yandex-cloud }} team does not currently offer support for Microsoft products.

#### What Microsoft software can I run on the {{ yandex-cloud }} platform? {#supported-soft}

{{ yandex-cloud }} supports server software available under the [License Mobility]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %} through Software Assurance.

#### What is License Mobility? {#license-mobility}

License Mobility is a benefit provided to customers with Microsoft corporate licenses for eligible server software covered by active Microsoft Software Assurance (SA) agreements. With License Mobility, customers can use eligible Microsoft software when working with third-party cloud solution providers such as {{ yandex-cloud }}. See more details at the [Microsoft website]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}.

#### How can I find out whether a Microsoft product is eligible for License Mobility? {#check-license-mobility}

This information is included in the terms of use for the Microsoft product. Whether or not a product is eligible for the License Mobility through Software Assurance program is indicated in the corresponding section of the Software Assurance agreement. Products that are eligible for the License Mobility through Software Assurance program include Remote Desktop Services, System Center, Exchange, and SharePoint.

#### Do I need to have a current Software Assurance agreement in place and participate in the License Mobility through Software Assurance program to deploy my own Microsoft licenses in {{ yandex-cloud }}? {#sa-for-license-mobility}

When transferring your licensed software to Compute Cloud, you must have a current Software Assurance agreement in place and participate in the License Mobility through Software Assurance program. An active Software Assurance agreement is always a requirement for participating in the License Mobility through Software Assurance program.

#### Can I import my own Windows image to {{ yandex-cloud }}? {#import-os-windows}

No. Currently, you cannot upload your own images with Windows.

### Windows Server licensing {#windows-server}

#### Can I purchase Windows Server from {{ yandex-cloud }}? {#buy-windows-server}

Yes, you can purchase a VM with a pre-installed [Windows Server 2012](/marketplace/products/yc/windows-server-2012r2-datacenter) or [Windows Server 2016](/marketplace/products/yc/windows-server-2016-datacenter) image from {{ marketplace-full-name }}. The Windows Server license is included in the cost of using {{ yandex-cloud }}.

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

   If activation was not successful, send us the output of these commands.

#### Can I deploy my own Windows Server licenses in {{ compute-name }}? {#custom-windows-server}

No. You currently can't deploy your own Windows Server licenses.

#### Does License Mobility cover Windows Server? {#lm-windows-server}

No. According to the terms of use for Microsoft products, License Mobility does not extend to Windows Server operating systems.

### Licensing of other Microsoft products {#other-products}

#### Can I purchase other Microsoft products with licenses that can be deployed in {{ compute-name }}? {#buy-other-products}

No. Currently, {{ yandex-cloud }} only provides Windows Server licenses and transfers server software licenses under the [License Mobility]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}. through Software Assurance Licensing of MSDN, Windows OS, Microsoft Office, and other products is not yet available.