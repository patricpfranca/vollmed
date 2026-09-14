# Vollmed

Aplicativo iOS para agendamento de consultas médicas na clínica Vollmed. Desenvolvido em **SwiftUI**, consome uma API REST para autenticar pacientes, listar especialistas, agendar, remarcar e cancelar consultas.

> Projeto desenvolvido durante a formação **[Evolua Apps em SwiftUI: CRUD, MVVM e Autenticação](https://www.alura.com.br/formacao-apps-swiftui-crud-mvvm-autenticacao)** da [Alura](https://www.alura.com.br/), ministrada por [Giovanna Moeller](https://www.linkedin.com/in/giovannamoeller).

Os cursos cobrem operações **CRUD** (Create, Read, Update, Delete), verbos HTTP (`GET`, `POST`, `PATCH`, `DELETE`), integração com API RESTful, autenticação com token, persistência segura no Keychain e construção de interfaces com SwiftUI.

## Funcionalidades

- **Login** — autenticação com e-mail e senha; o token e o ID do paciente ficam salvos no Keychain
- **Cadastro** — criação de conta com nome, e-mail, CPF, telefone, senha e plano de saúde (`Picker`)
- **Home** — lista os especialistas disponíveis com foto, nome e especialidade
- **Logout** — encerra a sessão, remove as credenciais locais e volta para a tela de login
- **Agendar consulta** — seleção de data e horário via `DatePicker` (intervalos de 15 minutos)
- **Minhas consultas** — visualização das consultas do paciente autenticado, com opções de remarcar ou cancelar
- **Remarcar consulta** — alteração da data de uma consulta existente
- **Cancelar consulta** — cancelamento com informação do motivo

A tela inicial depende do estado da autenticação: sem token, o app abre o login; com sessão válida, exibe um `TabView` com Home e Minhas consultas.

## Tecnologias

- Swift 5
- SwiftUI
- iOS 17.0+
- URLSession (requisições assíncronas com `async/await`)
- NSCache (cache de imagens dos especialistas)
- Keychain (armazenamento seguro do token e do ID do paciente)
- `AuthenticationManager` (Singleton + `ObservableObject`) para o estado da sessão

## Estrutura do projeto

```
Vollmed/
├── Models/
│   ├── Specialist.swift
│   ├── Appointment.swift
│   ├── ScheduleAppointment.swift
│   ├── Patient.swift
│   └── Login.swift
├── Services/
│   ├── WebService.swift
│   ├── KeychainHelper.swift
│   └── UserDefaultsHelper.swift
├── Managers/
│   └── AuthenticationManager.swift
├── Views/
│   ├── HomeView.swift
│   ├── SignInView.swift
│   ├── SignUpView.swift
│   ├── MyAppointmentsView.swift
│   ├── ScheduleAppointmentView.swift
│   ├── CancelAppointmentView.swift
│   └── Components/
│       ├── SpecialistCardView.swift
│       ├── ButtonView.swift
│       └── TextFieldLabelView.swift
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

## Autenticação

O `AuthenticationManager` é um Singleton que observa o token e o ID do paciente. Na inicialização, ele tenta recuperar esses valores no Keychain (`app-vollmed-token` e `app-vollmed-patient-id`).

Requisições autenticadas enviam o cabeçalho:

```
Authorization: Bearer <token>
```

O ID do paciente deixa de ser fixo no código: ele vem da resposta de login e é reutilizado nas telas que precisam dele (por exemplo, listar e agendar consultas).

## API

O app consome os seguintes endpoints:

| Método | Endpoint | Autenticação | Descrição |
|--------|----------|--------------|-----------|
| `POST` | `/auth/login` | Não | Autentica o paciente e retorna token + ID |
| `POST` | `/auth/logout` | Bearer | Encerra a sessão no servidor |
| `POST` | `/paciente` | Não | Cadastra um novo paciente |
| `GET` | `/especialista` | Não | Lista todos os especialistas |
| `POST` | `/consulta` | Bearer | Agenda uma nova consulta |
| `GET` | `/paciente/{id}/consultas` | Bearer | Lista consultas do paciente autenticado |
| `PATCH` | `/consulta/{id}` | Bearer | Remarca uma consulta |
| `DELETE` | `/consulta/{id}` | Bearer | Cancela uma consulta |

A URL base está definida em `WebService.swift`:

```swift
private let baseURL = "http://localhost:3001"
```

## Sobre os cursos

| | |
|---|---|
| **Formação** | [Evolua Apps em SwiftUI: CRUD, MVVM e Autenticação](https://www.alura.com.br/formacao-apps-swiftui-crud-mvvm-autenticacao) |
| **Curso 1** | [iOS com SwiftUI: CRUD e APIs REST](https://cursos.alura.com.br/course/ios-swiftui-aplicacoes-interativas-crud-apis-rest) |
| **Curso 2** | [iOS com SwiftUI: autenticação de usuários](https://cursos.alura.com.br/course/ios-swiftui-autenticacao-usuarios-aplicacao) |
| **Plataforma** | [Alura](https://www.alura.com.br/) |
| **Instrutora** | Giovanna Moeller |

## Autores

- [Giovanna Moeller](https://github.com/giovannamoeller) — instrutora do curso e estrutura inicial do projeto
- [Patric Pereira](https://github.com/patricpfranca) — implementação das funcionalidades de CRUD e autenticação

## Licença

Este projeto é de uso educacional, desenvolvido como parte dos cursos da Alura.
