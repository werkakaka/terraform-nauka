## Czym jest Terraform i po co go używać

Terraform to narzędzie do zarządzania infrastrukturą jako kodem (Infrastructure as Code).
Zamiast klikać w konsoli albo pisać imperatywne skrypty (krok po kroku "zrób to, potem to"),
opisujesz **deklaratywnie**, jak ma wyglądać docelowy stan (np. "chcę mieć taki kontener"),
a Terraform sam ustala, co trzeba zrobić, żeby ten stan osiągnąć.

### Kluczowe korzyści
- Infrastructure as Code - cała infrastruktura w plikach `.tf`, wersjonowana w Git
- Powtarzalność - ten sam kod da identyczny efekt na dowolnej maszynie
- Bezpieczeństwo zmian - `terraform plan` pokazuje co się zmieni, zanim cokolwiek się wykona
- Zarządzanie zależnościami - Terraform sam ogarnia kolejność tworzenia/usuwania zasobów

### Czym jest provider
Provider to wtyczka/plugin, który tłumaczy kod `.tf` na konkretne wywołania API danej platformy
(Docker Daemon, AWS API, GitHub API itd.). Sam Terraform to tylko silnik - nie wie nic
o konkretnych systemach, dopóki nie doda mu się odpowiedniego providera.

### Dlaczego akurat Terraform
- Działa z setkami providerów (AWS, Azure, GCP, Docker, Kubernetes, GitHub...) - jeden język
  do zarządzania różnymi systemami, w przeciwieństwie do np. CloudFormation (tylko AWS)
- Rynkowy standard w DevOps/Cloud/Platform Engineering - często wymagany w ogłoszeniach o pracę

## Cykl pracy z Terraformem
1. `terraform init` - pobiera providery zadeklarowane w `required_providers`
2. `terraform plan` - pokazuje podgląd zmian (nic jeszcze nie wykonuje)
3. `terraform apply` - wykonuje zmiany i zapisuje efekt do `terraform.tfstate`
4. `terraform destroy` - usuwa zasoby zarządzane przez Terraform

State (`terraform.tfstate`) to "pamięć" Terraforma - zapis tego, co aktualnie istnieje.
Nigdy nie usuwać/modyfikować ręcznie zasobów zarządzanych przez Terraform - state
przestanie się zgadzać z rzeczywistością.
