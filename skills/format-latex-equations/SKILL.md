---
name: format-latex-equations
description: Apply the user's LaTeX equation conventions for inline math delimiters, display environments, inequalities, differentials, fractions, substack line breaks, and paragraph hard wrapping. Use whenever writing, editing, converting, or reviewing mathematical LaTeX, including equations in Markdown, TeX documents, explanations, derivations, and generated documents or slides.
---

# Format LaTeX Equations

Apply these conventions consistently to every mathematical expression in scope.

## Inline Math

- Use `$...$` for inline math.
- Do not use `\(...\)` for inline math.

Example: write `$P_x(1,1)$`, not `\(P_x(1,1)\)`.

## Displayed Equations

- Use `\begin{equation*}` and `\end{equation*}` for centered displayed equations that are not labeled.
- Keep labeled centered displayed equations in `equation` with `\label{...}`.
- Use structured environments such as `align`, `align*`, or `gather*` when alignment or multiple lines are needed.
- Do not use `\[...\]` for centered displayed equations in TeX documents.

## Inequalities

- Use `\le` and `\ge` for inequality symbols.
- Do not use `\leq` or `\geq`.

Example: write `$x \le y$` and `$x \ge y$`.

## Paragraph Wrapping

- Do not insert manual newlines inside the same prose paragraph in TeX documents.
- Preserve blank lines between paragraphs and preserve line breaks required by TeX syntax, environments, displayed equations, tables, and explicit `\\` line breaks.

## Differentials

- Typeset the differential operator as `\mathrm d`.
- Do not use a bare italic `d` as the differential operator.
- Preserve any surrounding spacing unless the user specifies a separate spacing convention.

Example: write `\int f(x) \mathrm d x`, not `\int f(x) d x`.

## Fractions

- Use `\frac` only when the numerator and denominator are each a single atomic symbol, such as one digit, one Latin letter, or one named Greek symbol.
- Keep this form compact and omit braces when TeX permits it.
- Write examples such as `\frac12` and `\frac e\pi`.
- For every other fraction, use grouped `{numerator\over denominator}` syntax instead of `\frac`.

Examples:

- Write `{a+b\over c}`, not `\frac{a+b}{c}`.
- Write `{x\over y+z}`, not `\frac{x}{y+z}`.
- Write `{\sin x\over 2\pi}`, not `\frac{\sin x}{2\pi}`.

## Substack line breaks

- When writing `\substack`, put a space after each `\\` line break before the next row starts.
- This is especially important in Markdown math renderers, where `\\p` can render less reliably than `\\ p`.

Example: write `\substack{p\mid x\\ p>2}`, not `\substack{p\mid x\\p>2}`.

## Verification

Before returning mathematical LaTeX:

1. Use `$...$` for inline math, not `\(...\)`.
2. Use `equation*` for centered displayed equations that are not labeled; do not use `\[...\]` in TeX documents.
3. Use `\le` and `\ge`, not `\leq` or `\geq`.
4. Avoid manual newlines inside the same prose paragraph while preserving TeX syntax line breaks.
5. Replace each differential operator with `\mathrm d`.
6. Inspect every fraction.
7. Retain `\frac` only when both operands are single atomic symbols.
8. Convert all remaining fractions to grouped `{\over}` form.
9. In every `\substack`, insert a space after each `\\` line break.
