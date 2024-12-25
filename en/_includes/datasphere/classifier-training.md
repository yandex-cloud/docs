The following limits apply when tuning a classifier model based on {{ yagpt-name }}:

| Type of limit | Minimum value | Maximum value |
|---|---|---|
| Number of examples per dataset | 100 | 50,000 |
| Number of classes | 1 | 100 |
| Number of same class examples per dataset| 1 | — |
| Class name length, in characters | — | 100 |
| Number of [tokens](../../foundation-models/concepts/yandexgpt/tokens.md) in the text of the request to classify | — | 8,000 |

We recommend tuning models on datasets containing at least 1,000 examples and at least 100 examples for each class.

**Example of file contents for binary classification training**:

```json
{"text":"I'm fine","neutral":1}
{"text":"I did great","neutral":0}
{"text":"You could not possibly understand how tough it is to get up for work at six in the morning every day and spend two hours commuting on public transport","neutral":0}
{"text":"Everything is as usual, work, home, family","neutral":1}
```

Where:
* `text`: Message text.
* `neutral`: Binary classification class.


**Example of file contents for multi-class classification training**:

```json
{"text":"Wow, and how did that happen","anger":0,"fear":0,"joy":0,"sadness":0,"surprise":1}
{"text":"What am I supposed to do if this gets out","anger":0,"fear":1,"joy":0,"sadness":0,"surprise":0}
{"text":"It's Friday, and in the evening we're going to a club with my friends.","anger":0,"fear":0,"joy":1,"sadness":0,"surprise":0}
{"text":"Don't lie to me, you just overslept again and that's why you were late for school","anger":1,"fear":0,"joy":0,"sadness":0,"surprise":0}
```

Where:
* `text`: Message text.
* `anger`, `fear`, `joy`, `sadness`, and `surprise`: Classes.

**Example of file contents for multi-label classification training**:

```json
{"computer_science":0,"physics":0,"mathematics":1,"statistics":1,"quantitative_biology":0,"quantitative_finance":0,"text":"Title: Bias Reduction in Instrumental Variable Estimation through First-Stage Shrinkage\nAbstract:   The two-stage least-squares (2SLS) estimator is known to be biased when its\nfirst-stage fit is poor. I show that better first-stage prediction can\nalleviate this bias. In a two-stage linear regression model with Normal noise,\nI consider shrinkage in the estimation of the first-stage instrumental variable\ncoefficients. For at least four instrumental variables and a single endogenous\nregressor, I establish that the standard 2SLS estimator is dominated with\nrespect to bias. The dominating IV estimator applies James-Stein type shrinkage\nin a first-stage high-dimensional Normal-means problem followed by a\ncontrol-function approach in the second stage. It preserves invariances of the\nstructural instrumental variable equations.\n"}
{"computer_science":0,"physics":0,"mathematics":1,"statistics":0,"quantitative_biology":0,"quantitative_finance":0,"text":"Title: Essentially Finite Vector Bundles on Normal Pseudo-proper Algebraic Stacks\nAbstract:   Let $X$ be a normal, connected and projective variety over an algebraically\nclosed field $k$. It is known that a vector bundle $V$ on $X$ is essentially\nfinite if and only if it is trivialized by a proper surjective morphism $f:Y\\to\nX$. In this paper we introduce a different approach to this problem which\nallows to extend the results to normal, connected and strongly pseudo-proper\nalgebraic stack of finite type over an arbitrary field $k$.\n"}
{"computer_science":1,"physics":0,"mathematics":0,"statistics":1,"quantitative_biology":0,"quantitative_finance":0,"text":"Title: MOLIERE: Automatic Biomedical Hypothesis Generation System\nAbstract:   Hypothesis generation is becoming a crucial time-saving technique which\nallows biomedical researchers to quickly discover implicit connections between\nimportant concepts. Typically, these systems operate on domain-specific\nfractions of public medical data. MOLIERE, in contrast, utilizes information\nfrom over 24.5 million documents. At the heart of our approach lies a\nmulti-modal and multi-relational network of biomedical objects extracted from\nseveral heterogeneous datasets from the National Center for Biotechnology\nInformation (NCBI). These objects include but are not limited to scientific\npapers, keywords, genes, proteins, diseases, and diagnoses. We model hypotheses\nusing Latent Dirichlet Allocation applied on abstracts found near shortest\npaths discovered within this network, and demonstrate the effectiveness of\nMOLIERE by performing hypothesis generation on historical data. Our network,\nimplementation, and resulting data are all publicly available for the broad\nscientific community.\n"}
```

Where:
* `computer_science`, `physics`, `mathematics`, `statistics`, `quantitative_biology`, and `quantitative_finance`: Classes.
* `text`: Message text.
