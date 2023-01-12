# Text from external sources

The `include` block lets you insert content from another [page in {{ wiki-name }}](#include-wiki) or from [external sources](#include-ext).

## Using the block {#include-call}

```
{{ include page="{{ wiki-pagename }}/" notoc notitle nomark}} 
```

## Block parameters {#include-params}

### {{ wiki-name }} pages {#include-wiki}

| Parameter | Description |
--- | ---
| `page` | Required parameter. Relative address of the page in {{ wiki-name }}. |
| `notitle` | Displaying the title of the connected page. To disable title display, set `notitle = 1`. |
| `notoc` | Displaying titles from the connected page in the general table of contents. To avoid adding titles, set `notoc = 1`. |
| `nowarning` | An error message displayed to users with no permission to read the connected page. To disable message display, set `nowarning = 1`. |
| `from` / `to` | Names of {{ wiki-name }} page [anchors](#anchor) that limit the content to be added. By default, the entire page is added. The parameter only works for anchors added manually: you can't use automatic anchors from titles. |

### External sources {#include-ext}

| Parameter | Description |
--- | ---
| `href` | Required parameter. Page URL. |
| `expired` | External page's cache lifetime in minutes. The default value is 60 minutes. To disable cache storage, set `expired = 0 `. |
| `login` | Login used for HTTP authorization. |
| `passwd` | Password used for HTTP authorization. |
| `formatter` | Formatting the text of the connected page. If the parameter is omitted, it's detected automatically by the imported file's extension. If the format can't be identified, the `code` value is inserted. |
| `enc` | Encoding of the connected page. The default is `Windows-1251`. |

### Examples {#include-examples}

* To add a file from an SVN repository to your page, use the following code:
   ```
   {{include href="https://svn.yandex.ru/wiki/planner/trunk/src/planner/urls.py" formatter="python" expired=50}}
   ```

* To add a file from a Git repository to your page, use the following code:
   ```
   {{include href="https://github.yandex-team.ru/tools/wiki.git/?a=blob_plain;f=src/wiki/formatters/classes/base.py;h=4a77086f0e26551a19b2f7aed5ca898266dbe0d6;hb=HEAD" formatter="python" expired=999 from="11" to="20"}}
   ```

* To embed a section of a {{ wiki-name }} page limited with anchors in your page, use the following code:
   ```
   {{include page="/wiki/vodstvo/lists/Grids" from="tracker-start" to="tracker-end" nomark notitle}}
   ```
* To add a file from Arcanum to your page, use the following code:
   ```
   {{include href="https://a.yandex-team.ru/api/v1/repos/arc/tree/blob/trunk/arcadia/extsearch/video/vh/common/abc_mapping/data/abc_mapping.json?commit_id=HEAD" formatter="json" expired=999 from="110" to="117"}}
   ```
   To get a link to embed a file from Arcanum, open the file with source code and switch to **Raw** mode.

{% note info %}

To see how the `include` block works in {{ wiki-name }}, follow this [link](https://wiki.yandex-team.ru/wiki/vodstvo/actions/actioninclude/#primery).

{% endnote %}