---
layout: default
title: Starting over
published: true
---

The last time I wrote something and posted it in a semi-permanent
reverse-chronological database for public consumption (a.k.a a blog) was
propbably, *I don't know*, **years** ago. It's time to get back. And in the
spirit of starting over, I'm going to pretend this is my first blog post
*ever*.

Hi, I'm Zaim Bakar. I'm a web developer and this is my blog. I'll be writing
about almost anything, but I'll try to keep things within the confines of my
general interests, namely:

1. *Programming*
2. *technology*
3. *movies*, and
4. maybe some *music*.

As my first post ever, please allow me some latitude to meander a little bit
(but I promise there is a point in the end).

## Let's start with Programming

```python
def hello_world():
    print "yes, i'm still here"
```

But more specifically I want to talk about this blog in particular:

```bash
$ gem install jekyll
$ mkdir _posts
$ vim _posts/2013-02-26-starting-over.md
```

Yes, I'll grant you that installing [Jekyll](http://jekyllrb.com/) isn't
much related to programming (but at least I'm using vim!), so let me lead you
down the rabbit hole some more...

```bash
$ make post title="Starting over" open="vim +"
```

*Yes*, let's talk about Make! After reading this
[post about how awesome Make is](http://bost.ocks.org/mike/make/) (via
[reddit](http://www.reddit.com/r/programming/comments/195iz1/why_use_make/)), I
was inspired to look at things that are Makefile-worthy and lo and behold, what
about blog writing?

So I hacked together something to help me quickly write blog posts in the
spur of the moment.

You can see it in this blog's [source](http://github.com/zaim/zaim.github.com). 
But it's not that long, so let me paste it here:

```make
# Slugify title using tr
slugify = tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | tr '[:space:]' '-'

# Post options
title  = New Post
name   = $(shell echo -n $(title) | $(slugify))
date   = $(shell date +%Y-%m-%d)
type   = md
file   = ./_posts/$(date)-$(name).$(type)
open   = vim +
layout = default

# Assets
styluses = ./_assets/stylus
css_out  = ./assets/css

# Stylus
# just set to 'stylus' to use a global install instead
stylus = ./_plugins/node_modules/.bin/stylus
stylus_opts = -I _plugins/node_modules/nib/lib \
			  -I _plugins/node_modules/normalize/lib \
			  -u nib/lib/nib \
			  -u normalize/lib/normalize

site: css
	@jekyll

css:
	@$(stylus) $(stylus_opts) -o $(css_out) $(styluses)

post:
	@echo "---" > $(file)
	@echo "layout: $(layout)" >> $(file)
	@echo "title: $(title)" >> $(file)
	@echo "published: false" >> $(file)
	@echo "---" >> $(file)
	@echo >> $(file)
ifneq ($(open), 0)
	@$(open) $(file)
endif

server:
	@jekyll --server --auto

.PHONY: site css post server
```

Well, I know there are many
[other](http://grahamc.com/blog/using-make-to-manage-jekyll/) examples of
Jekyll/blog Makefiles out there, but the point here is for me to excersize some
Makefile-fu for myself. So here are some features of my blog Makefile that I
think *might* be different from the others out there.

- I auto-convert long titles into slugs for cleaner filenames.
- I automatically open the file in vim. (set `open=0` to *not* open the file)
- I use [stylus](http://learnboost.github.com/stylus/) to write my CSS.

I use [Node](http://nodejs.org) instead of the 
[many Stylus plugins](https://github.com/mojombo/jekyll/wiki/Plugins)
for Jekyll so that I can use the awesome Stylus extensions
[nib](http://visionmedia.github.com/nib/) and 
[normalize](https://github.com/nulltask/normalize.styl) (which requries Node).

Other things I'd like to implement:

- `make push` to push changes to GitHub.
- Customization of the YAML Front Matter directly from the command line.

And... that's it! Feel free to reuse this yourself. Or if you're feeling generous,
fork my [blog](http://github.com/zaim/zaim.github.com) and send me a pull 
request of any changes you made.

