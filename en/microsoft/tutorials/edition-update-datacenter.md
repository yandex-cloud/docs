# Upgrading Windows Server to Datacenter edition

If you're using Windows Server **Standard** Edition (2019, 2016, or 2012 R2), we recommend that you upgrade it to Windows Server Datacenter.

To update the Windows Server edition, use the built-in [DISM](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-windows-edition-servicing-command-line-options) utility.

{% list tabs %}

- PowerShell

   1. Run PowerShell as an administrator.
   1. View what edition is installed:

      ```powershell
      dism /Online /Get-CurrentEdition
      ```

      Result:

      ```
      ...
      Current edition is:

      Current Edition : ServerStandard
      ...
      ```

   1. Check what edition you can upgrade to:

      ```powershell
      dism /Online /Get-TargetEditions
      ```

      Result:
      ```
      ...
      Editions that can be upgraded to:

      Target Edition : ServerDatacenter
      ...
      ```

   1. To update, use the [KMS Client Product Key]({{ ms.docs }}/windows-server/get-started/kmsclientkeys) corresponding to the edition installed:
      * Windows Server **2019** Datacenter:
         ```
         WMDGN-G9PQG-XVVXX-R3X43-63DFG
         ```
      * Windows Server **2016** Datacenter:
         ```
         CB7KF-BWN84-R7R2Y-793K2-8XDDG
         ```
      * Windows Server **2012 R2** Datacenter:
         ```
         W3GGN-FT8W3-Y4M27-J84CP-Q3VJ9
         ```

      Replace the `<product_key>` parameter value with the KMS key and run the command:

      ```powershell
      DISM.exe /Online /Set-Edition:ServerDatacenter /AcceptEula /ProductKey:<product_key>
      ```

   After the operation is completed, the server is automatically restarted. If this doesn't happen, restart the server yourself.

   You can check the installed edition using the command:

   ```powershell
   dism /Online /Get-CurrentEdition
   ```

{% endlist %}

