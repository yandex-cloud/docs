---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Format text in issues

Use wiki markup when formatting text in issue descriptions or comments. For example, you can format text with italics or bold, as well as add lists and tables.

If you want to see the preview of how the issue description or comment will look after formatting, click **Preview** under the text input field. Click **Edit** to continue formatting.

The basic markup options are listed below.

| Element | Markup | Result |
| ----- | ----- | ----- |
| Headings | ```== First-level header```<br/>```=== Second-level header```<br/>```==== Third-level header``` | ![](../../_assets/tracker/format/h1-h3.png) |
| Horizontal line | ``` ---- ``` | ![](../../_assets/tracker/format/hr.png) |
| Bold | ``` **Bold text**``` | ![](../../_assets/tracker/format/bold.png) |
| Italics | ```*Italics*``` | ![](../../_assets/tracker/format/italic.png) |
| Underline | ``` __Underlined text__``` | ![](../../_assets/tracker/format/underlined.png) |
| Strikethrough | ``` --Strikethrough text--``` | ![](../../_assets/tracker/format/crossed.png) |
| Small text | ``` ++Small font++``` | ![](../../_assets/tracker/format/small-text.png) |
| Highlighted text | ```??Highlighted text??``` | ![](../../_assets/tracker/format/red-background.png) |
| Colored text.<br/><br/>Colors supported:<br/><br/>`red`;<br/>`green`;<br/>`blue`;<br/>`grey` / `gray`;<br/>`yellow`. | ```!!(blue)Blue text!!``` | ![](../../_assets/tracker/format/colored.png) |
| Numbered list | ```1. List item.```<br/>```2. List item.```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. Nested list item.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`2. Nested list item.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`3. Nested list item.`<br/>```3. List item.``` | ![](../../_assets/tracker/format/numerated-list-exampe.png) |
| Bulleted list | ```* list item;```<br/>```* list item:```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* nested list item;`<br/>```* list item.``` | ![](../../_assets/tracker/format/unordered-list-exampe.png) |
| Link | ```((http://example.com / link text))``` | ![](../../_assets/tracker/format/hyperlink.png) |
| Issue link | ``` TEST-123 ``` | ![](../../_assets/tracker/format/tracker-magic-link.png) |
| Quoted text | ``` <[Quoting long,``` <br/> ``` text,```<br/>``` with linebreaks]>``` | ![](../../_assets/tracker/format/quote.png) |
| Single-line quote | ``` >Single-line quoting```<br/>```>>Second-level quote``` | ![](../../_assets/tracker/format/inline-quote.png) |
| Collapsed text | ```<{Read the entire text```<br/>```This text can be seen by clicking```<br/>```the link "Read the entire text".```<br/>```}>``` | ![](../../_assets/tracker/format/cut.png) |
| Table | ```#\|```<br/>```\|\|cell 11\|cell 12\|cell 13\|\|```<br/>```\|\|cell 21\|cell 22\|\|```<br/>```#\|``` | ![](../../_assets/tracker/format/table.png) |
| Source code | ```%%code fragment%%``` | ![](../../_assets/tracker/format/source-code-2.png) |
| Escaping wiki markup | ``` ""**Escaping all markup**```<br/>```//elements in this text//""```<br/>```~**Escaping a single** //markup element//``` | ![](../../_assets/tracker/format/escaping.png) |