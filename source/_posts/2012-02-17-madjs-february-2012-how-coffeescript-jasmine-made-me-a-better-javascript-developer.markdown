---
layout: post
title: MadJS February 2012 - How CoffeeScript & Jasmine Made Me a Better JavaScript
  Developer
published: true
redirect_from:
  - /blog/2012/02/17/madjs-february-2012-how-coffeescript-jasmine-made-me-a-better-javascript-developer/
---

Recently, I spoke at the MadJS group about CoffeeScript & Jasmine. My slides appear below. Since Slideshare doesn't show my notes, you can either download the keynote file above, or you can read the notes below, which I've pulled out of the slides. I feel that the notes are necessary to know what I'm talking about, and I hate reading slide decks where there's no context or notes. This isn't going to be as helpful as having seen my talk in person, but hopefully you get some value out of my talk and the notes together:

[CoffeeScript & Jasmine - MadJS February 2012](http://www.slideshare.net/mathiasx/coffeescript-jasmine-madjs-february-2012)

<iframe marginheight="0" scrolling="no" src="http://www.slideshare.net/slideshow/embed_code/11637009" marginwidth="0" frameborder="0" height="355" width="425"></iframe>

View more presentations from [Matt Gauger](http://www.slideshare.net/mathiasx).

## How CoffeeScript & Jasmine made me a better JS developer

### First, an introduction:

*   I’m Matt Gauger
*   @mathiasx on twitter

### I work at [Bendyworks](http://bendyworks.com)

*   We primarily do Ruby on Rails work, with iOS now.
*   We care very deeply about software craftsmanship and honing our agile practices.

### Which leads me to my dilemma

*   Are you familiar with impostor syndrome?
*   It's the idea that even very skilled practitioners may sometimes feel like an impostor due to over-emphasizing their weaknesses.
*   Further, it’s the inability to internalize your own accomplishments.

### I felt like an impostor when it came to JavaScript.

*   Of course, I could read and write the syntax, pull in jQuery, manipulate the DOM, etc.
*   I had several projects under my belt at this time that used AJAX and were fairly complex
*   I'd even read JavaScript: The Good Parts several times, taken notes, etc.

### So, what does this have to do with CoffeeScript?

*   My thesis: How CoffeeScript & Jasmine made me a better JS developer (and how it can help you, too)
*   But before that: Let me warn you that I'm not going to go over every piece of syntax here.
*   I'm not going to be able to teach you all of CoffeeScript or Jasmine in this talk.
*   For that, see the resources & books at the end of the talk.

### CoffeeScript History

*   2010 I learn about CoffeeScript, and it sort of looks like Ruby and Python.
*   It grabs my interest.
*   But at that point it's still a novelty: The compiler is in Ruby, no one uses it for real dev yet.
*   It was a *toy*

### Today

*   Flash-forward to today, and everyone is extolling CoffeeScript.
*   It comes with Rails 3 by default now and gets compiled on the fly into JS for your app.
*   I’ve been using CoffeeScript for about a year now.

### CoffeeScript has Good Parts?

So why use CoffeeScript? What are its good parts?

*   It restricts you to a subset of JS you’d recognize from JS: The Good Parts.
*   It puts JSLint & a compiler between me and the half dozen browsers I need to support
*   It warns me when I do something wrong

This might be the most important part of the talk, and reason to use CoffeeScript

*   If you’re like me, you’ll put the compiled JS up next to the CoffeeScript
*   By reading the output of the compiler, you’re learning what good JS looks like.

### Criticisms of CoffeeScript:

*   It's not what runs in the browser.
*   Difficult to debug => Finding bugs (Names are the same between CoffeeScript & JS; its readable)
*   May feel like you’re learning a whole different language (It’s not, it’s less verbose JS)

### That isn't to say that CoffeeScript eliminates all bugs

*   At this point we may want to differentiate between bugs that are caused by poor syntax and mistakes (mistake bugs), and bugs that come from the interaction between complicated data & edge cases (ie computer is in a state you didn't predict when you wrote the code)
*   CoffeeScript can help cut down on a lot of the former.

### Some examples of CoffeeScript helping you with bugs:

Coercing the wrong types

*   This will print it’s true happily.
*   That’s not quite what you expect when the data is more complicated than 1 and the string 1.
*   Type coercion is the number 1 reason for [WTFJS](http://wtfjs.com/)
*   Ok, so that’s a very simple example.
*   But how often are you going to get bitten by more complicated versions of that same bug?
*   And are you always going to remember to use triple equals? === I am now.

### Scope

*   CoffeeScript scope is essentially the same as in JS
*   JS and CoffeeScript have “lexical scope”
  1. Every function creates a scope, and the only way to create a scope is to define a function.
  2. A variable lives in the outermost scope in which an assignment has been made to that variable.
  3. Outside of its scope, a variable is invisible.
*   The neat thing is that CoffeeScript’s compiler places the vars for each scope at the top of that scope
*   Define a variable at a specific scope by giving it a sensible initial value
*   Hopefully this is better than ‘null’, but you could do worse and just not initialize it at all.
*   JavaScript won’t force you to initialize it, but doing so can help you to figure out scope issues.

### a ?= b

*   the ?= is syntactic sugar, the ? is called the existential operator in CoffeeScript
*   Combined with =, the existential operator means “a equals b unless a?” or
    *   “Let b be the default value for a.”

### Lastly, wrapping up your code.

*   CoffeeScript can wrap each compiled file into a scope
*   This may be the default, depending on the version of coffeescript you’re using - you might need to pass an option now to either wrap or not wrap your code in a scope.
*   This is actually pretty cool -- if you’re including a lot of JavaScripts on a website, you can’t mix scope there -- no accidental leakage into the global scope space.
*   Compiled CoffeeScript Example:

```
(function() {
  console.log "hello world!";
}).call(this);
```

### Simpler Looping

*   You write list comprehensions rather than for loops in CoffeeScript
*   Comprehensions are expressions, and can be returned and assigned

### Jeremy Ashkenas’s Example

*   Loop over every item in a list, in CoffeeScript:

```
for item in list
  process item
```

### Intention gets obscured by managing the loop, in JS:

```
for (var i = 0, l = list.length; i < l; i++) {
  var item = list[i];
  process(item);
}
```

*   CoffeeScript allows “reasonably solid” JavaScript developers to accomplish the latter by simply writing the former.

### In Review: CoffeeScript will help you:

*   Write OO, Prototype-based code
*   Avoid bugs in comparisons
*   Stop using ==, only use ===
*   Manage scope and avoid state through scope creep
*   Reduce off-by-one errors in looping, and generally write better loops than you were writing before

### Jasmine

(My) History (with Jasmine)

*   I started using Jasmine last summer on a client project.
*   It’s enough like the BDD tool we use in Rails, Cucumber, that I consider it a BDD tool.
*   It makes the most sense to me of the BDD/TDD tools in JS I’ve used

### Why Jasmine?

*   All code should be tested => that’s what I believe.
*   You can spend some up-front time testing your code, or you can spend a lot of time bug fixing later
*   I realize that not all legacy codebases are going to have full test coverage overnight.

### The example on the Jasmine site:

```
describe("Jasmine", function() {
  it("makes testing awesome!", function() {
    expect(yourCode).toBeLotsBetter();
  });
});
```

*   This example sucks!
*   A better example:

```
describe ('addition', function() {
  it('adds two numbers', function() {
    expect(1 + 2).toEqual(3);
  });
});
```

*   Better? Not really. But we can see what the syntax is doing here and I’m using a real assertion!

### How should we test JS?

*   Functions should not depend on the DOM
*   Our Logic needs to be in separate pieces
    *   to make it easier to test the logic, things like AJAX calls, etc
    *   without interacting with the DOM

### Easier to test = better code

*   it just so turns out, that the abstraction for testing is a better abstraction overall
*   I've heard "The first implementation of your code is the unit tests" so it may not be DRY, but tests should show how to implement your code!

### Follow TDD/BDD:

### red, green, refactor

*   You can still do this in Jasmine, in fact, I find it kind of natural.

### Jasmine is designed to be standalone

*   This means you don’t need jQuery and you don’t need to run it in a real browser (but you can)

### Some really cool features of Jasmine:

Matchers:

*   `.toBe()`
*   `.toBeNull()`
*   `.toBeTruthy()`
*   `.toBeDefined()`
*   `.toBeUndefined()`

### Setup and teardown:

```
beforeEach()
afterEach()
```

*   You can use after Each to run a teardown function after each successful test
*   If you need a teardown function after a test whether it passed or failed, use after()

### Spies: built-in mocking & stubbing

*   In Ruby, we’ve been doing mocking and stubbing for awhile.
*   Jasmine’s spies make it easy!
*   These let you do things like watch to see if a method was called
*   Or to stub out other methods so you don’t do real AJAX calls, etc.

### But what about legacy codebases?

*   So you’re thinking, "CoffeeScript and Jasmine sound great, but I have a legacy codebase."
*   Or, "I’ll never get to use either; and they don’t help my big legacy codebase."
*   Well, we’ve run into this and I have a plan.

### Start simple.

*   First, get your tools lined up.
*   Get the CoffeeScript compiler in your tool chain
*   Get Jasmine set up and passing a dummy test.
*   You still haven’t done anything with your legacy code at this point.

### Fix one bug. (red, green, refactor)

*   It all starts with one bug. Or one feature, if you’re feeling adventurous. 
*   You might not be able to pull out an entire feature and rewrite it. I understand that. Don't give in to this temptation yet!
*   The way to start this is to write a test around the bug and see it fail. (this might be hard -> depending on how tied your code is to the DOM -- see Jasmine-JQuery for DOM Fixtures)
*   Then fix the bug in regular old JavaScript. See the Jasmine test pass.

### Rewrite the affected code in CoffeeScript.

*   (You know the test works because you saw it red then green.)
*   Now’s your chance to rewrite it in CoffeeScript. It may only be one function at this point. That’s ok.

### Start grouping in files / modules.

*   We found that even with a legacy codebase of a lot of JavaScript, we were able to figure out logical chunks that should live together in CoffeeScript files.

### Keep improving the codebase.

*   This is the hardest part.
*   The temptation is there to just give up and fix bugs only in JS, not to write unit tests, etc.
*   The other temptation is the one you usually can’t give into, which is to try to rewrite everything all at once -> this rarely is accomplishable, it’s better to stage the changes.
*   The big rewrite doesn't work!

### Lessons Learned:

*   These tools can help you learn JS better.
*   Legacy codebases can slowly grow better through using CoffeeScript & Jasmine.
*   Taking advantage of these is up to you!

### Thanks!

### Resources to learn more:

*   [http://jashkenas.github.com/coffee-script/](http://jashkenas.github.com/coffee-script/) (Note September 2015: This link has long been broken. Try [http://coffeescript.org/](http://coffeescript.org/) instead.)
*   [http://pivotal.github.com/jasmine/](http://pivotal.github.com/jasmine/)
*   [http://pragprog.com/book/tbcoffee/coffeescript](http://pragprog.com/book/tbcoffee/coffeescript)
*   [http://js2coffee.org](http://js2coffee.org)
