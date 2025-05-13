# Multimodal models

{{ foundation-models-name }} provides access to large vision language models that allow you to generate texts from a text prompt and image. These models are available in batch mode.

To access a model, use the standard model URI: `gpt://<folder_ID>/<model_name>/<branch>`.

| **Model** | **URI** | **Context** |
|---|---|---|
| **Qwen2 VL 7B**</br>[Model card](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2-vl-7b-instruct/` | 4096 |
| **Qwen2.5 VL 7B**</br>[Model card](https://huggingface.co/Qwen/Qwen2.5-VL-7B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license  | `gpt://<folder_ID>/qwen2.5-vl-7b-instruct/` | 4096 |
| **Qwen 2.5 VL 32B Instruct**</br>[Model card](https://huggingface.co/Qwen/Qwen2.5-VL-32B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2.5-vl-32b-instruct/` | 4096 |
| **DeepSeek 2 VL**</br>[Model card](https://huggingface.co/deepseek-ai/deepseek-vl2)</br>[DeepSeek license](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<folder_ID>/deepseek-vl2/` | 4096 |
| **DeepSeek 2 VL Tiny**</br>[Model card](https://huggingface.co/deepseek-ai/deepseek-vl2-tiny)</br>[DeepSeek license](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<folder_ID>/deepseek-vl2-tiny/` | 4096 |
| **Gemma3 4B it**</br>[Model card](https://huggingface.co/google/gemma-3-4b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-4b-it/` | 4096 |
| **Gemma3 12B it**</br>[Model card](https://huggingface.co/google/gemma-3-12b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-12b-it/` | 4096 |
| **Gemma3 27B it**</br>[Model card](https://huggingface.co/google/gemma-3-27b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-27b-it/` | 4096 |