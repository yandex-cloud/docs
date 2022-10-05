# RSS news feed

In the `feed` section, to can embed an RSS feed from [Atushka](https://my.at.yandex-team.ru/) or external sources.

## Using a block {#feed-call}

Show articles from Atushka:

```
{{feed url="http://my.at.yandex-team.ru/rss/popular.xml" notitlelink=1 max=5 nomark=1 time=1 dateformat="d.m H:M" today=1}}
```

Show articles from an external site:

```
{{feed url="http://rss.newsru.com/top/big/" nodesc="1" max=3 nomark=1 time=1 dateformat="d.m"}} 
```

## Block parameters {#feed-params}

| Parameter | Description |
| --- | --- |
| `url` | The RSS feed URL. |
| `notitlelink` | Don't make the header of an RSS feed entry a link. |
| `max`\|`limit` | The maximum number of entries in an RSS feed. |
| `nomark` | By default, RSS feeds are shown with a border (`nomark = 0`). To hide the border, use `nomark = 1`. |
| `title` | RSS feed header. |
| `time` | This parameter displays the publication date for the entry. To hide the date, use `time = 0`. |
| `dateformat` | The date display format (the [strftime](https://docs.python.org/2/library/datetime.html#strftime-strptime-behavior) method). |
| `today` | Use `today = 1` to show `today` next to entries published today. This label is shown if `time = 1`. |

