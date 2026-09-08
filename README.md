# Vollmed

Aplicativo iOS para agendamento de consultas médicas na clínica Vollmed. Desenvolvido em **SwiftUI**, consume uma API REST para listar especialistas, agendar, remarcar e cancelar consultas.

> Projeto desenvolvido durante o curso **[iOS com SwiftUI: construindo aplicações interativas com CRUD e APIs REST](https://cursos.alura.com.br/course/ios-swiftui-aplicacoes-interativas-crud-apis-rest)** da [Alura](https://www.alura.com.br/), ministrado por [Giovanna Moeller](https://www.linkedin.com/in/giovannamoeller).

O curso aborda operações **CRUD** (Create, Read, Update, Delete), verbos HTTP (`GET`, `POST`, `PATCH`, `DELETE`), integração com API RESTful, consumo de JSON e construção de interfaces com SwiftUI.

## Funcionalidades

- **Home** — lista os especialistas disponíveis com foto, nome e especialidade
- **Agendar consulta** — seleção de data e horário via `DatePicker` (intervalos de 15 minutos)
- **Minhas consultas** — visualização das consultas do paciente, com opções de remarcar ou cancelar
- **Remarcar consulta** — alteração da data de uma consulta existente
- **Cancelar consulta** — cancelamento com informação do motivo

## Tecnologias

- Swift 5
- SwiftUI
- iOS 17.0+
- URLSession (requisições assíncronas com `async/await`)
- NSCache (cache de imagens dos especialistas)

## Estrutura do projeto

```
Vollmed/
├── Models/
│   ├── Specialist.swift
│   ├── Appointment.swift
│   └── ScheduleAppointment.swift
├── Services/
│   └── WebService.swift
├── Views/
│   ├── HomeView.swift
│   ├── MyAppointmentsView.swift
│   ├── ScheduleAppointmentView.swift
│   ├── CancelAppointmentView.swift
│   └── Components/
│       ├── SpecialistCardView.swift
│       └── ButtonView.swift
├── Extensions/
│   ├── Date+.swift
│   └── String+.swift
├── ContentView.swift
└── VollmedApp.swift
```

## Pré-requisitos

- macOS com [Xcode](https://developer.apple.com/xcode/) 15 ou superior
- Simulador iOS ou dispositivo físico com iOS 17+
- API backend rodando em `http://localhost:3001`

## Como executar

1. Clone o repositório:

```bash
git clone git@github.com:patricpfranca/vollmed.git
cd vollmed
```

2. Inicie a API backend na porta `3001`.

3. Abra o projeto no Xcode:

```bash
open Vollmed.xcodeproj
```

4. Selecione um simulador ou dispositivo e pressione **⌘R** para executar.

> **Simulador:** como a API roda em `localhost`, o app consegue acessá-la normalmente pelo simulador iOS.

## API

O app consome os seguintes endpoints:

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/especialista` | Lista todos os especialistas |
| `POST` | `/consulta` | Agenda uma nova consulta |
| `GET` | `/paciente/{id}/consultas` | Lista consultas de um paciente |
| `PATCH` | `/consulta/{id}` | Remarca uma consulta |
| `DELETE` | `/consulta/{id}` | Cancela uma consulta |

A URL base está definida em `WebService.swift`:

```swift
private let baseURL = "http://localhost:3001"
```

O ID do paciente utilizado nas requisições também está em `WebService.swift`:

```swift
let patientID = "df19e157-9717-4cf2-ab8f-935c51af6306"
```

## Sobre o curso

| | |
|---|---|
| **Curso** | [iOS com SwiftUI: CRUD e APIs REST](https://cursos.alura.com.br/course/ios-swiftui-aplicacoes-interativas-crud-apis-rest) |
| **Plataforma** | [Alura](https://www.alura.com.br/) |
| **Instrutora** | Giovanna Moeller |
| **Carga horária** | 10h |

## Autores

- [Giovanna Moeller](https://github.com/giovannamoeller) — instrutora do curso e estrutura inicial do projeto
- [Patric Pereira](https://github.com/patricpfranca) — implementação completa das funcionalidades CRUD

## Licença

Este projeto é de uso educacional, desenvolvido como parte do curso da Alura.
