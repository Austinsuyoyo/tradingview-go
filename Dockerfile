# build stage
FROM golang:alpine AS build-env
ADD . /src
RUN cd /src && go build -o app

# final stage
FROM alpine
RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo "Asia/Taipei" > /etc/timezone
WORKDIR /app
COPY --from=build-env /src/app /app/
ENTRYPOINT ./app