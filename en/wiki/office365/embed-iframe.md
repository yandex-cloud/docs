# Embedding a document in a Wiki page

To embed an Office 365 document along with other content formatted using Wiki markup in your page, use the [dynamic block `iframe`](../actions/iframe.md).

1. In [SharePoint]({{ link-sharepoint-common }}) or your [OneDrive personal folder]({{ link-sharepoint-personal }}), open the document to add to your Wiki page.

1. Get the embed code:
   1. Open the document in your browser.
   1. Select **File** → **Share** → **Embed** (for a presentation in PowerPoint, **File** → **Share → **Embed**).
   1. Set the document embed parameters.
   1. Copy the text from the **Embed Code** field.

1. Paste the code in the text of the Wiki page.

1. Edit the code to have a functioning dynamic block:
   * Delete the text between the `<iframe></iframe>` tags.
   * Replace the `<iframe></iframe>` tags with `not_var{{iframe}}`.
   * Replace `&amp;` with `&`.

   {% cut "Example" %}

   The document embed code:

   ```html
   <iframe src="https://yandexteam-my.sharepoint.com/personal/login_yandex-team_ru/_layouts/15/Doc.aspx?sourcedoc={95eb752a-0736-4071-b8b2-83792c6a825f}\&amp;action=embedview\&amp;wdStartOn=1" width="476px" height="288px" frameborder="0">This is an embedded file <a target="_blank" href="https://office.com">Microsoft Office</a> on the platform <a target="_blank" href="https://office.com/webapps">Office</a>.</iframe>
   ```

   The iframe block:

   ```
   {{iframe src="https://yandexteam-my.sharepoint.com/personal/login_yandex-team_ru/_layouts/15/Doc.aspx?sourcedoc={95eb752a-0736-4071-b8b2-83792c6a825f}&action=embedview&wdStartOn=1" width="476px" height="288px" frameborder="0"}}
   ```
   {% endcut %}

   {% cut "Additional parameters for embedding Excel documents" %}

   | URL address parameter | Action | By default |
   --- | --- | ---
   | wdHideSheetTabs=True | Hides tabs that are displayed at the bottom of all worksheets. | False |
   | wdAllowInteractivity=True | Allows filtering data in tables and summary tables in a workbook. | True |
   | wdHideGridlines=True | Hides gridlines on a worksheet. | False |
   | wdHideHeaders=True | Hides row and column headers. | False |
   | Item=item_name | Outputs a specific item. If the workbook contains a diagram, table, summary table, or named range and you only need to display this item on your web page, you can set it with the Item parameter. For more information about named ranges and items in Excel workbooks, see [Define and use names in formulas]({{ link-excel }}). | Not specified |
   | ActiveCell=cell_name | Sets the cell to be active (selected) in the embedded workbook when opening the web page. You can specify this cell via a link to it (such as A1) or by name. | The last saved view is output. |

   {% endcut %}

1. Save the page.