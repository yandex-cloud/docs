Prior to the start of a check, the owner provides an architecture description from [here](../../../../security/standard-ai/intro.md) that contains precise IDs for resources, models, versions, and subjects. Applicable exceptions and authorization for active tests are attached separately if they fall within the scope of the check.

The reviewer compares this information with the actual configuration and selects applicable requirements. For example, model loader requirements do not apply to managed inference without custom weights; document authorization requirements apply if the RAG contains documents with differing access permissions; and MCP requirements only apply when an appropriate path is present.

The _not applicable_ result is permissible when the lack of a condition is confirmed, but not when the log is missing or the reviewer lacks access. If the architecture is unknown, it is architecture reconstruction that occurs first, rather than requirement closure.
