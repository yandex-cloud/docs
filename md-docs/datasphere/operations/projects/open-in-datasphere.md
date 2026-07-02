[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Пошаговые инструкции](../index.md) > Совместный доступ > Открыть ноутбук в DataSphere

# Открыть ноутбук в DataSphere

Вы можете опубликовать исходный файл ноутбука JupyterLab на своем сайте и предоставить пользователям возможность запустить его в DataSphere. При переходе по ссылке пользователю нужно будет пройти авторизацию в Yandex Cloud и выбрать проект.

## Открыть ноутбук {#open-notebook}

Чтобы открыть ноутбук в DataSphere:

1. Подставьте ссылку на исходный файл ноутбука к общей части ссылки. Файл должен быть доступен публично, без ограничений.

    ```text
    https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>
    ```

    Например:

    ```text
    https://datasphere.yandex.cloud/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb
    ```

1. Перейдите по ссылке и нажмите **Запустить в Yandex DataSphere**.

1. В открывшемся окне выберите нужный проект и нажмите **Добавить**.

Копия ноутбука появится в хранилище проекта.

## Примеры кода для вставки на сайт {#code-to-insert}

#|
|| **Виджет** | **Код для вставки** ||
|| [Открыть в DataSphere](https://datasphere.yandex.cloud/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-datasphere-batch-execution/main/src/train_classifier.ipynb) |

```html
<a href="https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>">
Открыть в DataSphere
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-ru.svg) |

```html
<a href="https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_ru.svg"
  alt="Открыть в DataSphere"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-blue-en.svg) |

```html
<a href="https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v1_en.svg"
  alt="Open in DataSphere"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-white-ru.svg) |

```html
<a href="https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg"
  alt="Открыть в DataSphere"/>
</a>

```
||
|| ![Run](../../../_assets/datasphere/open-white-en.svg) |

```html
<a href="https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_en.svg"
  alt="Open in DataSphere"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-ru.svg) |

```html
<a href="https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_ru.svg"
  alt="Открыть в DataSphere"/>
</a>
```
||
|| ![Run](../../../_assets/datasphere/open-black-en.svg) |

```html
<a href="https://datasphere.yandex.cloud/import-ipynb?path=<ссылка_на_исходный_файл>">
  <img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v3_en.svg"
  alt="Open in DataSphere"/>
</a>
```
||
|#