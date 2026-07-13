## Lekcja 2: Docker provider

Provider `kreuzwerker/docker` łączy się z lokalnym Docker Daemonem (ten sam socket,
z którym rozmawia zwykłe CLI `docker`). Dwa podstawowe zasoby:
- `docker_image` - odpowiednik `docker pull`
- `docker_container` - odpowiednik `docker run`

Zasoby mogą odwoływać się do siebie nawzajem, np.:
image = docker_image.nginx.image_id

Terraform sam wykrywa taką zależność i wie, że musi najpierw pobrać obraz,
zanim stworzy kontener - nie trzeba tego ręcznie ustalać kolejnością w pliku.

### Przydatne komendy do eksploracji state
- `terraform state list` - lista zasobów, którymi zarządza Terraform w danym projekcie
- `terraform state show <zasob>` - pełne szczegóły zasobu (w tym wartości wygenerowane
  automatycznie, jak ID kontenera czy adres IP)

### Ważny wniosek
Jeśli coś zmienisz ręcznie poza Terraformem (np. `docker stop`), `terraform plan`
wykryje tę rozbieżność między kodem/state a rzeczywistością i zaproponuje naprawę.
Terraform stale porównuje trzy rzeczy: kod, state, rzeczywistość.

## Lekcja 3: Variables i outputs

Zamiast wpisywać wartości na sztywno w zasobach, wydzielamy je do zmiennych:

```hcl
variable "nazwa" {
  description = "..."
  type        = string
  default     = "wartosc"
}
```

Użycie w kodzie: `var.nazwa` (bez `${}` - interpolacja `${}` jest potrzebna tylko
gdy wstrzykujemy wartość do środka stringa, nie gdy cały argument to jedna zmienna).

Wartość zmiennej można nadpisać z zewnątrz bez ruszania kodu:
```bash
terraform plan -var="external_port=9090"
```
To pozwala używać tego samego kodu na różnych środowiskach (dev/staging/prod)
z różnymi wartościami.

Outputy (`outputs.tf`) wypisują wartości po `apply` - przydatne dla danych
generowanych automatycznie (np. ID kontenera) albo gotowych linków/adresów.

### Ważny wniosek: "forces replacement"
Nie każdą zmianę da się zrobić "na żywo" - np. zmiana portu w kontenerze Dockera
wymaga zniszczenia i odtworzenia całego kontenera (Docker tego nie wspiera inaczej).
Terraform pokazuje to w planie jako `-/+ destroy and then create replacement`
i oznacza konkretny atrybut komentarzem `# forces replacement`.
Warto zawsze czytać plan uważnie - pozornie mała zmiana może oznaczać przestój.
