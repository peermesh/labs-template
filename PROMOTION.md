# Labs → Core Promotion

## Overview
This document describes the process for promoting PeerMesh Labs projects into the core PeerMesh organization.

## Preconditions
Before a Labs project can be promoted to Core:

- [ ] **MVP Complete**: Project matches the PRD.md specifications
- [ ] **Documentation**: README is clear, runnable, and complete
- [ ] **Testing**: CI passes with meaningful test coverage
- [ ] **Code Quality**: Clean commit history, follows project standards
- [ ] **Security Review**: No exposed secrets, proper input validation
- [ ] **Performance**: Meets performance requirements if applicable

## Promotion Steps

### 1. Prepare for Promotion
- Ensure all preconditions are met
- Clean up any experimental or unused code
- Update documentation to production standards
- Review and consolidate dependencies

### 2. Open Cross-Org PR
```bash
# From your labs repository
git remote add core https://github.com/peermesh/<target-core-repo>.git
git fetch core
git checkout -b promote-to-core
git push origin promote-to-core

# Open PR from peermesh/labs-<project>@promote-to-core 
# into peermesh/<core-repo>@main (or feature branch)
```

### 3. Review Process
- Request review from core maintainers
- Ensure all CI checks pass in the target repository
- Address any feedback or requested changes
- Confirm authorship is preserved (no squashing by others)

### 4. Merge and Integration
- Merge when approved by required reviewers
- Update any integration points or dependencies
- Archive or update the Labs repository status
- Announce the promotion to the team

## Important Notes

### Authorship Preservation
- **Critical**: All commit authors must be preserved
- Interns retain credit for their contributions
- Use merge commits or rebase, not squash (unless author agrees)

### Cross-Org PRs
- GitHub supports PRs between organizations
- Authorship metadata travels with commits
- Review history is preserved

### Core Repository Standards
- Core repos typically require 2+ reviews
- Stricter CI/CD requirements
- Additional security and performance checks
- May require architectural review for large changes

## Post-Promotion

### Labs Repository
After successful promotion:
1. Update README with promotion notice
2. Archive repository if no longer needed
3. Or continue development for v2 features

### Documentation Updates
- Update core documentation to include new feature
- Add migration guides if replacing existing functionality
- Update API documentation if applicable

## Support
For questions about the promotion process:
- Open an issue in the Labs repository
- Contact @peermesh/maintainers team
- Review previous successful promotions as examples