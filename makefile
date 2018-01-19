
.DEFAULT_GOAL:= build

npm_install:
	npm install

ensure_dist:
	mkdir -p dist

clean_dist: ensure_dist
	rm -rf dist/*

copy_index:
	cp ./app/index.html dist/index.html

bundle_javascript: npm_install
	./node_modules/.bin/browserify --entry ./app/start.js --outfile ./dist/bundle.js --transform [ babelify ]

compile_styles:
	./node_modules/.bin/node-sass --output-style compressed ./app/styles/styles.scss > ./dist/styles.css

post_css: compile_styles
	./node_modules/.bin/postcss  --use autoprefixer --autoprefixer.browsers "last 2 versions" --output ./dist/styles.css ./dist/styles.css

write_to_dist: copy_index bundle_javascript compile_styles

build: clean_dist write_to_dist

watchman:
	watchman-make -p 'index.html' -t copy_index -p 'app/**/*.js' -t bundle_javascript -p 'app/**/*.scss' -t post_css

live_reload: bundle_javascript
	./node_modules/.bin/livereload ./dist

run_tests:
	./node_modules/.bin/mocha

run_server:
	cd dist && python -m SimpleHTTPServer

watch: run_tests write_to_dist run_server watchman live_reload

dev: build run_server