# Replication: Incentives and Unintended Consequences: Spillover Effects in Food Choice

Manuela Angelucci, Silvia Prina, Heather Royer, and Anya Samek — American
Economic Journal: Economic Policy (2019).

This repository preserves the paper's official replication data and analysis
file for [stats.camp](https://stats.camp). The original commands remain in
place, including commands that stats.camp does not implement yet.

**Open in stats.camp:**
[APRS_tables.do](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-food-choice-spillovers.git&file=APRS_tables.do)

## The study

The authors ran a field experiment in school lunchrooms in which children
chose between grapes and cookies. The experiment independently varied whether
a child received an incentive to choose grapes, the proportion of peers who
received that incentive, and whether peers could observe who was incentivized.
The analysis separates the direct effect of incentives from spillovers caused
by peers' choices and by observing peers' incentives.

## Contents

| Path | Description |
| --- | --- |
| `APRS_tables.do` | Original analysis for main Tables 1–4 and 6, Appendix Tables B1–B4, and Figures 2–3 |
| `APRS_data.dta` | Authors' analysis dataset: 1,631 observations and 31 variables |
| `APRS-READ-ME.txt` | Authors' original 124-byte package note |

## What runs

The package was tested with the stats.camp engine on 2026-08-17. The original
dataset loads successfully, and the setup, generated variables, Table 1
cross-tabulation, summaries, loops, globals, logging, and
`preserve`/`keep`/`restore` workflow execute without adapting the do-file.

The complete analysis does not run in stats.camp yet. The original file is
kept unchanged so the remaining work is visible and can be implemented in the
engine rather than rewritten in the replication package:

- Tables require `xi:`, factor-variable interactions, `matrix`/`mat`,
  `testparm`, quiet blocks, clustered-option abbreviations, and the original
  coefficient-name abbreviations used by `lincom`.
- Figures 2 and 3 require the user-written `semipar` command and `twoway
  lpolyci`, including their estimation and confidence-band behavior.
- The original file contains 34 regressions, 80 `lincom` calls, and two
  semiparametric figures, so placeholder implementations would not be a
  faithful replication.

In Stata, the figure sections additionally require installation of the
community-contributed `semipar` package. The authors did not bundle that
package with the deposit.

## Changes from the original package

- `APRS_tables.do` and `APRS_data.dta` are byte-for-byte copies of the
  official AEA files. No command, path, variable, or data value was changed.
- The three substantive files were moved together from the archive's `data/`
  directory to the repository root. This preserves the original
  `use APRS_data, clear` command in stats.camp's repository-root working
  directory.
- The package note uses the current migrated deposit name
  `APRS-READ-ME.txt`; its contents are unchanged from the legacy AEA archive's
  `APRS READ ME.txt`.
- This README was added to document provenance and current compatibility.

Verified SHA-256 checksums:

| File | SHA-256 |
| --- | --- |
| `APRS_tables.do` | `f8ac1e8bda6feb01454215c409bca7ef37d424d895e62cc8f55de870f33c77fa` |
| `APRS_data.dta` | `9f3c575636f420dfd2b1eebc7640e169468d155dd396094f265026b541ad254e` |
| `APRS-READ-ME.txt` | `ff11ca73eec6c4c10e339988c79a45c82070acb8622e4239813faa131c0cd7bf` |

## Source and attribution

Angelucci, Manuela, Silvia Prina, Heather Royer, and Anya Samek. 2019.
"Incentives and Unintended Consequences: Spillover Effects in Food Choice."
*American Economic Journal: Economic Policy* 11 (4): 66–95.
[https://doi.org/10.1257/pol.20170588](https://doi.org/10.1257/pol.20170588)

The official replication deposit is distributed by the AEA Data and Code
Repository as version V1:
[https://doi.org/10.3886/E231586V1](https://doi.org/10.3886/E231586V1).
The original materials remain subject to the rights and terms stated by the
AEA and openICPSR. Please cite both the paper and the official replication
deposit when using these files.
