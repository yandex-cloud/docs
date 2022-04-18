# RSS news feeds

Use the `feed` block to embed an RSS feed with entries from [Atushka](https://my.at.yandex-team.ru/) or external sources.

## Calling the block {#feed-call}

Display entries from Atushka:

```
{{feed url="http://my.at.yandex-team.ru/rss/popular.xml" notitlelink=1 max=5 nomark=1 time=1 dateformat="d.m H:M" today=1}}
```

Display entires from external websites:

```
{{feed url="http://rss.newsru.com/top/big/" nodesc="1" max=3 nomark=1 time=1 dateformat="d.m"}} 
```

## Block parameters {#feed-params}

| Parameter | Description |
| --- | --- |
| `url` | Address of the RSS feed. |
| `notitlelink` | Don't convert the RSS feed element header into a link. |
| `max`\|`limit` | Maximum number of entries in the RSS feed. |
| `nomark` | By default, the RSS feed is displayed in a frame (`nomark = 0`). To hide the frame, set the value: `nomark = 1`. |
| `title` | RSS feed header. |
| `time` | The parameter for displaying an entry's publication date. To hide the date, set the value: `time = 0`. |
| `dateformat` | Date display format ([strftime](https://docs.python.org/2/library/datetime.html#strftime-strptime-behavior) method). |
| `today` | To display the `today` flag next to the entries published today, set the value: `today = 1`. You'll see the flag if `time = 1`. |

