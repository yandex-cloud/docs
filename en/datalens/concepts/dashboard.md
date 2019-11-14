# Dashboards

_Dashboards_ are pages or sets of pages that contain widgets. They let you group charts in one place and add explanatory text and titles.

New dashboard pages can be created using the _tab_ element.

## Widgets {#widget}

_Widgets_ are dashboard elements. You can create links between selector and chart widgets.

{{ datalens-full-name }} offers the following types of widgets:

- [Chart](#chart)
- [Selector](#selector)
- [Text](#text)
- [Title](#title)

### Charts {#chart}

Visualization as a table or chart.
You can place charts anywhere on a dashboard and change their size.
Charts can be linked to selectors.

For more information about charts, see [{#T}](chart.md).

### Selector {#selector}

A widget for managing one or more charts. Works within a single dashboard tab.

For more information, see [{#T}](#link).

### Text {#text}

A widget represented as text. It lets you place things like a set of links or explanatory captions on a dashboard. The [Markdown markup language](https://ru.wikipedia.org/wiki/Markdown) is supported.

### Title {#title}

A widget represented as a heading. It lets you differentiate charts by meaning and divide them into groups within a single dashboard page.

## Link {#link}

A link determines how a selector affects one or more charts. By default, selectors affect charts created within a single dataset. Selectors and charts based on different datasets can also be linked manually.

You can choose a dataset field as the link or create your own field where you manually set the selector values.

## Access management {#access-management}

You can configure dashboard permissions. For more information, see [{#T}](../security/index.md).

