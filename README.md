# Replication: Incentives and Unintended Consequences: Spillover Effects in Food Choice

Manuela Angelucci, Silvia Prina, Heather Royer, and Anya Samek — American
Economic Journal: Economic Policy (2019).

This repository preserves the paper's official replication data and analysis
file for [stats.camp](https://stats.camp). The original commands remain in
place; the whole script runs and its results equal Stata's (see below).

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

The whole unchanged script runs in stats.camp, including `xi:` with `##`
interactions, `qui {}` blocks, the `cl()` abbreviation, `testparm`, the
matrix construction, all 80 `lincom` calls with the authors' coefficient-name
shorthand, the user-written `semipar` (built into the engine) and `twoway
lpolyci`. On 2026-10-15 it was executed in Stata 19.5 (with `semipar` 1.3 from
SSC) and in the native engine on scratch copies: all 92 `lincom` result rows
and 33 of the 34 regressions are equal.

Remaining differences:

- In the Table 3 regression the sex and race dummies are jointly collinear
  (race and sex are both missing for the same 82 children). Stata omits
  `_Irace_4`; the engine omits `_Irace_6`, so the printed sex and race control
  coefficients differ while the fit and the `incentive` coefficient are the
  same. Stata's `regress` picks the omitted variable by a pivoted sweep rather
  than by list order.
- `tab table_incentive_pr incentive` prints the float row values with eight
  digits (`0.11111111`) instead of the variable's `%9.0g` (`.1111111`).
- Factor-variable rows are laid out differently (`0b` base rows,
  `c.table_incentive_pr#1.public` names versus Stata's nested
  `pub#incentive | 1 1` rows); the numbers are the same.
- Figures 2 and 3: the smoothed curves and bands have the same shape. Since
  2026-10-15 the `clpattern()` dashes style the fitted lines (bands solid),
  the figure keeps Stata's proportions, and the legend has Stata's two
  columns; where the ten `ylabel(.45(.05).9)` labels would overlap, the
  engine blanks the overlapping ones and keeps their ticks instead of
  overprinting them as Stata does. See `aea_replication/figure_comparison.html` in the main repository.

[TODO.md](TODO.md) tracks these items.

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
