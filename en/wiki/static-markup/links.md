# Links

Use the following markup to format your links:

```
[link text](URL)
```

Example:

| Markup | Result |
| --- | --- |
| `[Yandex]({{ link-yandex }})` | [Yandex]({{ link-yandex }}) |

If you paste a URL with no markup, it will be converted into a hyperlink anyway.

| Markup | Result |
| --- | --- |
| `{{ link-yandex }}` | [{{ link-yandex }}]({{ link-yandex }}) |

## Links to Wiki pages {#wiki-ref}

If you want insert a link to a Wiki page, you can use the page's relative address instead of the full page or cluster address.

### Link to page {#page-link}

- Specify the address in relation to the main {{ wiki-name }} page. Add the `/` symbol before the address.

    | Link destination | Markup |
    | --- | --- |
    | `{{ wiki-host-name }}/users/{{ username-oleg }}/notes` | `[{{ oleg-notes-title }}](/users/{{ username-oleg }}/notes)` |

- The address of the page with the link must be specified relative to that page's parent page. Do not add the `/` symbol before the address.

    | Page addresses | Markup |
    | --- | --- |
    | Link source: `{{ wiki-host-name }}/users/{{ username-oleg }}/newpage`<br/><br/>Link destination: `{{ wiki-host-name }}/users/{{ username-oleg }}/notes` | `[{{ oleg-notes-title }}](notes)` |
    | Link source: `{{ wiki-host-name }}/users/{{ username-oleg }}/notes/note1`<br/><br/>Link destination: `{{ wiki-host-name }}/users/{{ username-oleg }}/newpage` | `[New page](../newpage)` |

### Links to clusters {#section-link}

Every heading on a page has an auto-generated *anchor*, which is the cluster ID. Anchors are used as direct links to the page clusters.

Anchors are based on cluster headings. For example, `My cluster` will have the anchor `{{ example-anchor }}`.

To add a link to a cluster, enter the page address followed by the `#` symbol and the anchor:

```
[link text](/page address/#{{ example-anchor }})
```

To view the anchor value for a section:

1. Hover your cursor over the section heading and click the **§** symbol, which will appear to the right of the heading.

1. Copy the cluster address from the browser's address bar.

The anchor is shown after the `#` symbol at the end of the address.

### Linking to a specific spot on the page {#place-link}

If you want to link to a specific place on a page, you can always create an anchor ID wherever you need. To set an anchor, use the [not_var{{anchor}}](../actions/anchor.md) dynamic block:

```
{{anchor name="my-anchor"}}
```

To add an anchor link, enter the page address followed by the `#` symbol and add the anchor at the end:

```
[link text](http://page-address/#my-anchor)
```

## Links to images {#ref-to-image}

If you paste an image link with no markup, the image itself will be displayed on the page.

To add a link to an image, use the markup for links:

```
[link text](image URL)
```

| Markup | Result |
| --- | --- |
| `[Yandex Logo]({{ yandex-logo-link }})` | [Yandex logo]({{ yandex-logo-link }}) |

## Creating a link from an image {#image-as-ref}

You can create a link from an image, so that clicking an image opens a page or document. To do this, [embed an image](files.md#add-image) to the link's markup element instead of text:

```
[![Alternative text](image address)](link address)
```

| Markup | Result |
| --- | --- |
| `[![Logo]({{ yandex-logo-link }})]({{ link-yandex }})` | [![Logo](../../_assets/wiki/logo95x37x8.png)]({{ link-yandex }}) |

## Links to email addresses {#mail-ref}

To add a link to an email address:

- Enclose the email address in angle brackets `< >`.

- Use the common link markup and add `mailto:` before the email address.

`[link text](mailto:email-address)`

| Markup | Result |
| --- | --- |
| `<mail@example.com>` | ![](../../_assets/wiki/mail-ref-notitle.png) |
| `{{ example-link-mail }}` | ![](../../_assets/wiki/mail-ref.png) |

## Footnotes {#footnotes}

Footnotes are notes that are usually placed at the bottom of the page. To add a footnote to your page:

1. Add double brackets, <q>an asterisk</q>, and a footnote symbol after the words referenced by the footnote. You can use numbers or other symbols as your footnote sign. Otherwise, you can just use <q>asterisks</q>.

1. Add double square brackets, the `#` symbol, and the footnote sign before the footnote text.

Example:

```
Text, then the first footnote[[*]] and the second footnote [[**]].

Text, then the first numbered footnote[[*1]] and the second footnote [[*2]].

[[#*]] Footnote definition.
[[#**]] Footnote definition.
[[#1]] Footnote definition.
[[#2]] Footnote definition.
```

{% cut "See the result" %}

![](../../_assets/wiki/footnotes.png)

{% endcut %}

