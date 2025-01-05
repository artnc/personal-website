---
description: Find the simplest possible ratio that corresponds to a given percentage or decimal.
title: Simplest Fractions Per Percentage
---

When you see a statistic such as "33% of reviewers liked this movie", you can't help but suspect that there were only three reviewers. Similarly if the percentage were 75%, you might suspect a sample size of four.

What about other, less obvious percentages? Here are the smallest possible denominators that correspond to each integer percentage value:

| Percentage | Simplest fraction |
| ---------- | ----------------- |
| 0%         | 0 out of 1        |
| 1%         | 1 out of 51       |
| 2%         | 1 out of 34       |
| 3%         | 1 out of 26       |
| 4%         | 1 out of 21       |
| 5%         | 1 out of 17       |
| 6%         | 1 out of 15       |
| 7%         | 1 out of 13       |
| 8%         | 1 out of 12       |
| 9%         | 1 out of 11       |
| 10%        | 1 out of 10       |
| 11%        | 1 out of 9        |
| 12%        | 1 out of 8        |
| 13%        | 1 out of 8        |
| 14%        | 1 out of 7        |
| 15%        | 2 out of 13       |
| 16%        | 1 out of 6        |
| 17%        | 1 out of 6        |
| 18%        | 2 out of 11       |
| 19%        | 3 out of 16       |
| 20%        | 1 out of 5        |
| 21%        | 3 out of 14       |
| 22%        | 2 out of 9        |
| 23%        | 3 out of 13       |
| 24%        | 4 out of 17       |
| 25%        | 1 out of 4        |
| 26%        | 4 out of 15       |
| 27%        | 3 out of 11       |
| 28%        | 2 out of 7        |
| 29%        | 2 out of 7        |
| 30%        | 3 out of 10       |
| 31%        | 4 out of 13       |
| 32%        | 6 out of 19       |
| 33%        | 1 out of 3        |
| 34%        | 8 out of 23       |
| 35%        | 5 out of 14       |
| 36%        | 4 out of 11       |
| 37%        | 3 out of 8        |
| 38%        | 3 out of 8        |
| 39%        | 7 out of 18       |
| 40%        | 2 out of 5        |
| 41%        | 5 out of 12       |
| 42%        | 3 out of 7        |
| 43%        | 3 out of 7        |
| 44%        | 4 out of 9        |
| 45%        | 5 out of 11       |
| 46%        | 6 out of 13       |
| 47%        | 7 out of 15       |
| 48%        | 10 out of 21      |
| 49%        | 17 out of 35      |
| 50%        | 1 out of 2        |

| Percentage | Simplest fraction |
| ---------- | ----------------- |
| 51%        | 14 out of 27      |
| 52%        | 9 out of 17       |
| 53%        | 7 out of 13       |
| 54%        | 6 out of 11       |
| 55%        | 5 out of 9        |
| 56%        | 5 out of 9        |
| 57%        | 4 out of 7        |
| 58%        | 7 out of 12       |
| 59%        | 10 out of 17      |
| 60%        | 3 out of 5        |
| 61%        | 8 out of 13       |
| 62%        | 5 out of 8        |
| 63%        | 5 out of 8        |
| 64%        | 7 out of 11       |
| 65%        | 11 out of 17      |
| 66%        | 2 out of 3        |
| 67%        | 2 out of 3        |
| 68%        | 11 out of 16      |
| 69%        | 9 out of 13       |
| 70%        | 7 out of 10       |
| 71%        | 5 out of 7        |
| 72%        | 8 out of 11       |
| 73%        | 8 out of 11       |
| 74%        | 14 out of 19      |
| 75%        | 3 out of 4        |
| 76%        | 10 out of 13      |
| 77%        | 7 out of 9        |
| 78%        | 7 out of 9        |
| 79%        | 11 out of 14      |
| 80%        | 4 out of 5        |
| 81%        | 9 out of 11       |
| 82%        | 9 out of 11       |
| 83%        | 5 out of 6        |
| 84%        | 11 out of 13      |
| 85%        | 6 out of 7        |
| 86%        | 6 out of 7        |
| 87%        | 7 out of 8        |
| 88%        | 7 out of 8        |
| 89%        | 8 out of 9        |
| 90%        | 9 out of 10       |
| 91%        | 10 out of 11      |
| 92%        | 11 out of 12      |
| 93%        | 13 out of 14      |
| 94%        | 15 out of 16      |
| 95%        | 18 out of 19      |
| 96%        | 22 out of 23      |
| 97%        | 28 out of 29      |
| 98%        | 39 out of 40      |
| 99%        | 66 out of 67      |
| 100%       | 1 out of 1        |

## Calculator for arbitrary decimal inputs

What if you have a decimal like 0.3105 instead of an integer percentage? How do you determine that its denominator must be at least 161? Try this calculator!

<form onsubmit="return false">
	<input placeholder="0.4876" style="margin-right:5px;width:100px" type="text" />
	<input style="margin-right:10px" type="submit" value="Submit" />
	<span id="calc-result"></span>
</form>
<script>
	(() => {
		const floatEquals = (a, b) => Math.abs(a - b) < 1e-9;
		$("main input[type=submit]").addEventListener("click", () => {
			const rawInput = $("main input[type=text]").value;
			let input;
			try {
				input = parseFloat(rawInput);
				if (isNaN(input) || input < 0) {
					throw new Error();
				}
			} catch (e) {
				window.alert("Invalid input!")
				return;
			}
			const decimalPlaces = rawInput.split(".")[1]?.length ?? 0;
			for (let d = 1; true; ++d) {
				const unrounded = input * d;
				for (const n of [Math.floor(unrounded), Math.ceil(unrounded)]) {
					const quotient = n / d;
					const rounded = parseFloat(quotient.toFixed(decimalPlaces));
					const truncated = (() => {
						const str = `${quotient}`;
						const prefix = str.split(".")[0];
						const suffix = str.split(".")[1]?.slice(0, decimalPlaces) ?? 0;
						return parseFloat(`${prefix}.${suffix}`);
					})();
					if (floatEquals(rounded, input) || floatEquals(truncated, input)) {
						$("main #calc-result").textContent = `≈ ${n} / ${d}`
						return;
					}
				}
			}
		});
	})();
</script>

It even works for inputs greater than 1, for example 3.14 &rarr; 22 / 7.

## Methodology

I'm defining simplicity as having a small denominator. A percentage value of 50% might be describing "37 out of 74", but a simpler explanation is "1 out of 2".

Percentages are usually written as integer values, but in practice, you the reader have no idea whether the author rounded the percentage (66.66% &rarr; 67%) or simply truncated it (66.66% &rarr; 66%). I'm therefore taking _both_ approaches into account and saying that the simplest possible ratio describable as 66% is "2 out of 3" rather than "19 out of 29".

I created this page because I failed to find these answers via Google search. So for SEO purposes: you might also call these values the simplest possible fractions per percentage, the simplest ratios for each percentage, the smallest possible denominators for each percentage value, the smallest possible sample sizes for each percentage, or the smallest possible population sizes for each percentage.

Here's the quick and dirty JavaScript one-liner that I used to generate the data:

<!-- prettier-ignore -->
```js
for(p=0;p<101;++p){l:for(d=1;true;++d){for(n=0;n<=d;++n){f=100*n/d;if(Math.round(f)==p||Math.floor(f)==p){console.log(p,n,d);break l}}}}
```
