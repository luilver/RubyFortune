# Ruby Fortune

## Setup

```bash
docker build . -t rubyfortune
```

## Run

```bash
docker run -p 9292:9292 rubyfortune
```

## Tests

```bash
docker run -it rubyfortune rake
```
