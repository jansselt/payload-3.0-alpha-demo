FROM ubuntu:23.10

ENV POSTGRES_PASSWORD docker
ENV POSTGRES_DB payload

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get install -y curl
RUN apt install -y postgresql postgresql-contrib

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN npm install -g pnpm

COPY * ./

RUN pnpm install
RUN pnpm build

EXPOSE 5432
EXPOSE 5309


CMD ["pnpm", "start", "-p 5309"]
