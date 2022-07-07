1. On the page the produces the error, press **Ctrl** + **Shift** + **J** (**⌥** + **⌘** + **J** for macOS) or select ![image](../../_assets/support/yb-menu.png) → **Advanced** → **More tools** → **Developer tools** from the menu.
1. Click the **Network** tab.
1. Make sure that network logging is enabled: the button in the top left-hand corner is red ![image](../../_assets/support/chromium-log-record.png =20x20). If the button is black, press it.
1. Enable **Preserve log**.
1. To limit the HAR file to records that have to do with the error, clear the log by clicking ![image](../../_assets/support/chromium-log-clear.png =20x20) to the right of the record network log button.
1. Refresh the page or reproduce the actions that result in an error.
1. Right-click the table and select **Save all as HAR with content**.
1. Attach the HAR file to your message to [technical support]({{ link-console-support }}).
