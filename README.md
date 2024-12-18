# 🚀 Minha Configuração Incrível do Neovim

Bem-vindo à minha configuração personalizada do Neovim! Esta configuração inclui vários plugins e personalizações para melhorar sua experiência de programação. 🎨

## ✨ Recursos

- 🔍 Autocompletar inteligente de código
- 🎯 Integração com LSP
- 🛠️ Suporte ao desenvolvimento Flutter/Dart
- 🐘 Ferramentas para desenvolvimento PHP
- 📦 E muito mais!

## 🔧 Pré-requisitos

Antes de começar, certifique-se de ter o Neovim instalado no seu sistema (recomendada a versão 0.8.0 ou superior).

## 🪟 Configuração no Windows

1. Instalar o Chocolatey (gerenciador de pacotes do Windows)
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. Instalar dependências necessárias
   ```powershell
   choco install mingw
   choco install gzip
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

## 🐧 Configuração no Linux/macOS

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
