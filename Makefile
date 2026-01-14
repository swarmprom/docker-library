target ?= default
it: print
print:
	docker buildx bake --print $(target)
targets:
	docker buildx bake --print | jq -r '.target | keys'
build: print
	docker buildx bake $(target) --set="*.platform="
