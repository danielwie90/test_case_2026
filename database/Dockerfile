FROM mcr.microsoft.com/mssql/server:2022-latest AS prod-image

USER root
ENV ACCEPT_EULA="Y"
ENV DOCKERIZE_VERSION=v0.6.1
ENV USER_NAME="sa"

# Create directory for scripts
RUN mkdir -p /usr/src/app

# Copy the SQL script
COPY Script.PostDeployment.sql /usr/src/app/

# Copy the entrypoint script
COPY entrypoint.sh /usr/src/app/

# Make the entrypoint script executable
RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 1433

# Set the entrypoint
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]