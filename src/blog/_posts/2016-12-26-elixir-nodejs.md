---
layout: post
title: Elixir for Node.js Developers
---

Bilingual dictionaries are some of the most valuable tools for learning natural languages like French. The idea also applies perfectly well to programming languages, and so here's the guide I wished I had before embarking on my trip to Elixir land. Corrections from those more fluent in Elixir are welcome!

## The Elixir ecosystem

Let's first take a look at the software that comes with Elixir. I find tooling the biggest obstacle to learning any new language; the language itself is usually more stable and straightforward.

### BEAM

BEAM is also known as the Erlang Virtual Machine (EVM). It's the platform that Elixir runs on, similar to how Chrome's V8 engine is what powers Node.js. A better comparison would be to Java's JVM, which now supports a variety of languages other than Java.

### OTP

I initially thought OTP ("Open Telecom Platform") was just an incredibly fancy name for Erlang's standard library. Now I think of OTP as the subset of Erlang's stdlib that facilitates the [actor model](http://www.brianstorti.com/the-actor-model/) of concurrency. People sometimes refer to Erlang as "Erlang/OTP" because the actor model is such a big deal---it's what BEAM was built for.

### Mix

[Mix](http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html) is Elixir's build tool / task runner. It's analogous to Jake, Gulp, and much of the `npm` client (which seems to think the "p" in its name means "project" instead of "package").

Mix uses the dev [environment](http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html#environments) by default but can be overridden with an environment variable: `MIX_ENV=prod`. This is similar to how React expects you to set `NODE_ENV=production` for release builds.

When setting up a new Node.js project, you typically run `npm init` and then add `node_modules` to your `.gitignore`. The Elixir equivalent is `mix new project_name`. We'll soon see a few more of Mix's many available commands.

### Hex

[Hex](https://hex.pm/) is Elixir's package manager, analogous to the npm registry and the parts of the `npm` client that actually deal with package management. One big difference is that you don't get a separate "hex" command when you install Elixir. You instead use Hex via Mix commands like `mix deps.get` (analogous to `npm install`).

Elixir's equivalents of `package.json` and `npm-shrinkwrap.json` are `mix.exs` and `mix.lock`, respectively. Running `mix deps.get` will install all packages declared in those files. There currently aren't any Mix commands that work like `npm install --save`, so to add or remove individual packages you'll have to edit `mix.exs` manually and then run `mix deps.get` again. On the upside, Mix automatically updates `mix.lock` for you.

### IEx

Okay, enough about npm already. The Elixir counterparts to Node.js's `node` command are `iex` and `elixir`. Running `iex` will open an interactive Elixir prompt (or [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)), while running `iex -S mix` will open the prompt in the context of the current directory's compiled Mix project. You can alternatively execute the compiled project via `mix run` if you don't need the prompt.

Wait, you need to compile Elixir? Although you do need to compile Mix projects via `mix compile`, you can also run a standalone Elixir script with the command `elixir foobar.exs` (note the `.exs` extension, as opposed to `.ex`). Mix itself is implemented as an Elixir script!

### ExUnit

Elixir has an official unit testing framework that integrates with Mix via `mix test`. Having one true framework is pretty great if for no other reason than avoiding the dependency hell of Mocha, Chai, Karma, Sinon, etc.

### Dialyzer

Despite being a dynamically typed language, Erlang comes with a static analysis tool called `dialyzer`. It can automatically detect certain type errors even in the absence of type declarations, kind of like TypeScript and Flow. If you do prefer declaring types yourself, both Erlang and Elixir offer an [annotation syntax](http://elixir-lang.org/getting-started/typespecs-and-behaviours.html) that Dialyzer understands.

[Dialyxir](https://github.com/jeremyjh/dialyxir) makes Dialyzer much easier to use with Elixir.

### Phoenix

[Phoenix](http://www.phoenixframework.org/) has a lot in common with Express.js and Ruby on Rails: they're the go-to web frameworks, they've made household names out of their authors, and they don't actually ship with the language itself. I'm mentioning Phoenix only because it's so popular and what you'll probably be using if you're coming from Node.js.

## The Elixir language

The [official guide](http://elixir-lang.org/getting-started/basic-types.html) does an excellent job on its own, so I'll just add some JavaScript perspective to a few basic Elixir concepts that aren't found in ES5.

### Atoms

Atoms resemble ES6 symbols and serve much of the same purpose as opaque enums. They're arbitrarily named, intrinsically meaningless identifiers whose most useful property is global uniqueness. In JavaScript you might have a function that returns `true` or `false` to indicate success; the Elixir equivalent might instead return `:ok` or `:error`.

As another example, consider Webpack's [output.libraryTarget](https://webpack.github.io/docs/configuration.html#output-librarytarget) config option. Its possible values are restricted to a small set of strings: `"var"`, `"amd"`, etc. An idiomatic Elixir API would use lightweight atoms like `:var` and `:amd` instead of full-fledged UTF8 strings.

### Ampersand operator

The official guide introduces the capture operator `&` in [chapter 8](http://elixir-lang.org/getting-started/modules.html#funtuallyction-capturing) with a link to details in the [language reference](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#&/1). I think `&` deserves extra attention due to how unfamiliar yet common it is. Elixir newcomers may not realize that it has three distinct meanings depending on context:

1. `&` obtains references to named functions, allowing them to be passed around as variables and called as anonymous functions (a.k.a. lambdas). In JavaScript, you can simply refer to a named function like `Math.floor` by its name:

   ```js
   [1.62, 2.72].map(Math.floor); // [1.0, 2.0]
   var myLambda = Math.floor;
   myLambda(3.14); // 3.0
   ```

   In Elixir, you also need `&` and the function's [arity](https://en.wikipedia.org/wiki/Arity):

   ```elixir
   Enum.map([1.62, 2.72], &Float.floor/1) # [1.0, 2.0]
   my_lambda = &Float.floor/1
   # Lambdas must be called with a "."
   my_lambda.(3.14) # 3.0
   ```

   Why the additional syntax? Elixir functions can be defined multiple times for different arities, so you need to specify which version you want. Since parentheses are optional in Elixir when empty, you also need `&` to prevent the compiler from interpreting `Float.floor/1` as "the result of `Float.floor()` divided by 1".

2. `&` is shorthand notation for declaring simple lambdas that take at least one argument. These are all equivalent:

   ```js
   // ES5
   var sum = function (a, b) {
     return a + b;
   };

   // ES6
   const sum = (a, b) => a + b;
   ```

   ```elixir
   # Elixir
   sum = fn(a, b) -> a + b end
   sum = &(&1 + &2)
   ```

   The outer `&` behaves like the `fn` keyword. The two inner `&`'s bring us to #3...

3. `&` denotes arguments to shorthand lambdas. `&1` represents the first argument, `&2` the second, and so on. Here are some direct translations of `sum = &(&1 + &2)` into JavaScript:

   ```js
   // ES5
   var sum = function () {
     return arguments[0] + arguments[1];
   };

   // ES6
   const sum = (...args) => args[0] + args[1];
   ```

At this point you might be wondering how the compiler (or anyone else reading your code, for that matter) will manage to keep all of these `&`'s straight if you try nesting them. Easy answer: you'll get a `CompileError` saying "nested captures via & are not allowed".

### Pipe operator

Underscore and Lodash have a `_.chain` [function](http://underscorejs.org/#chaining) that lets you express data transformations in chronological order of application. It looks really nice but ends up being clunky to use in practice. The same functionality is built into Elixir as the pipe operator `|>`. A JavaScript example adapted from the Underscore docs:

```js
const lyrics = [
  { line: 1, words: "I'm a lumberjack and I'm okay" },
  { line: 2, words: "I sleep all night and I work all day" },
  { line: 3, words: "He's a lumberjack and he's okay" },
  { line: 4, words: "He sleeps all night and he works all day" },
];

const histogram = _.chain(lyrics)
  .pluck("words")
  .map(words => words.split(" "))
  .flatten(true)
  .reduce((acc, word) => {
    acc[word] = (acc[word] || 0) + 1;
    return acc;
  }, {})
  .value();

// histogram is { lumberjack: 2, all: 4, night: 2 ... }
```

Translated into Elixir:

```elixir
histogram =
  lyrics
  |> Stream.map(&(&1.words))
  |> Stream.flat_map(&String.split/1)
  |> Enum.reduce(%{}, fn(word, acc) -> Map.update(acc, word, 1, &(&1 + 1)) end)

# histogram is %{"lumberjack" => 2, "all" => 4, "night" => 2 ... }
```

Just like in Underscore and Lodash, Elixir functions specify the data that they work on as their first argument by convention. Chained function calls can then omit that first argument because it gets populated with the result of the previous step in the pipeline.

Blessed with native support via `|>`, chaining works with all functions that take at least one argument. But there's another reason it's ubiquitous in Elixir: the language's lack of objects. Since instance methods like JavaScript's `String.prototype.toUpperCase` don't exist, all such features are implemented as "static" methods in Elixir:

```elixir
# Prints "HELLO" and returns :ok
IO.puts(String.upcase(String.trim(" hello")))

# Same, but laid out more naturally
" hello" |> String.trim |> String.upcase |> IO.puts
```

## Final thoughts

Although it's hard to say whether Elixir lives up to its massive hype, I've generally liked what I've seen so far. The flavor of functional programming is more pragmatic than dogmatic, the concurrency model is as elegant as promised, and the included development tools are easily the best of any language I've used.

I'm still a bit skeptical about dynamic typing, but maybe "let it crash" just hasn't sunk in yet. I'm also really not a huge fan of all the Rails-esque boilerplate that Phoenix generates. The current lack of mature framework options has more to do with how young the language is, though, and it's not too hard to pare down Phoenix anyway.

Consider it a glowing endorsement of both Elixir and Phoenix that these minor details are my only complaints :)
