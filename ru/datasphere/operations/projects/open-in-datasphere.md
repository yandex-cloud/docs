# Открыть ноутбук в {{ ml-platform-name }}

Вы можете опубликовать исходный файл ноутбука {{ jlab }}Lab на своем сайте и предоставить пользователям возможность запустить его в {{ ml-platform-name }}. При переходе по ссылке пользователю нужно будет пройти авторизацию в {{ yandex-cloud }} и выбрать проект.

## Открыть ноутбук {#open-notebook}

Чтобы открыть ноутбук в {{ ml-platform-name }}:

1. Подставьте ссылку на исходный файл ноутбука к общей части ссылки. Файл должен быть доступен публично, без ограничений.

    ```text
    {{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>
    ```

    Например:

    ```text
    {{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb
    ```

1. Перейдите по ссылке и нажмите **{{ ui-key.yc-ui-datasphere.import-ipynb.open-in-dataSphere }}**.

1. В открывшемся окне выберите нужный проект и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

Копия ноутбука появится в хранилище проекта.

## Примеры кода для вставки на сайт {#code-to-insert}

#|
|| **Виджет** | **Код для вставки** ||
|| [Открыть в {{ ml-platform-name }}]({{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>">
Открыть в {{ ml-platform-name }}
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-ru.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_ru.svg"
  alt="Открыть в {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-en.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-white-ru.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg"
  alt="Открыть в {{ ml-platform-name }}"/>
</a>

```
||
|| ![Run](../../../_assets/datasphere/open-white-en.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-ru.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_ru.svg"
  alt="Открыть в {{ ml-platform-name }}"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-en.svg) |

```html
<a href="{{ link-datasphere-main }}/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_en.svg"
  alt="Open in {{ ml-platform-name }}"/>
</a>
```
||
|#
