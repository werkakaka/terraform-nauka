## Lekcja 4: Moduły

Moduł to folder z plikami `.tf`, który przyjmuje wejścia (`variable`) i zwraca
wyjścia (`output`) - jak funkcja w programowaniu. Pozwala reużywać ten sam kod
wielokrotnie z różnymi parametrami, bez duplikacji.

Struktura:
main.tf                        <- wywołania modułu (module "nazwa" { ... })
modules/docker-container/      <- definicja modułu (kod wielokrotnego użytku)
main.tf
variables.tf
outputs.tf

### Wywołanie modułu
```hcl
module "nginx_web" {
  source         = "./modules/docker-container"
  container_name = "nginx-web"
  image_name     = "nginx:latest"
  external_port  = 8080
}
```
Każde wywołanie modułu to osobna, izolowana grupa zasobów w state
(np. `module.nginx_web.docker_container.this`), mimo że pochodzą z tego samego kodu.

### Ważny wniosek: required_providers w każdym module
Konfiguracja providera (`provider "docker" {}`) dziedziczy się z pliku głównego
do modułu automatycznie, ALE informacja skąd pobrać provider (`required_providers`
z `source`) musi być zadeklarowana osobno w KAŻDYM module, jeśli provider nie jest
z domyślnej przestrzeni `hashicorp/*`. Bez tego Terraform szuka domyślnie
`hashicorp/<nazwa>`, co dla community'owych providerów (jak `kreuzwerker/docker`)
kończy się błędem "provider does not have a provider named...".

### Ważny wniosek: state jest izolowany per projekt
Terraform widzi tylko zasoby zapisane we własnym state. Jeśli dwa różne projekty
(dwa różne foldery/state) próbują użyć tego samego portu na hoście, Terraform
tego nie wykryje z góry - dowiesz się dopiero z błędu samego Dockera
("port is already allocated") przy `apply`. Warto pilnować unikalności takich
zasobów między różnymi state'ami zarządzającymi tą samą maszyną.
