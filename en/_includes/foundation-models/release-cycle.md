### Model lifecycle {#model-lifecycle}

Each model has certain lifecycle characteristics, such as the model name, branch, and release date. These characteristics allow you to precisely identify the model version. Below, you can see our rules for updating models. Refer to these rules to adjust your solutions to a new version as apporpriate. 

For each model, there are three branches (in the order from the oldest to the newest one): `Deprecated`, `Latest`, and `Release Candidate` (`RC`). Each of the branches is subject to the [SLA](../../overview/sla.md). 

The `RC` branch is updated as the new model is ready and may change at any time. When a model in the `RC` branch is ready for general use, we announce the upcoming release both in the [release notes](../../foundation-models/release-notes/index.md) and our [Telegram community](https://t.me/YFM_Community).

One month after the announcement, the `RC` version becomes the `Latest` one, and the `Latest` version is moved to the `Deprecated` branch. We continue the support of the `Deprecated` version for one more month, after which models in the `Deprecated` and `Latest` branches become identical.