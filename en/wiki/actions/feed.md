# RSS news feed

Use the `feed` block to embed RSS feed entries from [Atushka](https://my.at.yandex-team.ru/) or external sources in a Wiki page.

## Using the block {#feed-call}

Show posts from Atushka:
```
{{feed url="http://my.at.yandex-team.ru/rss/popular.xml" notitlelink=1 max=5 nomark=1 time=1 dateformat="d.m H:M" today=1}}
```

Show posts from an external website:
```
{{feed url="http://rss.newsru.com/top/big/" nodesc="1" max=3 nomark=1 time=1 dateformat="d.m"}} 
```

## Block parameters {#feed-params}

| Parameter | Description |
--- | ---
| `url` | RSS feed address. |
| `notitlelink` | Don't make the title of an RSS feed element a link. |
| `max`\|`limit` | Maximum number of entries per RSS feed. |
| `nomark` | By default, the RSS feed is displayed in a border (`nomark = 0`). To hide the border, set `nomark = 1`. |
| `title` | RSS feed heading. |
| `time` | Parameter for displaying the date of a post. To hide the date, set `time = 0`. |
| `dateformat` | Date format ([strftime](https://docs.python.org/2/library/datetime.html#strftime-strptime-behavior) method). |
| `today` | Set `today = 1` to have the `today` flag displayed next to the posts published during the day. The flag is on if `time = 1`. |