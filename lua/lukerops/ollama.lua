-- ensure the volume exists
vim.fn.system({'podman', 'volume', 'create', '--ignore', 'ollama'})

container_state = vim.trim(vim.fn.system({
  'podman', 'container', 'ls', '--all',
  '--filter=name=ollama', '--format={{.State}}'
}))

if container_state ~= "running" then
  vim.fn.system({
    'podman', 'run', '--detach', '--replace', '--pull=newer',
    '--name=ollama', '--publish=127.0.0.1:11434:11434/tcp', '--volume=ollama:/root/.ollama:Z',
    '--restart=always', 'docker.io/ollama/ollama:latest'
  })
end
