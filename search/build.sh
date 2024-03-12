#!/usr/bin/env bash

install_meilisearch() {
    # Check Platform.sh variable, to vary installation based on local v. Platform.sh
    echo "* INSTALLING MEILISEARCH"
    # Replicates Meilisearch download (https://github.com/meilisearch/MeiliSearch/blob/master/download-latest.sh) with locked version.
    release_file="meilisearch-linux-amd64"
    curl -OL "https://github.com/meilisearch/MeiliSearch/releases/download/$MEILISEARCH_VERSION/$release_file"
    mv "$release_file" "meilisearch"
    chmod 744 "meilisearch"
}

setup_venv(){
    echo "* SETTING UP POETRY VENV"
     # Fail the build if any errors occur
    set -eu

    # Download the latest version of pip
    python3.11 -m pip install --upgrade pip

    # Install and configure Poetry
    export PIP_USER=false
    curl -sSL https://install.python-poetry.org | python3 -
    # Update PATH to make Poetry available in this hook
    export PATH="/app/.local/bin:$PATH"
    export PIP_USER=true

    # Install dependencies
    poetry install --no-root
}

install_meilisearch
setup_venv
