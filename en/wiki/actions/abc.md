# Information about the ABC team

The `serviceteam` block shows the service team members. The block can automatically identify a service from the Wiki page URL and data from the [catalog of Yandex services](https://abc.yandex-team.ru/). If an ABC service card contains a link to the page with the `serviceteam` block, the service team info will be displayed in the block.

## Using the block {#serviceteam-call}

```
{{serviceteam id=287}}
```

## Block parameters {#serviceteam-params}

| Parameter | Description |
--- | ---
| `id` | Service numeric ID. For example: {{wiki-name}} = 287. |
| `slug` | Service text ID. For example, in a link to {{wiki-name}} `slug` = `_wiki_`: <br>https://abc.yandex-team.ru/services/\_wiki_/. |
| `contacts` | Service contact info. |