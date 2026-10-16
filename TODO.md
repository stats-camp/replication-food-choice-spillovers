# Validation status and remaining items

Validated 2026-10-15 against Stata 19.5 (`semipar` 1.3): the unchanged
`APRS_tables.do` runs; 92 of 92 `lincom` rows and 33 of 34 regressions equal.

- [ ] **Collinear-variable choice in `regress`.** Stata omits `_Irace_4` in
  the Table 3 regression (`xi: reg grape incentive i.strata i.table_s i.grade
  i.sex i.race i.lunch, cl(cluster)`); the engine omits `_Irace_6`. Stata's
  rule behaves like a pivoted sweep on the largest remaining diagonal after
  the constant (order-independent); the engine drops the later variable.
- [ ] `tab` should print numeric row values in the variable's display format
  (`.1111111`, not `0.11111111`).
- [ ] Factor-variable coefficient rows in Stata's nested layout without base
  rows.
- [x] Figures 2–3: `clpattern()` styles the `lpolyci` fit line, the canvas
  keeps Stata's proportions (overlapping axis labels are blanked, ticks kept)
  and the legend has two columns (2026-10-15). Renderings are compared in
  `aea_replication/figure_comparison.html` in the main repository.
- [ ] Verify the browser build separately.
