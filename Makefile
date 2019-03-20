build:
	docker build -t go-docker .
run:
	docker run -d -p 3001:3001 go-docker
