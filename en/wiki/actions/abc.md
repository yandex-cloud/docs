# Information about the ABC service team

The `serviceteam` block displays members of the team in charge of a service. This block can automatically identify services based on the Wiki page address and information from the [Yandex service catalog](https://abc.yandex-team.ru/). If an ABC service card includes a link to a page with the `serviceteam` block, that block will display information about the team in charge of the service.

## Calling the block {#serviceteam-call}

```
{{serviceteam id=287}} 
```

## Block parameters {#serviceteam-params}

| Parameter | Description |
| --- | --- |
| `id` | Service ID (number). For example, {{wiki-name}} = 287. |
| `slug` | Service ID (text). For example, in the link to the service {{wiki-name}} `slug` = `_wiki_`: <br>https://abc.yandex-team.ru/services/\_wiki_/. |
| `contacts` | Service contact information. |

