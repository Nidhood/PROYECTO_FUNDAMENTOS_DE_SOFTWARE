FROM cockroachdb/cockroach:latest

WORKDIR /app

COPY . .

EXPOSE 80

CMD [ "cockroach", "start-single-node", "--insecure", "--listen-addr=localhost:26257", "--http-addr=localhost:8080" ]