buildargs =
target ?= default
no-cache ?= false
ifeq ($(no-cache),true)
	buildargs += --no-cache
endif
it: print
print:
	docker buildx bake --print $(target)
targets:
	docker buildx bake --print | jq -r '.target | keys'
build: print
	docker buildx bake $(target) $(buildargs) --set="*.platform=" --load
push: print
	docker buildx bake $(target) $(buildargs) --push
