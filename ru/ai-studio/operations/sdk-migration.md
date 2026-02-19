# Перейти с Yandex Cloud ML SDK на {{ ml-sdk-full-name }}

В недавнем [релизе](../release-notes/index.md#270126) {{ yandex-cloud }} ML SDK был переименован в {{ ml-sdk-full-name }}. Чтобы продолжать пользоваться всеми функциями библиотеки, перейдите на {{ ml-sdk-name }}.

Политика управления версиями:

* `yandex-cloud-ml-sdk 0.18` — последняя настоящая версия ML SDK в PyPI;
* `yandex-cloud-ml-sdk 0.19.0` — оболочка, которая перенаправляет запросы на `yandex-ai-studio-sdk`;
* `yandex-ai-studio-sdk 0.19.0` — первая версия {{ ml-sdk-name }}.

Чтобы перейти на {{ ml-sdk-name }}:

1. Обновите библиотеку:

   ```bash
   pip install --upgrade yandex-cloud-ml-sdk
   ```

1. Измените названия пакетов и классов, выполнив команды в директории вашего проекта:

   ```bash
   grep -rl 'YCloudML' . | xargs sed -i 's/YCloudML/AIStudio/g'
   grep -rl 'yandex-cloud-ml-sdk' . | xargs sed -i 's/yandex-cloud-ml-sdk/yandex-ai-studio-sdk/g'
   grep -rl 'yandex_cloud_ml_sdk' . | xargs sed -i 's/yandex_cloud_ml_sdk/yandex_ai_studio_sdk/g'
   ```