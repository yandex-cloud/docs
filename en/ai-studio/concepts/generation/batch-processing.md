# Batch processing

## Text generation models {#text-batch}

#|
|| **Model** | **URI** | **Context** ||
|| **Qwen 2.5 7B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-7B-Instruct)
[Apache 2.0]({{ license-apache }}) license  | `gpt://<folder_ID>/qwen2.5-7b-instruct` | 32,768 ||
|| **Qwen 2.5 72B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct)
[Qwen license](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct/blob/main/LICENSE)  | `gpt://<folder_ID>/qwen2.5-72b-instruct` | 16,384 ||
|| **QwQ 32B Instruct** 
[Model card](https://huggingface.co/Qwen/QwQ-32B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwq-32b` | 32,768 ||
|| **Llama 3.3 70B Instruct**^2^ 
[Model card](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct)
[Llama 3.3 license](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/llama3.3-70b-instruct` | 8,192 ||
|| **Llama 3.1 70B Instruct**^2^
[Model card](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct)
[Llama 3.1 license](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct/blob/main/LICENSE)  | `gpt://<folder_ID>/llama3.1-70b-instruct` | 8,192 ||
|| **DeepSeek-R1 Distill Llama 70B** 
[Model card](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-70B)
[MIT]({{ license-mit }}) license
Based on Llama-3.3-70B-Instruct. [Llama-3.3-70B-Instruct Terms of Use](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/deepseek-r1-distill-llama-70b` | 8,192 ||
|| **Qwen2.5 32B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-32B-Instruct)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2.5-32b-instruct` | 32,768 ||
|| **DeepSeek-R1 Distill Qwen 32B** 
[Model card](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)
[MIT]({{ license-mit }}) license | `gpt://<folder_ID>/deepseek-r1-distill-qwen-32b` | 32,768 ||
|| **phi-4** 
[Model card](https://huggingface.co/microsoft/phi-4)
[MIT]({{ license-mit }}) license  | `gpt://<folder_ID>/phi-4` | 16,384 ||
|| **Gemma 3 1B it**
[Model card](https://huggingface.co/google/gemma-3-1b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-1b-it` | 32,768 ||
|| **Gemma 3 4B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-4b-it` | 131,072 ||
|| **Gemma 3 12B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-12b-it` | 65,536 ||
|| **Gemma 3 27B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-27b-it` | 32,768 ||
|| **Qwen3 0.6B** 
[Model card](https://huggingface.co/Qwen/Qwen3-0.6B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-0.6b` | 32,768 ||
|| **Qwen3 1.7B** 
[Model card](https://huggingface.co/Qwen/Qwen3-1.7B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-1.7b` | 32,768 ||
|| **Qwen3 4B** 
[Model card](https://huggingface.co/Qwen/Qwen3-4B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-4b` | 32,768 ||
|| **Qwen3 8B** 
[Model card](https://huggingface.co/Qwen/Qwen3-8B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-8b` | 32,768 ||
|| **Qwen3 14B** 
[Model card](https://huggingface.co/Qwen/Qwen3-14B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-14b` | 32,768 ||
|| **Qwen3 32B** 
[Model card](https://huggingface.co/Qwen/Qwen3-32B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-32b` | 32,768 ||
|| **Qwen3 30B A3B** 
[Model card](https://huggingface.co/Qwen/Qwen3-30B-A3B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-30b-a3b` | 32,768 ||
|| **Qwen3 235B A22B** 
[Model card](https://huggingface.co/Qwen/Qwen3-235B-A22B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-235b-a22b` | 32,768 ||
|#

^2^ {{ meta-disclaimer }}

## Multimodal models {#multimodels-batch}

#|
|| **Model** | **URI** | **Context** ||
|| **Qwen2 VL 7B**</br>[Model card](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2-vl-7b-instruct/` | 4,096 ||
|| **Qwen2.5 VL 7B**</br>[Model card](https://huggingface.co/Qwen/Qwen2.5-VL-7B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license  | `gpt://<folder_ID>/qwen2.5-vl-7b-instruct/` | 4,096 ||
|| **Qwen 2.5 VL 32B Instruct**</br>[Model card](https://huggingface.co/Qwen/Qwen2.5-VL-32B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2.5-vl-32b-instruct/` | 4,096 ||
|| **DeepSeek VL2**</br>[Model card](https://huggingface.co/deepseek-ai/deepseek-vl2)</br>[DeepSeek license](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<folder_ID>/deepseek-vl2/` | 4,096 ||
|| **DeepSeek VL2 Tiny**</br>[Model card](https://huggingface.co/deepseek-ai/deepseek-vl2-tiny)</br>[DeepSeek license](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<folder_ID>/deepseek-vl2-tiny/` | 4,096 ||
|| **Gemma 3 4B it**</br>[Model card](https://huggingface.co/google/gemma-3-4b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-4b-it/` | 4,096 ||
|| **Gemma 3 12B it**</br>[Model card](https://huggingface.co/google/gemma-3-12b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-12b-it/` | 4,096 ||
|| **Gemma 3 27B it**</br>[Model card](https://huggingface.co/google/gemma-3-27b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-27b-it/` | 4,096 ||
|# 

## Use cases {#usage-examples}

[{#T}](../../operations/batch/create.md)
