worker_processes 4
timeout 150
root = File.expand_path(File.dirname(__FILE__) + '/../')

listen      '/tmp/hoge.sock'
pid         '/tmp/hoge.pid'
stderr_path "#{root}/log/unicorn_error.log"
stdout_path "#{root}/log/unicorn.log"

proxy_read_timeout    160;