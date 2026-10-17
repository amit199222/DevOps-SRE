
FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

# Create a non-root user
RUN useradd --system --uid 65532 --no-create-home appuser

# Copy only the application code
#COPY --chown=appuser:appgroup app/ ./app/
COPY --chown=65532:65532 app/ ./app/

# Run without root privileges
#USER appuser
USER 65532

# Health-check HTTP server listens on port 8080
EXPOSE 8080

CMD ["python", "-u", "app/app.py"]
