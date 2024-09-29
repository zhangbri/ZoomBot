import os
import warnings
from sentence_transformers import SentenceTransformer
import json
import torch
import numpy as np

# Suppress specific warnings
warnings.filterwarnings("ignore", category=FutureWarning, module="transformers")
warnings.filterwarnings("ignore", category=UserWarning)

# Define a similarity threshold
threshold = 0.650

# Load JSON data from a file
with open('transcript.json', 'r') as file:
    data = json.load(file)

# Extract sentences into a list
transcript = data['transcript']
questions = data['prompt']

# Load the pre-trained model
model = SentenceTransformer("multi-qa-mpnet-base-cos-v1")

# Encode the transcript sentences (this should be done once)
passage_embeddings = model.encode(transcript)

# Convert passage_embeddings to a single numpy array for efficiency
passage_embeddings = np.array(passage_embeddings)

# Store results in a dictionary
result = {}

# Iterate over each question and compute similarities with the transcript
for question in questions:
    # Encode the question into an embedding
    query_embedding = model.encode(question)

    # Calculate cosine similarity between query and each sentence in the transcript
    similarity = torch.nn.functional.cosine_similarity(
        torch.tensor([query_embedding]), torch.tensor(passage_embeddings), dim=1
    )

    # Convert to NumPy array and get similarity scores
    similarity_scores = similarity.detach().cpu().numpy()

    # Find the index of the most similar sentence
    best_match_index = similarity_scores.argmax()

    # Retrieve the best matching sentence from the transcript
    best_match_sentence = transcript[best_match_index]

    # Print the most relevant answer for the question
    print(f"Question: {question}")
    print(f"Most relevant answer: {best_match_sentence}\n")

    # Store in the result dictionary
    result[question] = best_match_sentence

# Specify the path to save the JSON file
file_path = "output.json"

# Save the results as a JSON file
with open(file_path, "w") as json_file:
    json.dump(result, json_file, indent=4)  # `indent` makes the file more readable
