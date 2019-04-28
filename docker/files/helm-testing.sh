#!/bin/sh
set -e
set -o pipefail

WORKING_DIRECTORY="$PWD"
ACTION=$1

[ "$GITHUB_PAGES_REPO" ] || {
  echo "ERROR: Environment variable GITHUB_PAGES_REPO is required"
  exit 1
}
[ -z "$GITHUB_PAGES_BRANCH" ] && GITHUB_PAGES_BRANCH=gh-pages
[ -z "$HELM_CHARTS_SOURCE" ] && HELM_CHARTS_SOURCE="$WORKING_DIRECTORY/stable"
[ -d "$HELM_CHARTS_SOURCE" ] || {
  echo "ERROR: Could not find Helm charts in $HELM_CHARTS_SOURCE"
  exit 1
}
[ "$CIRCLE_BRANCH" ] || {
  echo "ERROR: Environment variable CIRCLE_BRANCH is required"
  exit 1
}

echo "GITHUB_PAGES_REPO=$GITHUB_PAGES_REPO"
echo "GITHUB_PAGES_BRANCH=$GITHUB_PAGES_BRANCH"
echo "HELM_CHARTS_SOURCE=$HELM_CHARTS_SOURCE"
echo "CIRCLE_BRANCH=$CIRCLE_BRANCH"


function checkout_gh_pages() {
  echo ">> Checking out $GITHUB_PAGES_BRANCH branch from $GITHUB_PAGES_REPO"
  mkdir -p /tmp/helm/publish && cd /tmp/helm/publish
  mkdir -p "$HOME/.ssh"
  ssh-keyscan -H github.com >> "$HOME/.ssh/known_hosts"
  git clone -b "$GITHUB_PAGES_BRANCH" "git@github.com:$GITHUB_PAGES_REPO.git" .
  helm repo add okgolove https://okgolove.github.io/helm-charts
}

function ct_run() {
  echo '>> Running chart testing'
  cd "$WORKING_DIRECTORY" && ct lint --remote origin --chart-yaml-schema /etc/ct/chart_schema.yaml --lint-conf /etc/ct/lintconf.yaml --validate-maintainers=false
}

function build() {
  echo '>> Building charts...'
  find "$HELM_CHARTS_SOURCE" -mindepth 1 -maxdepth 1 -type d | while read chart; do
    chart_name="`basename "$chart"`"
    echo ">>> helm package -u -d $chart_name $chart"
    mkdir -p "$chart_name"
    helm package -u -d "$chart_name" "$chart"
  done
  echo '>> helm repo index'
  helm repo index .
}

function publish() {
  echo ">> Publishing to $GITHUB_PAGES_BRANCH branch of $GITHUB_PAGES_REPO"
  git config user.email "$CIRCLE_USERNAME@users.noreply.github.com"
  git config user.name CircleCI
  git add .
  git status
  git commit -m "Published by CircleCI $CIRCLE_BUILD_URL"
  git push origin "$GITHUB_PAGES_BRANCH"
}

function main() {
  add_repos
  case "$ACTION" in
    ("ct") ct_run ;;
    ("build") checkout_gh_pages && build && publish ;;
  esac
}

main