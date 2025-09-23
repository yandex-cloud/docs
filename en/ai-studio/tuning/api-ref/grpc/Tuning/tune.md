---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/tune.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.Tune

## gRPC request

**rpc Tune ([TuningRequest](#yandex.cloud.ai.tuning.v1.TuningRequest)) returns ([yandex.cloud.operation.Operation](#yandex.cloud.operation.Operation))**

## TuningRequest {#yandex.cloud.ai.tuning.v1.TuningRequest}

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
  "validation_dataset": {
    "dataset_id": "string",
    "weight": "double"
  },
  "test_datasets": [
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

Required field. Format like a `gpt://{folder_id}/yandex-gpt/latest` ||
|| train_datasets[] | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| validation_datasets[] | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| validation_dataset | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| test_datasets[] | **[WeightedDataset](#yandex.cloud.ai.tuning.v1.TuningRequest.WeightedDataset)** ||
|| text_to_text_completion | **[TextToTextCompletionTuningParams](#yandex.cloud.ai.tuning.v1.TextToTextCompletionTuningParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_classification_multilabel | **[TextClassificationMultilabelParams](#yandex.cloud.ai.tuning.v1.TextClassificationMultilabelParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_classification_multiclass | **[TextClassificationMulticlassParams](#yandex.cloud.ai.tuning.v1.TextClassificationMulticlassParams)**

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_embedding_pair_params | **[TextEmbeddingPairParams](#yandex.cloud.ai.tuning.v1.TextEmbeddingPairParams)**

TextEmbeddingPairParams  is unimplemented

Includes only one of the fields `text_to_text_completion`, `text_classification_multilabel`, `text_classification_multiclass`, `text_embedding_pair_params`, `text_embedding_triplet_params`. ||
|| text_embedding_triplet_params | **[TextEmbeddingTripletParams](#yandex.cloud.ai.tuning.v1.TextEmbeddingTripletParams)**

TextEmbeddingTripletParams  is unimplemented

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

## yandex.cloud.operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "tuning_task_id": "string",
    "status": "Status",
    "total_steps": "int64",
    "current_step": "int64"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "tuning_task_id": "string",
    "status": "Status",
    "target_model_uri": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[TuningMetadata](#yandex.cloud.ai.tuning.v1.TuningMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[TuningResponse](#yandex.cloud.ai.tuning.v1.TuningResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## TuningMetadata {#yandex.cloud.ai.tuning.v1.TuningMetadata}

#|
||Field | Description ||
|| tuning_task_id | **string** ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED`
- `DRAFT`
- `ARCHIVED`
- `PAID` ||
|| total_steps | **int64** ||
|| current_step | **int64** ||
|#

## TuningResponse {#yandex.cloud.ai.tuning.v1.TuningResponse}

#|
||Field | Description ||
|| tuning_task_id | **string** ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED`
- `DRAFT`
- `ARCHIVED`
- `PAID` ||
|| target_model_uri | **string** ||
|#