FROM node:20-alpine AS frontend-build
WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm ci

COPY frontend/ ./
RUN npm run build

FROM python:3.11-slim
WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*

COPY backend/requirements_deploy.txt ./backend/requirements_deploy.txt
RUN pip install --no-cache-dir -r backend/requirements_deploy.txt

COPY backend/ ./backend/
COPY --from=frontend-build /app/frontend/build ./frontend/build/

WORKDIR /app/backend
EXPOSE 10000

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-10000}"]
