
How to deploy Openhands:

## 1. Deploy OpenHands docker:

Navigate the OpenHands github repo: `https://github.com/All-Hands-AI/OpenHands`

Refer to `Running OpenHands Locally`:
```shell
docker pull docker.all-hands.dev/all-hands-ai/runtime:0.48-nikolaik

docker run -it --rm --pull=always \
    -e SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:0.48-nikolaik \
    -e LOG_ALL_EVENTS=true \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/.openhands:/.openhands \
    -p 3000:3000 \
    --add-host host.docker.internal:host-gateway \
    --name openhands-app \
    docker.all-hands.dev/all-hands-ai/openhands:0.48
```

## 2. Deploy VLLM to serve local LLMs

How to use vllm to deploy Devstral-Small-2505-GGUF on RTX3090/RTX4090 with 24GB GPU memory.

Navigate to this HuggingFace repo: `https://huggingface.co/unsloth/Devstral-Small-2505-GGUF`
Click the `Files and version`:
We can see a list of quantized Devstral-Small-2005 models.
We choose to use `Devstral-Small-2505-Q4_K_M.gguf`
Download to a local dir:
```shell
wget https://huggingface.co/unsloth/Devstral-Small-2505-GGUF/resolve/main/Devstral-Small-2505-Q4_K_M.gguf
```

Then we can use vllm to serve this model.
Please refer this [blog](https://www.reddit.com/r/LocalLLaMA/comments/1ks18uf/mistrals_new_devstral_coding_model_running_on_a/) for more details.

Please edit the `docker-compose.yml` file:
* In the `volumns` section, mount you local directory with the `Devstral-Small-2505-Q4_K_M.gguf` in to the docker;
* Set other arguments in the `command` section, these will be passed to vllm.

Then start the docker:
```shell
docker-compose up -d
```

## 3. Configure the OpenHands
Open the OpenHands web UI: [http://localhost:3000](http://localhost:3000)

Click the advanced to set the LLM:
In the Custom Model field:
```
openai/Devstral-Small-2505-Q4_K_M
```
In the BaseURL field:
```
http://host.docker.internal:9999/v1/
```
Set the API Key to your api key and then save changes.

Then you can launch a new runtime to start deploy and develop.