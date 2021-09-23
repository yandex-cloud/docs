# Системные требования 

Для установки {{ sk-hybrid-name }} вам необходим сервер с ОС Linux, который поддерживает Docker Engine. Список поддерживаемых ОС см. в [официальной документации Docker](https://docs.docker.com/engine/install/#server).

{% note warning %}

Процессор должен поддерживать набор инструкций [AVX2]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/AVX){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Advanced_Vector_Extensions#CPUs_with_AVX2){% endif %} (Advanced Vector Support). 

{% endnote %}

В Linux вы можете проверить, поддерживает ли ваш хост AVX2, командой:
```bash
grep -q avx2 /proc/cpuinfo && echo AVX2 || echo No AVX2
```

## Конфигурация сервера {#hardware}

Рекомендуемые системные требования для запуска контейнеров {{sk-hybrid-name }}:

{% list tabs %}

- Контейнеры с CPU

   | Контейнер | CPU | RAM | HDD |
   |---|---|---|---|
   | Распознавание речи (40 каналов) | 2 процессора [Intel Gold 6230R](https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) | 128 ГБ | 300 ГБ |
   | Синтез речи (10–16 SPS^1^) | 1 процессор Intel Gold 6230R | 64 ГБ | 300 ГБ |

- Контейнеры с GPU

   | Контейнер | CPU | GPU | RAM | HDD |
   |---|---|---|---|---|
   | Распознавание речи (80–100 каналов) | 1 процессор [Intel Gold 6230R](https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) | Nvidia Tesla V100 (16 ГБ или 32 ГБ) | 128 ГБ | 300 ГБ |
   | Синтез речи (200 SPS^1^) | 1 процессор Intel Gold 6230R | Nvidia Tesla V100 (16 ГБ или 32 ГБ) | 128 ГБ | 300 ГБ |

{% endtab %}

^1^ Seconds per second (SPS) — количество секунд синтезированного текста, которое генерируется за секунду работы.

## Перед началом работы {#software}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md) в {{ container-registry-full-name }}. 
   
   {% include [default-catalogue](../../_includes/default-catalogue.md) %}
   
   ```
   yc container registry create --name speechkit-hybrid
   ```
   
   ```
   id: crpc9qeoft236r8tfalm
   folder_id: b1g0itj57rbjk9thrinv
   name: speechkit-hybrid
   status: ACTIVE
   created_at: "2021-08-25T12:24:56.286Z"
   ```
   
1. Сообщите `id` созданного реестра команде SpeechKit. В вашем реестре появятся все необходимые контейнеры, и вам предоставят `docker-compose.yaml`.
