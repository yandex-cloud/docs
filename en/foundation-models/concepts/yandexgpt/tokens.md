# Tokens

Neural networks work with texts by representing words and sentences as _tokens_. Tokens are logical fragments or frequently used character sequences that are common for a natural language. Tokens help neural networks detect patterns and process the natural language.

{{ yagpt-full-name }} uses its own tokenizer for text processing. You can estimate the text field size in tokens using the [`Tokenizer`](../..//text-generation/api-ref/Tokenizer/index.md) REST API methods. The token count of the same text may vary from one [model](models) to the next.