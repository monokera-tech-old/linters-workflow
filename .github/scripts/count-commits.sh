#!/bin/bash -e
# **********************************
# ** Return the count number of   **
# ** commits between two branches **
# **                              **
# ** Date  : 05/10/2021           **
# ** Author: Monokera DevOps Team **
# **********************************

EVENT_NAME="${EVENT_NAME:-pull_request}"
BRANCH_REF="${BRANCH_REF:-test}"
BRANCH_BASE_REF="${BRANCH_BASE_REF:-main}"

IS_PULL_REQUEST=$([[ "pull_request" == "${EVENT_NAME}" ]] && echo "true" || echo "false")
echo "--> IS_PULL_REQUEST: [${IS_PULL_REQUEST}]!"
echo "::set-output name=is-pull-request::${IS_PULL_REQUEST}"

FETCH_DEPTH='2'
COMMITS_COUNT='1'
if [ "${IS_PULL_REQUEST}" = true ] ; then
  git checkout "${BRANCH_BASE_REF}"
  git checkout "${BRANCH_REF}"

  COMMITS_COUNT=$(git rev-list --count "${BRANCH_REF}" "^${BRANCH_BASE_REF}")
  FETCH_DEPTH="$((COMMITS_COUNT + 1))"
fi

echo "--> FETCH_DEPTH: [${FETCH_DEPTH}]!"
echo "::set-output name=fetch-depth::${FETCH_DEPTH}"

echo "--> COMMITS COUNT: [${COMMITS_COUNT}]!"
echo "::set-output name=commits-count::${COMMITS_COUNT}"

exit 0
