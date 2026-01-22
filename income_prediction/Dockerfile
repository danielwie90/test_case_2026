FROM ubuntu:22.04 AS prod-image

WORKDIR /src

COPY income_api_client-1.0.0-py3-none-any.whl requirements.txt ./
RUN apt-get -y update && \
    apt-get -y install python3.10 python3-pip && \
    apt-get clean && \
    rm -rf /var/apt/lists/*

RUN python3.10 -m pip install --upgrade pip && \
    python3.10 -m pip install -r requirements.txt

COPY helper_functions.py model_bp.py app.py wsgi.py ./

CMD ["/bin/sh", "-c", "gunicorn --bind=0.0.0.0:7000 --preload wsgi:app"]
EXPOSE 7000
