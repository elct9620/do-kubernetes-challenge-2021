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

Demo URL: https://kube-challenge.aotoki.dev/

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

### Setup Cert-Manager for Let's Encrypt

Install Cert-Manager via Helm

```bash
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.6.1 \
  --set installCRDs=true
```

Configure issuer

```yaml
kubectl apply -f issuer.yml
```

> The email is masked, changed it before run the command

### Setup Application

Deploy application

```bash
kubectl apply -f deployments/cinema.yml
```

Create service

```bash
kubectl apply -f services/cinema.yml
```

Configure Ingress

```bash
kubectl apply -f ingress/cinema.yml
```

Add CronJob to refresh movies

```bash
kubectl apply -f jobs/cinema.yml
```

Trigger CronJob to initialize data

```bash
kubectl create job -n cinema --from=cronjob/cinema-refresh cinrma-movies-init
```

### Test API

```bash
curl https://kube-challenge.aotoki.dev/
```
