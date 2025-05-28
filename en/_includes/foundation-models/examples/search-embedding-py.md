```python
import requests
import numpy as np
from scipy.spatial.distance import cdist

FOLDER_ID = "<folder_ID>"
IAM_TOKEN = "<IAM_token>"
doc_uri = f"emb://{FOLDER_ID}/text-search-doc/latest"
query_uri = f"emb://{FOLDER_ID}/text-search-query/latest"
embed_url = "https://llm.api.cloud.yandex.net:443/foundationModels/v1/textEmbedding"
headers = {"Content-Type": "application/json", "Authorization": f"Bearer {IAM_TOKEN}", "x-folder-id": f"{FOLDER_ID}"}
doc_texts = [
  """Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow — January 29 [February 10], 1837, St. Petersburg) was a Russian poet, playwright, and novelist, the progenitor of Russian realism, a literary critic and theorist, historian, essay writer, and journalist.""",
  """Matricaria is a genus of annual flowering plants of the aster (composite) family. According to the today's classification, it includes around 70 species of low-rise fragrant herbs that blossom from the first year of life."""
]
query_text = "when is Pushkin's birthday?"

# Creating a query embedding
def get_embedding(text: str, text_type: str = "doc") -> np.array:
    query_data = {
        "modelUri": doc_uri if text_type == "doc" else query_uri,
        "text": text,
    }

    return np.array(
        requests.post(embed_url, json=query_data, headers=headers).json()["embedding"]
    )

# Creating a text embedding
query_embedding = get_embedding(query_text, text_type="query")
docs_embedding = [get_embedding(doc_text) for doc_text in doc_texts]

# Calculating cosine distance
dist = cdist(query_embedding[None, :], docs_embedding, metric="cosine")

# Calculating cosine similarity
sim = 1 - dist

# most similar doc text
print(doc_texts[np.argmax(sim)])
```