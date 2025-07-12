<<<<<<< HEAD
# RAG Chatbot for Internal Documents

This project implements a Retrieval-Augmented Generation (RAG) chatbot designed to answer questions based on internal company documents (PDFs). It leverages open-source models and frameworks to provide a locally deployable solution with a Streamlit-based user interface.

## Features

- **PDF Document Ingestion**: Processes PDF documents, extracts text, and chunks it for efficient retrieval.
- **Embeddings**: Uses `HuggingFaceEmbeddings` (`BAAI/bge-base-en-v1.5`) for generating document embeddings.
- **FAISS Vector Store**: Stores document embeddings and metadata in a FAISS index for fast similarity search.
- **Groq API Integration**: Leverages the Groq API for fast and efficient LLM inference (using models like Llama3-8B).
- **Streamlit UI**: Provides an intuitive web interface for interacting with the chatbot.
- **Source Attribution**: Displays the source PDF and page number for retrieved information.

## Project Structure

```
rag_chatbot/
├── app.py                  # Streamlit web application for the chatbot UI
├── ingest.py               # Script for ingesting PDF documents and creating the FAISS index
├── rag_chain.py            # Defines the RAG pipeline, including LLM and retrieval logic
├── utils.py                # Helper functions for PDF loading and text processing
├── requirements.txt        # Python dependencies
├── .env                    # Environment variables (e.g., GROQ_API_KEY)
├── data/
│   └── pdfs/               # Directory to place your PDF documents
│       └── your_document.pdf
├── models/                 # (Optional) Directory for local LLM models if used, otherwise can be removed
│   └── mistral-7b-instruct-v0.1.Q4_K_M.gguf # (Optional) Downloaded LLM model if used locally
└── vectorstore/
    └── faiss_index/        # Directory where the FAISS index will be stored
        ├── index.faiss
        └── index.pkl
```

## Setup and Installation

Follow these steps to set up and run the RAG chatbot on your local machine.

### 1. Clone the Repository (if applicable)

If you received this project as a repository, clone it:

```bash
git clone <repository_url>
cd rag_chatbot
```

### 2. Create a Virtual Environment

It's highly recommended to use a virtual environment to manage dependencies.

```bash
python -m venv env
# On Windows:
.\env\Scripts\activate
# On macOS/Linux:
source env/bin/activate
```

### 3. Install Dependencies

Install all required Python packages listed in `requirements.txt`:

```bash
pip install -r requirements.txt
```

### 4. Set Up Groq API Key

This project uses the Groq API for LLM inference. You need to obtain an API key from [Groq Console](https://console.groq.com/) and set it as an environment variable.

Create a `.env` file in the root directory of your project and add your API key:

```
GROQ_API_KEY=your_groq_api_key_here
```

Replace `your_groq_api_key_here` with your actual Groq API key. The application will automatically load this variable.

### 5. Place Your PDF Documents

Create a `data/pdfs/` directory inside your project root if it doesn't exist. Place all the PDF documents you want the chatbot to learn from into this directory.

Example:

```
rag_chatbot/
└── data/
    └── pdfs/
        ├── USA_Employee_Handbook-Freely_Available.pdf
        └── another_document.pdf
```

### 6. Ingest Documents and Create Vector Store

Run the ingestion script to process your PDFs, chunk their content, generate embeddings, and create the FAISS vector store. This step can take some time depending on the number and size of your documents.

```bash
python ingest.py
```

Upon successful completion, a `vectorstore/faiss_index/` directory will be created, containing `index.faiss` and `index.pkl`.

## Usage

Once the setup is complete and documents are ingested, you can run the Streamlit application.

```bash
streamlit run app.py
```

This command will open the RAG Chatbot interface in your default web browser (usually `http://localhost:8501`).

Type your questions into the input box and press Enter. The chatbot will retrieve relevant information from your documents and provide an answer, along with the source documents and snippets.

### Example Questions

- "What is the policy on vacation days?"
- "How many sick leaves are allowed?"
- "What are the company's values?"
- "Can you tell me about the employee benefits?"

## Troubleshooting

- **`ModuleNotFoundError`**: If you encounter a `ModuleNotFoundError` for `langchain`, `langchain-community`, `pypdf`, or any other package, ensure all dependencies are installed:
  ```bash
  pip install -r requirements.txt
  ```
  If a specific module like `pypdf` is still missing, try installing it directly:
  ```bash
  pip install pypdf
  ```

- **`FileNotFoundError: FAISS index not found`**: This means the vector store has not been created. Run the ingestion script:
  ```bash
  python ingest.py
  ```

- **`ValueError: GROQ_API_KEY environment variable not set`**: Ensure you have created a `.env` file in the root directory and added `GROQ_API_KEY=your_groq_api_key_here` with your actual API key. Also, ensure `python-dotenv` is installed (`pip install python-dotenv`).

- **No Specific Source Documents Found**: Ensure your PDFs contain the information relevant to your queries. Verify that the document loading, chunking, and embedding processes are working correctly by checking the console output of `ingest.py`.

## Performance Evaluation (Manual)

After running the chatbot, you can manually evaluate its performance based on the following criteria:

- **Relevance**: Are the answers accurate and directly derived from the content of your PDFs?
- **Source Attribution**: Does the chatbot correctly identify and display the source PDF filename and page number for its answers?
- **Response Time**: How quickly does the chatbot generate responses? This can be a subjective measure but helps in understanding the user experience.
- **Handling Out-of-Context Questions**: How does the chatbot respond to questions that are not covered by your documents? Ideally, it should state that it doesn't know the answer rather than generating incorrect or fabricated information (hallucinating).

## Pushing to a New GitHub Repository

If you wish to push this project to a new GitHub repository, follow these steps:

1.  **Create a new repository on GitHub**: Go to GitHub and create a new empty repository. Do NOT initialize it with a README, .gitignore, or license.

2.  **Initialize Git in your local project (if not already done)**:
    ```bash
    git init
    ```

3.  **Add your files to the local repository**: 
    ```bash
    git add .
    ```

4.  **Commit your changes**: 
    ```bash
    git commit -m "Initial commit"
    ```

5.  **Add the remote origin**: Replace `YOUR_GITHUB_USERNAME` and `YOUR_REPOSITORY_NAME` with your actual GitHub username and repository name.
    ```bash
    git remote add origin https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPOSITORY_NAME.git
    ```

6.  **Push your local repository to GitHub**: 
    ```bash
    git push -u origin main
    ```

## Further Enhancements (Future Work)

- **Advanced Chunking Strategies**: Experiment with different chunking methods (e.g., semantic chunking) to improve retrieval accuracy.
- **Hybrid Search**: Combine keyword search with vector similarity search for more robust retrieval.
- **Evaluation Metrics**: Implement automated evaluation metrics (e.g., RAGAS) to quantitatively assess the chatbot's performance.
- **User Feedback**: Add a mechanism for users to provide feedback on answer quality.
- **Scalability**: For larger document sets, consider more robust vector databases (e.g., ChromaDB, Pinecone) and distributed processing.
- **Fine-tuning LLM**: Fine-tune a smaller LLM on your specific document domain for potentially better performance.
>>>>>>> 00053f1d252375734bc7dc2ab97351ef3cdfa797
