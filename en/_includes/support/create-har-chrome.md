1. On the page with the error, press **Ctrl** + **Shift** + **I** (**⌥** + **⌘** + **I** for macOS) or select ![image](../../_assets/vertical-ellipsis.svg) → **More Tools** → **Developer Tools** from the menu.
1. Go to the **Network** tab.
1. Make sure network logging is enabled: the button in the top-left corner is red ![image](../../_assets/support/chromium-log-record-new.png =20x20). If the button is black, click it.
1. Enable **Preserve log**.
1. To limit the HAR file to records that have to do with the error, clear the log by clicking ![image](../../_assets/support/chromium-log-clear-new.png =20x20) to the right of the record network log button.
1. Refresh the page or repeat the actions that resulted in the error.
1. Click ![image](../../_assets/support/chromium-export-har.png =30x30) **Export HAR** in the top panel.
1. Attach the HAR file to your message to [support]({{ link-console-support }}).