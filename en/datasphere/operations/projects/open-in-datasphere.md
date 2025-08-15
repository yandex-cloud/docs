# Opening a notebook in {{ ml-platform-name }}

You can publish the {{ jlab }}Lab notebook's source file on your website and enable users to run it in {{ ml-platform-name }}. After clicking the link, users will be prompted to sign in to {{ yandex-cloud }} and select a project.

## Opening a notebook {#open-notebook}

To open a notebook in {{ ml-platform-name }}:

1. Replace the placeholder in the provided link with the URL of your notebook's source file. Make sure the file is publicly accessible without any restrictions.

    ```text
    {{ link-datasphere-main }}/import-ipynb?path=<source_file_link>
    ```

    Here is an example:

    ```text
    {{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb
    ```

1. Follow the link and click **{{ ui-key.yc-ui-datasphere.import-ipynb.open-in-dataSphere }}**.

1. In the window that opens, select the project and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

This will add a notebook copy to the project storage.

## Code snippets to embed on your website {#code-to-insert}

#|
|| **Widget** | **Embed code** ||
|| [Open in {{ ml-platform-name }}]({{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<source_file_link>">
Open in {{ ml-platform-name }}
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-ru.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<source_file_link>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_ru.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-en.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<source_file_link>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-white-ru.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<source_file_link>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>

```
||
|| ![Run](../../../_assets/datasphere/open-white-en.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<source_file_link>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-ru.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<source_file_link>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_ru.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-en.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<source_file_link>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|#
