# Function

## *class* yandex\_ai\_studio\_sdk.\_vision.ocr.function.**OCRFunction**{#yandex_ai_studio_sdk._vision.ocr.function.OCRFunction}

OCR function for creating an OCR object which provides methods for invoking Yandex Vision OCR.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *language\_codes=Undefined*, *model=Undefined*){#yandex_ai_studio_sdk._vision.ocr.function.OCRFunction.__call__i}

Creates an OCR object for working with Yandex Vision OCR API.

Refer to [OCR documentation](https://aistudio.yandex.ru/docs/vision/concepts/ocr/) for more information.

#|
|| Parameters | 

- **language\_codes** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – List of languages to recognize text, in ISO 639-1 format (e.g. **"ru"**, **"en"**). See [supported languages](https://aistudio.yandex.ru/docs/vision/concepts/ocr/supported-languages.html).
- **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Model to use for text recognition. General models: **"page"** (default), **"page-column-sort"**, **"handwritten"**, **"table"**, **"markdown"**, **"math-markdown"**. Document template models: **"passport"**, **"driver-license-front"**, **"driver-license-back"**, **"vehicle-registration-front"**, **"vehicle-registration-back"**, **"license-plates"**. See [models](https://aistudio.yandex.ru/docs/vision/concepts/ocr/#models) and [document recognition](https://aistudio.yandex.ru/docs/vision/concepts/ocr/template-recognition). ||
|| Return type | [*OCRTypeT*](../../types/other.md#yandex_ai_studio_sdk._vision.ocr.ocr.OCRTypeT) ||
|#

# OCR object

## *class* yandex\_ai\_studio\_sdk.\_vision.ocr.ocr.**OCR**{#yandex_ai_studio_sdk._vision.ocr.ocr.OCR}

OCR class which provides methods for working with Yandex Vision OCR API.

**run**(*content*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *mime\_type=Undefined*, *timeout=60*){#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.run}

#|
|| Parameters | 

- **content** ([*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes))
- **mime\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OCRResult*](../../types/vision.md#yandex_ai_studio_sdk._vision.ocr.result.OCRResult) ||
|#

**run\_deferred**(*content*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *mime\_type=Undefined*, *timeout=60*){#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.run_deferred}

#|
|| Parameters | 

- **content** ([*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes))
- **mime\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Operation*](../../types/operation.md#yandex_ai_studio_sdk._types.operation.Operation)[[*OCRResult*](../../types/vision.md#yandex_ai_studio_sdk._vision.ocr.result.OCRResult)] ||
|#

**attach\_deferred**(*operation\_id*, *timeout=60*){#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.attach_deferred}

Attaches to an ongoing deferred operation using its operation id.

#|
|| Parameters | 

- **operation\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the id of the deferred operation to attach to.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | *OperationTypeT* ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT)*{#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *language\_codes=Undefined*, *model=Undefined*){#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.configure}

Returns the new object with config fields overridden by passed values.

#|
|| Parameters | 

- **language\_codes** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – List of languages to recognize text, in ISO 639-1 format (e.g. **"ru"**, **"en"**). See [supported languages](https://aistudio.yandex.ru/docs/vision/concepts/ocr/supported-languages.html).
- **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Model to use for text recognition. General models: **"page"** (default), **"page-column-sort"**, **"handwritten"**, **"table"**, **"markdown"**, **"math-markdown"**. Document template models: **"passport"**, **"driver-license-front"**, **"driver-license-back"**, **"vehicle-registration-front"**, **"vehicle-registration-back"**, **"license-plates"**. See [models](https://aistudio.yandex.ru/docs/vision/concepts/ocr/#models) and [document recognition](https://aistudio.yandex.ru/docs/vision/concepts/ocr/template-recognition). ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._vision.ocr.ocr.OCR.version}