To make sure the setup created user accounts from your secret, log in to Windows on your VM:

1. In the [management console]({{ link-console-main }}), select your VM folder.
1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Select the `win-test` VM.
1. Navigate to the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
1. Under **{{ ui-key.yacloud.compute.instance.switch_console }}**, select `COM2` and click **{{ ui-key.yacloud.compute.instance.console.connect }}**. You will see the command line prompt:

    ```bash
    Computer is booting, SAC started and initialized.                               
                                                                                    
    Use the "ch -?" command for information about using channels.                   
    Use the "?" command for general help.                                           
                                                                                    
                                                                                    
    SAC>                                                                            
    EVENT: The CMD command is now available.                                         
    ```

1. Show the list of open channels:

    ```bash
    SAC>ch
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    ```

1. Create a new channel with a shell instance, if required.

    ```bash
    SAC>cmd
    The Command Prompt session was successfully launched.
    SAC>
    EVENT:   A new channel has been created.  Use "ch -?" for channel help.
    Channel: Cmd0001
    ```

1. To switch to a channel, press **ESC** + **TAB** or run the following command:

    ```bash
    SAC>ch -sn Cmd0001
    Name:                  Cmd0001
    Description:           Command
    Type:                  VT-UTF8
    Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
    Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

    Press <esc><tab> for next channel.
    Press <esc><tab>0 to return to the SAC channel.
    Use any other key to view this channel.
    ```

1. Press **Enter** and specify the following:

    * Username.
    * Domain, if you logged in under a domain account; otherwise, enter your host name or nothing.
    * Password.

    ```bash
    Please enter login credentials.
    Username: Administrator
    Domain  :
    Password: ***************
    ```

1. If you logged in successfully, you will see the Windows command prompt:

    ```bash
    C:\Windows\system32>
    ```

    A successful login means that the setup created user accounts from your secret.
