# go-web-app

## Run the go web app locally
go build -o main .
./ main

app will run on port 8081 : http://localhost:8081/courses

## Creating Dockerfile
Containerizing the go app (Multi Stage Docker Build)

FROM golang:1.23 AS base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o /main .

#first stage - dirtroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8081

CMD [ "./main" ]

Aim is to create docker image more secure and of reduced size using distroless image

Docker Build - docker build -t archichaudhari/go-web-app .

Docker Run - docker run -p 80801:80801 -it archichaudhari/go-web-app:v1

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Writing Kubernetes Manifest

Create Folder k8s -> 
                manifests ->
                  deployment.yaml
                  service.yaml
                  ingress.yaml (host based ingress)

To validate kuernetes manifests we will need kuernetes cluster

Using EKS with EC2 instance to create kubernetes cluster

## Authenticate AWS with local machine using access keys

eksctl create cluster --name demo-cluster --region us-east-1

We can directly deploy the application as pod but it will not create replica sets.
 
