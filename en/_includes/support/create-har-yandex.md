1. On the page with the error, press **Ctrl** + **Shift** + **I** (**⌥** + **⌘** + **I** for macOS) or select ![image](../../_assets/support/yb-burger.svg) → **Advanced** → **Developer tools** from the menu.
1. Go to the **Network** tab.
1. Make sure network logging is enabled: the button in the top-left corner is red ![image](../../_assets/support/yb-stop-rec.svg). If the button is grey, click it.
1. Enable **Preserve log**.
1. To limit the HAR file to records that have to do with the error, clear the log by clicking ![image](../../_assets/support/yb-clear-log.svg) to the right of the record network log button.
1. Refresh the page or repeat the actions that resulted in the error.
1. Click ![image](../../_assets/support/yb-export-har.svg) **Export HAR (sanitized)...** (**Export HAR (sanitized)...**) and save the HAR file.
1. Attach the HAR file to your message to [support]({{ link-console-support }}).
