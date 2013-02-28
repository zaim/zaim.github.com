# Slugify title using tr
slugify = tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | tr '[:space:]' '-'

# Post options
title  = New Post
name   = $(shell echo -n $(title) | $(slugify))
date   = $(shell date +%Y-%m-%d)
type   = md
file   = ./_posts/$(date)-$(name).$(type)
open   = 0
editor = vim +
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
	@$(editor) $(file)
endif

server:
	@jekyll --server --auto

.PHONY: site css post
