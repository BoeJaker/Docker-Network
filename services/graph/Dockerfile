FROM python:latest

RUN pip install flask docker

COPY graph.py /graph.py
COPY templates/ /templates

ENTRYPOINT [ "python", "/graph.py" ]