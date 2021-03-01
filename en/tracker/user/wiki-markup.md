# Format text in issues

Use wiki markup when formatting text in issue descriptions or comments. For example, you can format text with italics or bold, as well as add lists and tables.

If you want to see the preview of how the issue description or comment will look after formatting, click **Preview** under the text input field. Click **Edit** to continue formatting.

The basic markup options are listed below.

| Element | Markup | Result |
| ----- | ----- | ----- |
| Headings | {% if locale == "ru" %}``` == First-level header ```<br/>```=== Second-level header
```<br/>```==== Third-level header```{% else %}```== The first level header```<br/>```=== The second level header```<br/>```The third level header```{% endif %} | ![](../../_assets/tracker/format/h1-h3.png) |
| Horizontal line | ``` ---- ``` | ![](../../_assets/tracker/format/hr.png) |
| Bold | {% if locale == "ru" %}``` **Bold text**```{% else %}```**Bold text**```{% endif %} | ![](../../_assets/tracker/format/bold.png) |
| Italics | {% if locale == "ru" %}```* Italics*```{% else %}`*Italic text*`{% endif %} | ![](../../_assets/tracker/format/italic.png) |
| Underline | {% if locale == "ru" %}``` __Underlined text__```{% else %}```__Underlined text__```{% endif %} | ![](../../_assets/tracker/format/underlined.png) |
| Strikethrough | {% if locale == "ru" %}``` --Strikethrough text--```{% else %}```--Strikethrough text--```{% endif %} | ![](../../_assets/tracker/format/crossed.png) |
| Small text | {% if locale == "ru" %}``` ++Small font++```{% else %}```++Small font++```{% endif %} | ![](../../_assets/tracker/format/small-text.png) |
| Highlighted text | {% if locale == "ru" %}```??Highlighted text??```{% else %}```??Highlighted text??```{% endif %} | ![](../../_assets/tracker/format/red-background.png) |
| Colored text.<br/><br/>Colors supported:<br/><br/>`red` / `red` / `red`;<br/>`green` / `green` / `green`;<br/>`blue` / `blue` / `blue`;<br/>`grey` / `gray` / `gray`;<br/>`yellow` / `yellow` | {% if locale == "ru" %}```!!(blue)Blue text!!```{% else %}```!!(blue)Blue text!!```{% endif %} | ![](../../_assets/tracker/format/colored.png) |
| Numbered list | {% if locale == "ru" %}```1. List item.```<br/>```2. List item.```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. Nested list item.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`2. Nested list item.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`3. Nested list item.`<br/>```3. List item.```{% else %}```1. list item;```<br/>```2. list item;```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`2. nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`3. nested list item;`<br/>```3. list item.```{% endif %} | ![](../../_assets/tracker/format/numerated-list-exampe.png) |
| Bulleted list | {% if locale == "ru" %}```* list item;```<br/>```* list item:```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>```* list item.```{% else %}```* list item;```<br/>```* list item:```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>```* list item.```{% endif %} | ![](../../_assets/tracker/format/unordered-list-exampe.png) |
| Link | {% if locale == "ru" %}```((http://example.com / link text))```{% else %}```((http://example.com/ link text))```{% endif %} | ![](../../_assets/tracker/format/hyperlink.png) |
| Issue link | ``` TEST-123 ``` | ![](../../_assets/tracker/format/tracker-magic-link.png) |
| Quoted text | {% if locale == "ru" %} ``` <[Quoting long,``` <br/> ``` text,```<br/>``` with linebreaks]>``` {% else %} ``` <[Quoting long```<br/>``` text```<br/>```with linebreaks]>```{% endif %} | ![](../../_assets/tracker/format/quote.png) |
| Single-line quote | {% if locale == "ru" %}``` >Single-line quoting```<br/>```>>Second-level quote```{% else %}```>Single-line quoting```<br/>```>>Second-level quote```{% endif %} | ![](../../_assets/tracker/format/inline-quote.png) |
| Collapsed text | {% if locale == "ru" %}```<{Read the entire text```<br/>```This text can be seen by clicking```<br/>```the link "Read the entire text".```<br/>```}>```{% else %}```<{Read the entire text```<br/>```This text can be seen by clicking```<br/>```the link "Read the entire text".```<br/>```}>```{% endif %} | ![](../../_assets/tracker/format/cut.png) |
| Table | ```#|```<br/>```||cell 11|cell 12|cell 13||```<br/>```||cell 21|cell 22||```<br/>```#|``` | ![](../../_assets/tracker/format/table.png) |
| Source code | {% if locale == "ru" %}```%%code fragment%%```{% else %}```%%code fragment%%```{% endif %} | ![](../../_assets/tracker/format/source-code-2.png) |
| Escaping wiki markup | {% if locale == "ru" %}``` ""**Escaping all markup**```<br/>```//elements in this text//""```<br/>```~**Escaping a single** //markup element//```{% else %}```""**Escaping all markup**```<br/>```//elements in this text//""```<br/>```~**Escaping a single** //markup element//  ```{% endif %} | ![](../../_assets/tracker/format/escaping.png) |

[Contact support](../troubleshooting.md)

