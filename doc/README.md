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

## 4. Configuración del servidor

### Solo IPv4

En clase solo vamos a usar IPv4, así que se lo indico a Bind en `/etc/default/named`:

```
OPTIONS="-u bind -4"
```

![default named](img/default-named.png)

### 4.1. Fichero named.conf.options

Antes de modificarlo hago una copia de seguridad:

```
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup
```

Añado una lista de acceso (`confiables`) para que solo puedan hacer consultas recursivas los hosts de confianza: el propio servidor y la red 192.168.56.0/24. El fichero queda así:

```
acl confiables {
    127.0.0.1;
    192.168.56.0/24;
};

options {
        directory "/var/cache/bind";

        // forwarders {
        //   0.0.0.0;
        // };

        allow-transfer { none; };

        listen-on port 53 { 127.0.0.1; 192.168.56.10; };

        recursion yes;
        allow-recursion { confiables; };

        dnssec-validation yes;

        // listen-on-v6 { any; };
};
```

![named.conf.options](img/named-conf-options.png)

Qué hace cada parte:

- `directory`: es donde Bind guarda la caché (/var/cache/bind). Por defecto ya funciona como DNS caché.
- `allow-transfer { none; }`: no se permite transferir zonas a nadie, de momento.
- `listen-on port 53`: el servidor escucha en el puerto 53 en localhost y en la IP de su tarjeta de red privada.
- `recursion yes` y `allow-recursion { confiables; }`: permito consultas recursivas, pero solo a los hosts de la lista de acceso.
- `dnssec-validation yes`: activa la validación de DNSSEC.
- `listen-on-v6` está comentada porque no vamos a responder consultas IPv6.

Compruebo que la configuración es correcta, reinicio el servicio y miro su estado:

```
named-checkconf /etc/bind/named.conf.options
sudo systemctl restart named
systemctl status named
```

![comprobacion](img/checkconf-status.png)