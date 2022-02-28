# Formatting text in issues

To format text in issue descriptions or comments, use Yandex Flavored Markdown syntax. For example, you can format text with italics or bold, as well as add lists and tables.

If you want to see a preview of how the issue description or comment would look after formatting, click **Preview**. Click **Edit** to resume formatting.

The basic markup options are listed below.

| Element | Markup | Result |
| ----- | ----- | ----- |
| Headings | ```# First level header```<br/>```## Second level header```<br/>```### Third level header``` | ![](../../_assets/tracker/format/h1-h3.png) |
| Bold | ```**Bold**``` | **Bold** |
| Italics | ```_Italics_``` | _Italics_ |
| Bold italics | ```**_Bold italics_**``` | **_Bold italics_** |
| Also bold italics | ```_**Also bold italics**_``` | _**Also bold italics**_ |
| Strikethrough | ```~~Strikethrough~~``` | ~~Strikethrough~~ |
| Underline | ```++Underlined text++``` | ![](../../_assets/tracker/format/underlined.png) |
| Superscript | ```Super^script^``` | Super^script^ |
| Monospaced text | ```##Monospaced text##``` | ![](../../_assets/tracker/format/monospaced.png) |
| Colored text.<br/><br/>Supported colors:<br/><br/>`red`;<br/>`green`;<br/>`blue`;<br/>`gray`;<br/>`yellow`. | ```{blue}(Blue text)``` | ![](../../_assets/tracker/format/colored.png) |
| Numbered list | ```1. List item.```<br/>```1. List item.```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. Nested list item.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. Nested list item.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`1. Nested list item.`<br/>```1. List item.``` | ![](../../_assets/tracker/format/ol.png) |
| Bulleted list | ```* List item.```<br/>```* List item:```<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* Nested list item.`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`* Nested list item.`<br/>```* List item.``` | ![](../../_assets/tracker/format/ul.png) |
| Link | ```[link_text]({{ link-yandex }})``` | [link_text]({{ link-yandex }}) |
| URL | To convert a URL or email address into a link, add angle brackets on both sides <>.<br/>```<{{ link-yandex }}>``` | <{{ link-yandex }}> |
| Issue link | ``` TEST-123 ``` | ![](../../_assets/tracker/format/tracker-magic-link.png) |
| Quoted text | ```> Quoting```<br/>```>> Nested quotes``` | ![](../../_assets/tracker/format/quote.png) |
| Collapsed text | ```{% cut "Read the entire text" %}```<br/>```The content that's displayed on click.```<br/>```{% endcut %}``` | ![](../../_assets/tracker/format/cut.png) |
| Table | ```\| Heading1 \| Heading2  \|```<br/>```\| ---------- \| ---------- \|```<br/>```\| Text       \| Text       \|```<br/>```\| Text       \| Text       \|``` | ![](../../_assets/tracker/format/table.png) |
| Multiple-line table | ```#\|```<br/>```\|\| **Heading1** \| **Heading2** \|\|```<br/>```\|\| Text ```<br/>```on two lines```<br/>```\| Text \|\|```<br/>```\|#``` | ![](../../_assets/tracker/format/table2.png) |
| Source code | ``` `code snippet` ``` | `code snippet` |
| Multiple-line code block | ` ```php`<br/>`<?`<br/>`phpinfo();`<br/>`$s = "Hello, World!\n";`<br/>`print $s;`<br/>` ``` ` | ![](../../_assets/tracker/format/source-code-3.png) |
| Escaping markup elements | ```\*\*escaping** _markup elements_``` | \*\*escaping** _markup elements_ |

