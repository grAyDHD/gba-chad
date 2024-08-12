local dap = require("dap")

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = "codelldb",
    args= {"--port", "${port}"},
  }
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.c = {
  {
    name = "(gba) Launch",
    type = "cppdbg",
    request = "launch",
    targetArchitecture = "arm",
    program = "${workspaceFolder}/09_phys.elf",  -- Path to your ELF file
    args = {},
    stopAtEntry = false,
    cwd = "${fileDirname}",
    environment = {},
    externalConsole = false,
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:2345",
    setupCommands = {
      {
        description = "Enable pretty-printing for gdb",
        text = "-enable-pretty-printing",
        ignoreFailures = true
      },
      {
        description = "Set Disassembly Flavor to Intel",
        text = "-gdb-set disassembly-flavor intel",
        ignoreFailures = true
      }
    },
    miDebuggerPath = "arm-none-eabi-gdb",  -- Ensure this points to your GDB executable
    linux = {
      miDebuggerPath = "${env:DEVKITARM}/bin/arm-none-eabi-gdb",
      setupCommands = {
        {
          text = "shell \"mgba\" -g \"${workspaceFolder}/my-game.elf\" &"
        }
      }
    },
    {
    name = "Launch file",
    type = "codelldb",
   request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
  }
}

dap.configurations.cpp = dap.configurations.c
