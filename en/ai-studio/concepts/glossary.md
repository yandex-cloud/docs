# {{ ai-studio-full-name }} terms and definitions

## Generation seed {#seed}

_Generation seed_ is the starting point for image generation from noise used to achieve repeatability. Thus, with the same prompt and seed, the generation result will be the same. To change the generated image, change the seed value or the description.

In a {{ yandexart-name }} model, seed values may range from 0 to 2^63^-1.

## Prompt {#prompt}

Generative models are managed using _prompts_. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.

Apart from the prompt, other request parameters will impact the model's output too. Use {{ ai-playground }} available from the [management console]({{ link-console-main }}) to test your requests.

## Temperature {#temperature}

_Temperature_ is a large text model parameter for response variability: the higher the temperature, the less predictable will be the result. Its usual range is between 0 and 1.
