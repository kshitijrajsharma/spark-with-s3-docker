## Spark + Jupyter Docker Compose

Apache Spark docker setup with JupyterLab

### Prerequisites

- Docker and Docker Compose

### Quick start

```bash
make init
make up
```

UIs:

- Spark Master: http://localhost:8080
- Spark History: http://localhost:18080
- Jupyter: http://localhost:8889 (token: `spark`)

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
