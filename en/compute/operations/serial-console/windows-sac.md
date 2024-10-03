---
title: How to start your terminal in the Windows serial console (SAC) in {{ compute-full-name }}
description: Follow this guide to start your terminal in the Windows serial console (SAC).
---

# Starting your terminal in the Windows serial console (SAC)

To connect to the serial console and start the terminal:

1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Select the VM you need.
1. Click the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
1. Under **{{ ui-key.yacloud.compute.instance.switch_console }}**, select `COM2` and click **{{ ui-key.yacloud.compute.instance.console.connect }}**. The command line prompts you to enter commands:

   ```bash
   SAC>
   ```

1. View the list of open channels:

   ```bash
   SAC>ch
   Channel List

   (Use "ch -?" for information on using channels)

   # Status  Channel Name
   0 (AV)    SAC
   1 (AV)    Cmd0001
   ```

1. If necessary, create a new channel with a shell instance:

   ```bash
   SAC>cmd
   The Command Prompt session was successfully launched.
   SAC>
   EVENT:   A new channel has been created.  Use "ch -?" for channel help.
   Channel: Cmd0002
   ```

1. To switch to a channel, press **ESC**+**TAB** or run the command:

   ```bash
   SAC>ch -sn Cmd0002
   Name:                  Cmd0002
   Description:           Command
   Type:                  VT-UTF8
   Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
   Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

   Press <esc><tab> for next channel.
   Press <esc><tab>0 to return to the SAC channel.
   Use any other key to view this channel.
   ```

1. Press **Enter** and specify the following in the given order:
   - Username.
   - Domain if the domain account is used to log in. Otherwise, enter the hostname or leave it empty.
   - Password.

   ```bash
   Please enter login credentials.
   Username: Administrator
   Domain  :
   Password: ***************
   ```

1. An instance of the command line interpreter starts:

   ```bash
   C:\Windows\system32>
   ```

1. To run a PowerShell instance:

   ```bash
   C:\Windows\system32>powershell
   Windows PowerShell
   Copyright (C) Microsoft Corporation. All rights reserved.

   PS C:\Windows\system32>
   ```

   {% note warning %}

   To enter text in English when using PowerShell in the serial console, configure the Windows language settings:

   Go to **Control Panel** → **Region** → **Administrative** → **Welcome screen and new user accounts settings**. Under **Welcome Screen**, specify:
   * `Display Language` — `English (United States)`.
   * `Input Language` — `English (United States) — US`.

   {% endnote %}

1. To return to the management console, press **ESC**+**TAB**+**0**.
