DigitalOcean Kubernetes Challenge 2021
===

This repository is created for DigitalOcean Kubernetes Challenge 2021.

## Roadmap

* [ ] Build a demo Ruby on Rails API Server
* [x] Create a Kubernetes Cluster in DigitalOcean
* [x] Create a scalable database on Kubernetes
* [ ] Import example data to demo application

## Detail

This is [Viewshow](https://www.vscinemas.com.tw/vsweb/) crawler as an API service for demo.

### Create Namespace

```bash
kubectl apply -f namespaces.yml
```

### Create Secrets

To create the database for the application, we need to set up PostgreSQL.

```yaml
# secrets/postgres.yml
apiVersion: v1
kind: Secret
metadata:
  name: cinema-database-secret
  namespace: cinema
type: Opaque
stringData:
  superUserPassword: [PASSWORD]
  replicationUserPassword: [PASSWORD]
```

> In this demo, the super password will be used for the application. Don't use it in a production application.

```bash
kubectl apply secrets/postgres.yml
```

Add `DATABASE_URL` as secret for application

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: cinema-secret
  namespace: cinema
type: Opaque
stringData:
  DATABASE_URL: postgres://postgres:[PASSWORD]@cinema-db.cinema.svc.cluster.local/cinema
```

### Setup Kubegres

Install Kubegres

```bash
kubectl apply -f https://raw.githubusercontent.com/reactive-tech/kubegres/v1.14/kubegres.yaml
```

Crreate Database in `cinema` namespace

```bash
kubectl apply -f databases/cinama.yml
```

Create database use `createdb` command in local machine

```bash
kubectl port-forward -n cinema service/cinema-db 5678:5432
```
