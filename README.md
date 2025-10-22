# AI-Driven Stock News Sentiment Aggregator: A Polyglot Microservices Pipeline

This repository showcases a cloud-native data pipeline designed to ingest, analyze, and aggregate real-time financial news sentiment for specific stock tickers. It utilizes a **Polyglot Microservices Architecture** to leverage the specialized strengths of Python for Machine Learning and Go for high-performance concurrency.

## Key Technical Highlights ✨

This application demonstrates expertise across the full stack of modern cloud engineering:

* **Microservices:** Three decoupled services—Ingestion (**Python/FastAPI**), NLP Inference (**Python/FastAPI/FinBERT**), and Data Aggregation (**Go**).
* **AI/ML:** Uses a domain-specific **FinBERT** (a Transformer Model) for accurate sentiment classification, essential for financial text analysis.
* **Backend:** High-performance Aggregator Service implemented in **Go** for efficient, low-latency consumption of message queues and database writes.
* **Containerization & Orchestration:** All services are packaged using **Docker** and deployed via **Kubernetes (AWS EKS)**.
* **Infrastructure as Code (IaC):** The entire cloud environment is defined and managed using **Terraform** for repeatable, reliable provisioning of **AWS** resources.
* **Persistence:** Uses **PostgreSQL** (AWS RDS) for structured storage of aggregated sentiment scores and article data.

---

## ⚙️ Architecture Diagram & Data Flow

1.  **Ingestion Service (Python/FastAPI):** Polls external financial news APIs for raw headlines and abstracts. Pushes raw text data onto the Message Queue (e.g., Kafka/RabbitMQ).
2.  **Message Queue (RabbitMQ/Kafka):** Decouples services, managing the flow of data and buffering input for the resource-intensive ML service.
3.  **NLP Inference Service (Python/FastAPI/FinBERT):** Consumes raw text from the queue, runs the FinBERT model (using a framework like PyTorch/TensorFlow) to determine `sentiment_score` and `classification`. Pushes the structured result downstream.
4.  **Data Aggregator Service (Go):** Consumes structured sentiment data, performs high-speed calculations (e.g., a rolling 24-hour sentiment average per stock), and persists final scores to the database.
5.  **PostgreSQL (AWS RDS):** Serves as the central persistence layer for stock data and final aggregated scores.
6.  **Frontend (React):** A simple dashboard fetches aggregated scores and visualizes the sentiment trends.

---

## 🚀 Getting Started (Local Setup)

To run the full polyglot application locally, you will need to install **Docker** and **Docker Compose**.

1.  **Clone the Repository:**
    ```bash
    git clone [YOUR-REPO-URL]
    cd [YOUR-REPO-NAME]
    ```

2.  **Build and Run Services:**
    The `docker-compose.yml` file defines and orchestrates the database, message queue, and all three microservices.

    ```bash
    # This command builds the Docker images (Python and Go) and starts all 5 containers
    docker compose up --build
    ```

3.  **Verify Services:**
    After containers are stable, you should be able to:
    * Access the database on the defined local port.
    * Observe log messages showing the Ingestion service pushing data, the Inference service processing, and the Go Aggregator service writing to the DB.

---

## ☁️ Cloud Deployment (Terraform & Kubernetes)

This section documents the production deployment environment in AWS.

**Prerequisites:**

* AWS Account configured with CLI access.
* Terraform installed.
* `kubectl` installed and configured.

**Deployment Steps:**

1.  **Initialize Terraform:** Navigate to the `/infrastructure` directory and initialize.
    ```bash
    terraform init
    ```

2.  **Provision Infrastructure:** Run the following commands to provision the AWS EKS Cluster, AWS RDS PostgreSQL instance, and associated networking resources:
    ```bash
    terraform plan
    terraform apply
    ```

3.  **Deploy Microservices:** Once the EKS cluster is ready, use `kubectl` to apply the manifests defined in the `/k8s` directory. This deploys the Dockerized services (built via the CI/CD pipeline) into the cluster.

---

## ✅ Technologies Used

| Category | Technology | Purpose |
| :--- | :--- | :--- |
| **Backend & AI** | Python (FastAPI), FinBERT | High-performance APIs and specialized NLP inference. |
| **Backend & Concurrency** | Go (Golang) | Low-latency queue consumption and data aggregation. |
| **Database** | PostgreSQL (AWS RDS) | Structured data persistence and query. |
| **Cloud** | AWS (EKS, RDS, VPC) | Production-ready, managed cloud infrastructure. |
| **DevOps & IaC** | Terraform, Kubernetes, Docker | Automated provisioning, containerization, and cluster orchestration. |
| **Frontend** | React, HTML, CSS | Simple dashboard for data visualization
