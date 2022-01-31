#!/bin/bash -e
# ****************************************
# ** Lint the last DIFF Commit messages **
# ** from PR branches                   **
# **                                    **
# ** Date  : 31/01/2022                 **
# ** Author: Monokera DevOps Team       **
# ****************************************

BRANCH_REF="${BRANCH_REF:-test}"
BRANCH_BASE_REF="${BRANCH_BASE_REF:-main}"

git checkout "${BRANCH_BASE_REF}"
git checkout "${BRANCH_REF}"
COMMIT_MESSAGES=$(git log --oneline --pretty=format:%s "${BRANCH_REF}" "^${BRANCH_BASE_REF}" | tr ' ' '_*_' | tr '\n' ' ')
for commit_message in ${COMMIT_MESSAGES}; do
  cleaned_commit_message="$(echo "${commit_message}" | tr '_*_' ' ' )"
  echo "--> Linting commit message [${cleaned_commit_message}]..."
  echo "${cleaned_commit_message}" | commitlint
  test $? -eq 0 || exit 1
done

exit 0
