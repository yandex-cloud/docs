---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/createDraft.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.CreateDraft

Unimplemented

## gRPC request

**rpc CreateDraft ([CreateTuningDraftRequest](#yandex.cloud.ai.tuning.v1.CreateTuningDraftRequest)) returns ([CreateTuningDraftResponse](#yandex.cloud.ai.tuning.v1.CreateTuningDraftResponse))**

## CreateTuningDraftRequest {#yandex.cloud.ai.tuning.v1.CreateTuningDraftRequest}

```json
{
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
  // Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`
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
  },
  "text_embedding_pair_params": {
    "seed": "int64",
    "lr": "double",
    "n_samples": "int64",
    "additional_arguments": "string",
    "embedding_dims": [
      "int64"
    ],
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
      // Includes only one of the fields `warmup_ratio`
      "warmup_ratio": "double"
      // end of the list of possible fields
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
  "text_embedding_triplet_params": {
    "seed": "int64",
    "lr": "double",
    "n_samples": "int64",
    "additional_arguments": "string",
    "embedding_dims": [
      "int64"
    ],
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
      // Includes only one of the fields `warmup_ratio`
      "warmup_ratio": "double"
      // end of the list of possible fields
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
  // end of the list of possible fields
  "name": "string",
  "description": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| base_model_uri | **string**

Required field.  ||
|| train_datasets[] | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| validation_datasets[] | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| text_to_text_completion | **[TextToTextCompletionTuningParams](#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_classification_multilabel | **[TextClassificationMultilabelParams](#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_classification_multiclass | **[TextClassificationMulticlassParams](#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_embedding_pair_params | **[TextEmbeddingPairParams](#yandex.cloud.ai.tuning.v1.TextEmbeddingPairParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_embedding_triplet_params | **[TextEmbeddingTripletParams](#yandex.cloud.ai.tuning.v1.TextEmbeddingTripletParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
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
|| alpha | **double**

Integer value ||
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

## TextEmbeddingPairParams {#yandex.cloud.ai.tuning.v1.TextEmbeddingPairParams}

#|
||Field | Description ||
|| seed | **int64** ||
|| lr | **double** ||
|| n_samples | **int64** ||
|| additional_arguments | **string** ||
|| embedding_dims[] | **int64** ||
|| lora | **[TuningTypeLora](#yandex.cloud.ai.tuning.v1.TuningTypeLora)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| prompt_tune | **[TuningTypePromptTune](#yandex.cloud.ai.tuning.v1.TuningTypePromptTune)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| scheduler | **[Scheduler](#yandex.cloud.ai.tuning.v1.TextEmbeddingPairParams.Scheduler)** ||
|| optimizer | **[Optimizer](#yandex.cloud.ai.tuning.v1.TextEmbeddingPairParams.Optimizer)** ||
|#

## Scheduler {#yandex.cloud.ai.tuning.v1.TextEmbeddingPairParams.Scheduler}

#|
||Field | Description ||
|| linear | **[SchedulerLinear](#yandex.cloud.ai.tuning.v1.SchedulerLinear)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| constant | **[SchedulerConstant](#yandex.cloud.ai.tuning.v1.SchedulerConstant)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| cosine | **[SchedulerCosine](#yandex.cloud.ai.tuning.v1.SchedulerCosine)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| warmup_ratio | **double**

Includes only one of the fields `warmup_ratio`. ||
|#

## Optimizer {#yandex.cloud.ai.tuning.v1.TextEmbeddingPairParams.Optimizer}

#|
||Field | Description ||
|| adamw | **[OptimizerAdamw](#yandex.cloud.ai.tuning.v1.OptimizerAdamw)**

Includes only one of the fields `adamw`. ||
|#

## TextEmbeddingTripletParams {#yandex.cloud.ai.tuning.v1.TextEmbeddingTripletParams}

#|
||Field | Description ||
|| seed | **int64** ||
|| lr | **double** ||
|| n_samples | **int64** ||
|| additional_arguments | **string** ||
|| embedding_dims[] | **int64** ||
|| lora | **[TuningTypeLora](#yandex.cloud.ai.tuning.v1.TuningTypeLora)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| prompt_tune | **[TuningTypePromptTune](#yandex.cloud.ai.tuning.v1.TuningTypePromptTune)**

Includes only one of the fields `lora`, `prompt_tune`. ||
|| scheduler | **[Scheduler](#yandex.cloud.ai.tuning.v1.TextEmbeddingTripletParams.Scheduler)** ||
|| optimizer | **[Optimizer](#yandex.cloud.ai.tuning.v1.TextEmbeddingTripletParams.Optimizer)** ||
|#

## Scheduler {#yandex.cloud.ai.tuning.v1.TextEmbeddingTripletParams.Scheduler}

#|
||Field | Description ||
|| linear | **[SchedulerLinear](#yandex.cloud.ai.tuning.v1.SchedulerLinear)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| constant | **[SchedulerConstant](#yandex.cloud.ai.tuning.v1.SchedulerConstant)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| cosine | **[SchedulerCosine](#yandex.cloud.ai.tuning.v1.SchedulerCosine)**

Includes only one of the fields `linear`, `constant`, `cosine`. ||
|| warmup_ratio | **double**

Includes only one of the fields `warmup_ratio`. ||
|#

## Optimizer {#yandex.cloud.ai.tuning.v1.TextEmbeddingTripletParams.Optimizer}

#|
||Field | Description ||
|| adamw | **[OptimizerAdamw](#yandex.cloud.ai.tuning.v1.OptimizerAdamw)**

Includes only one of the fields `adamw`. ||
|#

## CreateTuningDraftResponse {#yandex.cloud.ai.tuning.v1.CreateTuningDraftResponse}

```json
{
  "tuning_task_id": "string"
}
```

#|
||Field | Description ||
|| tuning_task_id | **string** ||
|#