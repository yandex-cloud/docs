{% note info %}

During the upload, the widget changes the height of its host container to `100px`. This might result in an undesirable layout shift on the page due to the height change. To avoid this shift, set the `100px` container height before the widget is loaded.

```html
<div ... style="height: 100px"></div>
```

{% endnote %}