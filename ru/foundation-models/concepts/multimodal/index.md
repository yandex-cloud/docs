# Мультимодальные модели

{{ foundation-models-name }} предоставляет доступ к большим визуально-текстовым моделям, которые позволяют генерировать тексты по текстовому промту и изображению. 

## Модели, доступные в синхронном режиме {#generation}

#|
|| **Модель и URI** | **Контекст** | **[Режимы работы](../index.md#working-mode)** ||
|| **Gemma 3 27B**
`gpt://<идентификатор_каталога>/gemma-3-27b-it/latest` | 128 000 | Только [{{ openai }} API](../openai-compatibility.md) ||
|#

Модель Gemma 3 27B работает с изображениями в кодировке Base64. Модель может обрабатывать изображения с любым соотношением сторон благодаря адаптивному алгоритму, который масштабирует изображения до 896 пикселей по большей стороне, сохраняя важные визуальные детали. Каждое изображение использует 256 [токенов](../yandexgpt/tokens.md) контекста.

## Модели, доступные в пакетном режими {#batch}

Для доступа к модели используйте стандартный URI модели: `gpt://<идентификатор_каталога>/<название_модели>/<ветка>`.

| **Модель** | **URI** | **Контекст** |
|---|---|---|
| **Qwen2 VL 7B**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2-vl-7b-instruct/` | 4096 |
| **Qwen2.5 VL 7B**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-VL-7B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }})  | `gpt://<идентификатор_каталога>/qwen2.5-vl-7b-instruct/` | 4096 |
| **Qwen 2.5 VL 32B Instruct**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-VL-32B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2.5-vl-32b-instruct/` | 4096 |
| **DeepSeek VL2**</br>[Карточка модели](https://huggingface.co/deepseek-ai/deepseek-vl2)</br>[Лицензия DeepSeek](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<идентификатор_каталога>/deepseek-vl2/` | 4096 |
| **DeepSeek VL2 Tiny**</br>[Карточка модели](https://huggingface.co/deepseek-ai/deepseek-vl2-tiny)</br>[Лицензия DeepSeek](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<идентификатор_каталога>/deepseek-vl2-tiny/` | 4096 |
| **Gemma3 4B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-4b-it/` | 4096 |
| **Gemma3 12B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-12b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-12b-it/` | 4096 |
| **Gemma3 27B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-27b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-27b-it/` | 4096 |
