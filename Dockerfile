# ---- Build stage: nothing to compile, but keeps the final image minimal ----
FROM nginx:1.27-alpine

# Drop the default nginx landing page
RUN rm -rf /usr/share/nginx/html/*

# Copy the app
COPY index.html /usr/share/nginx/html/index.html

# Custom nginx config: gzip, caching, and a health endpoint
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
