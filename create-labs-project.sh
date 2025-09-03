#!/bin/bash
# Script to create a new PeerMesh Labs project from template

set -e

# Check if project name and intern handle are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <project-name> <intern-github-handle>"
    echo "Example: $0 auth-service jdoe"
    exit 1
fi

PROJECT_NAME=$1
INTERN_HANDLE=$2
REPO_NAME="labs-${PROJECT_NAME}-${INTERN_HANDLE}"

echo "🚀 Creating new Labs project: ${REPO_NAME}"

# Create repository from template
echo "📦 Creating repository from template..."
gh repo create peermesh/${REPO_NAME} \
    --public \
    --template peermesh/labs-template \
    --description "PeerMesh Labs project: ${PROJECT_NAME} by @${INTERN_HANDLE}"

# Give teams appropriate permissions
echo "👥 Setting team permissions..."
gh api -X PUT orgs/peermesh/teams/maintainers/repos/peermesh/${REPO_NAME} \
    --field "permission=admin" > /dev/null

gh api -X PUT orgs/peermesh/teams/interns/repos/peermesh/${REPO_NAME} \
    --field "permission=push" > /dev/null

# Set up branch protection
echo "🔒 Configuring branch protection..."
gh api -X PUT repos/peermesh/${REPO_NAME}/branches/main/protection \
    --field "required_status_checks[strict]=true" \
    --field "required_status_checks[contexts][]=build" \
    --field "enforce_admins=false" \
    --field "required_pull_request_reviews[required_approving_review_count]=1" \
    --field "required_pull_request_reviews[dismiss_stale_reviews]=true" \
    --field "required_pull_request_reviews[require_code_owner_reviews]=true" \
    --field "allow_force_pushes=false" \
    --field "allow_deletions=false" \
    --field "required_linear_history=true" > /dev/null

# Add the intern as a collaborator
echo "🤝 Adding ${INTERN_HANDLE} as collaborator..."
gh api -X PUT repos/peermesh/${REPO_NAME}/collaborators/${INTERN_HANDLE} \
    --field "permission=push" > /dev/null 2>&1 || echo "Note: Could not add ${INTERN_HANDLE} - they may need to accept org invitation first"

echo "✅ Successfully created: https://github.com/peermesh/${REPO_NAME}"
echo ""
echo "Next steps for @${INTERN_HANDLE}:"
echo "1. Clone the repository: git clone https://github.com/peermesh/${REPO_NAME}.git"
echo "2. Update README.md with project details"
echo "3. Fill out PRD.md with project specifications"
echo "4. Create feature branch: git checkout -b feature/initial-setup"
echo "5. Start coding!"