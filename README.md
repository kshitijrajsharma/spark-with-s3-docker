## Spark + Jupyter Docker Compose

Apache Spark docker setup with JupyterLab
<img width="865" height="484" alt="image" src="https://github.com/user-attachments/assets/eb58fb6d-cee5-4241-adc0-1c72990f240a" />

### Prerequisites

- Docker and Docker Compose
  ```bash
  brew install docker docker-compose
  ```
- Download Docker Desktop

- After all the prerequisites from Docker
  ```bash
  docker compose up 
  ```

### Quick start

- Clone : 

```bash
git clone https://github.com/kshitijrajsharma/spark-with-s3-docker.git
cd spark-with-s3-docker
```

- Install and Run : 

```bash
make init
make up
```

- UIs:
  
  - Spark Master: http://localhost:8080
  - Spark History: http://localhost:18080
  - Jupyter: http://localhost:8889 (token: `spark`)

**Enjoy** your ride with spark ! 

### Testing

#### Test with spark-submit

```bash
make test
```

you can also do it manually to submit jobs :

```bash
docker exec spark-master spark-submit scripts/test_wordcount.py
```

#### Test with Jupyter

1. Open http://localhost:8889
2. Open `notebooks/test_spark.ipynb`
3. Run all cells

#### Test scaling

```bash
make scale N=5
```

Check http://localhost:8080 to see 5 workers

### Commands

- Start: `make up`
- Test script: `make test`
- Scale workers: `make scale N=3`
- View logs: `make logs`
- Stop: `make down`
- Clean all data: `make clean`

#### Credits

Like this ? Give me a star or Buy me a coffee when you see me !
