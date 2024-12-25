# Tokens

Neural networks work with texts by representing words and sentences as _tokens_. Tokens are logical fragments or frequently used character sequences that are common for a natural language. Tokens help neural networks detect patterns and process natural language.

{{ yagpt-full-name }} uses its own tokenizer for text processing. You can [estimate](../../operations/yandexgpt/evaluate-request.md) the text field size in tokens using these special methods: [Tokenizer](../../text-generation/api-ref/Tokenizer/index.md) or [{{ ml-sdk-full-name }}](../../sdk/index.md). The token count of the same text may vary from one [model](./models.md) to the next.

To use a {{ yagpt-full-name }} tokenizer, you need the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).