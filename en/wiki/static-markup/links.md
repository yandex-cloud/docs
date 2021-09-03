# Links

Use the following markup to format your links:

```
[link text](URL)
```

For example:

| Markup | Result |
| --- | --- |
| `[Yandex]({{ link-yandex }})` | [Yandex]({{ link-yandex }}) |

If you paste an address with no markup, it will be converted into a hyperlink anyway:

| Markup | Result |
| --- | --- |
| `{{ link-yandex }}` | [{{ link-yandex }}]({{ link-yandex }}) |

## Links to Wiki pages {#wiki-ref}

If you want to link to a Wiki page, you can use that page's relative address instead of the full page or cluster address.

### Links to pages {#page-link}

- Specify the address in relation to the {{ wiki-name }} home page. Add the `/` symbol before the address.

    | Link destination | Markup |
    | --- | --- |
    | `{{ wiki-host-name }}/users/{{ username-oleg }}/notes` | `[{{ oleg-notes-title }}](/users/{{ username-oleg }}/notes)` |

- The address of the page with the link must be specified relative to that page's parent page. Do not add a `/` symbol before the address.

    | Page addresses | Markup |
    | --- | --- |
    | Links from: `{{ wiki-host-name }}/users/{{ username-oleg }}/newpage`<br/><br/>Links to: `{{ wiki-host-name }}/users/{{ username-oleg }}/notes` | `[{{ oleg-notes-title }}](notes)` |
    | Links from: `{{ wiki-host-name }}/users/{{ username-oleg }}/notes/note1`<br/><br/>Links to: `{{ wiki-host-name }}/users/{{ username-oleg }}/newpage` | `[New page](../newpage)` |

### Links to clusters {#section-link}

Each page title automatically gets its own *anchor*, which is the cluster ID. Anchors are used as direct links to the page's sections.

Anchors are based on section headings. For example, to the cluster `My cluster`, the anchor `not_var{{ example-anchor }}` will be assigned.

To add a link to a cluster, enter the page address followed by the `#` symbol and the anchor:

```
[link text](/page url/#not_var{{ example-anchor }})
```

To view the anchor value for a section:

1. Hover over the section title and click **§**, which will appear to the right of the title.

1. Copy the cluster address from the browser's address bar.

The anchor is shown after the `#` symbol at the end of the address.

### Link to any place on the page {#place-link}

If you want to link to a specific place on a page, you can always create an anchor ID wherever you need. To set an anchor, use the [`not_var{{anchor}}`](../actions/objects.md#anchor) dynamic block:

```
{{anchor name="my-anchor"}}
```

To add an anchor link, enter the page address followed by the `#` symbol and then add the anchor at the end:

```
[link text](http://page-address/#my-anchor)
```

## Links to images {#ref-to-image}

If you paste an image link with no markup, the image itself will be displayed on the page.

To add a link to an image, use the usual link markup:

```
[link text](image URL)
```

| Markup | Result |
| --- | --- |
| `[Yandex Logo]({{ yandex-logo-link }})` | [Yandex logo]({{ yandex-logo-link }}) |

## Make an image a link {#image-as-ref}

Images can also function as links so that when you click on the image, a page or file opens. To do this, in the link markup element, instead of text, [insert an image](files.md#add-image):

```
[![Alternative text](image address)](link address)
```

| Markup | Result |
| --- | --- |
| `[![Logo]({{ yandex-logo-link }})]({{ link-yandex }})` | [![Logo](../../_assets/wiki/logo95x37x8.png)]({{ link-yandex }}) |

## Links to email addresses {#mail-ref}

To add a link to an email address:

- Enclose the email address in angle brackets `< >`.

- Use the usual link markup and add `mailto:` before the email address.

  `[link text](mailto:postal address)`

| Markup | Result |
| --- | --- |
| `<mail@example.com>` | ![](../../_assets/wiki/mail-ref-notitle.png) |
| `{{ example-link-mail }}` | ![](../../_assets/wiki/mail-ref.png) |

## Footnotes {#footnotes}

Footnotes are notes that are usually placed at the bottom of the page. To add a footnote to your page:

1. Add double brackets, an <q>asterisk</q>, and a footnote symbol after the words covered by the footnote. You can use numbers and other sequential symbols as your asterisk symbols. You can also simply use <q>asterisks</q>.

1. Add double square brackets, the `#` symbol, and the footnote sign before the footnote text.

For example:

```
Text with unordered[[*]] footnotes[[**]].

TText with ordered[[*1]] footnotes[[*2]].

[[#*]] Footnote definition.
[[#**]] Footnote definition.
[[#1]] Footnote definition.
[[#2]] Footnote definition.
```

{% cut "See the result" %}

![](../../_assets/wiki/footnotes.png)

{% endcut %}

