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