# Vollmed

Aplicativo iOS para agendamento de consultas médicas na clínica Vollmed. Desenvolvido em **SwiftUI** com arquitetura **MVVM**, consome uma API REST para autenticar pacientes, listar especialistas, agendar, remarcar e cancelar consultas.

> Projeto desenvolvido durante a formação **[Evolua Apps em SwiftUI: CRUD, MVVM e Autenticação](https://www.alura.com.br/formacao-apps-swiftui-crud-mvvm-autenticacao)** da [Alura](https://www.alura.com.br/).

Os cursos cobrem operações **CRUD**, integração com API RESTful, autenticação com token, persistência no Keychain, padrão **MVVM**, camada de networking e construção de interfaces com SwiftUI.

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
- Arquitetura MVVM
- URLSession (requisições assíncronas com `async/await`)
- Camada de networking (`HTTPClient`, endpoints e serviços por domínio)
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
├── ViewModels/
│   └── HomeViewModel.swift
├── Networking/
│   ├── Base/
│   │   ├── Endpoint.swift
│   │   ├── HTTPClient.swift
│   │   ├── RequestError.swift
│   │   └── RequestMethod.swift
│   ├── Endpoints/
│   │   ├── HomeEndpoint.swift
│   │   └── AuthenticationEndpoint.swift
│   └── Services/
│       ├── HomeNetworkingService.swift
│       └── AuthenticationService.swift
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

## Arquitetura

O projeto segue **MVVM**:

- **View** — interface SwiftUI (ex.: `HomeView`)
- **ViewModel** — regras de negócio e orquestração das chamadas (ex.: `HomeViewModel`)
- **Model** — dados e contratos com a API
- **Networking** — `HTTPClient` genérico, endpoints tipados e serviços por funcionalidade (`HomeNetworkingService`, `AuthenticationService`)

## Autenticação

O `AuthenticationManager` é um Singleton que observa o token e o ID do paciente. Na inicialização, ele tenta recuperar esses valores no Keychain (`app-vollmed-token` e `app-vollmed-patient-id`).

Requisições autenticadas enviam o cabeçalho:

```
Authorization: Bearer <token>
```

O ID do paciente vem da resposta de login e é reutilizado nas telas que precisam dele (por exemplo, listar e agendar consultas).

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

A URL base é montada no `HTTPClient` com host `localhost` e porta `3001`:

```swift
urlComponents.scheme = endpoint.scheme
urlComponents.host = endpoint.host
urlComponents.path = endpoint.path
urlComponents.port = 3001
```

## Sobre os cursos

| | |
|---|---|
| **Formação** | [Evolua Apps em SwiftUI: CRUD, MVVM e Autenticação](https://www.alura.com.br/formacao-apps-swiftui-crud-mvvm-autenticacao) |
| **Curso 1** | [iOS com SwiftUI: CRUD e APIs REST](https://cursos.alura.com.br/course/ios-swiftui-aplicacoes-interativas-crud-apis-rest) |
| **Curso 2** | [iOS com SwiftUI: autenticação de usuários](https://cursos.alura.com.br/course/ios-swiftui-autenticacao-usuarios-aplicacao) |
| **Curso 3** | [Swift: MVVM e separação de responsabilidades](https://cursos.alura.com.br/course/swift-padrao-arquitetural-mvvm-separacao-responsabilidades) |
| **Plataforma** | [Alura](https://www.alura.com.br/) |
| **Instrutores** | Giovanna Moeller · Ândriu Felipe Coelho |

## Autores

- [Giovanna Moeller](https://github.com/giovannamoeller) — instrutora e estrutura inicial do projeto
- [Ândriu Felipe Coelho](https://www.linkedin.com/in/%C3%A2ndriu-felipe-coelho-2344b061/) — instrutor do curso de MVVM e networking
- [Patric Pereira](https://github.com/patricpfranca) — implementação das funcionalidades de CRUD, autenticação e MVVM

## Licença

Este projeto é de uso educacional, desenvolvido como parte dos cursos da Alura.
