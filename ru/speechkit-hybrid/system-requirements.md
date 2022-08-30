# Системные требования

{% include [system-requirements](../_includes/speechkit/system-requirements.md) %}

{% include [system-requirements](../_includes/speechkit/system-requirements-gpu.md) %}

## Программные требования {#software}

Выделенный для работы {{ sk-hybrid-name }} сервер должен поддерживать запуск контейнеров на базе CUDA® 11.4 и выше и иметь соответствующие драйвера NVIDIA. Подробнее о требованиях CUDA Toolkit см. в [официальной документации NVIDIA](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html).

Для установки и настройки сервисов {{ sk-hybrid-name }} понадобятся интерфейс командной строки {{ yandex-cloud }} и реестр в {{ container-registry-full-name }}.

1. {% include [cli-install](../_includes/cli-install.md) %}

1. [Создайте реестр](../iot-core/operations/registry/registry-create.md) в {{ container-registry-full-name }}. 
   
   {% include [default-catalogue](../_includes/default-catalogue.md) %}
   
   ```bash
   yc container registry create --name speechkit-hybrid
   ```
   
   Результат:
   ```text
   id: crpc9qeoft236r8tfalm
   folder_id: b1g0itj57rbjk9thrinv
   name: speechkit-hybrid
   status: ACTIVE
   created_at: "2021-08-25T12:24:56.286Z"
   ```
   
1. Сообщите `id` созданного реестра команде {{ speechkit-name }}. В вашем реестре появятся все необходимые контейнеры, и вам предоставят `docker-compose.yaml`.
