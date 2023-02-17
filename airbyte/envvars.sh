# This file only contains Docker relevant variables.
#
# Variables with defaults have been omitted to avoid duplication of defaults.
# The only exception to the non-default rule are env vars related to scaling.
#
# See https://github.com/airbytehq/airbyte/blob/master/airbyte-config/models/src/main/java/io/airbyte/config/Configs.java
# for the latest environment variables.
#
# # Contributors - please organise this env file according to the above linked file.


### SHARED ###
export VERSION=0.39.0-alpha

# When using the airbyte-db via default docker image
export CONFIG_ROOT=/data
export DATA_DOCKER_MOUNT=airbyte_data
export DB_DOCKER_MOUNT=airbyte_db

# Workspace storage for running jobs (logs, etc)
export WORKSPACE_ROOT=/tmp/workspace
export WORKSPACE_DOCKER_MOUNT=airbyte_workspace

# Local mount to access local files from filesystem
# todo (cgardens) - when we are mount raw directories instead of named volumes, *_DOCKER_MOUNT must
# be the same as *_ROOT.
# Issue: https://github.com/airbytehq/airbyte/issues/578
export LOCAL_ROOT=/tmp/airbyte_local
export LOCAL_DOCKER_MOUNT=/tmp/airbyte_local
# todo (cgardens) - hack to handle behavior change in docker compose. *_PARENT directories MUST
# already exist on the host filesystem and MUST be parents of *_ROOT.
# Issue: https://github.com/airbytehq/airbyte/issues/577
export HACK_LOCAL_ROOT_PARENT=/tmp


### DATABASE ###
# Airbyte Internal Job Database, see https://docs.airbyte.io/operator-guides/configuring-airbyte-db
export DATABASE_USER=docker
export DATABASE_PASSWORD=docker
export DATABASE_HOST=db
export DATABASE_PORT=5432
export DATABASE_DB=airbyte
# translate manually DATABASE_URL=jdbc:postgresql://${DATABASE_HOST}:${DATABASE_PORT}/${DATABASE_DB} (do not include the username or password here)
export DATABASE_URL=jdbc:postgresql://db:5432/airbyte
export JOBS_DATABASE_MINIMUM_FLYWAY_MIGRATION_VERSION=0.29.15.001

# Airbyte Internal Config Database, defaults to Job Database if empty. Explicitly left empty to mute docker compose warnings.
export CONFIG_DATABASE_USER=
export CONFIG_DATABASE_PASSWORD=
export CONFIG_DATABASE_URL=
export CONFIGS_DATABASE_MINIMUM_FLYWAY_MIGRATION_VERSION=0.35.15.001

### AIRBYTE SERVICES ###
export TEMPORAL_HOST=airbyte-temporal:7233
export INTERNAL_API_HOST=airbyte-server:8001
export WEBAPP_URL=http://localhost:8000/
# Although not present as an env var, required for webapp configuration.
export API_URL=/api/v1/


### JOBS ###
# Relevant to scaling.
export SYNC_JOB_MAX_ATTEMPTS=3
export SYNC_JOB_MAX_TIMEOUT_DAYS=3
export JOB_MAIN_CONTAINER_CPU_REQUEST=
export JOB_MAIN_CONTAINER_CPU_LIMIT=
export JOB_MAIN_CONTAINER_MEMORY_REQUEST=
export JOB_MAIN_CONTAINER_MEMORY_LIMIT=


### LOGGING/MONITORING/TRACKING ###
export TRACKING_STRATEGY=segment
# Although not present as an env var, expected by Log4J configuration.
export LOG_LEVEL=INFO
# Although not present as an env var, helps Airbyte track job healthiness.
export SENTRY_DSN="https://d4b03de0c4574c78999b8d58e55243dc@o1009025.ingest.sentry.io/6102835"


### APPLICATIONS ###
# Scheduler #
# Relevant to scaling.
export SUBMITTER_NUM_THREADS=10

# Worker #
# Relevant to scaling.
export MAX_SYNC_WORKERS=5
export MAX_SPEC_WORKERS=5
export MAX_CHECK_WORKERS=5
export MAX_DISCOVER_WORKERS=5


### FEATURE FLAGS ###
export NEW_SCHEDULER=false
export AUTO_DISABLE_FAILING_CONNECTIONS=false
export EXPOSE_SECRETS_IN_EXPORT=false
export FORCE_MIGRATE_SECRET_STORE=false