FROM apache/superset:latest


USER root

# Upgrade pip (optional)
RUN pip install --upgrade pip

# Copy your LGS configuration into Superset's pythonpath
COPY superset_config.py /app/pythonpath/superset_config.py

USER superset

# Automatic setup on Render startup (for Render free)
CMD superset db upgrade && \
    superset fab create-admin \
      --username ${ADMIN_USERNAME:-admin} \
      --password ${ADMIN_PASSWORD:-admin} \
      --firstname Admin \
      --lastname User \
      --email admin@lgs.com && \
    superset init && \
    /usr/bin/run-server.sh
