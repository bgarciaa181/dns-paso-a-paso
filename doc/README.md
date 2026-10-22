# Práctica: servidor DNS paso a paso

## 1. Máquina virtual con Vagrant

Creo el Vagrantfile con la máquina del servidor.
Tiene una tarjeta de red privada en la red 192.168.56.0/24 y su IP es 192.168.56.10.

```
vagrant up servidor
```

![vagrant up](img/vagrant-up.png)

Entro en la máquina y compruebo su IP:

```
vagrant ssh servidor
ip a
```

![ip a](img/ip-a.png)

## 2. Comprobación del fichero hosts

Antes de empezar compruebo que el fichero hosts de mi equipo no tiene entradas añadidas, para que vayan de verdad al servidor DNS.

```
Get-Content C:\Windows\System32\drivers\etc\hosts
```

![hosts](img/hosts.png)

## 3. Instalación del servidor DNS

Bind es el servidor DNS que se usa como estándar y también se le conoce como named. Lo instalo desde los repositorios oficiales con los paquetes bind9, bind9utils y bind9-doc. Añado dnsutils para tener dig y nslookup.

```
sudo apt update
sudo apt install -y bind9 bind9utils bind9-doc dnsutils
```

![instalacion](img/instalacion.png)

Compruebo que el servicio está activo:

```
systemctl status named
```

![status](img/status.png)