---
layout: post
title: MadJS February 2012 - How CoffeeScript & Jasmine Made Me a Better JavaScript
  Developer
published: true
redirect_from:
  - /blog/2012/02/17/madjs-february-2012-how-coffeescript-jasmine-made-me-a-better-javascript-developer/
---
<p>Recently, I spoke at the MadJS group about CoffeeScript &amp; Jasmine. My slides appear below. Since Slideshare doesn't show my notes, you can either download the keynote file above, or you can read the notes below, which I've pulled out of the slides. I feel that the notes are necessary to know what I'm talking about, and I hate reading slide decks where there's no context or notes. This isn't going to be as helpful as having seen my talk in person, but hopefully you get some value out of my talk and the notes together:</p>
<div style=""><strong style="display: block; margin: 12px 0 4px;"><a href="http://www.slideshare.net/mathiasx/coffeescript-jasmine-madjs-february-2012" title="CoffeeScript &amp; Jasmine - MadJS February 2012" target="_blank">CoffeeScript &amp; Jasmine - MadJS February 2012</a></strong> <iframe marginheight="0" scrolling="no" src="http://www.slideshare.net/slideshow/embed_code/11637009" marginwidth="0" frameborder="0" height="355" width="425"></iframe>
<div style="padding: 5px 0 12px;">View more <a href="http://www.slideshare.net/" target="_blank">presentations</a> from <a href="http://www.slideshare.net/mathiasx" target="_blank">Matt Gauger</a></div>
</div>
<h2>How CoffeeScript &amp; Jasmine made me a better JS developer</h2>
<h3>First, an introduction:</h3>
<ul>
<li>I&rsquo;m Matt Gauger</li>
<li>@mathiasx on twitter</li>
</ul>
<h3>I work at <a href="http://bendyworks.com">Bendyworks</a></h3>
<ul>
<li>We primarily do Ruby on Rails work, with iOS now.</li>
<li>We care very deeply about software craftsmanship and honing our agile practices.</li>
</ul>
<h3>Which leads me to my dilemma</h3>
<ul>
<li>Are you familiar with impostor syndrome?</li>
<li>It's the idea that even very skilled practitioners may sometimes feel like an impostor due to over-emphasizing their weaknesses.</li>
<li>Further, it&rsquo;s the inability to internalize your own accomplishments.</li>
</ul>
<h3>I felt like an impostor when it came to JavaScript.</h3>
<ul>
<li>Of course, I could read and write the syntax, pull in jQuery, manipulate the DOM, etc.</li>
<li>I had several projects under my belt at this time that used AJAX and were fairly complex</li>
<li>I'd even read JavaScript: The Good Parts several times, taken notes, etc.</li>
</ul>
<h3>So, what does this have to do with CoffeeScript?</h3>
<ul>
<li>My thesis: How CoffeeScript &amp; Jasmine made me a better JS developer (and how it can help you, too)</li>
<li>But before that: Let me warn you that I'm not going to go over every piece of syntax here.</li>
<li>I'm not going to be able to teach you all of CoffeeScript or Jasmine in this talk.</li>
<li>For that, see the resources &amp; books at the end of the talk.</li>
</ul>
<h3>CoffeeScript History</h3>
<ul>
<li>2010 I learn about CoffeeScript, and it sort of looks like Ruby and Python.</li>
<li>It grabs my interest.</li>
<li>But at that point it's still a novelty: The compiler is in Ruby, no one uses it for real dev yet.</li>
<li>It was a *toy*</li>
</ul>
<h3>Today</h3>
<ul>
<li>Flash-forward to today, and everyone is extolling CoffeeScript. </li>
<li>It comes with Rails 3 by default now and gets compiled on the fly into JS for your app.</li>
<li>I&rsquo;ve been using CoffeeScript for about a year now.</li>
</ul>
<h3>CoffeeScript has Good Parts?</h3>
<p>So why use CoffeeScript? What are its good parts?</p>
<ul>
<li>It restricts you to a subset of JS you&rsquo;d recognize from JS: The Good Parts.</li>
<li>It puts JSLint &amp; a compiler between me and the half dozen browsers I need to support</li>
<li>It warns me when I do something wrong</li>
</ul>
<p>This might be the most important part of the talk, and reason to use CoffeeScript</p>
<ul>
<li>If you&rsquo;re like me, you&rsquo;ll put the compiled JS up next to the CoffeeScript</li>
<li>By reading the output of the compiler, you&rsquo;re learning what good JS looks like.</li>
</ul>
<h3>Criticisms of CoffeeScript:</h3>
<ul>
<li>It's not what runs in the browser.</li>
<li>Difficult to debug =&gt; Finding bugs (Names are the same between CoffeeScript &amp; JS; its readable)</li>
<li>May feel like you&rsquo;re learning a whole different language (It&rsquo;s not, it&rsquo;s less verbose JS)</li>
</ul>
<h3>That isn't to say that CoffeeScript eliminates all bugs</h3>
<ul>
<li>At this point we may want to differentiate between bugs that are caused by poor syntax and mistakes (mistake bugs), and bugs that come from the interaction between complicated data &amp; edge cases (ie computer is in a state you didn't predict when you wrote the code)</li>
<li>CoffeeScript can help cut down on a lot of the former.</li>
</ul>
<h3>Some examples of CoffeeScript helping you with bugs:</h3>
<p>Coercing the wrong types</p>
<ul>
<li>This will print it&rsquo;s true happily.</li>
<li>That&rsquo;s not quite what you expect when the data is more complicated than 1 and the string 1.</li>
<li>Type coercion is the number 1 reason for <a href="http://wtfjs.com/">WTFJS</a></li>
<li>Ok, so that&rsquo;s a very simple example.</li>
<li>But how often are you going to get bitten by more complicated versions of that same bug?</li>
<li>And are you always going to remember to use triple equals? === I am now.</li>
</ul>
<h3>Scope</h3>
<ul>
<li>CoffeeScript scope is essentially the same as in JS</li>
<li>JS and CoffeeScript have &ldquo;lexical scope&rdquo;</li>
<li>1. <span> </span>Every function creates a scope, and the only way to create a scope is to define a function.</li>
<li>2. A variable lives in the outermost scope in which an assignment has been made to that variable.</li>
<li>3.<span> </span> Outside of its scope, a variable is invisible.</li>
<li>The neat thing is that CoffeeScript&rsquo;s compiler places the vars for each scope at the top of that scope</li>
<li>Define a variable at a specific scope by giving it a sensible initial value</li>
<li>Hopefully this is better than &lsquo;null&rsquo;, but you could do worse and just not initialize it at all.</li>
<li>JavaScript won&rsquo;t force you to initialize it, but doing so can help you to figure out scope issues.</li>
</ul>
<h3>a ?= b</h3>
<ul>
<li>the ?= is syntactic sugar, the ? is called the existential operator in CoffeeScript</li>
<li>Combined with =, the existential operator means &ldquo;a equals b unless a?&rdquo; or
<ul>
<li>&ldquo;Let b be the default value for a.&rdquo;</li>
</ul>
</li>
</ul>
<h3>Lastly, wrapping up your code.</h3>
<ul>
<li>CoffeeScript can wrap each compiled file into a scope</li>
<li>This may be the default, depending on the version of coffeescript you&rsquo;re using - you might need to pass an option now to either wrap or not wrap your code in a scope.</li>
<li>This is actually pretty cool -- if you&rsquo;re including a lot of JavaScripts on a website, you can&rsquo;t mix scope there -- no accidental leakage into the global scope space.</li>
<li>Compiled CoffeeScript Example: </li>
</ul>
<div class="CodeRay">
  <div class="code"><pre>(function() {
  console.log &quot;hello world!&quot;;
}).call(this);</pre></div>
</div>

<h3>Simpler Looping</h3>
<ul>
<li>You write list comprehensions rather than for loops in CoffeeScript</li>
<li>Comprehensions are expressions, and can be returned and assigned</li>
</ul>
<h3>Jeremy Ashkenas&rsquo;s Example</h3>
<ul>
<li>Loop over every item in a list, in CoffeeScript:</li>
</ul>
<div class="CodeRay">
  <div class="code"><pre>for item in list
  process item</pre></div>
</div>

<h3>Intention gets obscured by managing the loop, in JS:</h3>
<div class="CodeRay">
  <div class="code"><pre>for (var i = 0, l = list.length; i &lt; l; i++) {
  var item = list[i];
  process(item);
}</pre></div>
</div>

<li>CoffeeScript allows &ldquo;reasonably solid&rdquo; JavaScript developers to accomplish the latter by simply writing the former.</li>
<h3>In Review:&nbsp;CoffeeScript will help you:</h3>
<ul>
<li>Write OO, Prototype-based code</li>
<li>Avoid bugs in comparisons</li>
<li>Stop using ==, only use ===</li>
<li>Manage scope and avoid state through scope creep</li>
<li>Reduce off-by-one errors in looping, and generally write better loops than you were writing before</li>
</ul>
<h3>Jasmine</h3>
<p>(My) History (with Jasmine)</p>
<ul>
<li>I started using Jasmine last summer on a client project.</li>
<li>It&rsquo;s enough like the BDD tool we use in Rails, Cucumber, that I consider it a BDD tool.</li>
<li>It makes the most sense to me of the BDD/TDD tools in JS I&rsquo;ve used</li>
</ul>
<h3>Why Jasmine?</h3>
<ul>
<li>All code should be tested =&gt; that&rsquo;s what I believe.</li>
<li>You can spend some up-front time testing your code, or you can spend a lot of time bug fixing later</li>
<li>I realize that not all legacy codebases are going to have full test coverage overnight.</li>
</ul>
<h3>The example on the Jasmine site:</h3>
<div class="CodeRay">
  <div class="code"><pre>describe(&quot;Jasmine&quot;, function() {
  it(&quot;makes testing awesome!&quot;, function() {
    expect(yourCode).toBeLotsBetter();
  });
});</pre></div>
</div>

<ul>
<li>This example sucks!</li>
<li>A better example:</li>
</ul>
<div class="CodeRay">
  <div class="code"><pre>describe ('addition', function() {
  it('adds two numbers', function() {
    expect(1 + 2).toEqual(3);
  });
});</pre></div>
</div>

<ul>
<li>Better? Not really. But we can see what the syntax is doing here and I&rsquo;m using a real assertion!</li>
</ul>
<h3>How should we test JS?</h3>
<ul>
<li>Functions should not depend on the DOM</li>
<li>Our Logic needs to be in separate pieces
<ul>
<li>to make it easier to test the logic, things like AJAX calls, etc</li>
<li>without interacting with the DOM</li>
</ul>
</li>
</ul>
<h3>Easier to test = better code</h3>
<ul>
<li>it just so turns out, that the abstraction for testing is a better abstraction overall</li>
<li>I've heard "The first implementation of your code is the unit tests" so it may not be DRY, but tests should show how to implement your code!</li>
</ul>
<h3>Follow TDD/BDD:</h3>
<h3>red, green, refactor</h3>
<ul>
<li>You can still do this in Jasmine, in fact, I find it kind of natural.</li>
</ul>
<h3>Jasmine is designed to be standalone</h3>
<ul>
<li>This means you don&rsquo;t need jQuery and you don&rsquo;t need to run it in a real browser (but you can)</li>
</ul>
<h3>Some really cool features of Jasmine:</h3>
<p>Matchers:</p>
<ul>
<li>.toBe()</li>
<li>.toBeNull()</li>
<li>.toBeTruthy()</li>
<li>.toBeDefined()</li>
<li>.toBeUndefined()</li>
</ul>
<h3>Setup and teardown:</h3>
<div class="CodeRay">
  <div class="code"><pre>beforeEach()
afterEach()</pre></div>
</div>

<ul>
<li class="li1">You can use after Each to run a teardown function after each successful test</li>
<li class="li1">If you need a teardown function after a test whether it passed or failed, use after()</li>
</ul>
<h3>Spies: built-in mocking &amp; stubbing</h3>
<ul>
<li>In Ruby, we&rsquo;ve been doing mocking and stubbing for awhile.</li>
<li>Jasmine&rsquo;s spies make it easy!</li>
<li>These let you do things like watch to see if a method was called</li>
<li>Or to stub out other methods so you don&rsquo;t do real AJAX calls, etc.</li>
</ul>
<h3>But what about legacy codebases?</h3>
<ul>
<li>So you&rsquo;re thinking, "CoffeeScript and Jasmine sound great, but I have a legacy codebase."</li>
<li>Or, "I&rsquo;ll never get to use either; and they don&rsquo;t help my big legacy codebase."</li>
<li>Well, we&rsquo;ve run into this and I have a plan.</li>
</ul>
<h3>Start simple.</h3>
<ul>
<li>First, get your tools lined up.</li>
<li>Get the CoffeeScript compiler in your tool chain</li>
<li>Get Jasmine set up and passing a dummy test.</li>
<li>You still haven&rsquo;t done anything with your legacy code at this point.</li>
</ul>
<h3>Fix one bug.<br />(red, green, refactor)</h3>
<ul>
<li>It all starts with one bug. Or one feature, if you&rsquo;re feeling adventurous.&nbsp;</li>
<li>You might not be able to pull out an entire feature and rewrite it. I understand that. Don't give in to this temptation yet!</li>
<li>The way to start this is to write a test around the bug and see it fail. (this might be hard -&gt; depending on how tied your code is to the DOM -- see Jasmine-JQuery for DOM Fixtures)</li>
<li>Then fix the bug in regular old JavaScript. See the Jasmine test pass.</li>
</ul>
<h3>Rewrite the affected code in CoffeeScript.</h3>
<ul>
You&rsquo;ve got a working test around this bug.
<li>(You know the test works because you saw it red then green.)</li>
<li>Now&rsquo;s your chance to rewrite it in CoffeeScript. It may only be one function at this point. That&rsquo;s ok.</li>
</ul>
<h3>Start grouping in files / modules.</h3>
<ul>
<li>We found that even with a legacy codebase of a lot of JavaScript, we were able to figure out logical chunks that should live together in CoffeeScript files.</li>
</ul>
<h3>Keep improving the codebase.</h3>
<ul>
<li>This is the hardest part.</li>
<li>The temptation is there to just give up and fix bugs only in JS, not to write unit tests, etc.</li>
<li>The other temptation is the one you usually can&rsquo;t give into, which is to try to rewrite everything all at once -&gt; this rarely is accomplishable, it&rsquo;s better to stage the changes.</li>
<li>The big rewrite doesn't work!</li>
</ul>
<h3>Lessons Learned:</h3>
<ul>
<li>&nbsp;These tools can help you learn JS better.</li>
<li>Legacy codebases can slowly grow better through using CoffeeScript &amp; Jasmine.</li>
<li>Taking advantage of these is up to you! </li>
</ul>
<h3>Thanks!</h3>
<h3>Resources to learn more:</h3>
<ul>
  <li><span class="s2"><a href="http://jashkenas.github.com/coffee-script/">http://jashkenas.github.com/coffee-script/</a> (Note September 2015: This link has long been broken. Try <a href="http://coffeescript.org/">http://coffeescript.org/</a> instead.)</span></li>
  <li><span class="s2"><a href="http://pivotal.github.com/jasmine/">http://pivotal.github.com/jasmine/</a></span></li>
  <li><span class="s2"><a href="http://pragprog.com/book/tbcoffee/coffeescript">http://pragprog.com/book/tbcoffee/coffeescript</a></span></li>
  <li><a href="http://js2coffee.org"><span class="s2">http://js2coffee.org</span></a>/</li>
</ul>