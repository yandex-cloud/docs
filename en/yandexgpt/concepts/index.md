# About {{ yagpt-full-name }}

{% include notitle [preview-stage](../../_includes/yandexgpt/preview.md) %}

{{ yagpt-name }} is a neural network that can solve different tasks related to creating text content. {{ yagpt-name }} can generate product descriptions, articles, news stories, newsletters, blog posts, and many other types of texts. The quality of the neural network's response directly depends on the accuracy of provided instructions. With a more specific request, you are more likely to get the expected result.

The service is dynamically evolving with constant enhancements and refinements to its functionality. Currently, you can use {{ yagpt-name }} to create such text content as product descriptions, articles, news stories, newsletters, blog posts, and many other texts. Going forward, we will enhance the service with other features, including data analysis and process automation.

## {{ yagpt-name }} modes

{{ yagpt-name }} has two user interaction modes:

* In **Prompt** mode, you send a ready-made _prompt_ (an instruction and a request) to a model and get a response. A model treats each new question as a stand-alone task without saving the context of previous requests.

* In **Chat** mode, you chat with a model, specifying tasks and supplementing your previous remarks. The communication context is transmitted in every message and maintained during the current session until you explicitly start a new one.

Nether of the modes can process unlimited amounts of data yet. Currently, the maximum total number of [tokens](tokens.md) allowed per user request and model response is {{ yagpt-max-tokens }}. For more information about service limits, see [{#T}](limits.md).