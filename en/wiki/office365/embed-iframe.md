# Embedding a document in a Wiki page

To embed an Office 365 document in a page along with other content formatted using Wiki markup, use the [dynamic block `iframe`](../actions/iframe.md).

1. On the [Sharepoint portal]({{link-sharepoint-common}}) or in your [OneDrive personal folder]({{link-sharepoint-personal}}), open the document you want to embed in the Wiki page.

1. Get the embed code:
   1. Open the document in your browser.
   1. Select **File** → **Share** → **Embed** (in the PowerPoint menu: **File** → **Share → **Embed**).
   1. Configure the document embed parameters.
   1. Copy text from the **Embed Code** field.

1. Paste the code into the Wiki page text.

1. Edit the code to get a working dynamic block:
   * Delete the text between the `<iframe></iframe>` tags.
   * Replace the `<iframe></iframe>` tags with `not_var{{iframe}}`.
   * Replace `&` with `&`.

   {% cut "Example" %}

   Document embed code:

   ```html
   <iframe src="https://yandexteam-my.sharepoint.com/personal/login_yandex-team_ru/_layouts/15/Doc.aspx?sourcedoc={95eb752a-0736-4071-b8b2-83792c6a825f}\&amp;action=embedview\&amp;wdStartOn=1" width="476px" height="288px" frameborder="0">This is an embedded <a target="_blank" href="https://office.com">Microsoft Office</a> file on the <a target="_blank" href="https://office.com/webapps">Office</a> platform.</iframe>
   ```

   Iframe block:

   ```
   {{iframe src="https://yandexteam-my.sharepoint.com/personal/login_yandex-team_ru/_layouts/15/Doc.aspx?sourcedoc={95eb752a-0736-4071-b8b2-83792c6a825f}&action=embedview&wdStartOn=1" width="476px" height="288px" frameborder="0"}}
   ```

   {% endcut %}

   {% cut "An additional parameters for Excel embedded document" %}

   | URL parameter | Action | Default |
   | --- | --- | --- |
   | wdHideSheetTabs=True | Hides labels that are displayed at the bottom of all sheets in a workbook. | False |
   | wdAllowInteractivity=True | Allows you to sort and filter data in tables and pivot tables of a workbook. | True |
   | wdHideGridlines=True | Hides grid lines on a sheet. | False |
   | wdHideHeaders=True | Hides row and column headers. | False |
   | Item=item_name | Outputs a specific item. If a workbook contains a diagram, table, pivot table, or named range and only this item needs to be displayed on a web page, you can specify it using the Item parameter. For information about named ranges and named items in Excel workbooks, see [Define and use names in formulas]({{link-excel}}). | Not set |
   | ActiveCell=cell_name | Sets an active (selected) cell in an embedded workbook when a web page is opened. You can specify a cell  by referring to it (for example, A1) or by name. | The last saved view is displayed |

   {% endcut %}

1. Save the page.

