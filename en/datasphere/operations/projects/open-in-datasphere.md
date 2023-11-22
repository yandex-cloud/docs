# Opening a notebook in {{ ml-platform-name }}

You can publish your {{jlab}}Lab notebook's source file on your website and authorize users to run it in {{ ml-platform-name }}. After using a link, the user will need to log in to {{ yandex-cloud }} and select a project.

## Opening a notebook {#open-notebook}

To open a notebook in {{ ml-platform-name }}:

1. Substitute a link to the notebook source file in the common part of the link. The file must be publicly available without any restrictions.

   ```text
   {{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>
   ```

   For example:

   ```text
   {{ link-datasphere-main }}import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb
   ```

1. Follow the link and click **{{ ui-key.yc-ui-datasphere.import-ipynb.open-in-dataSphere }}**.

1. In the window that opens, select a project and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

This adds a notebook copy to the project storage.

## Examples of embed code for website {#code-to-insert}

#|
|| **Widget** | **Embed code** ||
|| [Open in {{ ml-platform-name }}]({{ link-datasphere-main }}import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb) |

```html
<a href="{{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>">
Open in {{ ml-platform-name }}
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-ru.svg) |

```html
<a href="{{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_ru.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-en.svg) |

```html
<a href="{{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-white-ru.svg) |

```html
<a href="{{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>

```
||
|| ![Run](../../../_assets/datasphere/open-white-en.svg) |

```html
<a href="{{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-ru.svg) |

```html
<a href="{{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_ru.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-en.svg) |

```html
<a href="{{ link-datasphere-main }}import-ipynb?path=<link_to_source_file>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|#