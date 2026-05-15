{% note info %}

Upon loading, the widget adjusts its container height to `100px`, which may cause an unwanted layout shift. To avoid the layout shift, set the container height to `100px` prior to the widget being loaded.

```html
<div ... style="height: 100px"></div>
```

{% endnote %}