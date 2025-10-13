## Model lifecycle {#model-lifecycle}

Each model has a number of lifecycle characteristics, such as model name, branch, and release date. These allow you to uniquely identify the model version. Refer to the model update rules provided below to adapt your solutions to the new version as needed. 

There are three model branches (from old to new): `Deprecated`, `Latest`, `Release Candidate` (`RC`). Each of the branches is subject to the [SLA](../../overview/sla.md). 

The `RC` branch is updated as the new model is ready and may change at any time. When a model in the `RC` branch is ready for general use, we announce the upcoming release both in the [release notes](../../ai-studio/release-notes/index.md) and our [Telegram community](https://t.me/YFM_Community).

One month after the announcement, the `RC` version becomes the `Latest` one, and the `Latest` version is moved to the `Deprecated` branch. We continue the support of the `Deprecated` version for one more month, after which models in the `Deprecated` and `Latest` branches become identical.