WAF = "$(shell pwd)/waf"
WSCRIPT = "$(shell pwd)/wscript"
PLOVR = "$(shell pwd)/bin/plovr.jar"

all: deps compile

compile:
	@$(WAF) configure
	@$(WAF) build

clean:
	@$(WAF) clean

deps:
	@test -f $(WSCRIPT) || curl -o $(WSCRIPT) https://raw.github.com/gist/1641869/c40dc861dec4cef07a7829a8b2d79b730a30ece2/wscript
	@git submodule init
	@git submodule update
	@test -f $(PLOVR) || (mkdir -p bin && curl -o $(PLOVR) http://dl.dropbox.com/u/4262506/plovr.jar)

serve:
	@java -jar $(PLOVR) serve ./etc/config.json

soyweb:
	@java -jar $(PLOVR) soyweb --unsafe --dir ./application/templates