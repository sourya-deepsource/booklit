targets=ast/booklit.peg.go docs/css/booklit.css errhtml/errors.css errhtml/bindata.go render/html/bindata.go render/text/bindata.go

all: $(targets)

ast/booklit.peg.go: ast/booklit.peg
	pigeon ast/booklit.peg | goimports > ast/booklit.peg.go

errhtml/errors.css: less/errors.less less/*.less
	yarn run lessc $< $@

docs/css/booklit.css: less/docs.less less/*.less
	yarn run lessc $< $@

less/logo-url.less: docs/css/images/booklit.svg
	yarn run build-logo-url-less

errhtml/bindata.go: errhtml errhtml/*.tmpl errhtml/*.css
	go-bindata -o errhtml/bindata.go -pkg errhtml errhtml/*.tmpl errhtml/*.css

render/html/bindata.go: render/html render/html/*.tmpl
	go-bindata -o render/html/bindata.go -pkg html render/html/*.tmpl

render/text/bindata.go: render/text render/text/*.tmpl
	go-bindata -o render/text/bindata.go -pkg text render/text/*.tmpl

clean:
	rm -f $(targets)
