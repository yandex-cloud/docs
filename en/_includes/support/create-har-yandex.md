1. On the page with the error, press **Ctrl** + **Shift** + **I** (**⌥** + **⌘** + **I** for macOS) or select ![image](../../_assets/support/yb-menu.png =20x20) → **Advanced** → **Developer tools** from the menu.
1. Go to the **Network** tab.
1. Make sure network logging is enabled: the button in the top-left corner is red ![image](../../_assets/support/chromium-log-record.png =20x20). If the button is black, click it.
1. Enable **Preserve log**.
1. To limit the HAR file to records that have to do with the error, clear the log by clicking ![image](../../_assets/support/chromium-log-clear.png =20x20) to the right of the record network log button.
1. Refresh the page or repeat the actions that resulted in the error.
1. Right-click the table and select **Save all as HAR with content**.
1. Attach the HAR file to your message to [support]({{ link-console-support }}).
