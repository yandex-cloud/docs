---
title: Function calling in {{ foundation-models-name }} generative models
description: In this article, you will learn how to use function calling with {{ foundation-models-full-name }} generative models.
---

# Function calling in generative models

Most AI applications interact with users directly but cannot access external databases, APIs, and other tools. To enhance model capabilities, you can use _function calling_, a special parameter enabling you to describe the available external tools and interpret the results of their operation.

When calling a function, the model does not generate a text response on its own but only provides parameters for the external tool.

> For example, you have a function for getting weather forecast and you want the model to use it. In which case, for a prompt _What is the weather like in St. Petersburg?_, the model will be able to initiate a call to this function, get the current weather forecast, and generate a response using the obtained value. For a detailed example, see [this step-by-step guide](../../operations/yandexgpt/function-call.md).

Any additional tools that may be available for the model will vary depending on the application developer. The model itself does not execute functions or interact directly with tools; it simply generates a request for an external tool providing structured data required to complete the task. Executing the function and providing its result back to the model is performed on the side of the user or service controlling the process. After receiving the result, the model uses it to generate the final response.

There are many use cases for function calling, such as the following:

* Performing tasks with strict logic: running a calculator or VM code interpreter.
* Searching for up-to-date information: weather, currency exchange rates, or tracking routes.
* Accessing external systems: getting and writing data to ERP and CRM systems or databases.
* Visualizing data: creating tables, charts, or reports.
* Remote device management: creating and deleting files, running scripts and software.
* Automation: checking deadlines, assigning tasks to employees.

## How to call functions in the text generation API {#tools}

When accessing a model via the text generation API, you can describe all functions available to the model in the `tools` field. Each function definition in `tools` must include its name, a description of its purpose or behavior, and a list of parameters the model must return for the function to apply correctly. Remember to describe the parameters in [JSON Schema](https://json-schema.org/) format:

```json
request_body = {
    "messages": [
        { "role":"system", "text":"<instruction_text>" }, 
        { "role":"user", "text":"<prompt_text>" },
    ],
    "tools": [ {
        "function": {
            "name": "weatherTool",
            "description": "Gets weather forecast in a city via API", # Remember to provide a detailed function description
            "parameters": {
                "type": "object",
                "properties": {
                    "city": {
                        "type": "string", # Parameter type
                        "description": "Name of the city to get the weather for." # Parameter description
                    },
                    "units": {
                        "type": "string",
                        "enum": ["metric", "imperial"], # List of acceptable values
                        "default": "metric", # Default value
                        "description": "Units of temperature; 'metric' for Celsius, 'imperial' for Fahrenheit."
                    },
                    "days": {
                        "type": "integer",
                        "default": 1,
                        "minimum": 1, # Parameter limitations
                        "maximum": 5,
                        "description": "Number of days to get the weather for, starting from the current day."
                    },
                    "regions": {
                        "type": "array", # Arrays
                        "default": ["center"],
                        "maxItems": 3,
                        "description": "City areas to get the weather for, such as 'center', 'west', 'west-east', etc."
                    },
                },
                
                "required": ["city"] # List of required parameters for the function to run
            }
        }
    } ] 
}
```

You can also specify basic data types, validation of strings, numbers, and arrays, as well as other parameters. For a more detailed description of JSON Schema, see the [official website](https://json-schema.org/learn/getting-started-step-by-step).

The `tools` field in a function call does not mean the model will actually call any of the tools. If the context compels the model to use additional tools, in response to the request, the user will get a message with the [`ToolCallList` field](../../text-generation/api-ref/TextGeneration/completion.mc#yandex.cloud.ai.foundation_models.v1.ToolCallList2) containing a call to the invoked function and required parameters as a JSON Schema. Send the function output in a message in the [`ToolResultList` field](../../text-generation/api-ref/TextGeneration/completion.md#yandex.cloud.ai.foundation_models.v1.ToolResultList). The model will use the output to generate its final response.

If the model, based on the request context, chooses not to use the suggested tools, it will generate and send its final response right away.

You can use function calling when working with {{ gpt-pro }} and {{ llama }} 70B^1^ models and when accessing those models via the [AI assistant](../assistant/index.md) API.

## Use cases {#examples}

[{#T}](../../operations/yandexgpt/function-call.md)