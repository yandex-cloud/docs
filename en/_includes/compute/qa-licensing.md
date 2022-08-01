# Windows licensing

The terms of use for Microsoft software are governed by the terms and conditions of the Microsoft license agreement that you enter into when purchasing a Microsoft product. The user is responsible for complying with the Microsoft licensing terms. Licensing recommendations are provided below. You are in no way obligated to follow such recommendations as they are not legally binding. If you have any questions about Microsoft software licensing and product usage rights, please consult your legal department or Microsoft reseller. The information on this page complies with the [current Microsoft Product Terms](https://www.microsoft.com/en-us/licensing/product-licensing/products).

## General questions about licensing {#common}

#### What is the relationship between Microsoft and {{ yandex-cloud }}? {#status}

{{ yandex-cloud }} is licensed to distribute Microsoft software products under the Services Provider License Agreement (SPLA) for providing software services. {{ yandex-cloud }} is also an authorized Microsoft partner under the [License Mobility through Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) program.

#### Does {{ yandex-cloud }} provide extended support for Microsoft products? {#expanded-support}

No, the {{ yandex-cloud }} team does not currently offer support for Microsoft products.

#### What is License Mobility? {#license-mobility}

License Mobility is a benefit provided to customers with Microsoft corporate licenses for eligible server software covered by active Microsoft Software Assurance (SA) agreements. With License Mobility, customers can use eligible Microsoft software when working with third-party cloud solution providers such as {{ yandex-cloud }}. To learn more, go to the [Microsoft website](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility).

#### What Microsoft software can I run on the {{ yandex-cloud }} platform? {#supported-soft}

{{ yandex-cloud }} supports server software available under the [License Mobility through Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) program.

#### How can I find out whether a Microsoft product is eligible for License Mobility? {#check-license-mobility}

This information is included in the terms of use for the Microsoft product. Whether or not a product is eligible for the License Mobility through Software Assurance program is indicated in the corresponding section of the [Software Assurance agreement](https://www.microsoft.com/en-us/licensing/terms/product/SoftwareAssuranceBenefits/all). Products that are eligible for the License Mobility through Software Assurance program include Remote Desktop Services, System Center, Exchange, and SharePoint.

#### Do I need to have a current Software Assurance agreement in place and participate in the License Mobility through Software Assurance program to deploy my own Microsoft licenses in {{ yandex-cloud }}? {#sa-for-license-mobility}

Yes. When using licensed Microsoft software in Yandex Compute Cloud, you must have a current Software Assurance agreement in place and participate in the License Mobility through Software Assurance program. An active Software Assurance agreement is always a requirement for participating in the License Mobility through Software Assurance program.

#### Why do I need to specify the address when using Microsoft products? {#ms-licensing-address}

As of January 24, 2022, to use Microsoft products, you need to specify user data and addresses of individuals and legal entities. These are the requirements of the Microsoft licensing policy. If the data isn't provided, you can't run Microsoft products.
#### Can I deploy my own licenses in {{ compute-name }}? {#custom}

Questions about Windows Server licensing are discussed in detail in [{#T}](../../compute/qa/licensing.md).

In the case of other software that you want to use inside the VM, read the license you purchased or contact the technical support of the product itself and they'll tell you if it's possible to use the product with this license in {{ yandex-cloud }}.

### Windows Server licensing {#windows-server}

#### Can I purchase Windows Server from {{ yandex-cloud }}? {#buy-windows-server}

Yes, you can [purchase](/marketplace?categories=databases&operationSystems=WINDOWS) a VM with a pre-installed Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 image from {{ yandex-cloud }}. The Windows Server license is included in the {{ yandex-cloud }} service cost.

#### How do I activate Windows Server {#activate-windows-server}

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

1. If activation was not successful, send us the output of these commands.

#### Does License Mobility cover Windows Server? {#lm-windows-server}

No. According to the terms of use for Microsoft products, License Mobility does not extend to Windows Server operating systems.

### Licensing of other Microsoft products {#other-products}

#### Can I purchase other Microsoft products with licenses that can be deployed in Yandex Compute Cloud? {#buy-other-products}

Yes. Currently, {{ yandex-cloud }} provides Windows Server, Microsoft SQL Server, and RDS licenses and transfers server software licenses under the [License Mobility through Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) program. Licensing of MSDN, Windows OS, Microsoft Office, and other products is not available.
