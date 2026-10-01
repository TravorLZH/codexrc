---
name: format-c-code
description: Apply the user's C style conventions when writing, editing, or reviewing C source, headers, and code snippets. Covers indentation, spacing, braces, naming, struct declarations, and zero tests.
---

# Format C Code

Apply these personal conventions to C code in scope.

## Indentation and Line Length

- Use hard tabs for indentation and alignment, including continuation lines.
- Set tabstop to eight columns.
- Keep lines within 80 displayed columns after expanding tabs. Wrap long conditions and comments.

## Spacing and Braces

- Do not put a space before `(` in function calls, declarations, definitions, or control statements.
- Do not put spaces after commas in C syntax. Commas at the end of a line may be followed by a newline; macro continuation lines may have whitespace between the comma and the trailing `\`.
- Do not put spaces around assignment operators (`=`, `+=`, `-=`, and the other compound assignments) or comparison operators (`==`, `!=`, `<`, `>`, `<=`, and `>=`). Examples: `int count=0;`, `count+=step;`, and `if(count!=limit)`.
- Prefer compact arithmetic (`+`, `-`, `*`, `/`, and `%`) in simple expressions, such as `header+1` and `addr/PAGE_SIZE`. Use spaces when they improve readability in larger expressions, such as `(header->nfiles+1) * sizeof(struct inode)`. Preserve whitespace needed to keep separate operators from merging into a different token.
- Do not put spaces around the semicolons separating `for` clauses: `for(i=0;i<limit;i++){`.
- Keep pointer casts compact, including the following expression: `(char*)ptr` and `(struct inode*)ptr`.
- Preserve ordinary punctuation spacing inside comments and string literals.
- Put a function definition's opening brace on the next line.
- Keep control-statement opening braces on the same line without a preceding space: `if(condition){`, `else{`, and `do{`.
- Do not put a space between a closing brace and `else`: `}else if(condition){`.
- One-statement branches may omit braces.

## Names and Declarations

- Use `snake_case` for functions and variables and uppercase names for macros.
- Use the `struct` keyword directly; do not introduce typedef aliases for structs.
- Keep internal helper functions `static`.
- Test for zero with `!`, rather than `== 0`.

## Increment and Decrement

- Use postfix `++` and `--` when the expression's value is unused, including standalone counter updates and `for` loop updates: `count++;`, `count--;`, and `for(i=0;i<limit;i++){`.
- Preserve prefix forms when the updated value is needed within an expression, such as `*++ptr` or `*--ptr`. Do not change increment/decrement placement where it would change behavior.

## Verification

Before returning C code, check indentation and displayed line lengths, comma, parenthesis, operator, `for` semicolon, and cast spacing, brace placement, names, struct declarations, zero tests, and increment/decrement placement. Keep these checks scoped to the requested changes.
