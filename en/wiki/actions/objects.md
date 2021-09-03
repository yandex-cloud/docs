# Embedding objects

## Table of contents {#toc}

Automatically creates a table of contents from page headings.

{% note alert %}

If the page has multiple identical headings, the links in the table of contents may not work correctly.

{% endnote %}

### Using a block {#toc-call}

```
{{toc from="h2" to="h6"}}
```

`not_var{{toc}}` block parameters.

### Block parameters (optional) {#toc-params}

| Parameter | Description |
| --- | --- |
| `from` | Highest heading level to include in the table of contents |
| `to` | Lowest heading level to include in the table of contents |

## List of issues {#section_task_list}

This block contains a list of Tracker issues that are part of the same queue or match a specific filter.

### Using a block {#task-call}

```
{{tasks url="filter or queue address"}}
```

There are no additional parameters for the `not_var{{tasks}}` block.

Read more about the task lists in the [{{ tracker-name }} documentation](../../tracker/manager/quick-filters.md#section_uy5_hds_3bb).

## Anchor {#anchor}

This block contains an *anchor*, which is used for navigating directly to this specific part of the page.

### Using a block {#anchor-call}

```
{{Anchor href="anchor"}}
```

### Block Parameters {#anchor-params}

| Parameter | Description | Required |
| --- | --- | --- |
| `href` | Contains the anchor name | Required |
| `title` | Contains the anchor header | Optional |
| `text` | Contains the anchor text | Optional |

To insert an anchor link, add the `#` symbol to the right of the page address and place the anchor name after it:

```
[Link text](http://pageaddress#Anchor)
```

You don't have to specify the page address if the link and the anchor are on the same page:

```
[Link text](#Anchor)
```

## Page or video {#iframe-video}

The `iframe` block allows you to insert any other page or videos from external sources, such as YouTube, Vimeo, Coub, into the page.

### Using a block {#iframe-call}

```
{{iframe src="http://pageAddress" width=700px height=600px frameborder=0 scrolling=no}}
```

### Block Parameters {#iframe-params}

| Parameter | Description |
| --- | --- |
| `src` | Required parameter. Contains the address of the object |
| `width` | Indicates the width of the frame in pixels or as a percentage of the page width |
| `height` | Indicates the height of the frame in pixels |
| `frameborder` | Indicates the presence or absence of a frame border |
| `scrolling` | Indicates the presence of scrollbars for the window's frame |
| `allowfullscreen` | Allows full-screen mode for the frame. Always is set to `true` |

### Subdomains allowed {#video-domain}

The `src` parameter can contain addresses that belong to domains:

- `vimeo.com`

- `yandex.ru`

- `yandex.ua`

- `yandex.kz`

- `yandex.by`

- `youtube.com`

- `youtube-nocookie.com`

- `player.vimeo.com`

- `player.vimple.ru`

- `vkontakte.ru`

- `vk.com`

- `coub.com`

