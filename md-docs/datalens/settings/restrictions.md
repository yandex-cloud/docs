[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > [Настройки сервиса](index.md) > Безопасность

# Настройки безопасности в Yandex DataLens

Настройки безопасности позволяют накладывать ограничения на использование некоторых возможностей сервиса на уровне экземпляра DataLens:

* [Нейроаналитик](../concepts/neuroanalyst.md#prohibit#prohibit) —  ограничение использования Нейроаналитика.
* [Возможность публикации](../concepts/datalens-public.md#publication-disable) — запрет на публикацию чартов и дашбордов.
* [Экспорт воркбуков](../workbooks-collections/export-and-import.md#workbooks-export-disable) — запрет на экспорт воркбуков в виде файла.
* [Экспорт данных](../concepts/chart/data-export.md#data-export-disable) — ограничение возможности скачивать данные из чартов в виде файлов.

Доступ к настройкам безопасности есть только у [администратора](../security/roles.md#datalens-admin) экземпляра DataLens (пользователь с ролью `datalens.admin`).

Чтобы перейти к настройкам безопасности:

1. На панели слева выберите ![image](../../_assets/console-icons/sliders.svg) **Настройки сервиса**. Если на панели не отображается ![image](../../_assets/console-icons/sliders.svg), сначала выберите ![image](../../_assets/console-icons/ellipsis.svg) **Ещё**, а затем — ![image](../../_assets/console-icons/sliders.svg) **Настройки сервиса**.
1. Выберите вкладку **Безопасность**.

   ![image](../../_assets/datalens/settings/restrictions.png)