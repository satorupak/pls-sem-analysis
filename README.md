# PLS-SEM Code Review Repository

This repository is intended **for code review only**. It is not packaged as a reproducible or ready-to-run analysis environment.

## Files

- `pls_sem_analysis.R` — the R analysis script submitted for review.
- `dummy_data.xlsx` — a synthetic/dummy Excel workbook that mirrors the **column structure** of the confidential source dataset and contains only artificial example values.
- `.gitignore` — helps prevent accidental upload of the original confidential workbook.

## Important data note

The original Excel dataset is confidential and is **not included in this repository**.

`dummy_data.xlsx` contains the same column headers/structure as the source workbook, but its rows contain randomly generated dummy values. It should not be interpreted as real study data and should not be used to reproduce or validate the study results.

## Local file paths in the R script

The R script contains file paths that point to directories on the original author's local computer, for example paths beginning with `C:/Users/...`.

These paths have intentionally been left unchanged because this repository is being shared for **code review rather than execution**. Anyone wishing to run the script would need to replace those paths with locations available on their own system and provide the required local dependencies/data.

## Reproducibility note

This repository is **not intended to reproduce the original results**. Its purpose is to let a reviewer inspect the R code while protecting the confidential source data.
