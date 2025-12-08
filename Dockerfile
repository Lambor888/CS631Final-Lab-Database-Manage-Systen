FROM python:3.10-slim as builder
WORKDIR /code
COPY requirements.txt /code/
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

FROM python:3.10-slim
WORKDIR /code
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY . /code

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]