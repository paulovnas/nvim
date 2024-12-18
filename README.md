# 🚀 Minha Configuração Incrível do Neovim

Bem-vindo à minha configuração personalizada do Neovim! Esta configuração inclui vários plugins e personalizações para melhorar sua experiência de programação. 🎨

## ✨ Recursos

- 🔍 Autocompletar inteligente de código
- 🎯 Integração com LSP
- 🛠️ Suporte ao desenvolvimento Flutter/Dart
- 🐘 Ferramentas para desenvolvimento PHP
- 📦 E muito mais!

## 🔧 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- Neovim (recomendada a versão 0.8.0 ou superior)
- ripgrep (necessário para busca de texto com Telescope)
  ```bash
  # macOS (com Homebrew)
  brew install ripgrep

  # Windows (com Chocolatey)
  choco install ripgrep

  # Linux
  sudo apt install ripgrep  # Ubuntu/Debian
  sudo dnf install ripgrep  # Fedora
  ```

## 🪟 Configuração no Windows

1. Instalar o Chocolatey (gerenciador de pacotes do Windows)
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. Instalar dependências necessárias
   ```powershell
   choco install mingw
   choco install gzip
   choco install ripgrep  # Necessário para busca de texto no Telescope
   ```

3. Instalar o Neovim
   ```powershell
   choco install neovim
   ```

4. Clonar esta configuração
   ```powershell
   git clone <url-do-seu-repositório> %LOCALAPPDATA%\nvim
   ```

5. Iniciar o Neovim
   ```powershell
   nvim
   ```

6. Configurar o caminho do Flutter
   - Abra o arquivo `lua/plugins/flutter.lua`
   - Localize a seção de configuração do Flutter
   - Atualize o caminho para o diretório onde o Flutter está instalado no seu sistema
   ```lua
   -- Exemplo de como configurar o caminho
   flutter_tools = {
     flutter_path = "C:\\path\\to\\flutter"
   }
   ```

## 🍎 Configuração no macOS com ASDF

1. Verificar os caminhos do Flutter e Dart
   Para encontrar os caminhos corretos do Flutter e Dart quando instalados via ASDF, use os seguintes comandos:
   ```bash
   # Encontrar o caminho do executável Flutter
   which flutter
   # Deve retornar algo como: /Users/seu-usuario/.asdf/shims/flutter

   # Encontrar o caminho do executável Dart
   which dart
   # Deve retornar algo como: /Users/seu-usuario/.asdf/shims/dart
   ```

2. Configurar o LSP do Flutter
   - Os caminhos já estão configurados automaticamente para usar os shims do ASDF
   - O arquivo `lua/plugins/flutter.lua` detecta automaticamente se você está no macOS e usa os caminhos corretos
   - O Dart SDK path será configurado baseado na versão atual do Flutter no ASDF

## 🐧 Configuração no Linux

Em breve! 🚧

## 📝 Estrutura da Configuração

```
nvim/
├── init.lua              # Arquivo principal de configuração
└── lua/
    └── plugins/         # Configurações dos plugins
        ├── init.lua     # Inicialização dos plugins
        ├── php.lua      # Configurações específicas para PHP
        ├── flutter.lua  # Configurações para Flutter/Dart
        └── completion.lua # Configurações de autocompletar
```

## 📜 Licença

Este projeto é open source e está disponível sob a Licença MIT.

## 🙏 Agradecimentos

Agradecimentos especiais à comunidade Neovim e a todos os autores de plugins que tornaram esta configuração possível! 💖
