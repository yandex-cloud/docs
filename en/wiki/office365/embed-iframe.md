# Embedding documents on Wiki pages

To embed an Office 365 document on a page along with other content formatted using the Wiki markup, you can use the ["iframe" dynamic block](../actions/iframe.md).

1. Go to the [Sharepoint portal]({{link-sharepoint-common}}) or your [personal OneDrive folder]({{link-sharepoint-personal}}) and open the document you want to embed.

1. Get the embed code:
   1. Open the document in the browser.
   1. In the menu, select **File** → **Share** → **Embed** (in PowerPoint, **File** → **Shared access → **Embed**).
   1. Configure embedding parameters for the document.
   1. Copy the text from the **Embed code** field.

1. Paste the code into the text body of the Wiki page.

1. Edit the code so you get a functional dynamic block:
   * Delete the text between the tags: `<iframe></iframe>`.
   * Replace the `<iframe></iframe>` tags with `not_var{{iframe}}`.
   * Replace the `&` symbols with `&`.

   {% cut "Example" %}

   Document embed code:

   ```html
   <iframe src="https://yandexteam-my.sharepoint.com/personal/login_yandex-team_ru/_layouts/15/Doc.aspx?sourcedoc={95eb752a-0736-4071-b8b2-83792c6a825f}\&amp;action=embedview\&amp;wdStartOn=1" width="476px" height="288px" frameborder="0">This is an embedded <a target="_blank" href="https://office.com">Microsoft Office</a> file hosted on <a target="_blank" href="https://office.com/webapps">Office</a>.</iframe>
   ```

   Iframe block:

   ```
   {{iframe src="https://yandexteam-my.sharepoint.com/personal/login_yandex-team_ru/_layouts/15/Doc.aspx?sourcedoc={95eb752a-0736-4071-b8b2-83792c6a825f}&action=embedview&wdStartOn=1" width="476px" height="288px" frameborder="0"}}
   ```

   {% endcut %}

   {% cut "An additional parameters for Excel embedded document" %}

   | URL parameter | Action | By default |
   | --- | --- | --- |
   | wdHideSheetTabs=True | Hides the icons that are displayed at the bottom of all the sheets in the book. | False |
   | wdAllowInteractivity=True | Allows you to sort and filter data in tables and pivot tables. | True |
   | wdHideGridlines=True | Hides the grid lines on the sheet. | False |
   | wdHideHeaders=True | Hides row and column headers. | False |
   | Item=element_name | Displays a specific element. If the book contains a diagram, table, pivot table, or named range, and this is the only element to be displayed on the webpage, you can specify it using the Item parameter. For information about named ranges and named elements in Excel books, see the article: [Defining and using names in formulas]({{link-excel}}). | Not set |
   | ActiveCell=cell_name | Determines which cell will be active (selected) in the embedded book when the webpage is opened. You can specify a cell by link (such as A1) or name. | The last saved view is displayed |

   {% endcut %}

1. Save the page.

