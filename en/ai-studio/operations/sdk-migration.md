# Migrating from Yandex Cloud ML SDK to {{ ml-sdk-full-name }}

In the recent [release](../release-notes/index.md#270126), {{ yandex-cloud }} ML SDK was renamed to {{ ml-sdk-full-name }}. To continue using all the library's features, migrate to {{ ml-sdk-name }}.

Version control policy:

* `yandex-cloud-ml-sdk 0.18`: Last actual ML SDK version in PyPI.
* `yandex-cloud-ml-sdk 0.19.0`: Shell redirecting requests to `yandex-ai-studio-sdk`.
* `yandex-ai-studio-sdk 0.19.0`: {{ ml-sdk-name }} first version.

To migrate to {{ ml-sdk-name }}:

1. Update the library:

   ```bash
   pip install --upgrade yandex-cloud-ml-sdk
   ```

1. Update the package and class names by running the following commands in your project directory:

   ```bash
   grep -rl 'YCloudML' . | xargs sed -i 's/YCloudML/AIStudio/g'
   grep -rl 'yandex-cloud-ml-sdk' . | xargs sed -i 's/yandex-cloud-ml-sdk/yandex-ai-studio-sdk/g'
   grep -rl 'yandex_cloud_ml_sdk' . | xargs sed -i 's/yandex_cloud_ml_sdk/yandex_ai_studio_sdk/g'
   ```