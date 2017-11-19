# cademeucarro-raspberry

Repositorio para inclusão de um sistema de identificação de placas de carro em um dispositivo contendo uma camera + Raspberry-Pi ou dispositivo com ubuntu.

## Getting Started

Guias e exemplo de execução. 

### Prerequisites - Raspberry

* **TO-DO**

### Prerequisites/Installation - Ubuntu 14.04+
Instale alguns pacotes/programas que você irá precisar:
```
sudo apt-get update
sudo apt-get -y install cmake git curl
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install beanstalkd
sudo apt-get install liblog4cplus-dev libcurl4-openssl-dev

``` 
Siga essas instruções para instalação do OpenALPR:

(obs: Instale utilizando o The Easy Way, pois o repositorio do ubuntu se encontrava desatualizado sem as dependencias da identificação de placas para a região brasileira. em: 19/11/2017)
* [OpenALPR - Install Guide](https://github.com/openalpr/openalpr/wiki/Compilation-instructions-(Ubuntu-Linux))

Infelizmente a regiao brasileira não é incluida por padrão no openalpr, para isso entre no repositorio clonado do mesmo e insira esse comando para copiar os arquivos faltantes:
```
sudo cp -R runtime_data/ /usr/share/openalpr/
```
Siga essas instruções para instalação do StreamEye:
* [StreamEye](https://github.com/ccrisan/streameye)

## Running 
Dentro do diretorio do repositorio execute o comando:
* **-s/--stream**: Endereço da stream de mjpeg a ser processada pelo sistema.
* **-ua/--uploadaddress**: Endereco em que será realizado o post das informações de placas processadas.
* **-c/--country**: Região/pais exemplo br, eu, us...
```
./start.sh -s (endereco_de_stream) -ua (endereco_de_upload)
```

## Built With

* [OpenALPR](https://github.com/openalpr/openalpr)
* [StreamEye](https://github.com/ccrisan/streameye)

