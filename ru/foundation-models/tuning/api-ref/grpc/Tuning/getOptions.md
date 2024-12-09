---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/getOptions.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.GetOptions

## gRPC request

**rpc GetOptions ([GetOptionsRequest](#yandex.cloud.ai.tuning.v1.GetOptionsRequest)) returns ([GetOptionsResponse](#yandex.cloud.ai.tuning.v1.GetOptionsResponse))**

## GetOptionsRequest {#yandex.cloud.ai.tuning.v1.GetOptionsRequest}

```json
{
  "task_id": "string"
}
```

#|
||Field | Description ||
|| task_id | **string**

Required field.  ||
|#

## GetOptionsResponse {#yandex.cloud.ai.tuning.v1.GetOptionsResponse}

```json
{
  "task_id": "string",
  "base_model_uri": "string",
  "train_datasets": [
    {
      "dataset_id": "string",
      "weight": "double"
    }
  ],
  "validation_datasets": [
    {
      "dataset_id": "string",
      "weight": "double"
    }
  ],
  // Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`
  "text_to_text_completion": {
    "seed": "int64",
    "lr": "double",
    "n_samples": "int64",
    "additional_arguments": "string",
    // Includes only one of the fields `lora`, `prompt_tune`
    "lora": {
      "rank": "int64",
      "alpha": "double",
      "initialization": "string",
      "type": "string"
    },
    "prompt_tune": {
      "virtual_tokens": "int64"
    },
    // end of the list of possible fields
    "scheduler": {
      // Includes only one of the fields `linear`, `constant`, `cosine`
      "linear": {
        "min_lr": "double"
      },
      "constant": "SchedulerConstant",
      "cosine": {
        "min_lr": "double"
      },
      // end of the list of possible fields
      "warmup_ratio": "double"
    },
    "optimizer": {
      // Includes only one of the fields `adamw`
      "adamw": {
        "beta1": "double",
        "beta2": "double",
        "eps": "double",
        "weight_decay": "double"
      }
      // end of the list of possible fields
    }
  },
  "text_classification_multilabel": {
    "seed": "int64",
    "lr": "double",
    "n_samples": "int64",
    "additional_arguments": "string",
    // Includes only one of the fields `lora`, `prompt_tune`
    "lora": {
      "rank": "int64",
      "alpha": "double",
      "initialization": "string",
      "type": "string"
    },
    "prompt_tune": {
      "virtual_tokens": "int64"
    },
    // end of the list of possible fields
    "scheduler": {
      // Includes only one of the fields `linear`, `constant`, `cosine`
      "linear": {
        "min_lr": "double"
      },
      "constant": "SchedulerConstant",
      "cosine": {
        "min_lr": "double"
      },
      // end of the list of possible fields
      "warmup_ratio": "double"
    },
    "optimizer": {
      // Includes only one of the fields `adamw`
      "adamw": {
        "beta1": "double",
        "beta2": "double",
        "eps": "double",
        "weight_decay": "double"
      }
      // end of the list of possible fields
    }
  },
  "text_classification_multiclass": {
    "seed": "int64",
    "lr": "double",
    "n_samples": "int64",
    "additional_arguments": "string",
    // Includes only one of the fields `lora`, `prompt_tune`
    "lora": {
      "rank": "int64",
      "alpha": "double",
      "initialization": "string",
      "type": "string"
    },
    "prompt_tune": {
      "virtual_tokens": "int64"
    },
    // end of the list of possible fields
    "scheduler": {
      // Includes only one of the fields `linear`, `constant`, `cosine`
      "linear": {
        "min_lr": "double"
      },
      "constant": "SchedulerConstant",
      "cosine": {
        "min_lr": "double"
      },
      // end of the list of possible fields
      "warmup_ratio": "double"
    },
    "optimizer": {
      // Includes only one of the fields `adamw`
      "adamw": {
        "beta1": "double",
        "beta2": "double",
        "eps": "double",
        "weight_decay": "double"
      }
      // end of the list of possible fields
    }
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| task_id | **string** ||
|| base_model_uri | **string** ||
|| train_datasets[] | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| validation_datasets[] | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| text_to_text_completion | **[TextToTextCompletionTuningParams](#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`. ||
|| text_classification_multilabel | **[TextClassificationMultilabelParams](#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`. ||
|| text_classification_multiclass | **[TextClassificationMulticlassParams](#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`. ||
|#

## WeightedDataset {#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset}

#|
||Field | Description ||
|| dataset_id | **string**

Required field.  ||
|| weight | **double** ||
|#

## TextToTextCompletionTuningParams {#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams}

#|
||Field | Description ||
|| seed | **int64** ||
|| lr | **double** ||
|| n_samples | **int64** ||
|| additional_arguments | **string** ||
|| lora | **[TuningTypeLora](#yandex.cloud.ai.tuning.v1.TuningTypeLora)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| prompt_tune | **[TuningTypePromptTune](#yandex.cloud.ai.tuning.v1.TuningTypePromptTune)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| scheduler | **[Scheduler](#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams.Scheduler)** ||
|| optimizer | **[Optimizer](#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams.Optimizer)** ||
|#

## TuningTypeLora {#yandex.cloud.ai.tuning.v1.TuningTypeLora}

#|
||Field | Description ||
|| rank | **int64** ||
|| alpha | **double** ||
|| initialization | **string** ||
|| type | **string** ||
|#

## TuningTypePromptTune {#yandex.cloud.ai.tuning.v1.TuningTypePromptTune}

#|
||Field | Description ||
|| virtual_tokens | **int64** ||
|#

## Scheduler {#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams.Scheduler}

#|
||Field | Description ||
|| linear | **[SchedulerLinear](#yandex.cloud.ai.tuning.v1.SchedulerLinear)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| constant | **[SchedulerConstant](#yandex.cloud.ai.tuning.v1.SchedulerConstant)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| cosine | **[SchedulerCosine](#yandex.cloud.ai.tuning.v1.SchedulerCosine)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| warmup_ratio | **double** ||
|#

## SchedulerLinear {#yandex.cloud.ai.tuning.v1.SchedulerLinear}

#|
||Field | Description ||
|| min_lr | **double** ||
|#

## SchedulerConstant {#yandex.cloud.ai.tuning.v1.SchedulerConstant}

#|
||Field | Description ||
|| Empty | > ||
|#

## SchedulerCosine {#yandex.cloud.ai.tuning.v1.SchedulerCosine}

#|
||Field | Description ||
|| min_lr | **double** ||
|#

## Optimizer {#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams.Optimizer}

#|
||Field | Description ||
|| adamw | **[OptimizerAdamw](#yandex.cloud.ai.tuning.v1.OptimizerAdamw)**

Includes only one of the fields `adamw`. ||
|#

## OptimizerAdamw {#yandex.cloud.ai.tuning.v1.OptimizerAdamw}

#|
||Field | Description ||
|| beta1 | **double** ||
|| beta2 | **double** ||
|| eps | **double** ||
|| weight_decay | **double** ||
|#

## TextClassificationMultilabelParams {#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams}

#|
||Field | Description ||
|| seed | **int64** ||
|| lr | **double** ||
|| n_samples | **int64** ||
|| additional_arguments | **string** ||
|| lora | **[TuningTypeLora](#yandex.cloud.ai.tuning.v1.TuningTypeLora)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| prompt_tune | **[TuningTypePromptTune](#yandex.cloud.ai.tuning.v1.TuningTypePromptTune)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| scheduler | **[Scheduler](#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams.Scheduler)** ||
|| optimizer | **[Optimizer](#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams.Optimizer)** ||
|#

## Scheduler {#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams.Scheduler}

#|
||Field | Description ||
|| linear | **[SchedulerLinear](#yandex.cloud.ai.tuning.v1.SchedulerLinear)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| constant | **[SchedulerConstant](#yandex.cloud.ai.tuning.v1.SchedulerConstant)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| cosine | **[SchedulerCosine](#yandex.cloud.ai.tuning.v1.SchedulerCosine)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| warmup_ratio | **double** ||
|#

## Optimizer {#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams.Optimizer}

#|
||Field | Description ||
|| adamw | **[OptimizerAdamw](#yandex.cloud.ai.tuning.v1.OptimizerAdamw)**

Includes only one of the fields `adamw`. ||
|#

## TextClassificationMulticlassParams {#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams}

#|
||Field | Description ||
|| seed | **int64** ||
|| lr | **double** ||
|| n_samples | **int64** ||
|| additional_arguments | **string** ||
|| lora | **[TuningTypeLora](#yandex.cloud.ai.tuning.v1.TuningTypeLora)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| prompt_tune | **[TuningTypePromptTune](#yandex.cloud.ai.tuning.v1.TuningTypePromptTune)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| scheduler | **[Scheduler](#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams.Scheduler)** ||
|| optimizer | **[Optimizer](#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams.Optimizer)** ||
|#

## Scheduler {#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams.Scheduler}

#|
||Field | Description ||
|| linear | **[SchedulerLinear](#yandex.cloud.ai.tuning.v1.SchedulerLinear)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| constant | **[SchedulerConstant](#yandex.cloud.ai.tuning.v1.SchedulerConstant)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| cosine | **[SchedulerCosine](#yandex.cloud.ai.tuning.v1.SchedulerCosine)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| warmup_ratio | **double** ||
|#

## Optimizer {#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams.Optimizer}

#|
||Field | Description ||
|| adamw | **[OptimizerAdamw](#yandex.cloud.ai.tuning.v1.OptimizerAdamw)**

Includes only one of the fields `adamw`. ||
|#