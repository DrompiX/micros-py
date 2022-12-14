FROM python:3.10.7-slim-buster

ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apt-get update && apt-get -y dist-upgrade
RUN pip3 install pipenv==2022.7.4

COPY Pipfile .
COPY Pipfile.lock .

RUN pipenv install --deploy --clear --system --ignore-pipfile;

# Transfer code
WORKDIR /app

COPY docker-entrypoint.sh .
COPY microspy microspy

ENTRYPOINT [ "/app/docker-entrypoint.sh" ]