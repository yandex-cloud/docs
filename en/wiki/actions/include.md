# Text from external sources

Use the `include` block to add content from other [pages from {{wiki-name}}](#include-wiki) or [external sources](#include-ext).

## Using a block {#include-call}

```
{{ include page="{{ wiki-pagename }}/" notoc notitle nomark}} 
```

## Block parameters {#include-params}

### {{wiki-name}} pages {#include-wiki}

| Parameter | Description |
| --- | --- |
| `page` | Required parameter. Relative page URL in {{wiki-name}}. |
| `notitle` | Displaying the title of the inserted page. To hide the title, use `notitle = 1`. |
| `notoc` | Showing headers from the added page in the page's table of contents. To avoid adding headers, use `notoc = 1`. |
| `nowarning` | Showing an error message to users who aren't allowed to read the added page. If you don't want to show the message, enter `nowarning = 1` |
| `from` / `to` | Names of [anchors](#anchor) on the {{wiki-name}} page to add content in-between. An entire page is added by default. This parameter only applies to anchors added manually: automatic anchors created from headers can't be used. |

### External sources {#include-ext}

| Parameter | Description |
| --- | --- |
| `href` | Required parameter. The URL of the page. |
| `expired` | The lifetime for the cache of an external page (in minutes). By default, it's 60 minutes. To disable cache storage, use `expired = 0`. |
| `login` | The login for HTTP authorization. |
| `passwd` | The password for HTTP authorization. |
| `formatter` | Formatting the text of the added page. If the parameter is omitted, it's detected automatically from the attached file extension. If the format can't be detected, the `code` value is used. |
| `enc` | The encoding of the added page. The default encoding is `Windows-1251`. |

### Examples {#include-examples}

* To add a file from an SVN repository to your page, use the code:

    ```
    {{include href="https://svn.yandex.ru/wiki/planner/trunk/src/planner/urls.py" formatter="python" expired=50}}
    ```

* To add a file from a Git repository to your page, use the code:

    ```
    {{include href="https://github.yandex-team.ru/tools/wiki.git/?a=blob_plain;f=src/wiki/formatters/classes/base.py;h=4a77086f0e26551a19b2f7aed5ca898266dbe0d6;hb=HEAD" formatter="python" expired=999 from="11" to="20"}}
    ```

* To add a section of a {{wiki-name}} page between two anchors, use the code:

    ```
    {{include page="/wiki/vodstvo/lists/Grids" from="tracker-start" to="tracker-end" nomark notitle}}
    ```

* To add a file from Arcanum to your page, use the code:

    ```
    {{include href="https://a.yandex-team.ru/api/v1/repos/arc/tree/blob/trunk/arcadia/extsearch/video/vh/common/abc_mapping/data/abc_mapping.json?commit_id=HEAD" formatter="json" expired=999 from="110" to="117"}}
    ```

    To get an embed link from Arcanum, open the source file and switch to the **Raw** mode.

{% note info %}

To see how the `include` block works in {{wiki-name}}, follow the [link](https://wiki.yandex-team.ru/wiki/vodstvo/actions/actioninclude/#primery).

{% endnote %}

