# GeoFence Alerting System (GFAS) 

The GFAS project aims to deploy a Tile38 server on Google Cloud Platform (GCP) using Docker, along with monitoring tools Grafana and Prometheus. This project focuses on the DevOps aspect, ensuring smooth deployment and monitoring of the [Tile38](https://tile38.com/) server.

## Table of Contents

- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Deployment](#deployment)
  - [Tile38 Server](#tile38-server)
  - [Grafana and Prometheus](#grafana-and-prometheus)
- [Monitoring](#monitoring)
- [License](#license)

## Requirements

- Docker
- Google Cloud Platform account and project
- Google Cloud SDK (gcloud CLI)
- kubectl

## Getting Started

1. Clone the repository:
```sh
git clone https://github.com/yourusername/gfas.git
cd gfas
```


2. Configure your GCP project:

```sh
gcloud config set project your-project-id
gcloud config set compute/zone your-compute-zone
```

## Deployment

### Tile38 Server

You need to have the GCP service account key generated (eg. in `json` format) and environment variable with the key exported:

```sh
export GOOGLE_APPLICATION_CREDENTIALS=gfas_key.json
```

Than just run the `deploy.sh` script:

```sh
chmod +x deploy.sh
./deploy.sh
```

The deployment script will deploy the tile32 server on GPC cluster together with Prometheus and Grafana and prints IP adress of the cluster.

Example:
```sh
kubernetes_cluster_host = "34.118.155.147"
kubernetes_cluster_name = "my_project-384211-gke"
primary_subnet_name = "my_project-384211-subnet"
primary_vpc_name = "my_project-384211-vpc"
```

## Destroying

To destroy the cluster just run:

```sh
./deploy.sh -d
```


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.