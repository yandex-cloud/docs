# Information about an ABC service team

In the `serviceteam` block, you can see members of the team that is developing the service. Based on the Wiki page URL and data in the [Yandex services catalog](https://abc.yandex-team.ru/), this block automatically determines the service name. If the ABC service card includes a link to a page with the `serviceteam` block, this block will display information about this service's team.

## Using a block {#serviceteam-call}

```
{{serviceteam id=287}} 
```

## Block parameters {#serviceteam-params}

| Parameter | Description |
| --- | --- |
| `id` | Numeric ID of the service. For example: {{wiki-name}} = 287. |
| `slug` | The text ID of the service. For example, in the link to the {{wiki-name}} service, `slug` = `_wiki_`: <br>https://abc.yandex-team.ru/services/\_wiki_/. |
| `contacts` | Contacts for the service. |

