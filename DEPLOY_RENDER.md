# Render deployment

This package is prepared as one Docker web service:
- React frontend is built during the Docker build.
- FastAPI serves the React build.
- API and WebSocket use the same public domain.
- The default generator runs on CPU and does not require CUDA/PyTorch.

## Steps
1. Push this repository to GitHub.
2. In Render choose **New -> Blueprint**.
3. Select the GitHub repository.
4. Render reads `render.yaml` and creates the service.
5. Wait for the build/deploy to finish.
6. Open the generated `https://...onrender.com` URL.

The free web service can sleep after inactivity, so the first request after idle time may be slower.
