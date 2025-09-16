# Пакетная обработка данных

## Модели генерации текста {#text-batch}

#|
|| **Модель** | **URI** | **Контекст** ||
|| **Qwen 2.5 7B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-7B-Instruct)
Лицензия [Apache 2.0]({{ license-apache }})  | `gpt://<идентификатор_каталога>/qwen2.5-7b-instruct` | 32 768 ||
|| **Qwen 2.5 72B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct)
[Лицензия Qwen](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct/blob/main/LICENSE)  | `gpt://<идентификатор_каталога>/qwen2.5-72b-instruct` | 16 384 ||
|| **QwQ 32B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/QwQ-32B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwq-32b` | 32 768 ||
|| **Llama 3.3 70B Instruct**^2^ 
[Карточка модели](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct)
[Лицензия Llama 3.3](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<идентификатор_каталога>/llama3.3-70b-instruct` | 8 192 ||
|| **Llama 3.1 70B Instruct**^2^
[Карточка модели](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct)
[Лицензия Llama 3.1](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct/blob/main/LICENSE)  | `gpt://<идентификатор_каталога>/llama3.1-70b-instruct` | 8 192 ||
|| **DeepSeek-R1 Distill Llama 70B** 
[Карточка модели](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-70B)
Лицензия [MIT]({{ license-mit }})
Основана на модели Llama-3.3-70B-Instruct. [Условия использования Llama-3.3-70B-Instruct](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<идентификатор_каталога>/deepseek-r1-distill-llama-70b` | 8 192 ||
|| **Qwen2.5 32B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-32B-Instruct)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2.5-32b-instruct` | 32 768 ||
|| **DeepSeek-R1 Distill Qwen 32B** 
[Карточка модели](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)
Лицензия [MIT]({{ license-mit }}) | `gpt://<идентификатор_каталога>/deepseek-r1-distill-qwen-32b` | 32 768 ||
|| **phi-4** 
[Карточка модели](https://huggingface.co/microsoft/phi-4)
Лицензия [MIT]({{ license-mit }})  | `gpt://<идентификатор_каталога>/phi-4` | 16 384 ||
|| **Gemma 3 1B it**
[Карточка модели](https://huggingface.co/google/gemma-3-1b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-1b-it` | 32 768 ||
|| **Gemma 3 4B it**
[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-4b-it` | 131 072 ||
|| **Gemma 3 12B it**
[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-12b-it` | 65 536 ||
|| **Gemma 3 27B it**
[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-27b-it` | 32 768 ||
|| **Qwen3 0.6B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-0.6B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-0.6b` | 32 768 ||
|| **Qwen3 1.7B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-1.7B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-1.7b` | 32 768 ||
|| **Qwen3 4B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-4B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-4b` | 32 768 ||
|| **Qwen3 8B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-8B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-8b` | 32 768 ||
|| **Qwen3 14B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-14B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-14b` | 32 768 ||
|| **Qwen3 32B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-32B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-32b` | 32 768 ||
|| **Qwen3 30B A3B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-30B-A3B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-30b-a3b` | 32 768 ||
|| **Qwen3 235B A22B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-235B-A22B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-235b-a22b` | 32 768 ||
|#

^2^ {{ meta-disclaimer }}

## Мультимодальные модели {#multimodels-batch}

#|
|| **Модель** | **URI** | **Контекст** ||
|| **Qwen2 VL 7B**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2-vl-7b-instruct/` | 4 096 ||
|| **Qwen2.5 VL 7B**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-VL-7B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }})  | `gpt://<идентификатор_каталога>/qwen2.5-vl-7b-instruct/` | 4 096 ||
|| **Qwen 2.5 VL 32B Instruct**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-VL-32B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2.5-vl-32b-instruct/` | 4 096 ||
|| **DeepSeek VL2**</br>[Карточка модели](https://huggingface.co/deepseek-ai/deepseek-vl2)</br>[Лицензия DeepSeek](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<идентификатор_каталога>/deepseek-vl2/` | 4096 ||
|| **DeepSeek VL2 Tiny**</br>[Карточка модели](https://huggingface.co/deepseek-ai/deepseek-vl2-tiny)</br>[Лицензия DeepSeek](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<идентификатор_каталога>/deepseek-vl2-tiny/` | 4096 ||
|| **Gemma 3 4B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-4b-it/` | 4 096 ||
|| **Gemma 3 12B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-12b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-12b-it/` | 4 096 ||
|| **Gemma 3 27B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-27b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-27b-it/` | 4 096 ||
|# 

## Примеры использования {#usage-examples}

[{#T}](../../operations/batch/create.md)