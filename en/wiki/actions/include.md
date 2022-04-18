# Text from external sources

You can use the `include` block to embed content from other [pages in {{wiki-name}}](#include-wiki) or [external sources](#include-ext).

## Calling the block {#include-call}

```
{{ include page="{{ wiki-pagename }}/" notoc notitle nomark}} 
```

## Block parameters {#include-params}

### Pages {{wiki-name}} {#include-wiki}

| Parameter | Description |
| --- | --- |
| `page` | Required parameter. The page's relative address in {{wiki-name}}. |
| `notitle` | Displaying the title of the linked page. If you don't want to display the title, enter `notitle = 1`. |
| `notoc` | Displaying headings from the linked page in the table of contents. If you don't want to include the headings, enter `notoc = 1`. |
| `nowarning` | Displaying the error message to users who don't have permission to read the linked page. If you don't want to display this message, enter `nowarning = 1`. |
| `from` / `to` | Names of [anchors](#anchor) limiting the content to be linked to the {{wiki-name}} page. By default, the entire page is linked. This parameter only works for anchors that were added manually: you can't use automatic anchors from headers. |

### External sources {#include-ext}

| Parameter | Description |
| --- | --- |
| `href` | Required parameter. Page URL. |
| `expired` | External page cache lifetime in minutes. Set to 60 minutes by default. To disable cache storage, enter `expired = 0 `. |
| `login` | Login used for HTTP authorization. |
| `passwd` | Password used for HTTP authorization. |
| `formatter` | Formatting text on the linked page. If the parameter is not specified, it will be determined automatically based on the extension of the attached file. If the format could not be determined, the `code` value is used instead. |
| `enc` | Encoding of the linked page. `Windows-1251` is used by default. |

### Examples {#include-examples}

To embed a file from the repository, use the following code:

```
{{include href="https://svn.yandex.ru/wiki/planner/trunk/src/planner/urls.py" formatter="python" expired=50}}
```

{% cut "See the result" %}

```python
from django.conf.urls.defaults import *
from django.conf import settings

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
    (r'^',             include('rooms.urls')),
)

if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),
    )
```

{% endcut %}

To see how the `include` block works in {{wiki-name}}, follow the [link](https://wiki.yandex-team.ru/wiki/vodstvo/actions/actioninclude/#primery).

