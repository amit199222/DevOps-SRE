
FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app
RUN useradd --system --uid 65532 --no-create-home appuser
COPY --chown=65532:65532 app/ ./app/


USER 65532


EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/healthcheck', timeout=3)" || exit 1

CMD ["python", "-u", "app/app.py"]
