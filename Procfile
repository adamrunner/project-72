# Procfile
frontend: bin/webpack-dev-server
livereload: bundle exec guard -P livereload
agent: env AGENT_MQTT_HOST=temp.adamrunner.com bin/rake agent:start
backend: bin/rails s -p 3000