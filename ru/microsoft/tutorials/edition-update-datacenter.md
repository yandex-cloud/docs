# Обновление редакции Windows Server до Datacenter

Если вы используете Windows Server **Standard** Edition (2019, 2016, 2012 R2), то рекомендуем вам повысить редакцию до Windows Server Datacenter.

Для изменения редакции Windows Server используется встроенная утилита [DISM](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-windows-edition-servicing-command-line-options).

{% list tabs %}

- PowerShell

  1. Запустите PowerShell от имени администратора.
  1. Посмотрите установленную редакцию:
      
      ```powershell
      dism /Online /Get-CurrentEdition
      ```

      Результат:
      
      ```
      ...
      Current edition is:

      Current Edition : ServerStandard
      ...
      ```

  1. Проверьте, обновление до какой редакции вам доступно:
      
      ```powershell
      dism /Online /Get-TargetEditions
      ```

      Результат:
      ```
      ...
      Editions that can be upgraded to:
    
      Target Edition : ServerDatacenter
      ...
      ```

  1. Для обновления используйте клиентский ключ [KMS Client ProductKey's]({{ ms.docs }}/windows-server/get-started/kmsclientkeys), соответствующий установленной редакции:
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
      
     Замените параметр `<product_key>` значением KMS-ключа и выполните команду:

      ```powershell
      DISM.exe /Online /Set-Edition:ServerDatacenter /AcceptEula /ProductKey:<product_key>
      ```

  После выполнения операции сервер будет автоматически перезагружен. Если этого не произошло, перезагрузите сервер самостоятельно.

  Вы можете проверить установленную редакцию с помощью команды:

   ```powershell
   dism /Online /Get-CurrentEdition
   ```

{% endlist %}

