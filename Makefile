it: print
print:
	docker buildx bake --print
targets:
	docker buildx bake --print | jq -r '.target | keys'
build: print
	docker buildx bake --set *.platform=
