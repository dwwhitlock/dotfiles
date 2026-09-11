# code/ — Repo Index

This directory holds all repos worked on for Clinician Nexus (`clinician-nexus` GitHub org) plus a few personal/vendor ones. Descend into a repo's directory to work on it — most have their own CLAUDE.md/README with details.

**Owner** column: `cn` = owned by the `clinician-nexus` GitHub org, `me` = personal (no org remote / personal use), `external` = third-party/vendor repo (fork or clone, not ours to push to).

## Working Conventions

- Before starting work in any repo, pull the latest `main` (or default branch) first.
- If a feature branch is already in progress, ask whether to rebase it onto the latest `main` before continuing work — don't do it silently.
- Run `./status.sh` (add `--fetch` for live ahead/behind counts) from this directory to see branch/dirty/ahead-behind state across every repo before picking up new work.
- On the first operation in a session at this level, do a fast check (e.g. list directories with a `.git` folder) for repos not yet listed in this index. If any are found: run `zseed` directly (no need to ask), then flag the new repos and ask whether to add them to this index.

## Navigation

`zoxide` is installed and pre-seeded with every repo here, so jump by fragment instead of typing paths:

```
z dwb ui     # -> ~/code/app-dwb-ui
z kb         # -> ~/code/platform-kb
z dwb db     # extra keywords disambiguate
```

`zseed` re-seeds the database from `~/code`. It is a script on `PATH` (`personal/dotfiles/bin/zseed`), not a shell function, so Claude can run it directly.

## This File

`CLAUDE.md` and `status.sh` are symlinks into `personal/dotfiles/code/` so they stay version-controlled. Edit them in place — the symlink resolves. `personal/dotfiles/setup/create_links` recreates the symlinks on a new machine.

## Core Applications

| Repo | Owner | Description |
|---|---|---|
| `app-bm-service` | cn | Benchmarks app — backend service. |
| `app-bm-data` | cn | Benchmarks app — data layer. |
| `app-cm` | cn | Compensation Management app — Go backend + Svelte frontend. |
| `app-cm-proto` | cn | Protobuf schemas for app-cm (Buf Schema Registry). |
| `app-dwb-db` | cn | Data Workbench (DWB) — Postgres schema/migrations for the healthcare compensation data platform. |
| `app-dwb-service` | cn | Data Workbench — backend service (local Kafka via Docker Compose, KRaft mode). |
| `app-dwb-ui` | cn | Data Workbench — frontend UI. |
| `app-mpt-ui` | cn | MPT application UI. |
| `app-mpt-data` | cn | MPT data objects. |
| `app-mpt-sql-db` | cn | MPT — SQL Server 2019 container/databases. |
| `app-mpt-api-data-elt` | cn | MPT API data ELT. |
| `app-ins360-sql-db` | cn | Legacy CIAI/Insight360 SQL database (Workforce, Client Portal, PNA, Benchmark apps). |
| `app-ins360-sql-script` | cn | Legacy Insight360 SQL scripts. |
| `app-ins360-sql-ssis` | cn | Legacy Insight360 SSIS packages. |
| `app-pna-sql-db` | cn | PNA SQL project. |
| `app-sc-consulting-service` | cn | SC consulting service. |
| `app-shared-protobuffs` | cn | Shared protobuf schemas (Buf Schema Registry, SSO-gated). |
| `app-survey-references` | cn | Survey references app (from GitHub template). |
| `ces` | cn | CES app. |
| `ces-form990-workflow` | cn | Serverless (SAM) workflow for Form 990 processing. |

## Surveys & Submission Pipelines

| Repo | Owner | Description |
|---|---|---|
| `survey-submission` | cn | Survey submission pipeline. |
| `etl-survey-submission` | cn | ETL: source-oriented → domain-oriented survey submission data. |
| `submission-status-lib` | cn | Python lib for reporting submission status. |
| `submission-status-protobuf` | cn | Deprecated — migrated into `data-platform-proto`. |
| `survey-cuts-etl-jobs` | cn | Databricks workflow infra for building/populating `survey_cuts` tables. |
| `surveys-large-clinic-physician` | cn | Large clinic physician survey (from GitHub template). |
| `benefits-ingestion` | cn | Ingestion of 2024/2025 Benefits survey data into Databricks. |
| `data-dictionary` | cn | Enriches CES data dictionary with business context from survey docs. |
| `data-platform-survey-to-file-type1` | cn | Transforms external survey formats into internal File Type 1. |
| `filtered-incumbent-to-ft1` | cn | Filtered incumbent data → File Type 1. |
| `data-platform-file-type1` | cn | File Type 1 definitions/tooling. |

## Data Platform / ETL

| Repo | Owner | Description |
|---|---|---|
| `dp-commons` | cn | Shared Python library for data platform (DBR-agnostic). |
| `data-quality-framework` | cn | Data quality framework for pipelines. |
| `great_expectations_suites` | cn | Scripts to generate/update Great Expectations suites. |
| `data-exchange-framework` | cn | File API integration/testing framework. |
| `file-api` | cn | Service governing file uploads for Databricks ingestion. |
| `file-registration` | cn | File registration. |
| `data-platform-simple-integration-service` | cn | Simple Integration/Data Mapping Service. |
| `data-platform-proto` | cn | Shared protobufs for data platform. |
| `protobuf-utils` | cn | Python lib for Protobuf classes + Buf Schema Registry. |
| `dxf-e2e-tests` | cn | E2E tests: file submission → Domain Oriented Database. |
| `red-stapler` | cn | Data ingestion/transformation pipeline platform. |
| `benchmarks-etl-job` | cn | ETL for Benchmarks 2.0. |
| `cms-data-pipeline` | cn | CMS (Medicare & Medicaid) data pipeline. |
| `epi-livingwage-scraper` | cn | Scraper/pipeline for EPI Living Wage data. |
| `irs990-scraper` | cn | Scrapes IRS Form 990 XML bulk data into Databricks Delta. |
| `etl-organization-financial-data` | cn | ETL for organization financial data. |
| `fmv-letter-automation` | cn | FMV letter automation (Physician Workforce). |
| `deidentification` | cn | De-identification pipeline. |
| `reltio-data-mastering` | cn | Data mastering/export to and from Reltio. |
| `reltio-hubspot-sync` | cn | Streams entity changes from Reltio to HubSpot. |
| `databricks-reltio-etl` | cn | ETL between Databricks and Reltio. |
| `pna_claims_ingestion` | cn | PNA claims ingestion (from GitHub template). |
| `workforce-metrics-manager` | cn | Workforce Metrics Manager data pipelines. |
| `workforce-analytics-view-replication` | cn | Captures SQL Server view changes with SCD Type 2 history/point-in-time recovery. |
| `project_tracking_integrations` | cn | Integrations between Notion, Azure DevOps, GitHub, Smartsheet. |
| `redshift-to-databricks-migration` | cn | Notebooks/SQL for Redshift → Databricks migration. |

## Databricks Platform & Apps

| Repo | Owner | Description |
|---|---|---|
| `databricks-apps-cliniciannexus` | cn | Template for Databricks Apps w/ team best practices. |
| `databricks-apps-cookiecutter-template` | cn | Cookiecutter hub template for Databricks Apps monorepos. |
| `databricks-apps-executive-workforce` | cn | Home-base repo for Executive Workforce Databricks Apps. |
| `databricks-function-registry` | cn | Databricks function registry. |
| `databricks-group-analysis` | cn | Group analysis (from GitHub template). |
| `databricks-table-clone` | cn | GitHub Action to clone tables between workspaces. |
| `databricks-template` | cn | Generic Databricks project template. |
| `databricks_recon` | cn | AWS recon tool for Databricks security incident investigation. |
| `dbdemos` | external | (Vendor) Databricks Lakehouse demo installer toolkit — upstream `databricks-demos/dbdemos`. |
| `dbsql_sme` | external | (Vendor/fork) Databricks SQL SME resources — upstream `CodyAustinDavis/dbsql_sme`. |

## Infrastructure / DevOps / IaC

| Repo | Owner | Description |
|---|---|---|
| `aws-core` | cn | AWS Core policies and permissions. |
| `aws-information-site` | cn | Artifacts for the AWS Information Site "gather" step. |
| `airbyte-iac` | cn | IaC for Airbyte (AWS, Databricks, Airbyte resources). |
| `bi-platform-devops-iac` | cn | IaC for the Business Intelligence Platform. |
| `data-platform-devops-iac` | cn | IaC for data platform (bastion EC2, etc.). |
| `data-platform-iac` | cn | Core data platform IaC. |
| `development-devops-iac` | cn | IaC managed by CN Development Team. |
| `shared-services-iac` | cn | IaC for shared services tooling. |
| `shared-storage-iac` | cn | Terraform for shared storage + GitHub OIDC/AWS integration. |
| `infra-cluster-resources` | cn | Terraform for cluster infrastructure resources. |
| `kubernetes` | cn | Source of truth for the Clinician Nexus Kubernetes platform. |
| `devops-incidents` | cn | Incident reports/templates tracked by DevOps team. |
| `finops` | cn | IaC + Databricks components for cloud cost visibility/optimization. |
| `finops-cost-tracker` | cn | Multi-cloud cost dashboard (AWS Cost Explorer, etc.). |
| `bug_bounty` | cn | Internal security/reliability bug-bounty event for the Databricks platform. |

## Platform Engineering / Tooling

| Repo | Owner | Description |
|---|---|---|
| `platform-github` | cn | Control plane for the `clinician-nexus` GitHub org (repos, teams, environments, apps). |
| `platform-access-requests` | cn | `pad` — self-service AD access group management via PRs. |
| `platform-engineering-hub` | cn | Internal Platform Engineering updates/decks/roadmap site (PR-driven). |
| `platform-kb` | cn | Canonical version-controlled platform team knowledge base. |
| `platform-utils` | cn | Typer-based CLI utilities for various platforms. |
| `ci_tools` | cn | Reusable CI components and examples. |
| `sonatype_to_codeartifact` | cn | Migration tooling: Sonatype → AWS CodeArtifact. |
| `gh_cloner` | me | Ad-hoc personal script for cloning GitHub repos (not a git repo itself). |

## Misc / Demos / Personal

| Repo | Owner | Description |
|---|---|---|
| `kafka-ui` | external | Vendor fork — upstream `kafbat/kafka-ui`. |
| `c3-streamlit` | cn | Streamlit app. |
| `chaos-day` | cn | Chaos day exercise repo. |
| `commitizen-demo` | cn | Commitizen demo. |
| `cn-ai-marketplace` | cn | Clinician Nexus Claude Code plugin marketplace (local repo, no remote configured yet). |
| `cn-dotfiles` | cn | Personal CLI configuration for CN AWS/dev tools (org-hosted). |
| `app-survey-analysis.bfg-report` | me | BFG repo-cleaner report output (dated folders), not a repo. |
| `personal/dotfiles` | me | Personal shell/dotfiles config, no org remote. |
| `personal/cn-dotfiles` | me | Personal CN-specific dotfiles/aliases/scripts, no org remote. |
| `scratch` | me | Scratch space, not a repo. |

## Notes

- A few repos (`kafka-ui`, `dbdemos`, `dbsql_sme`) are external/vendor forks — don't push to `origin` on these without setting up your own fork/remote first.
- Several `cn`-owned repos are freshly cloned from a shared GitHub template and still contain template boilerplate READMEs (`app-survey-references`, `databricks-group-analysis`, `databricks-template`, `pna_claims_ingestion`, `surveys-large-clinic-physician`).
- Previously, several repos' `origin` remotes had a GitHub OAuth token embedded directly in the URL; these have been scrubbed and switched to SSH (`git@github.com:...`) form.
