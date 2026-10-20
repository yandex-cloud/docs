Regulated data transformation reduces identifying information provided to a model or external component down to an absolute minimum required by a scenario. The transformation method is selected based on whether you need to preserve structure, relations between records, and ability to recover values, and whether there is risk of re-identification.

Below is a technical glossary of terms used throughout the standard. It does not constitute a legal definition or replace an assessment by duly authorized officers.

* **Masking**: Concealing or replacing a part of a value, e.g., `+7 *** ***-12-34` or `[USER_NAME]`. The format or some part of the value may remain as is.
* **Pseudonymization**: Replacing a value with an alias or code. Reverse transformation is possible if you have access to the key, mapping table, or detokenization service.
* **Tokenization**: Replacing a value with a token, usually when an application needs to restore the value after processing by a model.
* **Hashing**: Deriving a calculated value; its resilience depends on the entropy of the source data, salt, secret, and risk of brute-force attacks.
* **Aggregation**: Replacing detailed data with grouped or statistical values.
* **Anonymization**: Transformation that provides no standard way to recover the identity from the transmitted dataset; its sufficiency is evaluated for the specific dataset and risk of re-identification through linkage attacks.
